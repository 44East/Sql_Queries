-- Create table SKU
CREATE TABLE dbo.SKU (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Code AS 's' + CAST(ID AS VARCHAR(10)),
    Name NVARCHAR(50) NOT NULL,
    CONSTRAINT UQ_SKU_Code UNIQUE (Code)
);

-- Create table Family
CREATE TABLE dbo.Family (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    SurName NVARCHAR(50) NOT NULL,
    BudgetValue DECIMAL(18,2) NULL
);

-- Create table Basket
CREATE TABLE dbo.Basket (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    ID_SKU INT NOT NULL,
    ID_Family INT NOT NULL,
    Quantity DECIMAL(18,2) NOT NULL CHECK (Quantity >= 0),
    Value DECIMAL(18,2) NOT NULL CHECK (Value >= 0),
    PurchaseDate DATETIME2 NOT NULL DEFAULT(GETDATE()),
    DiscountValue DECIMAL(18,2) NULL,
    CONSTRAINT FK_Basket_SKU FOREIGN KEY (ID_SKU) REFERENCES dbo.SKU(ID),
    CONSTRAINT FK_Basket_Family FOREIGN KEY (ID_Family) REFERENCES dbo.Family(ID),
    CONSTRAINT CHK_Quantity CHECK (Quantity >= 0),
    CONSTRAINT CHK_Value CHECK (Value >= 0)
);
