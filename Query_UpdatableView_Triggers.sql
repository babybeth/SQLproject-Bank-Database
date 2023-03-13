/**********************************************************************************************************************************
-----------------------------------------------------------------------------------------------------------------------------------
File Name:Query_UpdatableView_Triggers
Purpose: Update BankdB databse involving:
         * CONDITIONAL & DYNAMIC INSERTION OF DATA
         * AUTOMATED TRANSACTION BEHAVIOUR USING TRIGGERS
-----------------------------------------------------------------------------------------------------------------------------------
***********************************************************************************************************************************/
GO
USE BankdB
GO

-----Create an updatable view for viewing branch details
IF EXISTS (SELECT * FROM sys.objects WHERE name = 'BranchInfo_VIew')
DROP VIEW BranchInfo_View
GO


CREATE VIEW BranchInfo_View 
AS
    (SELECT BA.Bank_Id,BR.Branch_Id,BRTY.BranchType_Description,BR.Branch_Manager_FirstName,BR.Branch_Manager_LastName,
    BR.Branch_emailid,Addr.Line1,Addr.Line2,Addr.Town_City,Addr.State_Prov_County,Addr.Country,Addr.Zip_code
    FROM synBranch AS BR (READPAST)
    LEFT JOIN synAddress AS Addr (READPAST)
    ON BR.Address_Id = Addr.Address_Id
    LEFT JOIN synBank AS BA (READPAST)
    ON BA.Bank_Id =BR.Bank_Id
    LEFT JOIN synBranchType AS BRTY (READPAST)
    ON BRTY.BranchType_Code = BR.BranchType_Code)
GO


----Create an trigger on branch view while adding a branch.
IF EXISTS (SELECT * FROM sys.objects WHERE name = 'Trigger_BranchInfo_VIew')
DROP TRIGGER Trigger_BranchInfo_View
GO

CREATE TRIGGER  Trigger_BranchInfo_View ON BranchInfo_View
INSTEAD OF INSERT
AS
BEGIN 
   
      DECLARE @BankId  VARCHAR(8)
	  SELECT @BankId = B.Bank_Id
	  FROM synBank AS B 
	  INNER JOIN Inserted AS I
	  ON B.Bank_Id = I.Bank_Id
	  IF (@BankId IS NULL)
	  BEGIN
	       RAISERROR('Bank Id does not exists',16,1)   ---Raise error if bank id does not exists
           RETURN
	  END

      BEGIN TRANSACTION T1
      BEGIN TRY

          DECLARE @BranchTypeCode VARCHAR(5)
		  SELECT @BranchTypeCode = BTY.BranchType_Code
		  FROM synBranchType AS BTY
		  INNER JOIN Inserted AS I 
		  ON BTY.BranchType_Description = I.BranchType_Description
		   	
	  END TRY
	  BEGIN CATCH
	  BEGIN
	    SELECT 'Branch Information entered is not valid. Check input values'
		ROLLBACK TRANSACTION  ----Roll back transaction if branch type code is incorrect
	  END
	  END CATCH

		 		 
      BEGIN TRANSACTION T2
      BEGIN TRY
          INSERT INTO dbo.synAddress(Line1,Line2,Town_City,State_Prov_County,Country,Zip_code)
		  SELECT Line1, Line2,Town_City,State_Prov_County,Country,Zip_code
		  FROM INSERTED 
		  --- Retrieve the address id inserted
		  DECLARE @Adressid  INT
		  SET @Adressid = @@IDENTITY
	  END TRY
	  BEGIN CATCH
	  BEGIN
	     SELECT 'Address Information entered is not valid. Check input values'
		 ROLLBACK TRANSACTION  ----Roll back transaction if address details issued is incorrect or insufficient
	  END
	  END CATCH

	  BEGIN TRANSACTION T3
	  BEGIN TRY
	      INSERT INTO dbo.synBranch(Branch_Id,Address_Id,Bank_Id,BranchType_Code,Branch_emailid,Branch_Manager_FirstName,Branch_Manager_LastName) 
	      SELECT Branch_Id,@Adressid,Bank_Id,@BranchTypeCode,Branch_emailid,Branch_Manager_FirstName,Branch_Manager_LastName FROM INSERTED

  	  END TRY
	  BEGIN CATCH
	  BEGIN
	     SELECT 'Branch Insertion failed due to data issues. Check input values'
		 ROLLBACK TRANSACTION    ----Roll back transaction if branch details is not correct or is insufficient
		 ;THROW
	 END
	 END CATCH
	---Commit Transactions to update the branch details if data inserted is correct
		  IF @@TRANCOUNT > 0
		  COMMIT TRANSACTION T1
		  IF @@TRANCOUNT > 0
		  COMMIT TRANSACTION T2
		   IF @@TRANCOUNT > 0
		  COMMIT TRANSACTION T3
END
GO 
----Add a new branch for a bank to the bank database 
INSERT INTO BranchInfo_View (Bank_Id,Branch_Id,BranchType_Description,Branch_Manager_FirstName,Branch_Manager_LastName,
Branch_emailid,Line1,Line2,Town_City,State_Prov_County,Country,Zip_code )
VALUES('SCBLLD48','124198','Large Rural','Mia','Lam','gph@hotmail.com','SM nagar',NULL,'Delhi','Delhi','India',576797)
SELECT * FROM Branch_Info_View


---Create a procedure to add a branch
IF EXISTS (SELECT * FROM sys.objects WHERE name = 'InsertBranchInfo')
DROP PROCEDURE InsertBranchInfo
GO

CREATE PROCEDURE  InsertBranchInfo
    (@BankId  VARCHAR(8),@BranchId  VARCHAR(6),@BranchTypeDescription   VARCHAR(20),
    @BranchManagerFirstName  CHAR(15),@BranchManagerLastname  CHAR(15),@Branchemailid  VARCHAR(25),
    @AddressLine1  VARCHAR(100),@AddressLine2  VARCHAR(100),@TownCity  VARCHAR(25),
    @StateProvCounty  VARCHAR(50),@Country  VARCHAR(50),@Zipcode  INT)

AS
BEGIN
    INSERT INTO BranchInfo_View VALUES (@BankId, @BranchId, @BranchTypeDescription,
    @BranchManagerFirstName, @BranchManagerLastname, @Branchemailid, @AddressLine1, @AddressLine2,
    @TownCity, @StateProvCounty, @Country, @Zipcode)
    END
GO

----Add a new branch by calling the InsertBranchInfo procedure
EXEC InsertBranchInfo @BankId = 'SCBLLD48', @BranchId = '157698',@BranchTypeDescription='Small Rural',
@BranchManagerFirstName='Haan',@BranchManagerLastname='N',@Branchemailid='hjh@gmail.com',@AddressLine1='T Nagar',@AddressLine2=NULL,
@TownCity='Lucknow',@StateProvCounty='Lucknow',@Country='India',@Zipcode=56892
GO
----Add a new branch with the same branch id and verify if it gives an error
EXEC InsertBranchInfo @BankId = 'SCBLLD48', @BranchId = '157698',@BranchTypeDescription='Small Rural',
@BranchManagerFirstName='Haan',@BranchManagerLastname='N',@Branchemailid='hjh@gmail.com',@AddressLine1='T Nagar',@AddressLine2=NULL,
@TownCity='Lucknow',@StateProvCounty='Lucknow',@Country='India',@Zipcode=56892
GO


---Create an updatable view for viewing customer details
IF EXISTS (SELECT * FROM sys.objects WHERE name = 'CustomerInfo_View')
DROP VIEW CustomerInfo_View
GO

CREATE VIEW CustomerInfo_View
AS
SELECT C.Customer_Id,C.Address_Id, C.Branch_Id, C.Customer_FirstName,
C.Customer_LastName, C.Customer_DOB, C.Customer_Gender,
Addr.Line1, Addr.Line2, Addr.Town_City, Addr.Zip_code, Addr.State_Prov_County, Addr.Country
FROM dbo.synCustomer AS C
INNER JOIN dbo.synAddress AS Addr
ON C.Address_Id = Addr.Address_Id
INNER JOIN  dbo.synBranch AS B
ON B.Branch_Id = C.Branch_Id
GO


---Create a procedure for inserting details os a new customer to a bank
IF EXISTS (SELECT * FROM sys.objects WHERE name = 'InsertCustomerProc')
DROP PROCEDURE InsertCustomerProc
GO


CREATE PROCEDURE InsertCustomerProc(@BranchId VARCHAR(6),@CustomerFirstName CHAR(15),
@CustomerLastname  CHAR(15),@Customer_DOB  DATE,@Customer_Gender CHAR(2),@AddressLine1 VARCHAR(100),
@AddressLine2  VARCHAR(100),@TownCity VARCHAR(25),@StateProvCounty VARCHAR(50),
@ZipCode  INT, @Country VARCHAR(50))
AS 
 BEGIN  
   DECLARE @Branch_Id  VARCHAR(6)
   SELECT @Branch_Id = Branch_Id 
   FROM dbo.synBranch WHERE Branch_Id = @BranchId 
   IF (@Branch_Id IS NULL)
   BEGIN
	   RAISERROR('Branch Id does not exists',16,1)   --Raise error if branch id does not exists
       RETURN
   END

  BEGIN TRANSACTION T1
  BEGIN TRY
         INSERT INTO dbo.synAddress(Line1,Line2,State_Prov_County,Town_City,Country,Zip_code)
		 VALUES (@AddressLine1, @AddressLine2,@StateProvCounty, @TownCity,@Country, @ZipCode)	
         DECLARE @AddressId INT
		 SET @AddressId = @@IDENTITY   --- Get the Address id which is incremented automatically from @@IDENTITY
  END TRY
  BEGIN CATCH
         SELECT 'Address Information is invalid'
		 ROLLBACK TRANSACTION  -- If address details is insufficient, rollback transaction
  END CATCH
  BEGIN TRANSACTION T2
  BEGIN TRY
      DECLARE @Customer_Id VARCHAR(20)
      DECLARE @Length as int = 8;
      SET @Customer_Id = substring(replace(newID(),'-',''),cast(RAND()*(31-@Length) as int),@Length);
	  SELECT @Customer_Id
      INSERT INTO dbo.synCustomer (Customer_Id,Address_Id,Branch_Id,Customer_FirstName,Customer_LastName,Customer_DOB,Customer_Gender)
	  VALUES (@Customer_Id,@AddressId,@Branch_Id,@CustomerFirstName,@CustomerLastname,@Customer_DOB,@Customer_Gender)
  END TRY
  BEGIN CATCH
       SELECT 'Customer details entered are incorrect.Please Check'
	   ROLLBACK TRANSACTION   ---Roll back the transaction if there is an issue with the customer details entered
  END CATCH
  ----Commit the transaction of updating customer address if details issued are correct
  IF @@TRANCOUNT >0
  COMMIT TRANSACTION T1
  IF @@TRANCOUNT >0
  COMMIT TRANSACTION T2
END
GO


-----Insert a new customer using the procedure InsertCustomerProc
EXEC InsertCustomerProc @BranchId = '902345',@CustomerFirstName = 'Lami',
@CustomerLastname = 'Sim',@Customer_DOB  = '1985-04-02',@Customer_Gender = 'M',@AddressLine1 = 'Subash Lane',
@AddressLine2 = NULL,@TownCity = 'Bombay',@StateProvCounty = 'Bombay',
@ZipCode = 687909, @Country = 'India'

SELECT * FROM CustomerInfo_View    ----Reports the Customer Details

-----Creating a procedure to add a new account
IF EXISTS (SELECT * FROM sys.objects WHERE name = 'CreateAccountProc')
DROP PROCEDURE CreateAccountProc
GO

 CREATE PROCEDURE CreateAccountProc (@CustomerId  VARCHAR(20),@CustomerFirstName CHAR(15),
 @CustomerLastName CHAR(15),@CustomerAge INT, @AccountType  VARCHAR(20),
 @CurrentBalance  MONEY)
 AS
 BEGIN

 DECLARE @Customer_Id  VARCHAR(20)
 DECLARE @Account_Status_Code INT
 DECLARE @Account_Type_Code INT
  
   SELECT @Customer_Id = Customer_Id
   FROM synCustomer WHERE Customer_Id = @CustomerId
   IF (@Customer_Id IS NULL)  ----Checking for the validity of customer id
   BEGIN
     RAISERROR('Customer Id is invalid',16,1)
   END
   SELECT @Account_Status_Code = Account_Status_Code
   FROM synAccountStatus WHERE Account_Status_Description = 'Opened'  --Account status description for new account is set as Opened
   SELECT @Account_Type_Code = Account_Type_Code
   FROM synAccountType WHERE Account_Type_Description = @AccountType
 
   DECLARE @Routing_Num VARCHAR(15)
   SELECT @Routing_Num = CAST(CONCAT(0,cast((RAND()*(100000000)+1) as int)) AS VARCHAR(15))    --- Create a routing number for the new account
   DECLARE @OpeningDate DATE
   SET @OpeningDate = CAST(GETDATE() AS DATE)   ---Set the current date as account opening date

 
   BEGIN TRANSACTION
   BEGIN TRY
       DECLARE @AccountNum VARCHAR(15)	
       SET @AccountNum = CAST(SUBSTRING(CONCAT(100,CAST((RAND()*(100000000)+1) AS INT)),0,9)AS VARCHAR(15))  ----Create an account number
	   INSERT INTO dbo.synAccount(Account_Num,Customer_Firstname,Customer_LastName,Customer_Age,Account_Status_Code,Account_Type_Code,
	   Customer_Id,Current_Balance,Date_Opened,Routing_Num) 
       VALUES(@AccountNum,@CustomerFirstName,@CustomerLastName,@CustomerAge,@Account_Status_Code,@Account_Type_Code,
	   @CustomerId,@CurrentBalance,@OpeningDate,@Routing_Num)
   END TRY
   BEGIN CATCH 
      SELECT 'Issue with account details.Check again'
	  ROLLBACK TRANSACTION   --- Roll back transaction if account details are issued incorrectlky
   END CATCH
       If @@TRANCOUNT > 0
	   BEGIN
	   SELECT 'I am here'
	   COMMIT TRANSACTION   ----Commit the transaction to insert new account details to Accounts table if all the details issued are correct
	   END
 END
 GO


 ----Add a new account for an existing customer and verify it.
EXEC CreateAccountProc @CustomerId = '7608IJ971',@CustomerFirstName ='Ani',
 @CustomerLastName = 'Moore', @CustomerAge = 35, @AccountType = 'Savings',
 @CurrentBalance = 0.00
 
SELECT * FROM synAccount

----Create an updatable view for Account and related Transaction details 
IF EXISTS (SELECT * FROM sys.objects WHERE name ='AccountTransactionView')
DROP VIEW AccountTransactionView
GO
 CREATE VIEW AccountTransactionView
 AS
  SELECT [Transaction Id], [Account Number],[Customer ID], [Transaction Date], [Transaction Type Code],ISNULL("Deposit",0) AS CREDIT,ISNULL("Withdrawal",0) AS DEBIT,[Routing Number]
  FROM
      (SELECT T.Transaction_Id AS [Transaction Id], A.Account_Num AS [Account Number],A.Customer_Id AS [Customer ID],
	  A.Customer_Firstname AS [Customer FirstName],A.Customer_LastName AS [Customer LastName],T.Transaction_Amount AS [Amount],
	  T.Transaction_Date_Time AS [Transaction Date],T.Transaction_Status AS [Transaction Status], 
	  T.TransactionType_Code AS [Transaction Type Code],TTY.TransactionType_Description AS [Transaction Description], 
	  T.Routing_Num AS [Routing Number]
   FROM synTransaction AS T
   INNER JOIN synTransactionType AS TTY
   ON T.TransactionType_Code = TTY.TransactionType_Code
   INNER JOIN synAccount AS A
   ON A.Account_Num = T.Account_Num)
   AS SUMMARY
   PIVOT 
     (MAX([Amount])
     FOR [Transaction Description] IN ("Deposit" ,"Withdrawal")  ----Create a pivot for Credit or Debit with transaction amount 
     )AS P
 GO

 ----Create a trigger on  the updatable view AccountTransactionView to add a new transaction and update related account details 
IF EXISTS (SELECT * FROM sys.objects WHERE name ='Update_AccountBalance')
DROP TRIGGER Update_AccountBalance
GO 

 CREATE TRIGGER Update_AccountBalance ON AccountTransactionView
 INSTEAD OF INSERT
 AS 
 BEGIN
     DECLARE @TransType_Code INT
     SELECT @TransType_Code = T.TransactionType_Code
     FROM synTransactionType AS T
     INNER JOIN Inserted AS I
     ON T.TransactionType_Code = I.[Transaction Type Code]

     DECLARE @Trans_id VARCHAR(50)
     SELECT @Trans_id = I.[Transaction Id] FROM Inserted AS I
     DECLARE @Account_Num VARCHAR(15)
     SELECT @Account_Num = A.Account_Num
     FROM
     synAccount AS A
     INNER JOIN 
     Inserted AS I
     ON A.Account_Num = I.[Account Number]

     DECLARE @Trans_DateTime DATETIME
     SELECT @Trans_DateTime = I.[Transaction Date] FROM INSERTED AS I

     DECLARE @Trans_Status INT
     SET @Trans_Status = ROUND ( 1 + ( RAND () * 99 ),0)   ---Create a Transaction status between 1 and 99

     DECLARE @Routing_Num VARCHAR(20)
     SELECT @Routing_Num = I.[Routing Number]
     FROM INSERTED AS I

     DECLARE @Amount MONEY 
    -----Update account balance in Account table dependinding on type of transaction
    IF (@TransType_Code = 55)
    BEGIN
         SELECT @Amount = CREDIT FROM INSERTED
         UPDATE synAccount SET Current_Balance = Current_Balance + @Amount WHERE Account_Num = @Account_Num
    END
    ELSE
    BEGIN
        SELECT @Amount = DEBIT FROM INSERTED
        UPDATE synAccount SET Current_Balance = Current_Balance - @Amount WHERE Account_Num = @Account_Num
    END 
 -----Ad new transaction details to transaction table
    INSERT INTO synTransaction VALUES(@Trans_id,@Account_Num,@TransType_Code,@Amount,@Trans_Status,@Trans_DateTime,@Routing_Num)
END
GO


----Create a procedure to add a new transaction
IF EXISTS (SELECT * FROM sys.objects WHERE name ='NewTransactionProc')
DROP PROCEDURE NewTransactionProc
GO 

 CREATE PROCEDURE NewTransactionProc(@TransType  VARCHAR(20),@AccountNum  VARCHAR(15),@TransactionAmount MONEY)
 AS
 BEGIN
   DECLARE @TransType_Code  INT
   SELECT @TransType_Code = TransactionType_Code FROM synTransactionType WHERE TransactionType_Description = @TransType
   DECLARE @Account_Num  VARCHAR(15)
   SELECT @Account_Num = Account_Num FROM synAccount WHERE Account_Num = @AccountNum
   DECLARE @Account_Balance MONEY
   SELECT @Account_Balance = Current_Balance  FROM synAccount WHERE Account_Num = @AccountNum 
   DECLARE @Routing_Num VARCHAR(15)
   SELECT @Routing_Num = Routing_Num  FROM synAccount WHERE Account_Num = @AccountNum 
   DECLARE @Customer_Id VARCHAR(15)
   SELECT @Customer_Id= Customer_Id  FROM synAccount WHERE Account_Num = @AccountNum
   SELECT @TransType_Code
   IF (@TransType_Code = 15 AND @TransactionAmount < @Account_Balance) OR (@TransType_Code = 55)  ---Check if transaction type is valid and within cash limit
   BEGIN
   BEGIN TRANSACTION
     BEGIN TRY
	   DECLARE @Trans_id VARCHAR(50)
       DECLARE @Length as int = 10;
       SET @Trans_Id = substring(replace(newID(),'-',''),cast(RAND()*(31-@Length) as int),@Length); ---Create a transaction id
       SELECT @Trans_id
	   DECLARE @TransactionDateTime DATETIME
       SET @TransactionDateTime = CURRENT_TIMESTAMP  ---Get current time as transaction time

      ---Update updatable view AccountTransactionView depending on transaction type
	  IF (@TransType_Code = 55)
	  BEGIN 
	    INSERT INTO AccountTransactionView 
	     VALUES(@Trans_id,@Account_Num,@Customer_Id,@TransactionDateTime,@TransType_Code,@TransactionAmount,0,@Routing_Num)		
	  END 
	 ELSE 
	  BEGIN 
        INSERT INTO AccountTransactionView 
	    VALUES(@Trans_id,@Account_Num,@Customer_Id,@TransactionDateTime,@TransType_Code,0,@TransactionAmount,@Routing_Num)
		
      END 
	 END TRY
     BEGIN CATCH
        SELECT 'Data entered is incorrect'
	    ROLLBACK TRANSACTION ---If data issued is incorrect, rollback transaction
     END CATCH
   
   IF @@TRANCOUNT >0
   COMMIT TRANSACTION
   SELECT 'Transaction inserted successfully.Your transaction reference number is ' + @Trans_id
   END
ELSE
     SELECT'Insufficient Balance,Transaction Declined.'  ---Transaction declined due to insufficient balance
END
GO


----Update database when a customer make a withdrawal and verify it
EXEC NewTransactionProc @TransType= 'Withdrawal', @AccountNum = '10064579',  @TransactionAmount =100
SELECT * FROM AccountTransactionView
