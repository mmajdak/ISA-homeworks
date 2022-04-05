--rozw. zadania 3a.
with max_amp as (
			select 
			"STA", "Date", ("MaxTemp"-"MinTemp") as amplituda 
			from summary_of_weather_csv sowc 
			order by amplituda desc
			limit 1
			)
select 
"STA", wslc."STATE/COUNTRY ID", amplituda 
from max_amp 
join weather_station_locations_csv wslc on "STA" = wslc."WBAN"

--Kraj NG - po sprawdzeniu wg współrzędnych np. w google maps, można zobaczyć, że stacja znajduje się w Nowej Gwinei, miasto Lae
select 
concat("Latitude",' , ',"Longitude") as GPS
from weather_station_locations_csv wslc 
where 
"WBAN" = 80411