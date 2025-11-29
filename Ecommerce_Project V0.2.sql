create Database if Not Exists Ecom_Project;
use Ecom_project;

Describe Customers;
Describe order_items;
Describe Orders;
Describe Payments;
Describe Products;
Describe Returns;
Describe Shipments;
Describe Vendors;

ALTER TABLE Customers
Add Primary Key (Customer_id);

Alter Table Orders 
Add Primary Key(order_id);

Alter Table order_items
Add Primary Key(Order_item_id);

Alter Table Vendors 
Add Primary key(Vendor_id);

Alter Table Products
Add primary Key(Product_id);

Alter Table Payments
Add Primary Key(Payment_id);

Alter Table Returns
Add Primary Key(Return_id);

Alter Table shipments
Add Primary Key(Shipment_id);

ALTER Table Orders 
Add Foreign Key (customer_id) References Customers(customer_Id);

ALTER Table Order_items 
Add Foreign Key(Order_id) References Orders(order_id);

Alter Table Payments 
Add foreign Key(order_id) References Orders(order_id);

Alter Table products 
add Foreign key(vendor_id) References vendors(vendor_id);

Alter Table Returns 
Add Foreign key(order_item_id) References Order_items(order_item_id);

Alter Table Shipments 
add foreign key(order_id) References Orders(Order_Id);

ALTER Table Order_items 
Add Foreign Key (Product_id) References Products(Product_id);


-- Data Cleaning
-- Order Table 
Select * From Orders;
Select Count(*) From Orders;
Select count(distinct order_id) From Orders;

-- Customer Table 

Select * From customers;

SELECT Count(*) From Customers;
SElECT COUNT(DIstinct name) From Customers;

Select 
	Customer_id,
    Name,
    Email,
    Row_Number() OVER (Partition by Name Order by Customer_id) As rw_number
From Customers;

ALter Table Customers
Rename column Name to FirstName;

DROP Table Customers;

Select * From information_Schema.key_column_usage
Where table_name = 'orders' and referenced_table_name is not null;


-- Data Cleaning order_items 
Select * From order_items;

Select 
	Count(*) From order_items;
    
SElect 
	COunt(DIstinct order_id) From order_items;

Select 
	order_item_id,
    order_id,
    Product_id,
	Unit_price 
From Order_items 
Where unit_price is null;

/*
1. How many orders were placed in 6 month ?
2. List all the orders placed in last 6 month
3. Daily order counts (last 30 days) — show date and count of orders per day.
4.Top 10 products by units sold (last 90 days).
5. Total revenue by month for current year.
6. Top 20 customers by lifetime spend.
7. Orders with payment pending (e.g., COD pending).
8.Total order count with Pending Payment 
9.List products with price greater than ₹10,000
10.Order Count By Shipping Methods 
11. Total number of customers per city.
12. Show orders that were cancelled.
*/
-- 1. How many orders were placed in 6 month ?

Select 
	Count(*) Total_Order 
From Orders 
Where Order_date >= Current_Date() - Interval 6 Month;

-- 2. List all the orders placed in last 6 month
Select 
	* 
From Orders 
Where order_date >= Current_date()- Interval 6 Month;
-- 3. Daily order counts (last 30 days) — show date and count of orders per day.
Select 
	Order_date,
    Count(*) Order_count
From orders 
Where Order_Date >= Current_Date() - Interval 30 Day 
Group by order_date
Order By Order_date Asc;

-- 4.Top 10 products by units sold (last 90 days).
Select 
	P.name,
    P.Category,
    Sum(OI.Quantity) Total_Quantity
From Products P 
Join Order_items OI 
on p.product_id = OI.product_id 
Join Orders O 
on OI.order_id = O.order_id 

Where O.order_date>= Current_Date() - Interval 90 Day 
Group By P.Name, P.Category
Order By Sum(OI.Quantity) Desc 
Limit 10;

-- 5. Total revenue by month for current year.
SELECT 
	Month(o.order_date) Monthly,
    Round(sum(oi.line_total-(p.cost+S.shipping_cost)),2) as Revenue
From Orders O 
JOIN Order_items oi 
On o.order_id = Oi.order_id 
Join Products P 
On Oi.product_id = P.product_id 
Join Shipments s 
on O.order_id = s.order_id
Where Year(O.order_Date) = Year(Current_Date())
Group By Month(o.order_date) 
Order By Month(o.order_date);

-- 6. Top 20 customers by lifetime spend.
SELECT 
	C.customer_Id,
    C.name,
    Round(Sum(O.Total_amount),2) Total_Spent 
From Customers C 
Join Orders O 
on c.customer_id = O.customer_id 
Group BY C.customer_id,C.name 
Order by sum(O.total_amount) Desc
Limit 20;

-- 7. Orders with payment pending (e.g., COD pending).

SELECT 
	O.Order_id,
    O.Order_Date,
    P.Payment_id,
    P.payment_method,
    p.payment_Status
From Orders O 
JOIN Payments P 
on o.order_id = p.order_id
Where Payment_Status ='pending';

-- 8.Total order count with Pending Payment 
SELECT 
	Count(*) Total_Pending
From Orders O 
JOIN Payments P 
on o.order_id = p.order_id
Where Payment_Status ='pending';

-- 9.List products with price greater than ₹10,000 
SELECT 
	p.Product_id,
    P.Name,
    p.Category,
    P.price
From Products P 
WHere Price >10000;

-- 10.Order Count By Shipping Methods 
SELECT 
    CASE 
        WHEN S.carrier IS NULL OR TRIM(S.carrier)='' THEN 'Others' 
        ELSE S.carrier
    END AS Carrier_type,
    COUNT(O.order_id) AS Total_Order
FROM Shipments S
JOIN Orders O 
    ON S.order_id = O.order_id
GROUP BY Carrier_type
ORDER BY Total_Order DESC;

-- 11. Total number of customers per city.
SELECT 
	C.CITY,
    COUNT(*) Total_Customer
From Customers C
Group BY C.CITY 
Order By Count(*) Desc;

-- 12. Show orders that were cancelled.
Select
	O.order_id,
    O.Order_Date,
    O.Order_Status,
    O.Total_amount
From Orders O 
Where O.order_status = 'Cancelled';

	










