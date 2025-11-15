
# Power BI Build Guide: Digital Payments Fraud Detection Dashboard

## Overview
Use the provided CSVs as a data source and create relationships in the model view:
- transactions.user_id -> users.user_id
- transactions.merchant_id -> merchants.merchant_id

## Pages to build
1. Executive Summary (KPIs): Total Transactions, Total Fraud Cases, Fraud Rate, Avg Ticket Size.
2. Transactions Trend: Line chart of daily transactions and frauds.
3. Fraud by Payment Method: Clustered bar chart showing count and fraud rate.
4. Merchant Risk Map: Map visual with city-level fraud intensity.
5. User Risk Explorer: Table listing flagged users from the SQL query output.

## DAX Examples
Total Transactions = COUNT('transactions'[transaction_id])
Total Fraud Cases = SUM('transactions'[is_fraud])
Fraud Rate = DIVIDE([Total Fraud Cases], [Total Transactions], 0)

Merchant Fraud Rate = 
VAR total = CALCULATE(COUNT('transactions'[transaction_id]), ALLEXCEPT(merchants, merchants[merchant_id]))
VAR frauds = CALCULATE(SUM('transactions'[is_fraud]), ALLEXCEPT(merchants, merchants[merchant_id]))
RETURN DIVIDE(frauds, total, 0)

## Tips
- Use conditional formatting for fraud rates (red scale).
- Use drill-through to go from merchant to transaction-level view.
- Add slicers for payment_method, merchant_type, and date range.
