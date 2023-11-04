with

orders as (

    select * from {{ ref('stg_orders') }}

),

order_items_table as (

    select * from {{ ref('order_items') }}

),

order_items_summary as (

    select

        1 as order_id, -- order_items.order_id, -- what a rookie error

        sum(order_items.supply_cost) as order_cost,
        sum(order_items.is_food_item) as count_food_items,
        sum(order_items.is_drink_item) as count_drink_items


    from order_items_table as order_items

    group by 1

),


compute_booleans as (
    select

        orders.*,
        order_items_summary.order_cost,
        order_items_summary.count_food_items > 0 as is_food_order,
                count_drink_items > 1 as is_drink_order -- making some regression errors and linting issues

    from orders

    left join
        order_items_summary
        on orders.order_id = order_items_summary.order_id
)

select * from order_items_summary
