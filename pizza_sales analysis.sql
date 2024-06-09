use pizza_sales;

describe pizza;

-- Change the data type of Date(text-Date) and Time(text-Time) columns

alter table pizza modify column order_date date;
alter table pizza modify column order_time time;

SELECT * from pizza;

-- Total Revenue

SELECT 
    SUM(total_price) AS Total_Revenue
FROM
    pizza;

-- Average Order value 

SELECT 
    ROUND(SUM(total_price) / COUNT(DISTINCT order_id),2) AS Average_Order_Value
FROM
    pizza;

-- Total Pizza Sold

SELECT 
    SUM(quantity) AS total_pizzas_sold
FROM
    pizza;


-- Total Orders

SELECT 
    COUNT(distinct order_id) AS Total_orders
FROM
    pizza
WHERE
    order_id IS NOT NULL;

-- Avg pizza per order


SELECT 
    SUM(quantity) / COUNT(DISTINCT order_id) AS total_pizzas_sold
FROM
    pizza;

-- daily trend for pizza orders

SELECT 
    dayname(order_date) order_day,
    COUNT(DISTINCT order_id) Total_Order
FROM
    pizza
GROUP BY 1
order by 2 desc;

-- hourly trend for pizza orders

SELECT 
    hour(order_time) order_time,
    COUNT(DISTINCT order_id) Total_Order
FROM
    pizza
GROUP BY 1
order by 2 desc;

-- monthly trend for pizza orders

SELECT 
    monthname(order_date) month_name,
    COUNT(DISTINCT order_id) Total_Order
FROM
    pizza
GROUP BY 1
order by 2 desc;

-- percentage of sales by pizza category (for month wise sales, include [where month(order_date)= <<month>>] in both query and sub-query) 

SELECT 
    pizza_category,
    (SUM(total_price) * 100 / 
    (SELECT SUM(total_price) FROM pizza)) PCT
FROM
    pizza
GROUP BY 1;

-- Percentage of Sales by pizza Size (for month wise sales, include [where month(order_date)= <<month>>] in both query and sub-query) 

SELECT 
    pizza_size,
    (SUM(total_price) * 100 / 
    (SELECT SUM(total_price) FROM pizza)) PCT
FROM
    pizza
GROUP BY 1;

-- Total pizza sold by pizza category

SELECT 
    pizza_category, SUM(quantity) Total_Pizza
FROM
    pizza
GROUP BY 1;

-- Top 5 Best Sellers by Revenue, Total Orders, Total Quantity
-- Note:- Change the "order by" for further Analysis- Revenue, Total_Orders, Total_quantity

SELECT 
    pizza_name,
    SUM(total_price) Total_Revenue,
    COUNT(DISTINCT order_id) Total_orders,
    SUM(quantity) Total_quantity
FROM
    pizza
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;


-- Bottom 5 Best Sellers  by Revenue, Total Orders, Total Quantity
-- Note:- Change the "order by" for further Analysis- Revenue, Total_Orders, Total_quantity


SELECT 
    pizza_name,
    SUM(total_price) Total_Revenue,
    COUNT(DISTINCT order_id) Total_orders,
    SUM(quantity) Total_quantity
FROM
    pizza
GROUP BY 1
ORDER BY 2 asc
LIMIT 5;

