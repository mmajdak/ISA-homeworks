with mintemp_denserank as (
		select 
		wslc."STATE/COUNTRY ID", "Date", "MinTemp", row_number() over(partition by wslc."STATE/COUNTRY ID" order by "MinTemp" asc) as mintemp_ofstate
		from 
		summary_of_weather_csv sowc 
		join weather_station_locations_csv wslc on "STA" = wslc."WBAN" 
		)
select 
rank() over(order by "MinTemp"), 
"STATE/COUNTRY ID", 
"MinTemp" 
from
mintemp_denserank
where 
mintemp_ofstate	= 1