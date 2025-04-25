









/**
I, Ali Abubaker, 000857347 certify that this material is my original work. 
No other person's work has been used without due acknowledgment.
**/


#1
select
 Name, CountryCode, District, Population
 from city
 where Name = 'irbil';

#2
select
Name
from country
order by Name
limit 5;

#3
select CountryCode
from countrylanguage
where Language = 'German' and Percentage > 50;

#4
select Name, LifeExpectancy
from country
order by LifeExpectancy desc
limit 1;

#5
SELECT 
Code, 
Name, 
Population
FROM country
WHERE 
Continent = 'Europe'
AND
Population > (SELECT AVG(Population) FROM country)
ORDER BY Name DESC;

#6
select 
Code,
Name,
Continent,
region
from country
where 
UPPER(SUBSTRING(Code,1,2))   = 'AN' And HeadOfState = '';

#7

select Continent, Region, 
MIN(Population) as 'Lowest Population',
AVG(population)as 'Average Population',
MAX(Population)as 'Highest Population'
from country
WHERE Continent= "Asia"
Group by
Region;

#8

select 
country.Code as 'country code',
country.Name as 'Name of Country',
(
select 
Language
from countrylanguage
where
IsOfficial='T'
limit 1
)as 'official language'

from country;

#9
select 
country.Name as 'Country Name',
Population/SurfaceArea As densely
from country
order by densely ;

#10
SELECT 
    codeCountry.Language AS 'Language',
    MAX(codeCountry.Percentage) AS HighLanguage
    
FROM 
    countrylanguage AS codeCountry
JOIN 
    country AS countryname
ON 
    codeCountry.CountryCode = countryname.Code
WHERE 
    codeCountry.Percentage = (
        SELECT MAX(sub_cl.Percentage)
        FROM countrylanguage AS sub_cl
        WHERE sub_cl.Language = codeCountry.Language
    )
    
group by
codeCountry.Language

ORDER BY 
   HighLanguage DESC
    
