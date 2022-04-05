with sup_prices as (
		select p."SupplierID", s."CompanyName", round(max("UnitPrice")::numeric,2) as max_price, round(min("UnitPrice")::numeric,2) as min_price, round(avg("UnitPrice")::numeric,2) as avg_price from products p 
		join suppliers s on p."SupplierID" = s."SupplierID" 
		group by p."SupplierID", s."CompanyName" order by p."SupplierID" asc
		)
select "CompanyName", max_price, min_price, avg_price from sup_prices