use pizza_sales;
--  Retrieve the total number of orders placed.

SELECT 
    COUNT(order_id) AS Total_orders
FROM
    orders;
    
--  Calculate the total revenue generated from pizza sales.
    
SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS total_revenue
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id;
    
-- Identify the highest-priced pizza.
    
SELECT 
    pizza_types.name, pizzas.price
FROM
    pizzas
        JOIN
    pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;
    
 -- Identify the most common pizza size ordered.   
 
SELECT 
    pizzas.size,
    COUNT( order_details.pizza_id) AS pizza_size_count
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizzas.size
ORDER BY pizza_size_count DESC
LIMIT 2;

--  List the top 5 most ordered pizza types along with their quantities.

SELECT 
    pizzas.pizza_type_id,
    pizza_types.name,
    SUM(order_details.quantity) AS Total_quantity
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
        JOIN
    pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY pizzas.pizza_type_id , pizza_types.name
ORDER BY Total_quantity DESC
LIMIT 5;
