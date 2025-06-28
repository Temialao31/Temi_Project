

select* from E_commerce_Dataset

--QUESTION 1 (a)
--what devices do my customers use to reach me 

select Device_Type, COUNT(*) AS customer_id
from E_commerce_Dataset
group by Device_Type
order by customer_id DESC;

--QUESTION (b)
--who is the customer base

select Gender, COUNT(*) AS customer_id
from E_commerce_Dataset
group by gender
order by customer_id DESC;

--QUESTION (c)
--what product categories am i seeling 

select Product_Category, COUNT(*) as product
from E_commerce_Dataset
group by Product_Category
order by Product DESC;

--QUESTION (d)
--which product categories do i sell whom?

select Gender, COUNT(*) as product
from E_commerce_Dataset
group by Gender
order by Product DESC;

--QUESTION (e)
--which login type do my customers prefer when shopping

select Customer_Login_type, COUNT(*) as customer_id
from E_commerce_Dataset
group by Customer_Login_type
order by Customer_Id DESC;

--QUESTION (f)
--how does the date and time affect my sales?

select 
	DATEPART(WEEKDAY, Order_Date) as weekday_sales,
	SUM(Sales) as total_sales
from E_commerce_Dataset
group by DATEPART(weekday, Order_Date)
order by weekday_sales;

--QUESTION (g)
--from which product do i earn the most profit per unit?

select TOP 1
	Product,
	Product_Category,
	Quantity,
	Profit
from E_commerce_Dataset
order by Product

--QUESTION (h)
--how is my delivery speed and order priority?

select Order_Priority,
	DATEPART(MONTH, Order_Date) as MonthlyOrder,
	AVG(Aging) as AvgDeliveryTime
from E_commerce_Dataset
group by Order_Priority, DATEPART(MONTH, Order_Date)
order by MonthlyOrder;

--QUESTION (2)
--SALES PERFORMANCE BY MONTH

--(a) calculate total sales for each month over the time period covered by dataset

select 
	FORMAT(Order_date, 'MMMM') as month,
	SUM(sales) as total_sales
from E_commerce_Dataset
group by FORMAT(Order_date, 'MMMM')
order by Total_Sales DESC;

--(b) identify the month with biggest sales and analyse the factors contributing to the peak

select TOP 1
	FORMAT(Order_date, 'MMMM') as month,
	SUM(sales) as total_sales
from E_commerce_Dataset
group by FORMAT(Order_date, 'MMMM')
order by Total_Sales DESC;

--QUESTION 3
--top 5 best selling products
--(a) determine the top 5 product best-selling products based on the total quantity sold

select TOP 5 Product, SUM(Quantity) as total_quantity_sold
from E_commerce_Dataset
group by Product
order by total_quantity_sold DESC;

--(b) provide insight to the characteristic of these products, such as price range, category, and subcategory

select Product, Product_Category, MIN(Sales/Quantity) as Minimim_Price, MAX(Sales/Quantity) as Maximum_price
from E_commerce_Dataset
group by Product, Product_Category
order by SUM(Quantity) DESC;

--QUESTION 4
--sales by product category 
--(a) analyze sales by product to determine which category contribute the most to revenue 

select Product_Category, SUM(Sales) as Sales_Revenue
from E_commerce_Dataset
group by Product_Category
order by Sales_Revenue DESC;

--(b) calculate the percentage contribution of each category to overall sales

select Product_Category,
	ROUND(SUM(Sales)*100/(select SUM(Sales)from E_commerce_Dataset), 2)as Sales_Percentage
from E_commerce_Dataset
group by Product_Category
order by Sales_Percentage DESC;


--QUESTION 5
--REVENUE generation by order
--(a) calculate the average sales by order

select 
	Product_Category,
	AVG(Sales)
	as avg_sales_per_order
from E_commerce_Dataset
group by Product_Category
order by avg_sales_per_order DESC;

--(b) identify the top 5 orders by total sales amount and analyze which products contributed the most to these orders

select TOP 5 Customer_Id, Order_Date, SUM(Sales) as Total_Sales_Amount_order
from E_commerce_Dataset
group by Customer_Id, Order_Date
order by Total_Sales_Amount_order DESC;

--QUESTION 6
--discount impact analysis
--(a) analysis the impact of discount on sales performance. determine if product with discounts are sold more frequently or generate higher revenue than non-discount product

SELECT
CASE
WHEN Discount < 0.10 THEN 'Low Discount (0-10%)'
WHEN Discount < 0.25 THEN 'Medium Discount (10-25%)'
ELSE 'High Discount (25%+)'
	END AS Discount_Tier,
	COUNT(*) AS Order_Count,
	SUM(Quantity) AS Total_Quantity_Sold,
	SUM(Sales) AS Total_Revenue,
	AVG(Sales) AS Avg_Sales_Per_Order
from E_commerce_Dataset
group by 
	CASE
		WHEN Discount < 0.10 THEN 'Low Discount (0-10%)'
		WHEN Discount < 0.25 THEN 'Medium Discount (10-25%)'
		ELSE 'High Discount (25%+)'
	END