with

-- get all customer records from staging
customers as (
    select * from {{ ref('stg_customers') }}
),

-- find the first day a customer record was created
first_date as (
    select date_trunc('month', min(created_at)) as month_first_customer_created
    from customers
),

-- generate a day-wise spine from the first day of the month the first customer
-- joined.  We are intentionally not using the `dbt_utils.date_spine` macro
-- because it added some complexity - perhaps we were doing it wrong?
days as (
    select
        generate_series(
            first_date.month_first_customer_created,
            {{ now() }},
            -- just like a datawarehouse's now() but a macro to also support
            -- unit testing
            '1 day'
        )::date as datestamp
    from first_date
),

-- customer created_at is a timestamp rather than a day - truncate the timestamp
-- to a day for grouping
customers_by_day as (
    select
        customer_id,
        date_trunc('day', created_at) as created_at
    from customers
),

-- count the total customer records created up to the current row using the
-- window'd sum function
customers_count_daily as (
    select
        days.datestamp as period,
        sum(
            coalesce(count(customers_by_day.customer_id), 0)
        ) over (
            order by days.datestamp
            rows between unbounded preceding and current row
        ) as total
    from days
    left outer join
        customers_by_day
        on days.datestamp = customers_by_day.created_at
    group by days.datestamp
)

select * from customers_count_daily
