select COUNT("UnitPrice") as how_many_products, CASE
when "UnitPrice" < 10 then 'lower price'
when "UnitPrice" <= 50 then 'middle price'
when "UnitPrice" > 50 then 'higher price'
end as price 
from products p GROUP BY price HAVING COUNT("UnitPrice") > 0;
