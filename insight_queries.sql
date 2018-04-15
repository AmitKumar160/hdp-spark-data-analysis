use organisation;
select 
Customer_first_name,
Customer_last_name,
customer_city,
customer_cty,
Quantity,
UnitPrice,
TotalAmount
from cus_sup_ord_join
group by Customer_first_name,Customer_last_name,customer_city,customer_cty,Quantity,UnitPrice,TotalAmount
order by TotalAmount desc;



drop table avg_revenue_cty;
select
customer_cty,
customer_city,
avg(TotalAmount) as avg_price
into avg_revenue_cty
from cus_sup_ord_join
group by customer_cty,customer_city
order by avg_price;


select 
customer_city,
customer_cty,
count(1) as Count
from cus_sup_ord_join
group by Customer_first_name,Customer_last_name,customer_city,customer_cty;


select 
city,
country,
count(1) as cus_count
from customer
group by city,country;

select 
city,
country,
count(1) as sup_count
from supplier
group by city,country;

use organisation;
select distinct customerId,
Customer_first_name,
customer_last_name,
productId,
productName,
supplierId,
CompanyName,
contactName,
IsDiscontinued
from 
cus_sup_ord_join
where IsDiscontinued = 1
;

use organisation;
select customerId,
productId,
OrderNumber,
OrderDate,
ProductName,
Quantity
from 
cus_sup_ord_join
group by customerId,
productId,
OrderNumber,
OrderDate,
ProductName,
Quantity
order by OrderDate;



