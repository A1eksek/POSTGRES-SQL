Смотрим те столбцы, где country USA 
SELECT company_name, contact_name, country
FROM customers
WHERE country = 'USA'

делаем выборку диапазоном
SELECT * FROM products
WHERE unit_price > 20 AND unit_price < 30

Выводим кол-во
SELECT COUNT(*) FROM products
WHERE unit_price > 20

Вывод условием "если discontinued = 1"
SELECT * FROM products
WHERE discontinued = 1

Вывод условием "если city не равно 'Berlin'"
SELECT * FROM customers
<> и != одео и тоже
WHERE city <> 'Berlin'
WHERE city != 'Berlin'

Вывод условием "если order_date > '1998-02-02' (год. месяц. день.)"
SELECT * FROM orders
WHERE order_date > '1998-03-02'

Вывод условием "Если город или берлин или лондон или сан франциско"
SELECT * FROM customers
WHERE city = 'Berlin' OR city = 'London' OR city = 'San Francisco'

Вывод условием 
SELECT * FROM orders
WHERE shipped_date > '1998-04-30' AND (freight < 75 OR freight > 150)

SELECT * FROM orders
WHERE freight BETWEEN 20 AND 40  AND (ship_city = 'London' or ship_city = 'Oulu') AND ship_address = '90 Wadhurst Rd.'

SELECT * from customers
WHERE country = 'Mexico' OR country = 'Germany'

SELECT * FROM customers
WHERE country IN('USA', 'Germany')

SELECT * FROM products
WHERE category_id IN (1, 3, 5, 7)

Сортировка по алфовиту DISTINCT, ACS - ПО ВОЗРАСТАНИЮ, DESC - ПО УБЫВАНИЮ
SELECT DISTINCT unit_price
FROM products
ORDER BY unit_price DESC

Выводим все, кроме того что в скобках
SELECT *
FROM customers
WHERE country NOT IN ('Mexico', 'Germany')

Выводим список по алфавиту
SELECT DISTINCT country
FROM customers
ORDER BY country

Выводит список по алфавиту наоборот в приаритете country
SELECT DISTINCT country, city
FROM customers
ORDER BY country DESC, city DESC

Выводит столбец ship_city с London и сортрует order_date
SELECT ship_city, order_date
FROM orders
WHERE ship_city = 'London'
ORDER BY order_date

Выводится минимальная дата order_date связаная с столбцом ship_city которая = "London"
SELECT MIN(order_date)
FROM orders
WHERE ship_city = 'London'

Выводит столбцы где ship_city = 'London' и order_date выдаётся по убыванию
SELECT ship_city, order_date
FROM orders
WHERE ship_city = 'London'
ORDER BY order_date DESC

SELECT MAX(order_date)
from orders
where ship_city = 'London'

AVG - Среднее арифмитическое число
SELECT AVG(unit_price)
FROM products
WHERE discontinued <> 1

SUM - СУММА
SELECT SUM(units_in_stock)
FROM products
WHERE discontinued <> 1

SELECT * FROM orders
WHERE ship_country IN ('France','Austria','Spania')

SELECT * FROM orders
ORDER BY required_date DESC, shipped_date

Домашка
SELECT MIN(unit_price) FROM products
WHERE units_in_stock > 30

Устанавливаем лимиты
SELECT product_name, unit_price
FROM products LIMIT 10

берём таблицу order столбец ship_country, где freight > 50, групируем ship_country и выводит по убыванию
SELECT ship_country, COUNT(*)
FROM orders
WHERE freight > 50
GROUP BY ship_country
ORDER BY COUNT(*) DESC


SELECT category_id, SUM(units_in_stock)
FROM products
GROUP BY category_id
ORDER BY SUM(units_in_stock) DESC
LIMIT 5 

Выводим столбец на первую букву или последнюю или между
SELECT last_name, first_name
FROM employees
WHERE last_name LIKE 'F%' OR last_name LIKE '%a' OR last_name LIKE '%e%'

HABING - Доп. условие (как я понял)
SELECT  category_id, SUM(unit_price * units_in_stock)
FROM products
WHERE discontinued <> 1
GROUP BY category_id
HAVING SUM (unit_price * units_in_stock) > 5000
ORDER BY SUM(unit_price * units_in_stock) DESC

Домашка1
SELECT AVG(shipped_date - order_date)
FROM orders
WHERE ship_country = 'USA'

Домашка2
SELECT unit_price * units_in_stock AS QU
FROM products
WHERE discontinued <> 0

SELECT DISTINCT suppliers.company_name
FROM suppliers
JOIN customers USING(country)

SELECT product_name, suppliers.company_name, units_in_stock
FROM products
INNER JOIN suppliers ON products.supplier_id = suppliers.supplier_id
ORDER BY units_in_stock DESC

SELECT category_name, SUM(unit_price * units_in_stock)
FROM products
JOIN categories ON products.category_id = categories.category_id
WHERE discontinued <> 1
GROUP BY category_name
HAVING SUM(unit_price * units_in_stock) > 5000
ORDER BY SUM(unit_price * units_in_stock) DESC

SELECT order_id, customer_id, first_name, last_name, title
FROM orders
INNER JOIN employees ON orders.employee_id = employees.employee_id


SELECT company_name, product_name
FROM suppliers
LEFT JOIN products ON products.supplier_id = suppliers.supplier_id

SELECT company_name, order_id
FROM customers
LEFT JOIN  orders ON orders.customer_id = customers.customer_id
WHERE order_id IS NULL

SELECT COUNT(*)
FROM employees
LEFT JOIN orders ON orders.employee_id = employees.employee_id
WHERE order_id IS NULL

SELECT company_name
FROM suppliers
WHERE country IN (SELECT DISTINCT country FROM customers)

SELECT DISTINCT suppliers.company_name
FROM suppliers
JOIN customers USING(country)

SELECT category_name, SUM(units_in_stock)
FROM products
INNER JOIN categories USING(category_id)
GROUP BY category_name
ORDER BY SUM(units_in_stock) DESC
LIMIT (SELECT MIN(product_id) + 4 FROM products)


SELECT product_name, units_in_stock
FROM products
WHERE units_in_stock > 
		(SELECT AVG(units_in_stock)
		FROM products)

ORDER BY units_in_stock

SELECT company_name, contact_name
FROM customers
WHERE EXISTS (SELECT customers.customer_id FROM orders
				WHERE customers.customer_id = customers.customer_id
				AND freight BETWEEN 50 AND 100)

SELECT company_name, contact_name
FROM customers
WHERE not EXISTS(SELECT customer_id FROM orders
					WHERE customer_id = customer_id
					AND order_date BETWEEN '1996-07-04' AND '1996-07-05'
					)

SELECT country, city
FROM customers
WHERE EXISTS(SELECT customer_id FROM orders
				WHERE customer_id = customers.customer_id
				AND ship_country LIKE 'N%')



SELECT *
INTO tmp_customers
FROM customers

SELECT region
FROM tmp_customers



UPDATE tmp_customers
SET region = 'noname'
WHERE region IS NULL

CREATE OR REPLACE FUNCTION fix_customer_region() RETURNS void AS $$
	UPDATE tmp_customers
	SET region = NULL
	WHERE region = 'noname_1'

$$ LANGUAGE SQL;

SELECT fix_customer_region()





