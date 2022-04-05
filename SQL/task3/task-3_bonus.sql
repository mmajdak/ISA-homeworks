Select
	wslc."WBAN",
	wslc."STATE/COUNTRY ID",
	wslc."NAME",
	sowc."SNF"
from 
summary_of_weather_csv sowc
join weather_station_locations_csv wslc on sowc."STA"=wslc."WBAN"
where sowc."MO" = 7 and sowc."SNF"> 0 