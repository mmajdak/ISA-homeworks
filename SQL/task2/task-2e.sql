select "CompanyName", case when "Phone" like ('%(17%') then "Phone" else "Fax" end contact, "City" from customers c where "City" = 'London'
union all
select "CompanyName", "Phone" as contact, "City" from suppliers s where "City" = 'London'