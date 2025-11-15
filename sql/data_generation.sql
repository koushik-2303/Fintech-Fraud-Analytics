
-- Bulk load CSV files (PostgreSQL example using COPY)
-- COPY users(user_id, age, gender, registration_date, avg_monthly_spend) FROM '/path/users.csv' CSV HEADER;
-- COPY merchants(merchant_id, merchant_type, city, risk_rating) FROM '/path/merchants.csv' CSV HEADER;
-- COPY devices(device_id, user_id, device_type, os, device_city) FROM '/path/devices.csv' CSV HEADER;
-- COPY transactions(transaction_id, user_id, merchant_id, amount, payment_method, timestamp, status, location, is_fraud) FROM '/path/transactions.csv' CSV HEADER;
