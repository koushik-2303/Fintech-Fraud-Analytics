
-- Create tables (PostgreSQL)
CREATE TABLE users (
    user_id VARCHAR PRIMARY KEY,
    age INT,
    gender VARCHAR(5),
    registration_date DATE,
    avg_monthly_spend NUMERIC
);

CREATE TABLE merchants (
    merchant_id VARCHAR PRIMARY KEY,
    merchant_type VARCHAR(100),
    city VARCHAR(100),
    risk_rating VARCHAR(10)
);

CREATE TABLE devices (
    device_id VARCHAR PRIMARY KEY,
    user_id VARCHAR REFERENCES users(user_id),
    device_type VARCHAR(50),
    os VARCHAR(50),
    device_city VARCHAR(100)
);

CREATE TABLE transactions (
    transaction_id VARCHAR PRIMARY KEY,
    user_id VARCHAR REFERENCES users(user_id),
    merchant_id VARCHAR REFERENCES merchants(merchant_id),
    amount NUMERIC,
    payment_method VARCHAR(50),
    timestamp TIMESTAMP,
    status VARCHAR(20),
    location VARCHAR(100),
    is_fraud INT -- 0/1 for demo
);
