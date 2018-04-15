use organisation;
Drop table if exists Customer;
create table Customer(
   Id INT NOT NULL IDENTITY(1, 1),
   FirstName VARCHAR(100) NOT NULL,
   LastName VARCHAR(100) NOT NULL,
   City VARCHAR(40),
   Country VARCHAR(40),
   Phone VARCHAR(40),
   PRIMARY KEY ( Id )
);

Drop table if exists Supplier;
create table Supplier(
   Id INT NOT NULL IDENTITY(1, 1),
   CompanyName VARCHAR(100) NOT NULL,
   ContactName VARCHAR(100) NOT NULL,
   City VARCHAR(40),
   Country VARCHAR(40),
   Phone VARCHAR(40),
   Fax VARCHAR(40),
   PRIMARY KEY ( Id )
);

Drop table if exists Product;
create table Product(
   Id INT NOT NULL IDENTITY(1, 1),
   ProductName VARCHAR(100) NOT NULL,
   SupplierId INT NOT NULL,
   UnitPrice DECIMAL(16,2),
   Package VARCHAR(100),
   IsDiscontinued INT,
   PRIMARY KEY ( Id )
);



Drop table if exists Orders;
create table Orders(
   Id INT NOT NULL IDENTITY(1, 1),
   OrderDate DATETIME,
   CustomerId INT NOT NULL,
   TotalAmount DECIMAL(16,2),
   OrderNumber INT,
   PRIMARY KEY ( Id )
);


Drop table if exists OrderItem;
create table OrderItem(
   Id INT NOT NULL IDENTITY(1, 1),
   OrderId INT NOT NULL,
   ProductId INT NOT NULL,
   UnitPrice DECIMAL(16,2),
   Quantity INT,
   PRIMARY KEY ( Id )
);