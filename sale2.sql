select * from sale

------Show off vendedor who is the best seller by cantidad sold
Create table Best_seller
(nombre nvarchar(255),vendedor nvarchar(255), total int)
insert into Best_seller
Select
nombre,
vendedor,
sum(cantidad) as total from sale
group by nombre,vendedor
order by nombre
-------
select * from Best_seller
-----
with ranked_seller as
(
select
*,
rank() over(partition by nombre order by total desc) as ranked
from Best_seller
)
select vendedor, total from ranked_seller
where  ranked = 1 

------Show off vendedor who is the best seller by revenue before tax
Create table highest_revenue
(nombre nvarchar(255),vendedor nvarchar(255), revenue int)
insert into highest_revenue
Select
nombre,
vendedor,
sum(Total) as revenue from sale
group by nombre,vendedor
order by nombre
-----
with ranked_revenue as
(
select
*,
rank() over(partition by nombre order by revenue desc) as ranked
from highest_revenue
)
select * from ranked_revenue
where ranked = 1
---------------------------Show off vendedor who contribute the highest revenue 
select
vendedor,
sum(cantidad) as total_quantity,
sum(total) as total_revenue
from sale
group by vendedor
order by total_revenue desc
------------show off how many type of nombre sold by each vendedor
select
vendedor,
count (distinct(nombre)) as count_type
from sale
group by vendedor
-----------Best-seller and revenue before tax
select
nombre,
sum(cantidad) as total_quantity,
sum(total) as total_revenue
from sale
group by nombre
order by total_quantity desc