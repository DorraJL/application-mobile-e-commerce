CREATE DATABASE productshop;

USE productshop;

CREATE TABLE users
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	firstName VARCHAR(50) NULL,
	phone VARCHAR(11) NULL,
	email VARCHAR(100) NOT NULL,
	passwordd VARCHAR(100) NOT NULL,
	token VARCHAR(256) NULL,
	statuss BOOL NULL DEFAULT 1,
	UNIQUE KEY (email),
	
)


CREATE TABLE Home_carousel
(
	uidCarousel INT PRIMARY KEY AUTO_INCREMENT,
	image VARCHAR(256) NULL,
	
)

CREATE TABLE SubCategory
(
	uidsubCategory INT PRIMARY KEY AUTO_INCREMENT,
	category VARCHAR(80),
	category_id INT,
	FOREIGN KEY (category_id) REFERENCES Category(uidCategory)
)
CREATE TABLE Category
(
	uidCategory INT PRIMARY KEY AUTO_INCREMENT,
	category VARCHAR(80)

)
CREATE TABLE Products
(
	uidProduct INT PRIMARY KEY AUTO_INCREMENT,
	nameProduct VARCHAR(90) NULL,
	description VARCHAR(256) NULL,
	stock INT NULL,
	price DOUBLE(18,2) NULL,
	status VARCHAR(80) DEFAULT 'IN STOCK',
	picture VARCHAR(256) NULL,
	category_id INT,
	FOREIGN KEY (category_id) REFERENCES SubCategory(uidsubCategory)
)

CREATE TABLE favorite
(
	uidFavorite INT PRIMARY KEY AUTO_INCREMENT,
	product_id INT,
	user_id INT,
	FOREIGN KEY(product_id) REFERENCES Products(uidProduct),
	FOREIGN KEY(user_id) REFERENCES users(persona_id)
)



CREATE TABLE orders
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	client_id INT NOT NULL,
	delivery_id INT NULL,
	address_id INT NOT NULL,
	latitude VARCHAR(50) NULL,
	longitude VARCHAR(50) NULL,
	status VARCHAR(50) DEFAULT "ENVOYE",
	receipt VARCHAR(100),
	amount DOUBLE(11,2),
	pay_type VARCHAR(50) NOT NULL,
	currentDate DATETIME DEFAULT NOW(),
	
	FOREIGN KEY (client_id) REFERENCES Person(uid),
	FOREIGN KEY (delivery_id) REFERENCES Person(uid),
	FOREIGN KEY (address_id) REFERENCES addresses(id)
);


CREATE TABLE orderDetails
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	order_id INT NOT NULL,
	product_id INT NOT NULL,
	quantity INT NOT NULL,
	price DOUBLE(11,2) NOT NULL,
	FOREIGN KEY(order_id) REFERENCES orders(id),
	FOREIGN KEY(product_id) REFERENCES Products(id)
);





/*---------------------------------------------------------------------------*/
/*-----------------  Storage PROCEDURE  || FRAVE SHOP ----------------------*/
/*-------------------------------------------------------------------------*/

DELIMITER //
CREATE PROCEDURE SP_GET_USER_BY_ID(IN UID INT )
BEGIN
	SELECT pe.uid, pe.firstName, pe.lastName, pe.phone, pe.address, pe.reference, pe.image, us.users, us.email 
	FROM person pe
	INNER JOIN users us ON pe.uid = us.persona_id
	WHERE pe.uid = UID;
END//


-- Add new users
DELIMITER //
CREATE PROCEDURE SP_REGISTER_USER (IN usu VARCHAR(50), IN email VARCHAR(100), IN passwordd VARCHAR(100) )
BEGIN
	INSERT INTO person ( firstName ) VALUE ( usu );
	INSERT INTO users ( users, email, passwordd , persona_id ) VALUE (usu, email, passwordd, LAST_INSERT_ID());
END//


DELIMITER //
CREATE PROCEDURE SP_UPDATE_INFORMATION( IN uid INT, IN nam VARCHAR(90), IN lastt VARCHAR(90), IN phone VARCHAR(11), IN address VARCHAR(90), IN reference VARCHAR(90))
BEGIN
	UPDATE person
		SET firstName = nam, 
			 lastName = lastt,
			 phone = phone, 
			 address = address, 
			 reference = reference
	WHERE person.uid = uid;
END//


-- Update Street Address - user
DELIMITER //
CREATE PROCEDURE SP_UPDATE_STREET(IN uid INT, IN ADDRESS VARCHAR(90), IN REFERENCESS VARCHAR(90) )
BEGIN
	UPDATE person
		SET address = ADDRESS, 
			 reference = REFERENCESS
	WHERE person.uid = uid;
END//


-- LIST PRODUCTS HOME
DELIMITER //
CREATE PROCEDURE SP_LIST_PRODUCTS_HOME(IN UID INT)
BEGIN
	SELECT uidProduct, nameProduct, description,  stock, price, p.status, p.picture, c.category,
	(SELECT COUNT(fa.uidFavorite) FROM favorite fa WHERE fa.user_id = UID AND fa.product_id = p.uidProduct ) AS is_favorite
	FROM Products AS p
	INNER JOIN SubCategory AS c ON p.category_id = c.uidsubCategory
	ORDER BY uidProduct DESC LIMIT 10;
END//

DELIMITER //
CREATE PROCEDURE SP_LIST_PRODUCTS_PRICE(IN UID INT ,IN MI DOUBLE,IN MA DOUBLE)
BEGIN
	SELECT uidProduct, nameProduct, description,  stock, p.price, p.status, p.picture, c.category,
	(SELECT COUNT(fa.uidFavorite) FROM favorite fa WHERE fa.user_id = UID AND fa.product_id = p.uidProduct ) AS is_favorite
	FROM Products AS p
	INNER JOIN SubCategory AS c ON p.category_id = c.uidsubCategory
	INNER JOIN favorite AS f ON p.uidProduct = f.product_id
	INNER JOIN users AS u ON f.user_id = u.id
	WHERE p.price BETWEEN MI AND MA ;
END//
--- LIST FAVORITE OF PRODUCTS
DELIMITER //
CREATE PROCEDURE SP_LIST_FAVORITE_PRODUCTS( IN UID INT )
BEGIN
	SELECT uidProduct, nameProduct, description,  stock, price, p.status, p.picture, c.category,
	(SELECT COUNT(fa.uidFavorite) FROM favorite fa WHERE fa.user_id = UID AND fa.product_id = p.uidProduct ) AS is_favorite
	FROM Products AS p
	INNER JOIN SubCategory AS c ON p.category_id = c.uidsubCategory
	INNER JOIN favorite AS f ON p.uidProduct = f.product_id
	INNER JOIN users AS u ON f.user_id = u.id
	WHERE u.id = UID;
END//

--- LIST PRODUCTS FOR CATEGORIES
DELIMITER //
CREATE PROCEDURE SP_LIST_PRODUCTS_FOR_CATEGORY(IN UIDCATEGORY INT, IN UIDUSER INT)
BEGIN
	SELECT uidProduct, nameProduct, description, stock, price, p.status, p.picture, c.category,
	(SELECT COUNT(fa.uidFavorite) FROM favorite fa WHERE fa.user_id = UIDUSER AND fa.product_id = p.uidProduct ) AS is_favorite
	FROM Products AS p
	INNER JOIN SubCategory AS c ON p.category_id = c.uidsubCategory
	LEFT JOIN favorite AS f ON p.uidProduct = f.product_id
	LEFT JOIN users AS u ON f.user_id = u.id
	WHERE c.uidsubCategory = UIDCATEGORY;
END//


DELIMITER //
CREATE PROCEDURE SP_ADD_CATEGORY(IN category VARCHAR(50), IN picture VARCHAR(100))
BEGIN
	INSERT INTO category (category, picture) VALUE (category, picture);
END//

-- GET PRODUCTS FOR ID USER
DELIMITER //
CREATE PROCEDURE SP_ORDER_DETAILS( IN ID INT )
BEGIN
	SELECT o.uidOrderDetails, o.product_id, p.nameProduct, p.picture, o.quantity, o.price  FROM orderdetails o
	INNER JOIN products p ON o.product_id = p.uidProduct
	WHERE o.orderBuy_id = ID;
END//












DELIMITER //
CREATE PROCEDURE SP_SEARCH_FOR_CATEGORY(IN IDCATEGORY INT)
BEGIN
	SELECT pro.id, pro.nameProduct, pro.description, pro.price, pro.status, ip.picture, c.category, c.id AS category_id FROM products pro
	INNER JOIN categories c ON pro.category_id = c.id
	INNER JOIN imageProduct ip ON pro.id = ip.product_id
	INNER JOIN ( SELECT product_id, MIN(id) AS id_image FROM imageProduct GROUP BY product_id) p3 ON ip.product_id = p3.product_id AND ip.id = p3.id_image
	WHERE pro.category_id = IDCATEGORY;
END//



DELIMITER //
CREATE PROCEDURE SP_LIST_subCategory_FOR_CATEGORY(IN UIDCATEGORY INT)
BEGIN
	SELECT c.uidsubCategory, c.category, c.category_id,cc.uidCategory
	FROM SubCategory  c
	INNER JOIN Category  cc ON c.category_id =cc.uidCategory
	WHERE c.category_id = UIDCATEGORY;
END//






DELIMITER //
CREATE PROCEDURE SP_REGISTER(IN firstName VARCHAR(50), IN lastName VARCHAR(50), IN phone VARCHAR(11), IN image VARCHAR(250), IN email VARCHAR(100), IN pass VARCHAR(100), IN rol INT, IN nToken VARCHAR(255))
BEGIN
	INSERT INTO Person (firstName, lastName, phone, image) VALUE (firstName, lastName, phone, image);
	
	INSERT INTO users (users, email, passwordd, persona_id, rol_id, notification_token) VALUE (firstName, email, pass, LAST_INSERT_ID(), rol, nToken);
END//

/*---------------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER //
CREATE PROCEDURE SP_LOGIN(IN email VARCHAR(100))
BEGIN
	SELECT p.uid, p.firstName, p.lastName, p.image, u.email, u.passwordd, u.rol_id, u.notification_token FROM person p
	INNER JOIN users u ON p.uid = u.persona_id
	WHERE u.email = email AND p.state = TRUE;
END//

/*---------------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER //
CREATE PROCEDURE SP_RENEWTOKENLOGIN(IN uid INT )
BEGIN
	SELECT p.uid, p.firstName, p.lastName, p.image, p.phone, u.email, u.rol_id, u.notification_token FROM person p
	INNER JOIN users u ON p.uid = u.persona_id
	WHERE p.uid = uid AND p.state = TRUE;
END//

/*---------------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER //
CREATE PROCEDURE SP_ADD_CATEGORY(IN category VARCHAR(50), IN description VARCHAR(100))
BEGIN
	INSERT INTO categories (category, description) VALUE (category, description);
END//

/*---------------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER //
CREATE PROCEDURE SP_USER_BY_ID(IN ID INT)
BEGIN
	SELECT p.uid, p.firstName, p.lastName, p.phone, p.image, u.email, u.rol_id, u.notification_token FROM person p
	INNER JOIN users u ON p.uid = u.persona_id
	WHERE p.uid = 1 AND p.state = TRUE;
END//

/*---------------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER //
CREATE PROCEDURE SP_UPDATE_PROFILE(IN ID INT, IN firstName VARCHAR(50), IN lastName VARCHAR(50), IN phone VARCHAR(11))
BEGIN
	UPDATE person
		SET firstName = firstName,
			 lastName = lastName,
			 phone = phone
	WHERE person.uid = ID;
END//

/*---------------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER //
CREATE PROCEDURE SP_USER_UPDATED(IN ID INT)
BEGIN
	SELECT p.firstName, p.lastName, p.image, u.email, u.rol_id FROM person p
	INNER JOIN users u ON p.uid = u.persona_id
	WHERE p.uid = 1 AND p.state = TRUE;
END//

/*---------------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER //
CREATE PROCEDURE SP_GET_PRODUCTS_TOP()
BEGIN
	SELECT pro.id, pro.nameProduct, pro.description, pro.price, pro.status, ip.picture, c.category, c.id AS category_id FROM products pro
	INNER JOIN categories c ON pro.category_id = c.id
	INNER JOIN imageProduct ip ON pro.id = ip.product_id
	INNER JOIN ( SELECT product_id, MIN(id) AS id_image FROM imageProduct GROUP BY product_id) p3 ON ip.product_id = p3.product_id AND ip.id = p3.id_image
	LIMIT 10;
END//

/*---------------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER //
CREATE PROCEDURE SP_SEARCH_PRODUCT(IN UID INT ,IN nameProduct VARCHAR(100))
BEGIN
	SELECT p.uidProduct, p.nameProduct, p.description, p.stock, p.price, p.status, p.picture, c.category,
	(SELECT COUNT(fa.uidFavorite) FROM favorite fa WHERE fa.user_id = UID AND fa.product_id = p.uidProduct ) AS is_favorite
	FROM Products AS p
	INNER JOIN SubCategory AS c ON p.category_id = c.uidsubCategory
	LEFT JOIN favorite AS f ON p.uidProduct = f.product_id
	LEFT JOIN users AS u ON f.user_id = u.id
	WHERE p.nameProduct LIKE CONCAT('%', nameProduct , '%');
END//

/*---------------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER //
CREATE PROCEDURE SP_SEARCH_FOR_CATEGORY(IN IDCATEGORY INT)
BEGIN
	SELECT pro.id, pro.nameProduct, pro.description, pro.price, pro.status, ip.picture, c.category, c.id AS category_id FROM products pro
	INNER JOIN categories c ON pro.category_id = c.id
	INNER JOIN imageProduct ip ON pro.id = ip.product_id
	INNER JOIN ( SELECT product_id, MIN(id) AS id_image FROM imageProduct GROUP BY product_id) p3 ON ip.product_id = p3.product_id AND ip.id = p3.id_image
	WHERE pro.category_id = IDCATEGORY;
END//


/*---------------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER //
CREATE PROCEDURE SP_LIST_PRODUCTS_ADMIN()
BEGIN
	SELECT pro.uidProduct, pro.nameProduct, pro.description, pro.price, pro.status, ip.picture, c.category, c.id AS category_id FROM products pro
	INNER JOIN category c ON pro.category_id = c.id
	INNER JOIN imageProduct ip ON pro.id = ip.product_id
	INNER JOIN ( SELECT product_id, MIN(id) AS id_image FROM imageProduct GROUP BY product_id) p3 ON ip.product_id = p3.product_id AND ip.id = p3.id_image;
END//

/*---------------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER //
CREATE PROCEDURE SP_ALL_ORDERS_STATUS(IN statuss VARCHAR(30))
BEGIN
	SELECT o.id AS order_id, o.delivery_id, CONCAT(pe.firstName, " ", pe.lastName) AS delivery, pe.image AS deliveryImage, o.client_id, CONCAT(p.firstName, " ", p.lastName) AS cliente, p.image AS clientImage, p.phone AS clientPhone, o.address_id, a.street, a.reference, a.Latitude, a.Longitude, o.status, o.pay_type, o.amount, o.currentDate
	FROM orders o
	INNER JOIN person p ON o.client_id = p.uid
	INNER JOIN addresses a ON o.address_id = a.id
	LEFT JOIN person pe ON o.delivery_id = pe.uid
	WHERE o.`status` = statuss;
END//


