select * from WalmartSalesData;

-------------------------------------------------------------------------------------------------------------------------

---1. time_of_day

select Time 
,case when Time between '00:00:00' and '12:00:00' then 'Morning'
	  when Time between '12:01:00' and '16:00:00' then 'Afternoon'
	  else 'Evening'
end as time_of_date
from WalmartSalesData;


Alter table WalmartSalesData 
add time_of_day varchar(50);

update WalmartSalesData 
set time_of_day = (case when Time between '00:00:00' and '12:00:00' then 'Morning'
	  when Time between '12:01:00' and '16:00:00' then 'Afternoon'
	  else 'Evening'
end);

select * from WalmartSalesData;

---2. day_name

select date,
Datename(WEEKDAY,date)
from WalmartSalesData;


Alter table WalmartSalesData add day_name varchar(50);

update WalmartSalesData set day_name = DATENAME(WEEKDAY,date);

select * from WalmartSalesData;

---3. month_name

select date,
DATENAME(MONTH,date)
from WalmartSalesData;

Alter table WalmartSalesData add month_name varchar(50);

update WalmartSalesData set month_name = DATENAME(MONTH,date);

select * from WalmartSalesData;


-------------------------------------------------------------------------------------------------------------------------------------

---1. How many unique cities does data have?

select count(distinct city) as count_of_cities from WalmartSalesData;

---2. In which city is each branch?

select distinct branch from WalmartSalesData;

select distinct city, branch from WalmartSalesData;

---3. How many unique product line does the data have?

select * from WalmartSalesData;

select distinct product_line from WalmartSalesData;

select count(distinct product_line) as no_of_product_line from WalmartSalesData;

---4. What is the most common payment method?

select payment, count(*) as pay_method 
from WalmartSalesData
group by payment
order by pay_method desc;

---5. What is the most selling product line?

select * from WalmartSalesData;

select product_line , count(*) as no_of_product_line
from WalmartSalesData
group by product_line
order by no_of_product_line desc;

---6.What is the total revenue by month?


select * from WalmartSalesData;

select month_name, sum(total) as total_revenue 
from WalmartSalesData
group by month_name
order by total_revenue desc;



---7. What month had the largest cogs?

select * from WalmartSalesData;

select month_name,sum(cogs) as no_of_cogs
from WalmartSalesData
group by month_name
order by no_of_cogs desc;


---8. What product line had the largest revenue?

select * from WalmartSalesData;

select Product_line, sum(total) as total_reve_of_product_line 
from WalmartSalesData
group by product_line
order by total_reve_of_product_line desc;


---9. What is the city with the largest revenue?

select * from WalmartSalesData;

select city, sum(total) as city_largest_reve 
from WalmartSalesData
group by city
order by city_largest_reve desc;


--- 10. What product line had the largest VAT?

select * from WalmartSalesData;

select product_line, avg(Tax_5) as avg_tax 
from WalmartSalesData
group by product_line
order by avg_tax desc;


--- 11. Fetch each product line  and add a column  to those product line showing "Good","Bad".  Good if its greater than average sales.

select * from WalmartSalesData;

with cte as
(
select product_line , avg(total) as avg_total
from WalmartSalesData
group by product_line
---order by avg_total desc
),cte2 as
(
select avg(avg_total) as total_avg from cte)
select cte.product_line ,
case when cte.avg_total > cte2.total_avg then 'Good'
else 'Bad'
end as 'Good/Bad'
from cte,cte2
;


--- 12. Which branch sold more products than average product sold?

select * from WalmartSalesData;


select branch, sum(quantity) as qty
from WalmartSalesData
group by branch 
having sum(quantity) > (select avg(quantity) from WalmartSalesData);


---13.  What is the most common product line by gender?

select * from WalmartSalesData;

select product_line,
Count(case when gender = 'Female' then 0 end) as female_cnt,
sum(case when gender = 'Male' then 1 end) as male_cnt
from WalmartSalesData
group by product_line;

--- Same question but different approach
select product_line, gender,
count(gender) as total_cnt
from WalmartSalesData
group by product_line,gender
order by total_cnt desc;


--- 14. What is the average rating of each product line?

select * from WalmartSalesData;

select product_line, round(avg(rating),1) as avg_rating
from WalmartSalesData
group by product_line
order by avg_rating desc;



-------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------ Sales Analysis Part------------------------------------------------------------

---1. Number of sales made in each time of the day per weekday?

select * from WalmartSalesData;

select time_of_day,
count(*) as total_sales
from WalmartSalesData
where day_name = 'Monday'
group by time_of_day
order by total_sales desc;


---2. Which of the customer type brings the most revenue?

select * from WalmartSalesData;

select Customer_type,round(sum(total),2) as revenue 
from WalmartSalesData
group by Customer_type
order by revenue desc;


---3. Which city has the largest tax percent/VAT?


select * from WalmartSalesData;

select City, round(sum(Tax_5),2) as taxes
from WalmartSalesData
group by City
order by taxes desc;


---4. Which customer type pays the most in VAT?

select * from WalmartSalesData;

select Customer_type, round(SUM(Tax_5),2) as total_tax
from WalmartSalesData
group by Customer_type
order by total_tax desc;


------------------------------------------------------------------------------------------------------------------------
---------------------------------------------Customer-------------------------------------------------------------------

---1. How many unique customer type does the data have?

select * from WalmartSalesData;

select Count(distinct Customer_type) as total_cust_type from WalmartSalesData;

---2. How many unique payment methods does the data have?

select * from WalmartSalesData;

select Count(distinct Payment) as total_pay_method 
from WalmartSalesData;


---3. What is the most common Customer type?

select * from WalmartSalesData;

select Customer_type, Count(Customer_type) as total_cnt 
from WalmartSalesData
group by Customer_type
order by total_cnt desc;

---4. Which Customer type buys the most?

select Customer_type, Count(Customer_type) as total_cnt 
from WalmartSalesData
group by Customer_type
order by total_cnt desc;


---5. What is the gender of most of the customer?

select * from WalmartSalesData;

select Gender, count(*) as total_gender_cnt
from WalmartSalesData
group by Gender
order by total_gender_cnt desc;


---6. What is the gender distriution per branch?

select * from WalmartSalesData;

select Branch, count(Gender ) as total_gender_cnt
from WalmartSalesData
group by Branch
order by total_gender_cnt desc;



---7. Which time of the day do customers give most ratings?


select * from WalmartSalesData;

select time_of_day,Count(rating) as total_no_rating 
from WalmartSalesData
group by time_of_day;

---8. Which time of the day do customers give most rating per branch?

select * from WalmartSalesData;

select time_of_day,Branch,Count(rating) as total_no_rating 
from WalmartSalesData
group by time_of_day,Branch
order by time_of_day,Branch,total_no_rating desc;

---9. Which day of the week has the best avg rating?

select * from WalmartSalesData;

select day_name, round(avg(rating),2) as total_no_rating 
from WalmartSalesData
group by day_name;


---10.  Which day of the week  has the best avg rating per branch?


select * from WalmartSalesData;

select day_name,Branch,ROUND(avg(Rating),2) as total 
from WalmartSalesData
group by day_name,Branch
order by day_name,Branch,total desc;
















