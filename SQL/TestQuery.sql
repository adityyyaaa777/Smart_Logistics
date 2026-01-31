use smart_logistics;


# Customer record
INSERT INTO customers (
    customer_name,
    email,
    phone
) VALUES (
    'Adi Sharma',
    'adi@example.com',
    '9876543210'
);



# Role Record
INSERT INTO roles (role_name)
VALUES
('CUSTOMER'),
('ADMIN');


# User 
INSERT INTO users (
    linked_customer_id,
    role_id,
    username,
    password
) VALUES (
    1001,
	5001,
    'adi123',
    'adi@123'
);




# Addresses
INSERT INTO addresses (
    customer_id,
    address_line,
    city,
    state,
    pincode
) VALUES
(1001,'MG Road, Andheri East', 'Mumbai', 'Maharashtra', '400069');



# Orders
INSERT INTO orders (
    customer_id,
    order_date,
    order_status,
    pickup_address_id,
    delivery_address_id
) VALUES (
    1001,
    NOW(),
    'PLACED',
    4001,
	4001
);



# order_items
INSERT INTO order_items (
    order_id,
    item_name,
    quantity
) VALUES (
    7001,
    'Electronics Package',
    2
);



# Shipments
INSERT INTO shipments (
    order_id,
    tracking_number,
    shipment_type,
    current_status
) VALUES (
    7001,
    'TRK202601251234',
    'Parcel',
    'IN TRANSIT'
);



# Shipment Tracking
INSERT INTO shipment_tracking (
    shipment_id,
    current_location,
    latitude,
    longitude
) VALUES (
    9001,
    'Pune',
    19.0760,
    72.8777
);



 # Shipment History
 INSERT INTO shipment_status_history (
    shipment_id,
    status,
    updated_time
) VALUES
(9001, 'ORDER PLACED', NOW()),
(9001, 'IN PROCESS', NOW());




# FINAL QUERY
SELECT
    c.customer_name,
    o.order_id,
    s.shipment_id,
    s.current_status,
    st.tracking_id
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN shipments s ON o.order_id = s.order_id
JOIN shipment_tracking st ON s.shipment_id = st.shipment_id;






