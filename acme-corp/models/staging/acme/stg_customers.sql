with customers as (

    select
        id as customer_id,
        first_name,
        last_name,
        created_at,
        deleted_at

    from {{ source('acme', 'customers') }}
)

select * from customers
