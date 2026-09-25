with dates as (
  select dateadd(day, seq4(), '2025-01-01'::date) as date_day
  from table(generator(rowcount => 3650))
)
select
  date_day,
  year(date_day) as year,
  quarter(date_day) as quarter,
  month(date_day) as month,
  monthname(date_day) as month_name,
  week(date_day) as week,
  dayofweek(date_day) as day_of_week,
  dayname(date_day) as day_name
from dates
