-- Select database
USE sales_analysis;

-- Raw customers table
CREATE TABLE customers_raw (
    CustomerKey INT,
    Gender VARCHAR(10),
    Name VARCHAR(200),
    City VARCHAR(100),
    StateCode VARCHAR(10),
    State VARCHAR(100),
    ZipCode VARCHAR(20),
    Country VARCHAR(100),
    Continent VARCHAR(50),
    Birthday VARCHAR(20)
);

-- Raw products table
CREATE TABLE products_raw (
    ProductKey INT,
    ProductName VARCHAR(150),
    Brand VARCHAR(100),
    Color VARCHAR(50),
    UnitCostUSD VARCHAR(20),
    UnitPriceUSD VARCHAR(20),
    SubcategoryKey INT,
    Subcategory VARCHAR(100),
    CategoryKey INT,
    Category VARCHAR(100)
);

-- Raw sales table
CREATE TABLE sales_raw (
    OrderNumber INT,
    LineItem INT,
    OrderDate VARCHAR(20),
    DeliveryDate VARCHAR(20),
    CustomerKey INT,
    StoreKey INT,
    ProductKey INT,
    Quantity INT,
    CurrencyCode VARCHAR(10)
);

-- Raw stores table
CREATE TABLE stores_raw (
    StoreKey INT,
    Country VARCHAR(100),
    State VARCHAR(100),
    SquareMeters INT,
    OpenDate VARCHAR(20)
);

-- Raw exchange rates table
CREATE TABLE exchange_rates_raw (
    Date VARCHAR(20),
    Currency VARCHAR(10),
    Exchange DECIMAL(10,5)
);

-- Reconfirm database
USE sales_analysis;

-- Load customers CSV
LOAD DATA LOCAL INFILE
'C:/Users/digvi/Desktop/Sharpener/Portfolio/1.SQL_Python_BI/Global+Electronics+Retailer/Customers.csv'
INTO TABLE customers_raw
CHARACTER SET latin1
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
 CustomerKey,
 Gender,
 Name,
 City,
 StateCode,
 State,
 ZipCode,
 Country,
 Continent,
 Birthday
);

-- Load products CSV
LOAD DATA LOCAL INFILE "C:/Users/digvi/Desktop/Sharpener/Portfolio/1.SQL_Python_BI/Global+Electronics+Retailer/Products.csv"
INTO TABLE products_raw
CHARACTER SET latin1
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- Load sales CSV
LOAD DATA LOCAL INFILE "C:/Users/digvi/Desktop/Sharpener/Portfolio/1.SQL_Python_BI/Global+Electronics+Retailer/Sales.csv"
INTO TABLE sales_raw
CHARACTER SET latin1
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- Load stores CSV
LOAD DATA LOCAL INFILE "C:/Users/digvi/Desktop/Sharpener/Portfolio/1.SQL_Python_BI/Global+Electronics+Retailer/Stores.csv"
INTO TABLE stores_raw
CHARACTER SET latin1
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- Load exchange rates CSV
LOAD DATA LOCAL INFILE "C:/Users/digvi/Desktop/Sharpener/Portfolio/1.SQL_Python_BI/Global+Electronics+Retailer/Exchange_Rates.csv"
INTO TABLE exchange_rates_raw
CHARACTER SET latin1
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- Row count check
SELECT COUNT(*) FROM customers_raw;

-- Reconfirm database
USE sales_analysis;

-- Clean customers data
CREATE TABLE customers_clean AS
SELECT
    CustomerKey,
    Gender,
    TRIM(Name) AS Name,
    UPPER(TRIM(City)) AS City,
    StateCode,
    UPPER(TRIM(State)) AS State,
    ZipCode,
    Country,
    Continent,
    STR_TO_DATE(Birthday, '%m/%d/%Y') AS Birthday
FROM customers_raw
WHERE Birthday REGEXP '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$';

-- Remove duplicate customers keeping earliest birthday
DELETE c1
FROM customers_clean c1
JOIN customers_clean c2
ON c1.CustomerKey = c2.CustomerKey
AND c1.Birthday > c2.Birthday;

-- Clean products data
CREATE TABLE products_clean AS
SELECT
    ProductKey,
    ProductName,
    Brand,
    Color,
    CAST(REPLACE(UnitCostUSD, '$', '') AS DECIMAL(10,2)) AS UnitCostUSD,
    CAST(REPLACE(UnitPriceUSD, '$', '') AS DECIMAL(10,2)) AS UnitPriceUSD,
    SubcategoryKey,
    Subcategory,
    CategoryKey,
    Category
FROM products_raw;

-- Verify cost parsing
SELECT UnitCostUSD FROM products_clean LIMIT 5;

-- Clean sales data
CREATE TABLE sales_clean AS
SELECT
    OrderNumber,
    LineItem,
    STR_TO_DATE(NULLIF(OrderDate, ''), '%m/%d/%Y') AS OrderDate,
    STR_TO_DATE(NULLIF(DeliveryDate, ''), '%m/%d/%Y') AS DeliveryDate,
    CustomerKey,
    NULLIF(StoreKey, 0) AS StoreKey,
    ProductKey,
    Quantity,
    CurrencyCode
FROM sales_raw;

-- Add delivery status column
ALTER TABLE sales_clean ADD DeliveryStatus VARCHAR(20);

-- Populate delivery status
UPDATE sales_clean
SET DeliveryStatus =
    CASE
        WHEN DeliveryDate IS NULL THEN 'Pending'
        ELSE 'Delivered'
    END
WHERE OrderNumber IS NOT NULL;

-- Clean stores data
CREATE TABLE stores_clean AS
SELECT
    StoreKey,
    Country,
    State,
    NULLIF(SquareMeters, 0) AS SquareMeters,
    STR_TO_DATE(OpenDate, '%m/%d/%Y') AS OpenDate
FROM stores_raw;

-- Clean exchange rates data
CREATE TABLE exchange_rates_clean AS
SELECT
    STR_TO_DATE(Date, '%m/%d/%Y') AS RateDate,
    Currency,
    Exchange
FROM exchange_rates_raw;

-- Primary key for exchange rates
ALTER TABLE exchange_rates_clean
ADD PRIMARY KEY (RateDate, Currency);

-- Primary keys
ALTER TABLE customers_clean ADD PRIMARY KEY (CustomerKey);
ALTER TABLE products_clean ADD PRIMARY KEY (ProductKey);
ALTER TABLE stores_clean ADD PRIMARY KEY (StoreKey);

-- Foreign key: sales → customers
ALTER TABLE sales_clean
ADD CONSTRAINT fk_sales_customer
FOREIGN KEY (CustomerKey) REFERENCES customers_clean(CustomerKey);

-- Foreign key: sales → products
ALTER TABLE sales_clean
ADD CONSTRAINT fk_sales_product
FOREIGN KEY (ProductKey) REFERENCES products_clean(ProductKey);

-- Foreign key: sales → stores
ALTER TABLE sales_clean
ADD CONSTRAINT fk_sales_store
FOREIGN KEY (StoreKey) REFERENCES stores_clean(StoreKey);

-- Check invalid quantities
SELECT * FROM sales_clean WHERE Quantity <= 0;

-- Check orphan customers
SELECT *
FROM sales_clean s
LEFT JOIN customers_clean c
ON s.CustomerKey = c.CustomerKey
WHERE c.CustomerKey IS NULL;

-- Reconfirm database
USE sales_analysis;

-- Orphan customer check (repeat)
SELECT *
FROM sales_clean s
LEFT JOIN customers_clean c
ON s.CustomerKey = c.CustomerKey
WHERE c.CustomerKey IS NULL;

-- Invalid quantity check
SELECT *
FROM sales_clean
WHERE Quantity <= 0;

-- Currency mismatch check
SELECT DISTINCT CurrencyCode
FROM sales_clean
WHERE CurrencyCode NOT IN (
    SELECT DISTINCT Currency FROM exchange_rates_clean
);

-- Customer count
SELECT COUNT(*) FROM customers_clean;

-- Product pricing sample
SELECT
    UnitCostUSD,
    UnitPriceUSD
FROM products_clean
LIMIT 10;

-- Stores with missing size
SELECT *
FROM stores_clean
WHERE SquareMeters IS NULL;

-- Exchange rates with invalid dates
SELECT *
FROM exchange_rates_clean
WHERE RateDate IS NULL;

-- Sales with zero store key
SELECT *
FROM sales_clean
WHERE StoreKey = 0;

-- Orphan customers check (repeat)
SELECT *
FROM sales_clean s
LEFT JOIN customers_clean c
ON s.CustomerKey = c.CustomerKey
WHERE c.CustomerKey IS NULL;

-- List tables
SHOW TABLES;

-- Final orphan check
SELECT *
FROM sales_clean s
LEFT JOIN customers_clean c
ON s.CustomerKey = c.CustomerKey
WHERE c.CustomerKey IS NULL;
