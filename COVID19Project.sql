select * from COVID19Project..['coviddeaths']
WHERE continent is not null
order by 1,3

--Total cases Vs Total Deaths
--Shows the likelihood of contracting COVID within your country
select location, date, total_cases, total_deaths, (total_deaths / total_cases)*100 AS DeathPercentage
FROM COVID19Project..['coviddeaths']
WHERE location like '%canada%'
ORDER BY 1,2

--Total cases Vs population
-- shows what percentage of the population has got COVID
select location, date, total_cases, population, (total_cases / population)*100 AS PercentPopulationInfected
FROM COVID19Project..['coviddeaths']
WHERE location like '%canada%'
ORDER BY 1,2

--Countries with highest infection rate compared to population
select location, population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases / population )*100) as HighestPercentPopInfected
FROM COVID19Project..['coviddeaths']
WHERE continent is not null
GROUP BY location, population
ORDER BY HighestPercentPopInfected DESC

-- Countries with the highest death count per population
select location, population, MAX(total_deaths) AS TotalDeathCount
FROM COVID19Project..['coviddeaths']
WHERE continent is not null
GROUP BY location, population
ORDER BY TotalDeathCount DESC

-- Death count by continent
select continent, MAX(total_deaths) AS TotalDeathCount
FROM COVID19Project..['coviddeaths']
WHERE continent is not null
GROUP BY continent
ORDER BY TotalDeathCount DESC

-- Global numbers

select date, sum(new_cases) as TotalCases, sum(new_deaths) as TotalDeaths,
		case
		when sum(new_cases) = 0 then 0
		else (sum(new_deaths) / sum(new_cases)) * 100 
		end as DeathPercentage
from COVID19Project..['coviddeaths']
where continent is not null
group by date
--order by 1,2

--Total Vaccinations Vs population
--Use CTE

with PopvsVac (continent, location, date, population, new_vaccinations, rollingvaccinations)
as
(
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	sum(vac.new_vaccinations) over (partition by dea.location order by dea.location, dea.date) as rollingvaccinations
from COVID19Project..['coviddeaths'] dea
join COVID19Project..['covid vaccinations'] vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
)
select *, (rollingvaccinations/population) * 100
from PopvsVac

--Using a TEMP table
drop table if exists PercentPopVaccinated --add this to create room for alterations
create table PercentPopVaccinated
( 
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
Rolling_vaccinations numeric
)

insert into PercentPopVaccinated

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	sum(vac.new_vaccinations) over (partition by dea.location order by dea.location, dea.date) as rollingvaccinations
from COVID19Project..['coviddeaths'] dea
join COVID19Project..['covid vaccinations'] vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null

select *, (Rolling_vaccinations/population) * 100
from PercentPopVaccinated

-- Create views to store data for visualisations

Create View PercentagePeopleVaccinated as
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	sum(vac.new_vaccinations) over (partition by dea.location order by dea.location, dea.date) as rollingvaccinations
from COVID19Project..['coviddeaths'] dea
join COVID19Project..['covid vaccinations'] vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null

Create View CountryTotalCasesVsTotalDeaths as
select location, date, total_cases, total_deaths, (total_deaths / total_cases)*100 AS DeathPercentage
FROM COVID19Project..['coviddeaths']
WHERE continent is not null

Create View Infectionratebycountry as 
select location, date, total_cases, population, (total_cases / population)*100 AS PercentPopulationInfected
FROM COVID19Project..['coviddeaths']
WHERE continent is not null

Create View CountryHighestInfections as
select location, population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases / population )*100) as HighestPercentPopInfected
FROM COVID19Project..['coviddeaths']
WHERE continent is not null
GROUP BY location, population
--ORDER BY HighestPercentPopInfected DESC

Create View DeathCountPerLocation as
select location, population, MAX(total_deaths) AS TotalDeathCount
FROM COVID19Project..['coviddeaths']
WHERE continent is not null
GROUP BY location, population
--ORDER BY TotalDeathCount DESC

Create View DeathCountContinent as
select continent, MAX(total_deaths) AS TotalDeathCount
FROM COVID19Project..['coviddeaths']
WHERE continent is not null
GROUP BY continent
--ORDER BY TotalDeathCount DESC

Create View GlobalPercVacc as
select *, (Rolling_vaccinations/population) * 100 as cumulative_per_pop_vaccinated
from PercentPopVaccinated


