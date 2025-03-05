-- SQL Retail Sales Analysis - P1
Create database SQL_Projects_1;
use SQL_Projects_1;
Create table Retail_sales(
    transactions_id INT,
	sale_date date,
	sale_time time,
    customer_id	int,
    gender varchar(15),
    age	int,
    category varchar(15),
    quantiy int,
	price_per_unit float,
	cogs float,
	total_sale float
	);
select * from Retail_sales ;

select * from Retail_sales where transactions_id is null;
select * from Retail_sales where sale_date is null;
select * from Retail_sales where sale_time is null;
select * from Retail_sales where customer_id is null;
select * from Retail_sales where gender is null;
select * from Retail_sales where age is null;
select * from Retail_sales where category is null;
select * from Retail_sales where quantiy is null;
select * from Retail_sales where price_per_unit is null;
select * from Retail_sales where cogs is null;
select * from Retail_sales where total_sale is null;

delete  from Retail_sales
where
    transactions_id is null
    or
    sale_date is null
    or
    sale_time is null
    or
    customer_id is null
    or
    gender is null
    or
    category is null
    or 
    quantiy is null
    or
    price_per_unit is null
    or
    cogs is null
    or
    total_sale is null ;

Set SQL_SAFE_UPDATES = 0;
select count(*) from Retail_sales;
 

-- DATA EXPLORATION
-- How many sales we have ??
select count(*) as total_sale from Retail_sales;
 -- how many unique customers we have ?
 select count(distinct customer_id ) as customers from Retail_sales;
-- How many categories are present in Retail_sales ??

-- Data Analysis / Business Analysis

 -- Q1) Write  a SQL Query  to retrieve  all columns made on '2022-11-05' 
 Select * from Retail_sales where sale_date = "2022-11-05";
 
 -- Q2) Write a SQl Query to Retreieve all Transactions where category is "Clothing" and the  quantity sold is more than 4 in the month of nov_2022
 -- Q3) Write a SQl Query to Calculate the total sales(total_sale) for each category.
 Select category,sum(total_sale) as net_sale from Retail_sales
 group by 1;
 
select category,sum(total_sale) as net_sale,count(*) as total_oeders from retail_sales
group by 1; 
 
 -- Q4) Write a SQL Query to find the average age of customers who purchased items  from the "Beauty" Category.alter
 Select round(Avg(age),2) from Retail_sales where category = "Beauty";
 
-- Q5) Write a SQL query to find all transcations where the total_sale is greater than 1000
Select * from Retail_sales where total_sale > 1000 ;

-- Q6) WRITE A SQL Query to find the total number of transactions(transaction_id) made by each gender in each each category
Select gender,category,  count(*) as total_transactions  from Retail_sales
group by gender,category
order by 1;

-- Q7) Write a SQl query to calculate the Average sales for each month.findout the best selling month in each year !
select * from (
Select year(sale_date) ,month(sale_date),Avg(total_sale) as Avg_sales,
Rank()over(partition by extract(year from sale_date) order by avg(total_sale)desc) as ranking 
from  Retail_sales group by 1,2) as t1;

-- Q8) write  a SQL Query total 5 customers based on highest  total sales
select customer_id,sum(total_sale) as Total_Sales from Retail_sales 
group by 1
order by 2 desc
limit 5;

-- Q9)write a sql query to find the number of unique customers who  purchased items from each category
select  category,count(distinct customer_id) from Retail_sales
group by category;

-- Q10)Write a SQL Query  to create each shift and number of order(Example Morning <=12,Afternoon  between 12 and 17,evening >17 ;

CASE
    WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'MORNING'
    WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12AND 17 THEN  'AFTERNOON'
    ELSE 'EVENING'
END as shift
)
SELECT
    shift,
    count(*) as total_orders
FROM hourly_sale
group by shift



