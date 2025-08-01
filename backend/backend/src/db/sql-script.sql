IF DB_ID('ProductsDB') IS NULL
BEGIN
    CREATE DATABASE ProductsDB;
END
GO

USE ProductsDB;
GO

IF OBJECT_ID('PRODUCTS', 'U') IS NULL
BEGIN
    CREATE TABLE PRODUCTS (
        PRODUCTID INT PRIMARY KEY IDENTITY(1,1),
        PRODUCTNAME NVARCHAR(100) NOT NULL,
        PRODUCTNAME DECIMAL(10, 2) NOT NULL,
        STOCK INT NOT NULL
    );
END
GO
