with orders as (

    select
        id as order_id,
        customer_id,
        order_date,
        status

    from {{ source('acme', 'orders') }}
)

select * from orders
