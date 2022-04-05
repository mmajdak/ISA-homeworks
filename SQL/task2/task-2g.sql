select "ProductName", "CategoryID", round("UnitPrice"::numeric ,2) as price, dense_rank() over(partition by "CategoryID" order by "UnitPrice") as rrank from products p 
