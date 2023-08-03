SELECT product_category_name, count(*) as product_amount
FROM products
GROUP BY product_category_name
ORDER BY product_amount;

SELECT product_category_name, COUNT(oi.product_id) AS products_count 
FROM order_items oi
LEFT JOIN products p
ON  oi.product_id=p.product_id
GROUP BY product_category_name
ORDER BY products_count;

-- average monthly income of all sellers
SELECT AVG(sum_price)
FROM (SELECT YEAR(o.order_purchase_timestamp),MONTH(o.order_purchase_timestamp),oi.seller_id, SUM(oi.price) as sum_price FROM
order_items oi
JOIN orders o ON oi.order_id = o.order_id
GROUP BY YEAR(o.order_purchase_timestamp),MONTH(o.order_purchase_timestamp), oi.seller_id) temp;

SELECT 
    ROUND(
          SUM(oi.price)
          / 
          (TIMESTAMPDIFF(MONTH, MIN(o.order_purchase_timestamp), MAX(o.order_purchase_timestamp) ) +1), 
          2
          ) AS avg_monthly_earnings
FROM
    order_items AS oi
    JOIN
    orders AS o
    USING
    (order_id);