with max_mid_price as (
			select Max("UnitPrice") as mid_max from products p where "UnitPrice" <= 50
			)
select 
case 
when Max("UnitPrice") = (select mid_max from max_mid_price) then 'true' else 'false' end max_mid_price_is_max_total from products p;
