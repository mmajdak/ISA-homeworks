with help2 as (

	with help as (
				select 
				"STA", "Date",   
				case 
				when "Precip" = 'T' then '0'
				else "Precip" end::numeric 
				from 
				summary_of_weather_csv sowc 
				)
	select
	"STA", 
	"Date", 
	"Precip", 
	(lag("Precip",5) over(partition by "STA" order by "Date") + lag("Precip",4) over(partition by "STA" order by "Date") + lag("Precip",3) over(partition by "STA" order by "Date") + lag("Precip",2) over(partition by "STA" order by "Date") + lag("Precip",1) over(partition by "STA" order by "Date")) as Precip_last5_sum
	from 
	help
	)
select
"STA", 
"Date", 
"Precip"
from 
help2
where 
"Precip" > Precip_last5_sum