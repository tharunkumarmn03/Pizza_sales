-- Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT 
    pizza_types.category,
    SUM(order_details.quantity) AS total_quantity_category
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
        JOIN
    pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY pizza_types.category
ORDER BY total_quantity_category DESC;

--  Determine the distribution of orders by hour of the day.

SELECT 
    HOUR(order_time), COUNT(order_id) AS order_count
FROM
    orders
GROUP BY HOUR(order_time);

--  Join relevant tables to find the category-wise distribution of pizzas.

select category, count(name) from pizza_types group by category ;

-- Group the orders by date and calculate the average number of pizzas ordered per day.


select round(avg(total_order_per_day),0) as average_pizza_per_day from 
(SELECT 
    orders.order_date, COUNT(order_details.quantity) as total_order_per_day 
FROM
    order_details
        JOIN
    orders ON order_details.order_id = orders.order_id
GROUP BY orders.order_date
ORDER BY orders.order_date) as order_quantity ;

--  Determine the top 3 most ordered pizza types based on revenue.

SELECT 
    pizza_types.name,
    SUM(order_details.quantity * pizzas.price) AS revenu
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
        JOIN
    pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY pizza_types.name
ORDER BY revenu DESC
LIMIT 3;


