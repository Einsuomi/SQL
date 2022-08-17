#### Question 1 ####

## Please fetch these columns from the "products" table:
##
##	- product_name		(The product_name column)
##	- list_price		(The list_price column)
##	- date_added		(The date_added column)
##
## Please only return the rows with a list price that’s greater than 500 and less than 2000.
## Please also sort the result set by the "date_added" column in descending order.

SELECT 
	product_name,list_price, date_added 
FROM 
	products
WHERE 
	list_price>500 AND list_price< 2000
ORDER BY
	date_added DESC;


#### Question 2 ####

## Please fetch these column and data from the "order_items" table:
##
##	- item_id			(The item_id column)
##	- item_price		(The item_price column)
##	- discount_amount	(The discount_amount column)
##	- quantity			(The quantity column)
##	- price_total		(A column that’s calculated by multiplying the item price by the quantity)
##	- discount_total	(A column that’s calculated by multiplying the discount amount by the quantity)
##	- item_total		(A column that’s calculated by subtracting the discount amount from the item price
##						 and then multiplying by the quantity)
##
## Please only return the rows where the "item_total" is greater than 500.
## Pleasee also sort the result set by the "item_total" column in descending order.

SELECT 
	item_id,
    item_price,
    discount_amount,
    quantity,
    item_price*quantity AS price_total,
    discount_amount*quantity AS discount_total,
    (item_price-discount_amount)*quantity AS item_total
FROM 
	order_items
WHERE 
	(item_price-discount_amount)*quantity>500
ORDER BY 
	item_total DESC;


#### Question 3 ####

## Please write a query that inner joins the "categories" table to the "products" table and returns these columns:
##
##	- category_name
##	- product_name
##	- list_price
##
## Sort the result set by the "category_name" column and then by the "product_name" column in ascending order.

SELECT 
	category_name,product_name,list_price
FROM 
	categories AS T1 INNER JOIN products AS T2 ON T1.category_id=T2.category_id
ORDER BY 
	category_name,
	product_name;


#### Question 4 ####

## Please write a query to identify the products in the "products" table that have the same list price.
## The query should return their "product_id", "product_name" and "list_price" in the result set.
##
## Hint: CROSS JOIN the "products" table to itself.

SELECT 
	T1.product_id,T1.product_name,T1.list_price
FROM 
	products AS T1 CROSS JOIN products AS T2
WHERE 
	T1.list_price = T2.list_price 
    AND 
    T1.product_id!=T2.product_id;


#### Question 5 ####

## Please identify the categories in the "categories" table that do not match any product in the "products" table.
## Your query should return their "category_name" in the result set.
##
## NOTE: You must present THREE different methods in your answer. Please write one query for each method used.

## 1. LEFT JOIN
SELECT 
	category_name
FROM 
	categories AS T1 LEFT JOIN products AS T2 ON T1.category_id=T2.category_id
WHERE 
	product_id IS NULL;
    
## 2. SUBQUERY 
SELECT 
	category_name
FROM 
	categories
WHERE 
	category_id NOT IN (SELECT DISTINCT
							category_id
						FROM
							products);
                            
##3. NOT EXISTS
SELECT 
	category_name
FROM 
	categories AS T1
WHERE 
	NOT EXISTS (SELECT 
					*
				FROM 
					products AS T2
				WHERE 
					T2.category_id = T1.category_id);



#### Question 6 ####

## Please return one row for each category that has products, and each row returned should contain the following values:
##
##	- category_name
##	- The number of products in the "products" table that belong to the category
##	- The maximum list price of products in the "products" table that belong to the category
##
## Sort the result set so that the category with the most products appears first.

SELECT 
	category_name,COUNT(product_name) AS "The number of products",MAX(list_price) AS "The maximum list price"
FROM 
	categories AS T1 INNER JOIN products AS T2 ON T1.category_id=T2.category_id
GROUP BY 
	category_name
ORDER BY 
	COUNT(product_name) DESC;


#### Question 7 ####

## Please identify the products whose list price is greater than the average list price for all products.
## Return the "product_name" and "list_price" columns for each product satisfying the given criteria.
## Please also sort the result set by the "list_price" column in descending order.

SELECT 
	product_name,list_price
FROM 
	products
WHERE 
	list_price > (SELECT 
					AVG(list_price)
				  FROM 
					products)
ORDER BY 
	list_price DESC;


#### Question 8 ####

## Please return the product name and discount percent of each product that has a unique discount percent.
## In other words, don’t include products that have the same discount percent as another product.
## Please sort the result set by the "product_name" column in ascending order.

SELECT 
	product_name,discount_percent
FROM 
	products
WHERE 
	discount_percent IN (    SELECT 
								discount_percent
							 FROM
								products
							 GROUP BY 
								discount_percent
							 HAVING 
								COUNT(*)=1)
ORDER BY 
	product_name;




