
Synthetic E-commerce dataset for MySQL import.
Files saved to: /mnt/data/synthetic_ecommerce_mysql

Files:
- customers.csv
- vendors.csv
- products.csv
- employees.csv
- orders.csv
- order_items.csv
- shipments.csv
- payments.csv
- returns.csv

Import tips (MySQL):
1) Create tables with appropriate datatypes and primary/foreign keys.
2) Use LOAD DATA LOCAL INFILE '/path/to/file.csv' INTO TABLE table_name
   FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;
3) For date/datetime columns, ensure MySQL date formats YYYY-MM-DD or use STR_TO_DATE.
4) Add indexes on foreign key columns (order_id, customer_id, product_id) after import.

Dataset generated on: 2025-11-25
Rows: orders=5000, order_items=14879, customers=1000, products=500
