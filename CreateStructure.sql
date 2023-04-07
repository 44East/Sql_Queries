-- Создание таблицы SKU
CREATE TABLE dbo.SKU (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Code VARCHAR(50) UNIQUE,
    Name VARCHAR(255)
)

-- Создание вычисляемого поля Code
ALTER TABLE dbo.SKU ADD Code AS 's' + CAST(ID AS VARCHAR(10))

-- Создание таблицы Family
CREATE TABLE dbo.Family (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    SurName VARCHAR(255),
    BudgetValue DECIMAL(18, 2)
)

-- Создание таблицы Basket
CREATE TABLE dbo.Basket (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    ID_SKU INT REFERENCES dbo.SKU(ID),
    ID_Family INT REFERENCES dbo.Family(ID),
    Quantity INT CHECK (Quantity >= 0),
    Value DECIMAL(18, 2) CHECK (Value >= 0),
    PurchaseDate DATETIME2 DEFAULT GETDATE(),
    DiscountValue DECIMAL(18, 2) DEFAULT 0
)