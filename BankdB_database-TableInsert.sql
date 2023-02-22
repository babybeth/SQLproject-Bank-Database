
---Create Database for an online banking service Provider.


Go
USE BankdB
Go

-- Insert Bank detasils to Banks_table
INSERT dbo.Banks_Table(Bank_Id, Bank_FullName, Num_Branches, Num_Outlets, Business_Type, Num_Servers, Num_Apps)
VALUES('SCBLLD48','Standard Chartered Bank',1200,70,'Design/Support',2000,150)
INSERT dbo.Banks_Table(Bank_Id, Bank_FullName, Num_Branches, Num_Outlets, Business_Type, Num_Servers, Num_Apps)
VALUES('SCBLLD42','Wells Fargo Bank',900,90,'Design/Support',800,300)
INSERT dbo.Banks_Table(Bank_Id, Bank_FullName, Num_Branches, Num_Outlets, Business_Type, Num_Servers, Num_Apps)
VALUES('SCBLLD39','HDFC Bank',1500,70,'Design/Support',1000,500)
GO


SELECT * FROM dbo.Banks_Table  --- Report the bank details


---Insert address information of branches and the customers to the Address_Table
SET IDENTITY_INSERT dbo.Address_Table ON 

INSERT dbo.Address_Table(Address_Id, Line1, Line2, Town_City, Zip_Code, State_Prov_County,Country) 
VALUES (101,'Sarojini Lane','NULL','Delhi',456799,'Delhi','India')
INSERT dbo.Address_Table(Address_Id, Line1, Line2, Town_City, Zip_Code, State_Prov_County,Country) 
VALUES (102,'Apt 112','K K Nagar','Gurgaon',123456,NULL,'India')
INSERT dbo.Address_Table(Address_Id, Line1, Line2, Town_City, Zip_Code, State_Prov_County,Country) 
VALUES (103,'Apt 578','Gandhinagar','Jaipur',687459,NULL,'India')
INSERT dbo.Address_Table(Address_Id, Line1, Line2, Town_City, Zip_Code, State_Prov_County,Country) 
VALUES (104,'Lohi Rd',NULL,'Delhi',457639,'Delhi','India')
INSERT dbo.Address_Table(Address_Id, Line1, Line2, Town_City, Zip_Code, State_Prov_County,Country) 
VALUES (105,'Apt 122','Jeeva Nagar','Kolkata',687909,NULL,'India')
INSERT dbo.Address_Table(Address_Id, Line1, Line2, Town_City, Zip_Code, State_Prov_County,Country) 
VALUES (106,'Lane No 12','S S Nagar','Gwalior',568779,NULL,'India')
INSERT dbo.Address_Table(Address_Id, Line1, Line2, Town_City, Zip_Code, State_Prov_County,Country) 
VALUES (107,'Shivaji Rd','KK Puram','Dharmapuri',688209,NULL,'India')
INSERT dbo.Address_Table(Address_Id, Line1, Line2, Town_City, Zip_Code, State_Prov_County,Country) 
VALUES (108,'Jodha Lane','Ravipur','Kolkata',68779,'West Bengal','India')
INSERT dbo.Address_Table(Address_Id, Line1, Line2, Town_City, Zip_Code, State_Prov_County,Country) 
VALUES (109,'Blossom Lane','JJ Rd','Goa',437909,NULL,'India')
INSERT dbo.Address_Table(Address_Id, Line1, Line2, Town_City, Zip_Code, State_Prov_County,Country) 
VALUES (110,'Lane 50','Shastri Nagar','Karnataka',595909,'Karnataka','India')
INSERT dbo.Address_Table(Address_Id, Line1, Line2, Town_City, Zip_Code, State_Prov_County,Country) 
VALUES (111,'KS Rao Lane','Ramoji Rd','Delhi',686790,'Delhi','India')
INSERT dbo.Address_Table(Address_Id, Line1, Line2, Town_City, Zip_Code, State_Prov_County,Country) 
VALUES (112,'Sarovar Lane','Lalpur','Mizoram',908659,NULL,'India')
INSERT dbo.Address_Table(Address_Id, Line1, Line2, Town_City, Zip_Code, State_Prov_County,Country) 
VALUES (113,'Apt 21','Janam Street','Sikkim',954768,NULL,'India')
INSERT dbo.Address_Table(Address_Id, Line1, Line2, Town_City, Zip_Code, State_Prov_County,Country) 
VALUES (114,'Jill Rd','JJ Lane','Trissur',621446,NULL,'India')
GO

INSERT dbo.Address_Table(Address_Id, Line1, Line2, Town_City, Zip_Code, State_Prov_County,Country) 
VALUES (115,'KDT Lane','Kumarapur','Surat',690868,NULL,'India')
INSERT dbo.Address_Table(Address_Id, Line1, Line2, Town_City, Zip_Code, State_Prov_County,Country) 
VALUES (116,'Janamaithri Rd',NULL,'Trissur',621446,'Kerala','India')
INSERT dbo.Address_Table(Address_Id, Line1, Line2, Town_City, Zip_Code, State_Prov_County,Country) 
VALUES (117,'SR Lane','Milapur','Munnar',756909,'Kerala','India')
INSERT dbo.Address_Table(Address_Id, Line1, Line2, Town_City, Zip_Code, State_Prov_County,Country) 
VALUES (118,'Apt89','S R Puri','Andhra Pradesh',667619,NULL,'India')
INSERT dbo.Address_Table(Address_Id, Line1, Line2, Town_City, Zip_Code, State_Prov_County,Country) 
VALUES (119,'Sarangi Rd',NULL,'Gurgaon',687991,NULL,'India')
INSERT dbo.Address_Table(Address_Id, Line1, Line2, Town_City, Zip_Code, State_Prov_County,Country) 
VALUES (120,'Nayak Ln','Banasvathi Rd','Delhi',450909,NULL,'India')
INSERT dbo.Address_Table(Address_Id, Line1, Line2, Town_City, Zip_Code, State_Prov_County,Country) 
VALUES (121,'Veni Lane','Palace Rd','Meghalaya',687162,NULL,'India')
INSERT dbo.Address_Table(Address_Id, Line1, Line2, Town_City, Zip_Code, State_Prov_County,Country) 
VALUES (122,'Lalitpuri Rd','Lalitpuri','Bellandur',676849,NULL,'India')
INSERT dbo.Address_Table(Address_Id, Line1, Line2, Town_City, Zip_Code, State_Prov_County,Country) 
VALUES (123,'SRPuri','Hosur','Karnataka',288009,'Karnataka','India')
INSERT dbo.Address_Table(Address_Id, Line1, Line2, Town_City, Zip_Code, State_Prov_County,Country) 
VALUES (124,'Srinagar Plot No:1','Veloor',288687,'Himachal Pradesh','India')

INSERT dbo.Address_Table(Address_Id, Line1, Line2, Town_City, Zip_Code, State_Prov_County,Country) 
VALUES (125,'Lane no:18',NULL,NULL,834687,NULL,NULL)
INSERT dbo.Address_Table( Address_Id,Line1, Line2, Town_City, Zip_Code, State_Prov_County,Country) 
VALUES (126,'Sundar Lane',NULL,NULL,768768,'Roorkee',NULL)
INSERT dbo.Address_Table(Address_Id, Line1, Line2, Town_City, Zip_Code, State_Prov_County,Country) 
VALUES (127,'RR Rd',NULL,NULL,876734,NULL,NULL)
INSERT dbo.Address_Table(Address_Id, Line1, Line2, Town_City, Zip_Code, State_Prov_County,Country) 
VALUES (128,'Lane no:18',NULL,NULL,234567,NULL,NULL)
INSERT dbo.Address_Table( Address_Id,Line1, Line2, Town_City, Zip_Code, State_Prov_County,Country) 
VALUES (129,'Chirag Ln',NULL,NULL,313245,NULL,NULL)
INSERT dbo.Address_Table( Address_Id,Line1, Line2, Town_City, Zip_Code, State_Prov_County,Country) 
VALUES (130,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT dbo.Address_Table( Address_Id,Line1, Line2, Town_City, Zip_Code, State_Prov_County,Country) 
VALUES (131,'Vasishta Rd',NULL,NULL,567897,NULL,NULL)
INSERT dbo.Address_Table(Address_Id, Line1, Line2, Town_City, Zip_Code, State_Prov_County,Country) 
VALUES (132,'KK Rd',NULL,NULL,561209,NULL,NULL)
INSERT dbo.Address_Table(Address_Id, Line1, Line2, Town_City, Zip_Code, State_Prov_County,Country) 
VALUES (133,'Jamuna Ln',NULL,NULL,134309,NULL,NULL)

SET IDENTITY_INSERT dbo.Address_Table OFF
GO
SELECT * FROM dbo.Address_Table
GO


---Insert the Account Status information for all the accounts in the bank
INSERT Accounts_Schema.Ref_AccountStatus_Table (Account_Status_Code, Account_Status_Description)
VALUES (101,'Active'),(102,'Dormant'),(100,'Closed')
GO

SELECT * FROM Accounts_Schema.Ref_AccountStatus_Table

---Insert the details of all the account types and their account_type_code. 
INSERT Accounts_Schema.Ref_AccountType_Table (Account_Type_Code, Account_Type_Description)
VALUES (11,'Savings'),(12,'Checking'),(13,'NRI'),(14,'Recurring Deposit'),(15,'Fixed Deposit'),(16,'Demat')
GO

SELECT * FROM Accounts_Schema.Ref_AccountType_Table


--- Insert details of all the branch types in BranchTypes_Table.
INSERT Branches_Schema.Ref_BranchTypes_Table (BranchType_Code, BranchType_Description)
VALUES ('01', 'Small Urban'),('02','Large Urban'),('03','Small Rural'),('04','Large Rural')
GO

SELECT * FROM Branches_Schema.Ref_BranchTypes_Table

---Insert details of all the branches in the bank
INSERT Branches_Schema.Branch_Table (Branch_Id, Address_Id, Bank_Id, BranchType_Code, Branch_emailid, Branch_Manager_FirstName, Branch_Manager_LastName)  
VALUES ('123456',115,'SCBLLD48','01','xyz@hotmail.com','Raki','Raj')
INSERT Branches_Schema.Branch_Table (Branch_Id, Address_Id, Bank_Id, BranchType_Code, Branch_emailid, Branch_Manager_FirstName, Branch_Manager_LastName)  
VALUES ('367896',118,'SCBLLD48','02','ryz@hotmail.com','John','Ron')
INSERT Branches_Schema.Branch_Table (Branch_Id, Address_Id, Bank_Id, BranchType_Code, Branch_emailid, Branch_Manager_FirstName, Branch_Manager_LastName)  
VALUES ('563896',109,'SCBLLD48','04','znm@hotamil.com','Fin','Leo')
INSERT Branches_Schema.Branch_Table (Branch_Id, Address_Id, Bank_Id, BranchType_Code, Branch_emailid, Branch_Manager_FirstName, Branch_Manager_LastName)  
VALUES ('562390',123,'SCBLLD48','02','zas@hotamil.com','Nate','Sam')
INSERT Branches_Schema.Branch_Table (Branch_Id, Address_Id, Bank_Id, BranchType_Code, Branch_emailid, Branch_Manager_FirstName, Branch_Manager_LastName)  
VALUES ('789456',117,'SCBLLD48','01','ery@hotmail.com','Rai','Som')
INSERT Branches_Schema.Branch_Table (Branch_Id, Address_Id, Bank_Id, BranchType_Code, Branch_emailid, Branch_Manager_FirstName, Branch_Manager_LastName)  
VALUES ('389675',119,'SCBLLD48','02','lim@hotmail.com','Jack','Bill')
INSERT Branches_Schema.Branch_Table (Branch_Id, Address_Id, Bank_Id, BranchType_Code, Branch_emailid, Branch_Manager_FirstName, Branch_Manager_LastName)  
VALUES ('902345',120,'SCBLLD48','04','def@hotamil.com','Han','Kim')
INSERT Branches_Schema.Branch_Table (Branch_Id, Address_Id, Bank_Id, BranchType_Code, Branch_emailid, Branch_Manager_FirstName, Branch_Manager_LastName)  
VALUES ('197834',122,'SCBLLD48','02','mvt@hotamil.com','Nave','Tom')
INSERT Branches_Schema.Branch_Table (Branch_Id, Address_Id, Bank_Id, BranchType_Code, Branch_emailid, Branch_Manager_FirstName, Branch_Manager_LastName)  
VALUES ('805256',121,'SCBLLD48','04','rtz@hotamil.com','Bill','Von')
GO
INSERT Branches_Schema.Branch_Table (Branch_Id, Address_Id, Bank_Id, BranchType_Code, Branch_emailid, Branch_Manager_FirstName, Branch_Manager_LastName)  
VALUES ('680436',124,'SCBLLD48','04','ghgj@hotmail.com','Ryan','Raj')
INSERT Branches_Schema.Branch_Table (Branch_Id, Address_Id, Bank_Id, BranchType_Code, Branch_emailid, Branch_Manager_FirstName, Branch_Manager_LastName)  
VALUES ('898701',133,'SCBLLD48','02','ryasz@hotmail.com','Harry','Ron')
INSERT Branches_Schema.Branch_Table (Branch_Id, Address_Id, Bank_Id, BranchType_Code, Branch_emailid, Branch_Manager_FirstName, Branch_Manager_LastName)  
VALUES ('790442',132,'SCBLLD48','04','znmsa@hotamil.com','Antony','Ben')
INSERT Branches_Schema.Branch_Table (Branch_Id, Address_Id, Bank_Id, BranchType_Code, Branch_emailid, Branch_Manager_FirstName, Branch_Manager_LastName)  
VALUES ('124363',128,'SCBLLD48','02','zaass@hotamil.com','Liam','Peter')
INSERT Branches_Schema.Branch_Table (Branch_Id, Address_Id, Bank_Id, BranchType_Code, Branch_emailid, Branch_Manager_FirstName, Branch_Manager_LastName)  
VALUES ('763894',126,'SCBLLD48','03','easry@hotmail.com','Rais',NULL)
INSERT Branches_Schema.Branch_Table (Branch_Id, Address_Id, Bank_Id, BranchType_Code, Branch_emailid, Branch_Manager_FirstName, Branch_Manager_LastName)  
VALUES ('977314',108,'SCBLLD48','01','liam@hotmail.com','Jeny','Bill')
INSERT Branches_Schema.Branch_Table (Branch_Id, Address_Id, Bank_Id, BranchType_Code, Branch_emailid, Branch_Manager_FirstName, Branch_Manager_LastName)  
VALUES ('736879',107,'SCBLLD48','01','esf@hotamil.com','Hanet','Jim')
INSERT Branches_Schema.Branch_Table (Branch_Id, Address_Id, Bank_Id, BranchType_Code, Branch_emailid, Branch_Manager_FirstName, Branch_Manager_LastName)  
VALUES ('924334',111,'SCBLLD48','02','msazct@hotamil.com','Omar','V')
INSERT Branches_Schema.Branch_Table (Branch_Id, Address_Id, Bank_Id, BranchType_Code, Branch_emailid, Branch_Manager_FirstName, Branch_Manager_LastName)  
VALUES ('887912',104,'SCBLLD48','03','cvbz@hotamil.com','Zia','Von')
GO
SELECT * FROM Branches_Schema.Branch_Table

UPDATE synBranch SET Bank_Id ='SCBLLD42' WHERE Branch_id ='789456'
UPDATE synBranch SET Bank_Id ='SCBLLD42' WHERE Branch_id ='197834'


--- Insert details of all the customers in the bank
INSERT Customers_Schema.Customers_Table (Customer_Id, Address_Id, Branch_Id, Customer_FirstName, Customer_LastName, Customer_DOB, Customer_Gender)
VALUES ('7608IJ971',104,'197834','Allen','Dheem',CAST('1956-05-16' AS DATE),'F')
INSERT Customers_Schema.Customers_Table (Customer_Id, Address_Id, Branch_Id, Customer_FirstName, Customer_LastName, Customer_DOB, Customer_Gender)
VALUES ('6423DS45',111,'389675','Somi','Gaur',CAST('1983-12-29' AS DATE),'M')
INSERT Customers_Schema.Customers_Table (Customer_Id, Address_Id, Branch_Id, Customer_FirstName, Customer_LastName, Customer_DOB, Customer_Gender)
VALUES ('7687DE90',110,'789456','Ben','Sue',CAST('1999-05-23' AS DATE),NULL)
INSERT Customers_Schema.Customers_Table (Customer_Id, Address_Id, Branch_Id, Customer_FirstName, Customer_LastName, Customer_DOB, Customer_Gender)
VALUES ('7680FI01',101,'805256','Somi','Jai',CAST('1995-12-22' AS DATE),'F')
INSERT Customers_Schema.Customers_Table (Customer_Id, Address_Id, Branch_Id, Customer_FirstName, Customer_LastName, Customer_DOB, Customer_Gender)
VALUES ('6410NY95',113,'197834','Das','R',CAST('1989-09-15' AS DATE),'M')
INSERT Customers_Schema.Customers_Table (Customer_Id, Address_Id, Branch_Id, Customer_FirstName, Customer_LastName, Customer_DOB, Customer_Gender)
VALUES ('2353AC46',114,'902345','Seema','Biswas',CAST('1966-10-08' AS DATE),'M')
INSERT Customers_Schema.Customers_Table (Customer_Id, Address_Id, Branch_Id, Customer_FirstName, Customer_LastName, Customer_DOB, Customer_Gender)
VALUES ('76IKFJ01',101,'902345','Iman','Som',CAST('1995-12-22' AS DATE),'F')
INSERT Customers_Schema.Customers_Table (Customer_Id, Address_Id, Branch_Id, Customer_FirstName, Customer_LastName, Customer_DOB, Customer_Gender)
VALUES ('7210IN46',105,'563896','Liya',NULL,CAST('1979-04-11' AS DATE),'F')
INSERT Customers_Schema.Customers_Table (Customer_Id, Address_Id, Branch_Id, Customer_FirstName, Customer_LastName, Customer_DOB, Customer_Gender)
VALUES ('7608FY01',101,'805256','Somi','Saran',CAST('1995-12-22' AS DATE),'F')
GO

SELECT * FROM Customers_Schema.Customers_Table
GO
UPDATE synCustomer SET Customer_FirstName ='Somi' WHERE Customer_Id = '7608FY01'
UPDATE synCustomer SET Customer_LastName ='Saran' WHERE Customer_Id = '7608FY01'



---Insert the Account details to the Accounts_Table
INSERT Accounts_Schema.Accounts_Table (Account_Num, Customer_Firstname, Customer_LastName, Customer_Age, Account_Status_code, Account_Type_code, Customer_Id, Current_Balance, Date_Opened, Routing_Num) 
VALUES('10045879','Iman','Som',34,100,13,'76IKFJ01',9000.75,CAST('2000-03-16' AS DATE),'03980986')
INSERT Accounts_Schema.Accounts_Table (Account_Num, Customer_Firstname, Customer_LastName, Customer_Age, Account_Status_code, Account_Type_code, Customer_Id, Current_Balance, Date_Opened, Routing_Num) 
VALUES('10013254','Allen','Dheem',65,100,16,'7608IJ971',1259800,CAST('2001-12-22' AS DATE),'06129886')
INSERT Accounts_Schema.Accounts_Table (Account_Num, Customer_Firstname, Customer_LastName, Customer_Age, Account_Status_code, Account_Type_code, Customer_Id, Current_Balance, Date_Opened, Routing_Num) 
VALUES('10065674','Somi','Jai',44,100,13,'7680FI01',1000000.50,CAST('1989-11-06' AS DATE),'07056463')
INSERT Accounts_Schema.Accounts_Table (Account_Num, Customer_Firstname, Customer_LastName, Customer_Age, Account_Status_code, Account_Type_code, Customer_Id, Current_Balance, Date_Opened, Routing_Num) 
VALUES('10029170','Somi','Gaur',34,101,13,'6423DS45',95620,CAST('1978-10-27' AS DATE), '07695312')
INSERT Accounts_Schema.Accounts_Table (Account_Num, Customer_Firstname, Customer_LastName, Customer_Age, Account_Status_code, Account_Type_code, Customer_Id, Current_Balance, Date_Opened, Routing_Num) 
VALUES('10566874','Ani','Moore',48,102,13,'7608IJ971',45000,CAST('1975-11-17' AS DATE),'07876751')
INSERT Accounts_Schema.Accounts_Table(Account_Num, Customer_Firstname, Customer_LastName, Customer_Age, Account_Status_code, Account_Type_code, Customer_Id, Current_Balance, Date_Opened, Routing_Num) 
VALUES('10022907','Neha','Manohar',59,101,11,'7687DE90',34890230,CAST('2000-02-15' AS DATE), '07690980')
INSERT Accounts_Schema.Accounts_Table (Account_Num, Customer_Firstname, Customer_LastName, Customer_Age, Account_Status_code, Account_Type_code, Customer_Id, Current_Balance, Date_Opened, Routing_Num) 
VALUES('10034379','Somi','Saran',56,100,12,'7608FY01',477680.56,CAST('1987-08-19' AS DATE), '07453675')
INSERT Accounts_Schema.Accounts_Table (Account_Num, Customer_Firstname, Customer_LastName, Customer_Age, Account_Status_code, Account_Type_code, Customer_Id, Current_Balance, Date_Opened, Routing_Num) 
VALUES('10012354','Somi','Saran',65,101,13,'7608FY01',NULL,CAST('1954-04-17' AS DATE), '06357886')
INSERT Accounts_Schema.Accounts_Table (Account_Num, Customer_Firstname, Customer_LastName, Customer_Age, Account_Status_code, Account_Type_code, Customer_Id, Current_Balance, Date_Opened, Routing_Num) 
VALUES('10066879','Somi','Jawahar',46,100,13,'2353AC46',1105600.50,CAST('1975-07-14' AS DATE), '07055645')
INSERT Accounts_Schema.Accounts_Table (Account_Num, Customer_Firstname, Customer_LastName, Customer_Age, Account_Status_code, Account_Type_code, Customer_Id, Current_Balance, Date_Opened, Routing_Num) 
VALUES('10068379','Das','R',28,101,'15','6410NY95',9560300,NULL,'07234552')
INSERT Accounts_Schema.Accounts_Table (Account_Num, Customer_Firstname, Customer_LastName, Customer_Age, Account_Status_code, Account_Type_code, Customer_Id, Current_Balance, Date_Opened, Routing_Num) 
VALUES('10064579','Hami','Neer',21,102,11,'7210IN46',4700.00,NULL,NULL)
INSERT Accounts_Schema.Accounts_Table (Account_Num, Customer_Firstname, Customer_LastName, Customer_Age, Account_Status_code, Account_Type_code, Customer_Id, Current_Balance, Date_Opened, Routing_Num) 
VALUES('10061279','Ima','Isa',64,100,11,'7687DE90',34000.00,NULL,'05787979')
GO

SELECT * FROM Accounts_Schema.Accounts_Table
SELECT * FROM synCustomer


UPDATE synAccount SET Customer_Firstname = 'Somi',Customer_LastName= 'Gaur' WHERE Account_Num = '10029170'

---Insert the details of transaction types and their code
INSERT Transactions_Schema.Ref_TransactionType_Table (TransactionType_Code, TransactionType_Description)
VALUES (55,'Deposit'),(15,'Withdrawal')
GO

SELECT * FROM Transactions_Schema.Ref_TransactionType_Table


---Insert the details of all the transactions occured in the bank
INSERT Transactions_Schema.Transactions_Table (Transaction_Id, Account_Num, TransactionType_Code, Transaction_Amount, Transaction_Status,  Transaction_Date_Time,Routing_Num) 
VALUES ('12334546AN', '10566874', 55,5000,25,CAST(N'2002-02-27 00:00:00.000' AS DATETIME),'07055645')
INSERT Transactions_Schema.Transactions_Table (Transaction_Id, Account_Num, TransactionType_Code,  Transaction_Amount, Transaction_Status,Transaction_Date_Time, Routing_Num) 
VALUES ('10066879HN', '10064579', 15,10000,56,CAST(N'2004-01-06 00:00:00.000' AS DATETIME),NULL)
INSERT Transactions_Schema.Transactions_Table (Transaction_Id, Account_Num, TransactionType_Code,  Transaction_Amount, Transaction_Status,Transaction_Date_Time, Routing_Num) 
VALUES ('15467865KD', '10034379', 55,5000,32,CAST(N'2003-02-07 00:00:00.000' AS DATETIME),'07453675')
INSERT Transactions_Schema.Transactions_Table (Transaction_Id, Account_Num, TransactionType_Code,  Transaction_Amount, Transaction_Status,Transaction_Date_Time, Routing_Num) 
VALUES ('15488309AS', '10029170', 55,5000,98,CAST(N'1998-11-05 00:00:00.000' AS DATETIME),'07695312')
INSERT Transactions_Schema.Transactions_Table (Transaction_Id, Account_Num, TransactionType_Code, Transaction_Amount, Transaction_Status, Transaction_Date_Time, Routing_Num) 
VALUES ('12549706AL', '10061279', 15,8000,94,CAST(N'1992-04-12 00:00:00.000' AS DATETIME), '05787979')
INSERT Transactions_Schema.Transactions_Table (Transaction_Id, Account_Num, TransactionType_Code,  Transaction_Amount, Transaction_Status,Transaction_Date_Time,Routing_Num) 
VALUES ('18786454AB', '10012354', 55,8000,35,CAST(N'2002-02-27 00:00:00.000' AS DATETIME),'06357886')
INSERT Transactions_Schema.Transactions_Table (Transaction_Id, Account_Num, TransactionType_Code,  Transaction_Amount, Transaction_Status,Transaction_Date_Time, Routing_Num) 
VALUES ('11989775SJ', '10013254', 15,10000,54, CAST(N'1990-10-25 00:00:00.000' AS DATETIME),'06129886')
INSERT Transactions_Schema.Transactions_Table (Transaction_Id, Account_Num, TransactionType_Code, Transaction_Amount, Transaction_Status, Transaction_Date_Time, Routing_Num) 
VALUES ('17698965NM', '10066879', 55,500,10,CAST(N'1993-10-12 00:00:00.000' AS DATETIME),'07876751')
INSERT Transactions_Schema.Transactions_Table (Transaction_Id, Account_Num, TransactionType_Code, Transaction_Amount, Transaction_Status, Transaction_Date_Time, Routing_Num) 
VALUES ('12549702IJ', '10022907', 55,3500,94,CAST(N'2002-02-27 00:00:00.000' AS DATETIME), '07690980')
INSERT Transactions_Schema.Transactions_Table (Transaction_Id, Account_Num, TransactionType_Code, Transaction_Amount, Transaction_Status, Transaction_Date_Time, Routing_Num) 
VALUES ('12545789LJ', '10022907', 55,3500,94,CAST(N'2002-10-27 00:00:00.000' AS DATETIME), '07690980')
INSERT Transactions_Schema.Transactions_Table (Transaction_Id, Account_Num, TransactionType_Code, Transaction_Amount, Transaction_Status, Transaction_Date_Time, Routing_Num) 
VALUES ('12579879KK', '10022907', 55,3500,94,CAST(N'2002-09-27 00:00:00.000' AS DATETIME), '07690980')
INSERT Transactions_Schema.Transactions_Table (Transaction_Id, Account_Num, TransactionType_Code, Transaction_Amount, Transaction_Status, Transaction_Date_Time, Routing_Num) 
VALUES ('18798708FG', '10022907', 55,3500,94,CAST(N'2002-08-27 00:00:00.000' AS DATETIME), '07690980')
INSERT Transactions_Schema.Transactions_Table (Transaction_Id, Account_Num, TransactionType_Code, Transaction_Amount, Transaction_Status, Transaction_Date_Time, Routing_Num) 
VALUES ('12797906PL', '10061279', 15,8000,94,CAST(N'1992-04-09 00:00:00.000' AS DATETIME), '05787979')
INSERT Transactions_Schema.Transactions_Table (Transaction_Id, Account_Num, TransactionType_Code, Transaction_Amount, Transaction_Status, Transaction_Date_Time, Routing_Num) 
VALUES ('12678706AP', '10061279', 15,8000,94,CAST(N'1992-04-22 00:00:00.000' AS DATETIME), '05787979')
INSERT Transactions_Schema.Transactions_Table (Transaction_Id, Account_Num, TransactionType_Code, Transaction_Amount, Transaction_Status,  Transaction_Date_Time,Routing_Num) 
VALUES ('12154465AF', '10566874', 55,5000,25,CAST(N'2002-02-13 00:00:00.000' AS DATETIME),'07055645')
INSERT Transactions_Schema.Transactions_Table (Transaction_Id, Account_Num, TransactionType_Code, Transaction_Amount, Transaction_Status,  Transaction_Date_Time,Routing_Num) 
VALUES ('12573267AN', '10566874', 55,5000,25,CAST(N'2002-02-09 00:00:00.000' AS DATETIME),'07055645')


GO


UPDATE synTransaction SET Transaction_Date_Time =CAST(N'1990-10-25 00:00:00.000' AS DATETIME) WHERE Transaction_Id = '11989775SJ'
SELECT * FROM Transactions_Schema.Transactions_Table

CREATE SYNONYM synBank                  FOR dbo.Banks_Table
CREATE SYNONYM synAddress				FOR dbo.Address_Table
CREATE SYNONYM synBranchType			FOR Branches_Schema.Ref_BranchTypes_Table
CREATE SYNONYM synBranch				FOR Branches_Schema.Branch_Table
CREATE SYNONYM synCustomer				FOR Customers_Schema.Customers_Table

CREATE SYNONYM synAccountType			FOR Accounts_Schema.Ref_AccountType_Table
CREATE SYNONYM synAccountStatus			FOR Accounts_Schema.Ref_AccountStatus_Table
CREATE SYNONYM synAccount				FOR Accounts_Schema.Accounts_Table

CREATE SYNONYM synTransactionType		FOR Transactions_Schema.Ref_TransactionType_Table
CREATE SYNONYM synTransaction			FOR Transactions_Schema.Transactions_Table

