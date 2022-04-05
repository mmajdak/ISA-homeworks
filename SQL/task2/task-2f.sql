with www as (
	select "OrderID", round(sum(od."UnitPrice" *od."Quantity" *(1-od."Discount"))::numeric ,2) as suma from order_details od group by "OrderID" order by suma desc limit 1
	)
	
select www."OrderID", case when www."OrderID"=od."OrderID" then od."ProductID" end ProductID, p."ProductName" from www
join order_details od on www."OrderID" = od."OrderID"
join products p on od."ProductID" = p."ProductID"