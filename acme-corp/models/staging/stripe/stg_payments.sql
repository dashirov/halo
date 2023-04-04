with
payments as (
    select
        orderid as order_id,
        amount,
        paymentmethod as payment_method,
        status
    from
        {{ source('stripe', 'payment') }}
)

select * from payments
