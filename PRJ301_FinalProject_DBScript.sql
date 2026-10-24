USE [master]
GO

/*******************************************************************************
   Drop database if it exists
********************************************************************************/
IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'businessProject')
BEGIN
	ALTER DATABASE [businessProject] SET OFFLINE WITH ROLLBACK IMMEDIATE;
	ALTER DATABASE [businessProject] SET ONLINE;
	DROP DATABASE [businessProject];
END

GO

CREATE DATABASE [businessProject]
GO

USE [businessProject]
GO

/*******************************************************************************
	Drop tables if exists
*******************************************************************************/
DECLARE @sql nvarchar(MAX) 
SET @sql = N'' 

SELECT @sql = @sql + N'ALTER TABLE ' + QUOTENAME(KCU1.TABLE_SCHEMA) 
    + N'.' + QUOTENAME(KCU1.TABLE_NAME) 
    + N' DROP CONSTRAINT ' -- + QUOTENAME(rc.CONSTRAINT_SCHEMA)  + N'.'  -- not in MS-SQL
    + QUOTENAME(rc.CONSTRAINT_NAME) + N'; ' + CHAR(13) + CHAR(10) 
FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS AS RC 

INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS KCU1 
    ON KCU1.CONSTRAINT_CATALOG = RC.CONSTRAINT_CATALOG  
    AND KCU1.CONSTRAINT_SCHEMA = RC.CONSTRAINT_SCHEMA 
    AND KCU1.CONSTRAINT_NAME = RC.CONSTRAINT_NAME 

EXECUTE(@sql) 

GO
DECLARE @sql2 NVARCHAR(max)=''

SELECT @sql2 += ' Drop table ' + QUOTENAME(TABLE_SCHEMA) + '.'+ QUOTENAME(TABLE_NAME) + '; '
FROM   INFORMATION_SCHEMA.TABLES
WHERE  TABLE_TYPE = 'BASE TABLE'

Exec Sp_executesql @sql2 
GO


/*******************************************************************************
   Create table
********************************************************************************/
CREATE TABLE ProductTypes(
	id INT PRIMARY KEY IDENTITY,
	[name] VARCHAR(100) NOT NULL,
	typeImage VARCHAR(100),
	isDeleted BIT DEFAULT 0
);


CREATE TABLE Products(
	proId INT PRIMARY KEY IDENTITY,
	proName VARCHAR(100) NOT NULL,
	proDescription TEXT NOT NULL,
	proPrice MONEY	NOT NULL,
	proQuantity	INT,
	proImage VARCHAR(50),
	proTypeId INT FOREIGN KEY REFERENCES ProductTypes(id),
	isDeleted BIT DEFAULT 0
);

CREATE TABLE Users(
	id INT PRIMARY KEY IDENTITY,
	username VARCHAR(50) NOT NULL UNIQUE,
	[password] VARCHAR(100) NOT NULL,
	[fullname] VARCHAR(100),
	gender VARCHAR(50),
	[role] VARCHAR(20) DEFAULT 'Customer',
	[address] VARCHAR(100),
	[balance] MONEY DEFAULT 0,
	CHECK ([role] IN ('Admin', 'Customer'))
);

CREATE TABLE Carts(
	id INT PRIMARY KEY IDENTITY,
	[userId] INT FOREIGN KEY REFERENCES Users(id),
	[status] VARCHAR(20) DEFAULT 'active',
	productId INT FOREIGN KEY REFERENCES Products(proId),
	unitPrice DECIMAL(10, 2),
	quantity INT,
	CHECK ([status] IN ('active', 'checked_out'))
);

CREATE TABLE Orders(
	orderId INT PRIMARY KEY IDENTITY,
	[userId] INT FOREIGN KEY REFERENCES Users(id),
	orderDate DATETIME,
	[status] VARCHAR(50) DEFAULT 'pending',
	CHECK ([status] IN ('pending', 'completed', 'cancelled'))
);

CREATE TABLE OrderDetails(
	id INT PRIMARY KEY IDENTITY,
	[orderId] INT FOREIGN KEY REFERENCES Orders(orderId),
	productId INT FOREIGN KEY REFERENCES Products(proId),
	quantity INT,
	unitPrice DECIMAL(10, 2),
	totalPrice DECIMAL(10, 2)
);

CREATE TABLE Payments(
	id INT PRIMARY KEY IDENTITY,
	[orderId] INT FOREIGN KEY REFERENCES Orders(orderId),
	paymentDate DATETIME,
	amount DECIMAL(10, 2)
)

GO

/*******************************************************************************
   Example Data
********************************************************************************/
INSERT INTO Users(username, password, fullname, gender, role, address, balance) VALUES
('admin', '123456', 'Co Cam Lan', 'Female', 'Admin', 'Nothing', 0),
('guest', '123456', 'Ngoc Lan', 'Female', 'Customer', '3646, Quoc lo 80, Vinh Thanh, Can Tho', 5000000),
('guest2', '123456', 'Minh Lan', 'Male', 'Customer', '6B/6, Co Do, Can Tho', 10000)

INSERT INTO ProductTypes(name, typeImage) VALUES
('Canned good', 'canned_good.jpg'),
('Dairy', 'dairy.jpg'),
('Baking product', 'baking_product.jpg'),
('Frozen food', 'frozen_food.jpg'),
('Spice', 'spice.jpg'),
('Snack food', 'snack_food.jpg'),
('Beverage', 'beverage.jpg'),
('Utensil', 'utensil.jpg'),
('Paper product', 'paper_product.jpg'),
('Washing product', 'washing_product.jpg'),
('Hygiene product', 'hygiene_product.jpg')

INSERT INTO Products(proName, proDescription, proPrice, proQuantity, proImage, proTypeId) VALUES
('Three Miss Canned Fish', 'Fish Fish Fish', 15000, 30, 'threeMissCannedFish.jpg', 1),
('Coconut Milk', 'Desserts with coconut milk are extremely good.', 32000, 40, 'coconutMilk.jpg', 1),
('Vinamilk', '2 to 3 cup per day', 8000, 100, 'vinamilk.jpg', 2),
('Butter Truong An', 'Scented and tasty', 23000, 20, 'butterTruongAn.jpg', 2),
('Wheat Flour', 'self make cake at home', 20000, 20, 'wheatFlour.jpg', 3),
('ST25 Rice', 'Best rice in the world', 50000, 10, 'st25Rice.jpg', 3),
('Sausage', 'Enjoy your meal', 10000, 20, 'sausage.jpg', 4),
('Egg', 'Just Egg', 3000, 200, 'egg.jpg', 4),
('Oil Cai Lan', 'Fry, Stir and everything', 42000, 30, 'oilCaiLan.jpg', 5),
('Chili Powder', 'Hot and spicy like you', 50000, 20, 'chiliPowder.jpg', 5),
('Chip Lay', 'Chip Chip Chip', 8000, 20, 'chipLay.jpg', 6),
('OREO', 'Sweet like your crush', 11000, 80, 'oreo.jpg', 6),
('Coca Cola', 'Pepsi. Thats what I like', 9000, 150, 'cocaCola.jpg', 7),
('7 Up', 'A friend in hot day', 9000, 150, '7Up.jpg', 7),
('Spoon', 'It is a Spoon', 3000, 20, 'spoon.jpg', 8),
('Big Knife', 'Cutting is easier than ever', 24000, 15, 'bigKnife.jpg', 8),
('Pen', 'A Pen', 4000, 200, 'pen.jpg', 9),
('A4 Paper', 'Print every time you want', 1000, 100, 'a4Paper.jpg', 9),
('Dish Washing Liquid', 'Healthy for your hands', 20000, 20, 'dishWashingLiquid.jpg', 10),
('Detergent', 'For every type of Cloth', 50000, 70, 'detergent.jpg', 10),
('Soap Lifeboy', 'Smooth and Big', 12000, 30, 'soapLifeboy.jpg', 11),
('Nguyen Xuan Shampoo', 'Shampoo for caring your hair', 80000, 20, 'nguyenXuanShampoo.jpg', 11)