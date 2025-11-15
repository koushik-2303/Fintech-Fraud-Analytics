# 🚨 Digital Payments Fraud Detection Analytics  
### **SQL + Power BI | End-to-End Fintech Analytics Project**

This project showcases an end-to-end **Fraud Detection Analytics System** built for digital payments. It demonstrates data modeling, SQL analytics, anomaly detection logic, and an interactive Power BI dashboard — exactly the kind of work expected from a modern Data Analyst / BI Analyst in Fintech.

📦 **Download Dataset:**  
- [Transactions (120K rows)](data/transactions.csv)  
- [Users](data/users.csv)  
- [Merchants](data/merchants.csv)  
- [Devices](data/devices.csv)  

📄 **SQL Scripts:**  
- [Create Tables (DDL)](sql/create_tables.sql)  
- [Analysis Queries](sql/analysis_queries.sql)

📊 **Power BI Guide:**  
- [Build Guide + DAX](powerbi/BUILD_GUIDE.md)

---

## 🔍 Project Overview

Digital payments have exploded globally — UPI, credit cards, wallets, and online banking handle millions of transactions daily. With this growth comes a rise in **fraud**, making fraud analytics one of the hottest problem areas in fintech.

This project simulates fraud patterns and builds a reporting system to answer crucial business questions:
- Which merchants are involved in the most fraud?
- Which payment methods are the riskiest?
- What times of day see abnormal activity?
- Which users or transactions show anomaly patterns?
- What is the overall fraud rate and trend over time?

---

## 🧩 Data Model

The dataset includes **120,000+** synthetic but highly realistic fintech transactions generated with:
- Merchant-level risk ratings  
- Payment method patterns  
- Seasonal fraud spikes (e.g., holiday fraud)  
- High-value anomalies  
- Device-level vulnerabilities  

### **Tables**
| Table | Rows | Description |
|-------|------|-------------|
| `users` | 5,000 | Customer demographics + avg monthly spend |
| `merchants` | 800 | Merchant categories, cities, risk rating |
| `devices` | 7,000 | Device OS + location (risk correlation) |
| `transactions` | 120,000 | Full payment data + fraud flags |

Complete ERD:  
