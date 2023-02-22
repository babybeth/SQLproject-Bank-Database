

CREATE DATABASE BankdB    ---Create a database called BankdB
GO

USE BankdB      -- Connect to BankdB database
GO

---Create schemas for BankdB database
CREATE SCHEMA Branches_Schema      ---Create BRANCH_SCHEMA

CREATE SCHEMA Accounts_Schema      ---Create ACCOUNTS_SCHEMA

CREATE SCHEMA Customers_Schema     ---Create CUSTOMERS_SCHEMA

CREATE SCHEMA Transactions_Schema ---Create TRANSACTIONS_SCHEMA


---Create Table Banks_Table with the default schema dbo
CREATE TABLE dbo.Banks_Table (
Bank_Id     VARCHAR(8)  PRIMARY KEY NOT NULL,
Bank_FullName   VARCHAR(15) NOT NULL,
Num_Branches   INT NULL,
Num_Outlets   INT  NULL,
Business_Type    VARCHAR(25)  NULL,
Num_Servers    INT  NOT NULL,
Num_Apps       INT NOT NULL
)
GO


--Create Address_Table with dbo schema that conatins all the addresses relateed to the bank 
--such as bank branch addresses and customers addresses
CREATE TABLE dbo.Address_Table (
Address_Id   INT IDENTITY(101,1)PRIMARY KEY NOT NULL,
Line1        VARCHAR(100) NULL,
Line2        VARCHAR(100) NULL,
Town_City    VARCHAR(25) NULL,
Zip_code     INT NULL,
State_Prov_County   VARCHAR(50) NULL,
Country   VARCHAR(50) NULL
)
GO

---Create Ref_AccountStatus_Table with Accounts_Schema to store all the information
--- on status of bank accounts(eg:account active,closed...) 

CREATE TABLE Accounts_Schema.Ref_AccountStatus_Table (
Account_Status_Code    INT PRIMARY KEY NOT NULL,
Account_Status_Description  VARCHAR(20) NULL
) ON Accounts_FG
GO

---Create Ref_AccountType_Table that contains the detailsof the the type of 
---banking accounts(savings,checking..) 

CREATE TABLE Accounts_Schema.Ref_AccountType_Table (
Account_Type_Code   INT  PRIMARY KEY NOT NULL,
Account_Type_Description   VARCHAR(20) NULL  
) ON Accounts_FG
GO


---Create Ref_BranchTyoes_table with branches schema that has the details of the bank branches

CREATE TABLE Branches_Schema.Ref_BranchTypes_Table(
BranchType_Code VARCHAR(5) PRIMARY KEY,
BranchType_Description  VARCHAR(20)
) ON Branches_FG
GO


---Create the TransactionType_Table with Transactions schema that has the details on the type of bank 
---transaction (withrawal,deposit..) 

CREATE TABLE Transactions_Schema.Ref_TransactionType_Table (
TransactionType_Code  INT NOT NULL PRIMARY KEY,
TransactionType_Description VARCHAR(20) NULL  
) ON Transactions_FG
GO


---Create the Branch_Table with Branches _Schema that has the details of all 
---the branches in the bank
CREATE TABLE Branches_Schema.Branch_Table (
Branch_Id VARCHAR(6)  PRIMARY KEY NOT NULL,
Address_Id INT REFERENCES Address_Table(Address_Id) UNIQUE,
Bank_Id  VARCHAR(8)   REFERENCES Banks_Table(Bank_Id),
BranchType_Code  VARCHAR(5)  REFERENCES  Branches_Schema.Ref_BranchTypes_Table(BranchType_Code),
Branch_emailid   VARCHAR(25) NULL UNIQUE,
Branch_Manager_FirstName  CHAR(15) NULL,
Branch_Manager_LastName   CHAR(15) NULL,
)  ON Branches_FG
GO


---Create Customers_Table with Customers_Schema that has the details of all the 
---customers in the bank

CREATE TABLE Customers_Schema.Customers_Table (
Customer_Id  VARCHAR(20)  PRIMARY KEY NOT NULL,
Address_Id  INT  REFERENCES Address_Table(Address_Id),
Branch_Id    VARCHAR(6) REFERENCES Branches_Schema.Branch_table(Branch_Id),
Customer_FirstName CHAR(15) NULL,
Customer_LastName  CHAR(15) NULL,
Customer_DOB   DATE NULL,
Customer_Gender   CHAR(2) NULL  
) 
GO


---Create Accounts_Table with Accounts schema that has the details of
---all the accounts in the bank. 
CREATE  TABLE Accounts_Schema.Accounts_Table (
Account_Num   VARCHAR(15) PRIMARY KEY NOT NULL,
Customer_Firstname   CHAR(15) NULL,
Customer_LastName   CHAR(15) NULL,
Customer_Age    INT  CHECK (Customer_Age >18 AND Customer_Age <80),
Account_Status_Code   INT REFERENCES Accounts_Schema.Ref_AccountStatus_Table(Account_Status_Code),
Account_Type_Code  INT  REFERENCES Accounts_Schema.Ref_AccountType_Table(Account_Type_Code),
Customer_Id   VARCHAR(20) REFERENCES Customers_Schema.Customers_Table(Customer_Id),
Current_Balance   MONEY NULL,
Date_Opened       DATE NULL,
Routing_Num       VARCHAR(15) NULL UNIQUE,
) ON Accounts_FG
GO

ALTER TABLE Accounts_Schema.Accounts_Table ALTER COLUMN Customer_Id   VARCHAR(20) REFERENCES Customers_Schema.Customers_Table(Customer_Id) NOT NULL;

ALTER TABLE Accounts_Schema.Accounts_Table ALTER COLUMN Customer_Id NOT NULL;
ALTER TABLE Accounts_Schema.Accounts_Table  MODIFY Customer_Id NOT NULL;
ALTER TABLE Accounts_Schema.Accounts_Table ADD CONSTRAINT Customer_Id NOT NULL;
ALTER TABLE Accounts_Schema.Accounts_Table ALTER COLUMN Customer_Id   VARCHAR(20) REFERENCES Customers_Schema.Customers_Table(Customer_Id) NOT NULL;


---Create Transactions_Table with Transactions schema that has the details of all the transactions
---happening in the bank.

CREATE TABLE Transactions_Schema.Transactions_Table (
Transaction_Id   VARCHAR(50)  PRIMARY KEY NOT NULL,
Account_Num     VARCHAR(15) REFERENCES Accounts_Schema.Accounts_Table(Account_Num) NULL,
TransactionType_Code  INT REFERENCES Transactions_Schema.Ref_TransactionType_Table(TransactionType_Code),
Transaction_Amount  MONEY NULL,
Transaction_Status  INT CHECK(Transaction_Status>1 AND Transaction_Status <99 ),
Transaction_Date_Time  DATETIME  NULL,
Routing_Num VARCHAR(20)  NULL
) ON Transactions_FG
GO






















