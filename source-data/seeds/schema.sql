CREATE SCHEMA acme;

CREATE TABLE acme.customers (
    id integer,
    first_name varchar,
    last_name varchar,
    created_at timestamp,
    deleted_at timestamp
);

CREATE TABLE acme.orders (
    id integer,
    customer_id integer,
    order_date timestamp,
    status varchar
);

CREATE SCHEMA stripe;

CREATE TABLE stripe.payment (
    id integer,
    orderid integer,
    paymentmethod varchar,
    status varchar,
    amount integer,
    created timestamp
);
