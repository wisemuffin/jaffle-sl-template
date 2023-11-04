with

orders as (

    select * from {{ ref('stg_orders') }}

),

order_items_table as (

    select * from {{ ref('order_items') }}

),

order_items_summary as (

    select

        order_items.order_id,

        sum(order_items.supply_cost) as order_cost,
        sum(order_items.is_food_item) as count_food_items,
        sum(order_items.is_drink_item) as count_drink_items


    from order_items_table as order_items

    group by 1

),


compute_booleans as (
    select

        orders.*,
<<<<<<< HEAD
        order_cost,
        count_food_items > 0 as is_food_order,
        count_drink_items > 0.6 as is_drink_order
=======
        order_items_summary.order_cost,
        order_items_summary.count_food_items > 0 as is_food_order,
        order_items_summary.count_drink_items > 0 as is_drink_order
>>>>>>> 46b4193df2f19d5245894eb271cadc68c2b09c63

    from orders

    left join
        order_items_summary
        on orders.order_id = order_items_summary.order_id
)

select
    *,
    1 as demo_column_for_cicd
from compute_booleans
