-- queries to create tables and insert dummy data

-- CREATE TABLE customers(
-- 	id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
-- 	NAME VARCHAR(50) NOT NULL,
-- 	email VARCHAR(30) NOT NULL,
-- 	location VARCHAR(100) NOT NULL,
-- 	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
-- 	update_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP()
-- );

-- insert  into `customers`(`id`,`name`,`email`,`location`,`created_at`,`update_at`) values (1,'John Smith','john.smith@gmail.com','New York, USA','2023-11-03 16:03:53','2023-11-03 16:04:24'),(2,'Jane Doe','jane.doe@gmail.com','Los Angeles, USA','2023-11-03 16:05:03','2023-11-03 16:05:03'),(3,'David johnson','david@gmail.com','Chicago, USA','2023-11-03 16:06:02','2023-11-03 16:06:02');




-- CREATE TABLE orders(
-- 	id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
-- 	customer_id INT(11) UNSIGNED NOT NULL,
-- 	order_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
-- 	total_amount INT(11) UNSIGNED NOT NULL,
-- 	FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE RESTRICT ON UPDATE CASCADE,
-- 	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
-- 	update_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP()
-- );

-- insert  into `orders`(`id`,`customer_id`,`order_date`,`total_amount`,`created_at`,`update_at`) values (1,1,'2023-11-03 16:19:17',38000,'2023-11-03 16:19:17','2023-11-03 16:19:17'),(2,2,'2023-11-03 16:20:18',72000,'2023-11-03 16:20:18','2023-11-03 16:20:18'),(3,1,'2023-11-03 16:22:49',100,'2023-11-03 16:22:49','2023-11-03 16:22:49');




-- CREATE TABLE categories(
-- 	id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
-- 	NAME VARCHAR(50) NOT NULL,
-- 	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
-- 	update_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP()
-- );

-- insert  into `categories`(`id`,`name`,`created_at`,`update_at`) values (1,'Gadgets','2023-11-03 16:02:11','2023-11-03 19:02:19'),(2,'Groceries','2023-11-03 16:09:50','2023-11-03 19:02:34');



-- CREATE TABLE products(
-- 	id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
-- 	category_id INT(11) UNSIGNED NOT NULL,
-- 	FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE RESTRICT ON UPDATE CASCADE,
-- 	NAME VARCHAR(50) NOT NULL,
-- 	description VARCHAR(255) NOT NULL,
-- 	price INT(11) NOT NULL,
-- 	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
-- 	update_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP()
-- );

-- insert  into `products`(`id`,`category_id`,`name`,`description`,`price`,`created_at`,`update_at`) values (1,1,'Smartphone','a handy device',12000,'2023-11-03 16:13:29','2023-11-03 16:14:15'),(2,1,'Laptop','a device to work',38000,'2023-11-03 16:14:07','2023-11-03 16:14:36'),(3,1,'Desktop','a powerfull device for production',60000,'2023-11-03 16:15:02','2023-11-03 16:15:02'),(4,2,'Rice','a product to have as daily food',70,'2023-11-03 16:15:31','2023-11-03 16:15:31'),(5,2,'Ice cream','a product to have with dear and near ones',60,'2023-11-03 16:16:35','2023-11-03 16:16:35'),(6,2,'Chocolate','a product for girls and babies',10,'2023-11-03 16:16:58','2023-11-03 16:16:58');




-- CREATE TABLE order_items(
-- 	id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
-- 	order_id INT(11) UNSIGNED NOT NULL,
-- 	FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE RESTRICT ON UPDATE CASCADE,
-- 	product_id INT(11) UNSIGNED NOT NULL,
-- 	FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE RESTRICT ON UPDATE CASCADE,
-- 	quantity INT(6) UNSIGNED NOT NULL,
-- 	unit_price INT(11) UNSIGNED NOT NULL,
-- 	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
-- 	update_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP()
-- );

-- insert  into `order_items`(`id`,`order_id`,`product_id`,`quantity`,`unit_price`,`created_at`,`update_at`) values (4,1,2,1,38000,'2023-11-03 16:19:45','2023-11-03 16:19:45'),(5,2,1,1,12000,'2023-11-03 16:20:56','2023-11-03 16:20:56'),(6,3,5,1,60,'2023-11-03 16:23:37','2023-11-03 16:23:37'),(7,3,6,4,10,'2023-11-03 16:23:47','2023-11-03 16:23:47'),(8,2,3,1,60000,'2023-11-03 19:01:41','2023-11-03 19:01:41');





                                                                        -- Tasks --

-- task 1:

-- Write a SQL query to retrieve all the customer information along with the total number of orders 
-- placed by each customer. Display the result in descending order of the number of orders.

SELECT customers.*, COUNT(orders.id) AS total_number_of_order_placed
FROM customers
INNER JOIN orders ON customers.id = orders.customer_id
GROUP BY orders.customer_id ORDER BY total_number_of_order_placed DESC;




-- task 2:

-- Write a SQL query to retrieve the product name, quantity, and total amount 
-- for each order item. Display the result in ascending order of the order ID.

SELECT o.id,p.name, oi.quantity, o.total_amount
FROM products p
INNER JOIN order_items oi ON oi.product_id = p.id
INNER JOIN orders o ON o.id = oi.order_id
ORDER BY o.id ASC;




-- task 3:

-- Write a SQL query to retrieve the total revenue generated by each product category. 
-- Display the category name along with the total revenue in descending order of the revenue.

SELECT c.name AS category_name,SUM(oi.quantity*oi.unit_price) AS revenue
FROM categories c
INNER JOIN products p ON p.category_id = c.id
INNER JOIN order_items oi ON oi.product_id = p.id
GROUP BY p.category_id ORDER BY revenue DESC;




-- task 4:

-- Write a SQL query to retrieve the top 5 customers who have made the highest total purchase amount. 
-- Display the customer name along with the total purchase amount in descending order of the purchase amount.


SELECT c.name AS customer_name,SUM(o.total_amount) AS purchase_amount
FROM customers c
INNER JOIN orders o ON o.customer_id = c.id
GROUP BY o.customer_id ORDER BY purchase_amount DESC LIMIT 5;