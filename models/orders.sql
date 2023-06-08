
{{ config({
        "materialized": "incremental",
        "tags": ["orders_snapshots"],
        "alias": "orders"
    })
}}

{% set payment_methods = ['credit_card', 'coupon', 'bank_transfer', 'gift_card'] %}

{% set payments_dict = {
    'credit':'card10',
    'bank':'transfer11'
} %}


with orders as (
-- test comment 2
    select * from {{ ref('stg_orders') }}

),

payments as (
-- test comment 2
    select *

    from {{ ref('stg_payments') }}

),

order_payments as (
-- test comment 2
    select
        order_id,
        -- {{my_abc}},
        -- {{payment_methods}},
        -- {{ var('my_payment_methods') }},
        {% for payment_method in payment_methods -%}
        sum(case when payment_method = '{{ payment_method }}' then amount else 0 end) as {{ payment_method }}_amount,
        {% endfor -%}

        sum(amount) as total_amount

    from payments

    group by order_id

),

final as (
-- test comment
    select
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        orders.status,

        {% for payment_method in payment_methods -%}

        order_payments.{{ payment_method }}_amount,

        {% endfor -%}

        order_payments.total_amount as amount

    from orders


    left join order_payments
        on orders.order_id = order_payments.order_id

)

select * from final
