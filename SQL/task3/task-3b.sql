--rozw 3b.
--W celu policzenia korelacji dla długości i szerokości geograficznej, użyłem wartości bezwzględnej, aby wyeliminować wartości ujemne zarówno z długości, jak i szerokości geograficznej. Według mnie fałszują pomiar dla korelacji, a przez występowanie pór roku oraz ruch kołowy ziemi - warunki na przestrzeni 365 dni dają szansę na miarodajny i "sprawiedliwy" wynik, zwłaszcza że były przeprowadzana przez okres pełnych 6 lat, tj. od 1.1.1940 do 31.12.1945.
with dane_kor as 
				(
				select 
				"STA", "Date", "MeanTemp", wslc."Latitude", wslc."Longitude"
				from summary_of_weather_csv sowc 
				join weather_station_locations_csv wslc on "STA" = wslc."WBAN" 
				)
select 
corr("MeanTemp"::numeric ,abs("Latitude")) as corr_latitude, 
corr("MeanTemp"::numeric ,abs("Longitude")) as corr_longitude
from dane_kor

--Korelacja między śr.temp.dzienną a szerokością geo. jest silniejsza aniżeli między śr.temp.dzienną a długością geo. Korelacja dot.szer.geo. jest korelacją ujemną, tzn., że wraz ze wzrostem szer. maleje temperatura. Wartość bezwzględna tej korelacji przyjmuje wartość 0.687 , przez co uważać można ją za umiarkowaną zależność. Warto dodać, że do przedziału 0.7, od której możemy ją kwalifikować jako dość silną zależność - brakuje jedynie 0.013. Natomiast drugi współczynnik korelacji dot. długości geo. był dodatki na poziomie 0.244 . Jego wartość mieści się w przedziale tzw. słabej zależności.
--źródło interpretacji wartości korelacji: Akademia Górniczno-Hutnicza w Krakowie, http://home.agh.edu.pl/~romanf/Wprowadzenie_do_MATLAB/_build/html/Analiza_istotnosci.html
--Dla porównaniua obu korelacji dopisałem jeszcze formułkę (tu również użyta wartość bezwzględna):

with kor_la_lo as 
		(
		with dane_kor as 
				(
				select 
				"STA", "Date", "MeanTemp", wslc."Latitude", wslc."Longitude"
				from summary_of_weather_csv sowc 
				join weather_station_locations_csv wslc on "STA" = wslc."WBAN" 
				)
		select 
		corr("MeanTemp"::numeric ,abs("Latitude")) as corr_latitude, 
		corr("MeanTemp"::numeric ,abs("Longitude")) as corr_longitude
		from dane_kor
		)
select 
	case 
	when abs(corr_latitude) > abs(corr_longitude) then 'Korelacja między śr. temp. dzienną a szer. geo. jest silniejsza niż kor. między śr. temp. dzienną a długością geo.' 
	when abs(corr_latitude) < abs(corr_longitude) then 'Korelacja między śr. temp. dzienną a długością geo. jest silniejsza niż kor. między śr. temp. dzienną a szer. geo.' 
	else 'wartości obu korelacji są sobie równe' end as anwsear
from kor_la_lo