
-- ANALYSIS QUERIES for Fraud Detection Dashboard

-- 1. Daily transaction trend (volume & amount)
SELECT DATE(timestamp) AS txn_date,
       COUNT(*) AS total_txns,
       SUM(CASE WHEN status='SUCCESS' THEN 1 ELSE 0 END) AS success_txns,
       SUM(CASE WHEN is_fraud=1 THEN 1 ELSE 0 END) AS fraud_txns,
       SUM(amount) FILTER (WHERE status='SUCCESS') AS total_amount
FROM transactions
GROUP BY DATE(timestamp)
ORDER BY txn_date;

-- 2. Fraud rate by payment method
SELECT payment_method,
       COUNT(*) AS total_txns,
       SUM(is_fraud) AS fraud_cases,
       ROUND(100.0 * SUM(is_fraud)::numeric / COUNT(*), 3) AS fraud_rate_percent
FROM transactions
GROUP BY payment_method
ORDER BY fraud_rate_percent DESC;

-- 3. High-risk merchants (top 20 by fraud percent)
SELECT m.merchant_id, m.merchant_type, m.city,
       COUNT(t.transaction_id) AS txn_count,
       SUM(t.is_fraud) AS fraud_cases,
       ROUND(100.0 * SUM(t.is_fraud)::numeric / COUNT(t.transaction_id),3) AS fraud_percent
FROM merchants m
JOIN transactions t ON m.merchant_id = t.merchant_id
GROUP BY m.merchant_id, m.merchant_type, m.city
HAVING COUNT(t.transaction_id) > 50
ORDER BY fraud_percent DESC
LIMIT 20;

-- 4. Users flagged by simple rules (high amount vs avg spend OR multiple failed attempts)
WITH user_spend AS (
    SELECT user_id, AVG(amount) AS avg_txn_amt, SUM(amount) AS total_amount, COUNT(*) AS txn_count
    FROM transactions
    WHERE status='SUCCESS'
    GROUP BY user_id
),
failed_attempts AS (
    SELECT user_id, DATE_TRUNC('minute', timestamp) AS minute_slot, COUNT(*) AS failed_count
    FROM transactions
    WHERE status='FAILED'
    GROUP BY user_id, DATE_TRUNC('minute', timestamp)
    HAVING COUNT(*) >= 3
)
SELECT t.user_id,
       COUNT(*) FILTER (WHERE t.amount > 2 * us.avg_txn_amt) AS high_value_anomalies,
       COUNT(*) FILTER (WHERE t.status='FAILED') AS failed_attempts,
       MAX(t.timestamp) AS last_txn
FROM transactions t
LEFT JOIN user_spend us ON t.user_id = us.user_id
GROUP BY t.user_id
HAVING COUNT(*) FILTER (WHERE t.amount > 2 * us.avg_txn_amt) > 0 OR SUM(CASE WHEN t.status='FAILED' THEN 1 ELSE 0 END) >= 3
ORDER BY failed_attempts DESC NULLS LAST, high_value_anomalies DESC
LIMIT 200;

-- 5. Hour-of-day fraud distribution
SELECT EXTRACT(HOUR FROM timestamp) AS hour, COUNT(*) AS total, SUM(is_fraud) AS frauds,
       ROUND(100.0 * SUM(is_fraud)::numeric / NULLIF(COUNT(*),0),3) AS fraud_rate_percent
FROM transactions
GROUP BY hour
ORDER BY hour;

-- 6. Merchant performance with user demographics
SELECT m.merchant_id, m.merchant_type, u.gender,
       COUNT(t.transaction_id) AS txn_count,
       SUM(t.is_fraud) AS fraud_cases,
       ROUND(100.0 * SUM(t.is_fraud)::numeric / COUNT(t.transaction_id),3) AS fraud_pct
FROM transactions t
JOIN merchants m ON t.merchant_id = m.merchant_id
JOIN users u ON t.user_id = u.user_id
GROUP BY m.merchant_id, m.merchant_type, u.gender
ORDER BY fraud_pct DESC
LIMIT 50;

-- 7. Device OS risk (correlate fraud with OS versions)
SELECT d.os, COUNT(*) AS total_txns, SUM(t.is_fraud) AS frauds,
       ROUND(100.0 * SUM(t.is_fraud)::numeric / NULLIF(COUNT(*),0),3) AS fraud_rate_pct
FROM transactions t
JOIN devices d ON t.user_id = d.user_id
GROUP BY d.os
ORDER BY fraud_rate_pct DESC;
