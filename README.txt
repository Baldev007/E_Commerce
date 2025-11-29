Synthetic E-commerce dataset for MySQL import.
Files saved to: /mnt/data/synthetic_ecommerce_mysql

Files:
- customers.csv
- vendors.csv
- products.csv
- orders.csv
- order_items.csv
- shipments.csv
- payments.csv
- returns.csv


1) Loaded Data
2) Created tables with appropriate datatypes and primary/foreign keys.
3) Data cleaning (Duplicate/Null) 
4) Add indexes on foreign key columns (order_id, customer_id, product_id) after import.

Dataset generated on: 2025-11-25
Rows: orders=5000, order_items=14879, customers=1000, products=500, Vendor = 50, Shipments= 5000, Payments= 5000, Returns = 446

Questions:

1	Total order placed in the last 6 months
2	Last 6 months orders — list all orders placed in the last 6 months.
3	Daily order counts (last 30 days) — show date and count of orders per day.
4	Top 10 products by units sold (last 90 days).
5	Total revenue by month for the current year.
6	Top 20 customers by lifetime spend.
7	Orders with payment pending (e.g., COD pending).
8	Total order count with Pending Payment 
9	List products with price > ₹10,000 (or another threshold).
10	Count orders by shipping method.
11	Total number of customers per city.
12	Show orders that were cancelled.

