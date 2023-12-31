DROP TABLE Users cascade constraints;
CREATE TABLE Users( 
        USER_ID INTEGER  PRIMARY KEY,
        USER_FIRST_NAME VARCHAR(225) NOT NULL,
        USER_LAST_NAME VARCHAR(225) NOT NULL,
        USER_CONTACT INTEGER NOT NULL,
        USER_ROLE VARCHAR(225) NOT NULL,
        USER_EMAIL VARCHAR(225) NOT NULL,
        USER_PASSWORD VARCHAR(225) NOT NULL,
	USER_CODE INTEGER,
	USER_STATUS VARCHAR(225)
);
DROP TABLE Shop cascade constraints;

CREATE TABLE Shop(
        SHOP_ID INTEGER CONSTRAINT Shop_Pk PRIMARY KEY,
        SHOP_NAME VARCHAR(225) NOT NULL,
        SHOP_LOCATION VARCHAR(225) NOT NULL,
        OWNER_NAME VARCHAR(225) NOT NULL,
        SHOP_KEYWORD VARCHAR(255) NOT NULL,
	SHOP_DESCRIPTION VARCHAR2(225),
        USER_ID INTEGER,
       CONSTRAINT fk_shop
            FOREIGN KEY(USER_ID) REFERENCES Users(USER_ID)
           ON DELETE CASCADE
);
DROP TABLE Cart cascade constraints;

CREATE TABLE Cart(
        CART_ID INTEGER CONSTRAINT Cart_Pk PRIMARY KEY,
        USER_ID INTEGER,
        CONSTRAINT fk_cart FOREIGN KEY(USER_ID) REFERENCES Users(USER_ID)
            ON DELETE CASCADE
);
DROP TABLE Orders cascade constraints;

CREATE TABLE Orders(
        ORDER_ID INTEGER CONSTRAINT Order_pk PRIMARY KEY,
        ORDER_DATE DATE NOT NULL,
        CART_ID INTEGER,
        SLOT_ID INTEGER,
	STATUS	VARCHAR2(25),
        CONSTRAINT fk_orders FOREIGN KEY(CART_ID) REFERENCES Cart(CART_ID),
        CONSTRAINT fk_orderss FOREIGN KEY(SLOT_ID) REFERENCES CollectionSlot(SLOT_ID)
        ON DELETE CASCADE
);
DROP TABLE Product cascade constraints;

CREATE TABLE Product(
        PRODUCT_ID INTEGER CONSTRAINT Product_Pk PRIMARY KEY,
        PRODUCT_NAME VARCHAR(225) NOT NULL,
        PRODUCT_CATEGORY VARCHAR(225) NOT NULL,
        PRODUCT_DECRIPTION VARCHAR(225) NOT NULL,
        ALLERGY_INFO VARCHAR(225) NOT NULL,
        PRODUCT_PRICE DECIMAL NOT NULL,
        STOCK_AVAILBLE INTEGER NOT NULL,
        MIN_ORDER INTEGER NOT NULL,
        MAX_ORDER INTEGER NOT NULL,
        PRODUCT_IMAGENAME VARCHAR(225),
        SHOP_ID INTEGER,
        CONSTRAINT fk_Product
            FOREIGN KEY(SHOP_ID) REFERENCES Shop(SHOP_ID)
            ON DELETE CASCADE
);
DROP TABLE Feedback cascade constraints;

CREATE TABLE Feedback(
        FEEDBACK_ID INTEGER CONSTRAINT Feedback_Pk PRIMARY KEY,
        COMMENTS VARCHAR(225),
        PRODUCT_ID INTEGER,
        USER_ID INTEGER,
        CONSTRAINT fk_Feedbacks FOREIGN KEY(PRODUCT_ID) REFERENCES Product(PRODUCT_ID),
        CONSTRAINT fk_Feedback FOREIGN KEY(USER_ID) REFERENCES  Users(USER_ID)
        ON DELETE CASCADE 
);

DROP TABLE discount cascade constraints;

CREATE TABLE Discount(
        DISCOUNT_ID INTEGER CONSTRAINT Discount_pk PRIMARY KEY,
        DISCOUNT_PERCENTAGE INTEGER,
        PRODUCT_ID INTEGER,
        CONSTRAINT  fk_Discount FOREIGN KEY(PRODUCT_ID) REFERENCES Product(PRODUCT_ID)
        ON DELETE CASCADE
);
DROP TABLE Order_Product cascade constraints;

CREATE TABLE Order_Product(
        ORDER_ID INTEGER,
        PRODUCT_ID INTEGER,
        ORDER_QUANTITY INTEGER NOT NULL,
        PRIMARY KEY(ORDER_ID,PRODUCT_ID)
);
DROP TABLE Payment cascade constraints;

CREATE TABLE Payment(
        PAYMENT_ID INTEGER CONSTRAINT Payment_pk PRIMARY KEY,
        TOTAL_AMOUNT DECIMAL NOT NULL,
        PAYMENT_STATUS INTEGER NOT NULL,
        ORDER_ID INTEGER,
        USER_ID INTEGER,
        CONSTRAINT fk_Payment FOREIGN KEY(ORDER_ID) REFERENCES Orders(ORDER_ID),
        CONSTRAINT fk_payments FOREIGN KEY(USER_ID) REFERENCES Users(USER_ID)
        ON DELETE CASCADE
);
DROP TABLE CollectionSlot cascade constraints;
CREATE TABLE CollectionSlot(
    SLOT_ID INTEGER CONSTRAINT Collectionslots_Pk PRIMARY KEY,
    COLLECTION_DATE  DATE NOT NULL,
    COLLECTION_TIME TIMESTAMP NOT NULL,
    ORDER_ID INTEGER
);



DROP SEQUENCE seq_cart_id;

CREATE SEQUENCE seq_cart_id
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

CREATE OR REPLACE TRIGGER "CART_T1"
BEFORE INSERT
ON "CART"
FOR EACH ROW
BEGIN 
:new.cart_id:=seq_cart_id.nextval;
END;

/

DROP SEQUENCE seq_user_id;

CREATE SEQUENCE seq_user_id
START WITH 200
INCREMENT BY 1
NOCACHE
NOCYCLE;

CREATE OR REPLACE TRIGGER "USERS_T1"
BEFORE INSERT
ON "USERS"
FOR EACH ROW
BEGIN 
:new.user_id:=seq_user_id.nextval;
END;

/

DROP SEQUENCE seq_shop_id;

CREATE SEQUENCE seq_shop_id
START WITH 400
INCREMENT BY 1
NOCACHE
NOCYCLE;

CREATE OR REPLACE TRIGGER "SHOP_T1"
BEFORE INSERT
ON "SHOP"
FOR EACH ROW
BEGIN 
:new.shop_id:=seq_shop_id.nextval;
END;

/


DROP SEQUENCE seq_order_id;

CREATE SEQUENCE seq_order_id
START WITH 600
INCREMENT BY 1
NOCACHE
NOCYCLE;

CREATE OR REPLACE TRIGGER "ORDER_T1"
BEFORE INSERT
ON "ORDERS"
FOR EACH ROW
BEGIN 
:new.order_id:=seq_order_id.nextval;
END;

/


DROP SEQUENCE seq_product_id;

CREATE SEQUENCE seq_product_id
START WITH 800
INCREMENT BY 1
NOCACHE
NOCYCLE;

CREATE OR REPLACE TRIGGER "PRODUCT_T1"
BEFORE INSERT
ON "PRODUCT"
FOR EACH ROW
BEGIN 
:new.product_id:=seq_product_id.nextval;
END;

/

DROP SEQUENCE seq_feedback_id;

CREATE SEQUENCE seq_feedback_id
START WITH 1000
INCREMENT BY 1
NOCACHE
NOCYCLE;

CREATE OR REPLACE TRIGGER "FEEDBACK_T1"
BEFORE INSERT
ON "FEEDBACK"
FOR EACH ROW
BEGIN 
:new.feedback_id:=seq_feedback_id.nextval;
END;

/

DROP SEQUENCE seq_discount_id;

CREATE SEQUENCE seq_discount_id
START WITH 1200
INCREMENT BY 1
NOCACHE
NOCYCLE;

CREATE OR REPLACE TRIGGER "DISCOUNT_T1"
BEFORE INSERT
ON "DISCOUNT"
FOR EACH ROW
BEGIN 
:new.discount_id:=seq_discount_id.nextval;
END;

/
DROP SEQUENCE seq_payment_id;

CREATE SEQUENCE seq_payment_id
START WITH 1400
INCREMENT BY 1
NOCACHE
NOCYCLE;

CREATE OR REPLACE TRIGGER "PAYMENT_T1"
BEFORE INSERT
ON "PAYMENT"
FOR EACH ROW
BEGIN 
:new.payment_id:=seq_payment_id.nextval;
END;

/

DROP SEQUENCE seq_slot_id;

CREATE SEQUENCE seq_slot_id
START WITH 1600
INCREMENT BY 1
NOCACHE
NOCYCLE;

CREATE OR REPLACE TRIGGER "SLOT_T1"
BEFORE INSERT
ON "COLLECTIONSLOT"
FOR EACH ROW
BEGIN 
:new.slot_id:=seq_slot_id.nextval;
END;
