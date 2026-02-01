use smart_logistics;

select * from Customers;
select * from orders;
select * from addresses;
select * from shipments;


use smart_logistics;

Delimiter $$
CREATE PROCEDURE get_addresses_by_customer(IN p_customer_id int)
BEGIN
	SELECT address_id, customer_id , address_line , city , state , pincode FROM addresses
    WHERE customer_id = p_customer_id;
END $$
Delimiter ;


# CREATE USER WITH ROLE
Delimiter $$
CREATE PROCEDURE create_user_with_role(
	IN p_name varchar(100),
    IN p_username varchar(100),
    IN p_password varchar(100),
    IN p_role_id int
)
BEGIN
	INSERT INTO users(name,username,password,role_id)
    VALUES(p_name,p_username,p_password,p_role_id);

END$$
Delimiter ;


# CREATE ADMIN OR AGENT
DELIMITER $$
CREATE PROCEDURE create_admin_or_agent (
    IN p_username VARCHAR(100),
    IN p_password VARCHAR(100),
    IN p_role_id INT
)
BEGIN
    INSERT INTO users (username, password, role_id, linked_customer_id)
    VALUES (p_username, p_password, p_role_id, NULL);
END$$

DELIMITER ;


# GET ADMINS AND AGENT LIST;
DELIMITER $$
CREATE PROCEDURE get_admins_and_agents ()
BEGIN
    SELECT user_id, username, role_id
    FROM users
    WHERE role_id IN (2,3);
END$$

DELIMITER ;


# GET ADMINS LIST;
DELIMITER $$
CREATE PROCEDURE get_admins()
BEGIN
    SELECT user_id, username, role_id
    FROM users
    WHERE role_id = 2;
END $$
DELIMITER ;


# GET AGENTS LIST;
DELIMITER $$
CREATE PROCEDURE get_agents()
BEGIN
    SELECT user_id, username, role_id
    FROM users
    WHERE role_id = 3;
END $$
DELIMITER ;


# GET ALL ORDERS LIST;
DELIMITER $$
CREATE PROCEDURE GetAllOrders()
BEGIN
    SELECT
        o.order_id,
        c.customer_name,

        CONCAT(a1.address_line, ', ', a1.city) AS pickup_address,
        CONCAT(a2.address_line, ', ', a2.city) AS delivery_address,

        o.order_status
    FROM orders o

    INNER JOIN customers c
        ON o.customer_id = c.customer_id

    LEFT JOIN addresses a1
        ON o.pickup_address_id = a1.address_id

    LEFT JOIN addresses a2
        ON o.delivery_address_id = a2.address_id;

END $$
DELIMITER ;

# DELETE ORDERS
DELIMITER $$
CREATE PROCEDURE DeleteOrder(IN oid INT)
BEGIN
    DELETE FROM orders
    WHERE order_id = oid;
END $$

DELIMITER ;





DROP PROCEDURE GetAllOrders;
DROP PROCEDURE get_admins_and_agents ;
DROP PROCEDURE IF EXISTS create_admin_or_agent;
