-- Calculate the percentage contribution of each pizza type to total revenue.

SELECT 
    pizza_types.category,
    ROUND(SUM(order_details.quantity * pizzas.price) / (SELECT 
                    ROUND(SUM(order_details.quantity * pizzas.price),
                                2) AS total_sales
                FROM
                    order_details
                        JOIN
                    pizzas ON order_details.pizza_id = pizzas.pizza_id) * 100,
            2) AS total_revenu
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
        JOIN
    pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY pizza_types.category
ORDER BY total_revenu DESC;

-- Analyze the cumulative revenue generated over time.


SELECT  order_date,
Round(sum(revenue) over (order by order_date),2) as cum_revenu 
FROM
(SELECT 
    orders.order_date,
    SUM(order_details.quantity * pizzas.price) AS revenue
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
        JOIN
    orders ON orders.order_id = order_details.order_id
GROUP BY orders.order_date) as sales;

-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.

SELECT 
  category,name, revenue ,RANK_
  FROM
(SELECT 
    category, name, revenue,
    RANK() over (partition by category order by revenue desc) as RANK_ 
FROM(
SELECT 
    pizza_types.name,
    pizza_types.category,
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS revenue
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
        JOIN
    pizza_types ON pizza_types.pizza_type_id = pizzas.pizza_type_id
GROUP BY pizza_types.category , pizza_types.name ) as a )as b where RANK_ <= 3;


