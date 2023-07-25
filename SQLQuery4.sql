use dannydiner



  CREATE TABLE menu (
  "product_id" INT primary key,
  "product_name" NVARCHAR(5) not null,
  "price" INT not null
);

INSERT INTO menu
  ("product_id", "product_name", "price")
VALUES
  ('1', 'sushi', '10'),
  ('2', 'curry', '15'),
  ('3', 'ramen', '12');
  

CREATE TABLE members (
  "customer_id" NVARCHAR(1) primary key,
  "join_date" DATE not null
);


INSERT INTO members
  ("customer_id", "join_date")
VALUES
  ('A', '2023/1/3'),
  ('B', '2022/11/11');

  CREATE TABLE sales (
  "customer_id" nVARCHAR(1) foreign key references members,
  "order_date" DATE not null,
  "product_id" INT foreign key references menu
);

INSERT INTO sales
  ("customer_id", "order_date", "product_id")
VALUES
  ('A', '2023/01/03', '1'),
  ('A', '2023/02/04', '2'),
  ('A', '2023/01/01', '2'),
  ('A', '2023/04/05', '3'),
  ('A', '2023/10/5', '3'),
  ('A', '2023/11/05', '3'),
  ('B', '2022/11/11', '2'),
 ('B', '2022/1/5', '2')


  select * from members;

  select * from menu;

  select * from sales;


  
drop table sales;
drop table members;
drop table menu;


  1)

  SELECT 
  s.customer_id, 
  SUM(price) AS total_sales
FROM dbo.sales AS s
JOIN dbo.menu AS m
  ON s.product_id = m.product_id
GROUP BY customer_id;


2)

SELECT 
  customer_id, 
  COUNT(DISTINCT(order_date)) AS visit_count
FROM dbo.sales
GROUP BY customer_id;


3)

WITH ordered_sales_cte AS
(
	SELECT 
    customer_id, 
    order_date, 
    product_name,
		DENSE_RANK() OVER(PARTITION BY s.customer_id ORDER BY s.order_date) AS rank
	FROM dbo.sales AS s
	JOIN dbo.menu AS m
		ON s.product_id = m.product_id
)

SELECT 
  customer_id, 
  product_name
FROM ordered_sales_cte
WHERE rank = 1
GROUP BY customer_id, product_name;


4)

SELECT 
  TOP 1 (COUNT(s.product_id)) AS most_purchased, 
  product_name
FROM dbo.sales AS s
JOIN dbo.menu AS m
  ON s.product_id = m.product_id
GROUP BY s.product_id, product_name
ORDER BY most_purchased DESC;


5)

WITH fav_item_cte AS
(
	SELECT 
    s.customer_id, 
    m.product_name, 
    COUNT(m.product_id) AS order_count,
		DENSE_RANK() OVER(PARTITION BY s.customer_id ORDER BY COUNT(s.customer_id) DESC) AS rank
FROM dbo.menu AS m
JOIN dbo.sales AS s
	ON m.product_id = s.product_id
GROUP BY s.customer_id, m.product_name
)

SELECT 
  customer_id, 
  product_name, 
  order_count
FROM fav_item_cte 
WHERE rank = 1;


6)

WITH member_sales_cte AS 
(
  SELECT 
    s.customer_id, 
    m.join_date, 
    s.order_date, 
    s.product_id,
    DENSE_RANK() OVER(PARTITION BY s.customer_id ORDER BY s.order_date) AS rank
  FROM sales AS s
	JOIN members AS m
		ON s.customer_id = m.customer_id
	WHERE s.order_date >= m.join_date)


SELECT 
  s.customer_id, 
  s.order_date, 
  m2.product_name 
FROM member_sales_cte AS s
JOIN menu AS m2
	ON s.product_id = m2.product_id
WHERE rank = 1;


7)

WITH prior_member_purchased_cte AS 
(
  SELECT 
    s.customer_id, 
    m.join_date, 
    s.order_date, 
    s.product_id,
    DENSE_RANK() OVER(PARTITION BY s.customer_id ORDER BY s.order_date DESC)  AS rank
  FROM sales AS s
	JOIN members AS m
		ON s.customer_id = m.customer_id
	WHERE s.order_date < m.join_date
)

SELECT 
  s.customer_id, 
  s.order_date, 
  m2.product_name 
FROM prior_member_purchased_cte AS s
JOIN menu AS m2
	ON s.product_id = m2.product_id
WHERE rank = 1;

8)

SELECT 
  s.customer_id, 
  COUNT(DISTINCT s.product_id) AS unique_menu_item, 
  SUM(mm.price) AS total_sales
FROM sales AS s
JOIN members AS m
	ON s.customer_id = m.customer_id
JOIN menu AS mm
	ON s.product_id = mm.product_id
WHERE s.order_date < m.join_date
GROUP BY s.customer_id


9)

WITH price_points_cte AS
(
	SELECT *, 
		CASE WHEN product_name = 'sushi' THEN price * 20
		ELSE price * 10 END AS points
	FROM menu
)

SELECT 
  s.customer_id, 
  SUM(p.points) AS total_points
FROM price_points_cte AS p
JOIN sales AS s
	ON p.product_id = s.product_id
GROUP BY s.customer_id


10)

WITH dates_cte AS 
(
	SELECT 
    *, 
    DATEADD(DAY, 6, join_date) AS valid_date, 
		EOMONTH('2023/04/05') AS last_date
	FROM members AS m
)
SELECT 
  d.customer_id, s.order_date, d.join_date, d.valid_date, d.last_date, m.product_name, 
  m.price,
	SUM( 
    CASE WHEN m.product_name = 'sushi' THEN 2 * 10 * m.price
		WHEN s.order_date BETWEEN d.join_date AND d.valid_date THEN 2 * 10 * m.price
		ELSE 10 * m.price END) AS points
FROM dates_cte AS d
JOIN sales AS s
	ON d.customer_id = s.customer_id
JOIN menu AS m
	ON s.product_id = m.product_id
WHERE s.order_date < d.last_date
GROUP BY d.customer_id, s.order_date, d.join_date, d.valid_date, d.last_date, m.product_name, m.price

