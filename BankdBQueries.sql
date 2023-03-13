 /**********************************************************************************************************************************
-----------------------------------------------------------------------------------------------------------------------------------
File Name:BankdBQueries.sql
Purpose: Create SQL Queries for data reporting
-----------------------------------------------------------------------------------------------------------------------------------
***********************************************************************************************************************************/


 USE BankdB
 GO
 --1. CREATE FUNCTION TO GET ACCOUNT STATEMENT FOR A GIVEN CUSTOMER ?

 --Function to get the statement when Customer name is the input
  CREATE  FUNCTION GET_ACC_STMNT(@Firstname char(15),@Lastname char(15))
 RETURNS TABLE
 AS RETURN 
 (
     SELECT C.Customer_FirstName, C.Customer_LastName , A.Account_Num , C.Address_Id, C.Branch_Id,C.Customer_Id,A.Account_Type_Code,A.Current_Balance 
     FROM synAccount  AS A 
     INNER JOIN synCustomer AS C
     ON (A.Customer_Id = C.Customer_Id)
     WHERE  (C.Customer_Firstname = @FirstName AND C.Customer_LastName = @LastName)
 )
 GO

 SELECT * FROM GET_ACC_STMNT('Somi', 'Gaur')
 GO

 ---Function to get the statement when customer id is the inpout parameter
CREATE FUNCTION GET_STATEMNT ( @CST_ID VARCHAR(20) )
RETURNS TABLE
AS
RETURN
(
	SELECT C.Customer_FirstName, C.Customer_LastName , A.Account_Num , C.Address_Id, C.Branch_Id,C.Customer_Id,A.Account_Type_Code,A.Current_Balance 
	FROM synAccount AS A	-- JOIN OF MULTIPLE TABLES ACCROSS MULTIPLE SCHEMAS, BASED ON RELATION
	INNER JOIN
	synCustomer AS C
	on A.Customer_Id = C.Customer_Id 
	WHERE 
	C.Customer_Id = @CST_ID
) 
 GO


 SELECT * FROM GET_STATEMNT('6423DS45')
 GO

 -- 2. List all Banks and their Branches with total number of Accounts in each Branch

 SELECT BA.Bank_Id,BA.Bank_FullName,BR.BranchType_Code,BR.Branch_emailid,BR.Address_Id,COUNT(BR.Branch_Id) AS Num_Accounts
 FROM synBank AS BA 
 INNER JOIN synBranch AS BR
 ON BA.Bank_Id = BR.Bank_Id
 INNER JOIN synCustomer AS C
 ON BR.Branch_Id =C.Branch_Id
 INNER JOIN synAccount AS A
 ON C.Customer_Id = A.Customer_Id
 GROUP BY BA.Bank_Id,BA.Bank_FullName,BR.BranchType_Code,BR.Branch_emailid,BR.Address_Id
 ORDER BY BA.Bank_FullName DESC
 GO


 -- 3. List total number of Customers for each Branch

 
 SELECT BA.Bank_Id,BA.Bank_FullName,BR.Branch_Id,COUNT(C.Customer_ID) AS Total_Customers
 FROM synBank AS BA 
 INNER JOIN synBranch AS BR
 ON BA.Bank_Id = BR.Bank_Id
 LEFT JOIN synCustomer AS C
 ON BR.Branch_Id = C.Branch_Id
 GROUP BY BA.Bank_Id,BA.Bank_FullName,BR.Branch_Id
 ORDER BY BA.Bank_FullName
 GO
 
 -- 4. Find all Customer Accounts that does not have any Transaction

CREATE VIEW Customer_Acct_Without_Trans 
AS
 (
    SELECT C.Customer_Id,C.Customer_Firstname +' '+ C.Customer_LastName AS Customer_Name,
	A.Account_Num,A.Account_Status_Code,A.Account_Type_Code,A.Current_Balance
    FROM synCustomer AS C
    LEFT JOIN synAccount AS A
    ON C.Customer_Id = A.Customer_Id
    LEFT JOIN synTransaction AS T
    ON A.Account_Num = T.Account_Num
    WHERE T.Transaction_Id IS NULL
)
 GO

 SELECT * FROM Customer_Acct_Without_Trans
 GO


-- 5. Rank the Customers for each Bank & Branch based on number of Transactions. 
--   Customer with maximum number of Transaction gets 1 Rank (Position)


SELECT C.Customer_Id,C.Customer_FirstName +' '+ C.Customer_LastName AS Customer_Name,
COUNT(T.Transaction_Id) AS No_of_Transactions,DENSE_RANK() OVER(ORDER BY COUNT(T.Transaction_Id) DESC) AS Ranking, B.Bank_Id,B.Bank_FullName,BR.Branch_Id,C.Address_Id AS Customer_AddressId
FROM 
synBank AS B
INNER JOIN synBranch AS BR
ON B.Bank_Id = BR.Bank_Id
RIGHT JOIN
synCustomer AS C
ON BR.Branch_Id = C.Branch_Id
LEFT JOIN
synAccount AS A
ON C.Customer_Id = A.Customer_Id
FULL JOIN synTransaction AS T
ON A.Account_Num = T.Account_Num
GROUP BY C.Customer_Id,C.Customer_FirstName +' '+ C.Customer_LastName ,B.Bank_Id,B.Bank_FullName,BR.Branch_Id,C.Address_Id
GO




-- 6. MONTHLY STATEMENT transactions for a given month for a given customer id

CREATE FUNCTION GET_MONTHLY_STATEMENT(@Customer_Id VARCHAR(20), @month INT)
RETURNS TABLE
AS RETURN
(
SELECT C.Customer_Id,BR.Branch_Id,C.Customer_FirstName,C.Customer_LastName,BR.Bank_Id,
A.Current_Balance,T.Transaction_Id, T.Transaction_Date_Time,T.Transaction_Amount
FROM 
synCustomer AS C
LEFT JOIN synBranch AS BR
ON C.Branch_Id = BR.Branch_Id
LEFT JOIN synAccount AS A
ON C.Customer_Id = A.Customer_Id
INNER JOIN synTransaction AS T
ON A. Account_Num = T.Account_Num
WHERE( C.Customer_Id = @Customer_Id AND MONTH(CAST(T.Transaction_Date_Time AS VARCHAR(20))) = @month ))
GO

SELECT * FROM GET_MONTHLY_STATEMENT('7608IJ971', 2)
GO

-- 7. Total Sum of DEBITS & CREDITS for each Customer. 

CREATE VIEW VIEW_TRANSACTIONDETAILS 
AS
(
	SELECT  
	T.Account_Num,A.Customer_Id,TT.TransactionType_Description,
	ISNULL(sum(T.Transaction_Amount),0) AS [Total Transaction Amount]
	FROM synTransaction AS T
	INNER JOIN
	synTransactionType AS TT
	ON
	T.TransactionType_Code = TT.TransactionType_Code
	LEFT OUTER JOIN
	synAccount AS A
	ON
	A.Account_Num = T.Account_Num
	WHERE T.Account_Num IS NOT NULL
	GROUP BY T.Account_Num,A.Customer_Id,TT.TransactionType_Code,TT.TransactionType_Description
	)
GO



SELECT * FROM VIEW_TRANSACTIONDETAILS
PIVOT
( sum([Total Transaction Amount]) --- Column Alias Name works in Pivot 
  FOR  TransactionType_Description IN (Deposit, Withdrawal)
) as PivotQuery
GO


-- 8. LIST OF ALL CUSTOMERS WITH ACCOUNTS, NO TRANSACTIONS

SELECT C.Customer_Id, C.Customer_FirstName,C.Customer_LastName,A.Account_Num,T.Transaction_Id
FROM synCustomer AS C
INNER JOIN synAccount AS A
ON C.Customer_Id = A.Customer_Id
LEFT JOIN synTransaction AS T
ON A.Account_Num = T.Account_Num
WHERE T.Transaction_Id IS NULL

-- 9. LIST OF ALL ZIP CODES WITH MISSING CUSTOMER ADDRESS


SELECT * FROM synAddress 
WHERE (Line1 IS  NULL AND Line2 IS NULL ) AND State_Prov_County IS NULL

-- 10. LIST OF ALL CUSTOMERS WITH ACCOUNTS BASED ON ACCOUNT STATUS


SELECT C.Customer_Id, C.Customer_FirstName,C.Customer_LastName, A.Account_Num,A.Account_Status_Code,
A.Account_Type_Code,AST.Account_Status_Description
FROm synCustomer AS C
LEFT JOIN synAccount AS A
ON C.Customer_Id = A.Customer_Id
LEFT JOIN synAccountStatus AS AST
ON A.Account_Status_Code = AST.Account_Status_Code

-- 11. LIST OF ALL CUSTOMERS WITH ACCOUNTS BASED ON ACCOUNT STATUS & TYPES WITHOUT ANY TRANSACTION

SELECT C.Customer_Id, C.Customer_FirstName,C.Customer_LastName, A.Account_Num,A.Account_Status_Code,A.Account_Type_Code,
ASt.Account_Status_Description,Aty.Account_Type_Description,
ISNULL(CONVERT(VARCHAR,T.Account_Num),'No Transactions') AS 'Transaction_id'
FROM synCustomer AS C
INNER JOIN synAccount AS A
ON C.Customer_Id = A.Customer_Id
INNER JOIN synAccountStatus AS ASt
ON Ast.Account_Status_Code =  A.Account_Status_Code
INNER JOIN synAccountType AS ATy
ON ATy.Account_Type_Code= A.Account_Type_Code
LEFT JOIN synTransaction AS T
ON A.Account_Num = T.Account_Num
WHERE T.Transaction_Id IS NULL
GO



-- 12. LIST OF ALL BANKS BASED ON CUSTOMERS AND TRANSACTION AMOUNTS
CREATE PROCEDURE TRANSACTIONS_OVERVIEW AS
SELECT B.Bank_Id,B.Bank_FullName,BR.Branch_Id,C.Customer_Id,C.Customer_FirstName,C.Customer_LastName,A.Account_Num,
ISNULL(CONVERT(VARCHAR,T.Transaction_Amount),'No Transactions') AS "Transaction Amount" FROM synBank AS B
INNER JOIN synBranch AS BR
ON B.Bank_Id = BR.Bank_Id
INNER JOIN synCustomer AS C
ON BR.Branch_Id = C.Branch_Id
INNER JOIN synAccount AS A
ON C.Customer_Id = A.Customer_Id
INNER JOIN synTransaction AS T
ON A. Account_Num = T.Account_Num
ORDER BY Bank_FullName

EXEC TRANSACTIONS_OVERVIEW


---INSERT, UPDATE OR DELETE A BRANCH.

---Creating an updaable view.

CREATE VIEW Branch_Info_View AS
SELECT BA.Bank_Id,BR.Branch_Id,BR.BranchType_Code,BR.Branch_Manager_FirstName,BR.Branch_Manager_LastName,BR.Branch_emailid,
Addr.Address_Id,Addr.Line1,Addr.Line2,Addr.Town_City,Addr.State_Prov_County,Addr.Country,Addr.Zip_code
FROM synBranch AS BR 
LEFT JOIN synAddress AS Addr
ON BR.Address_Id = Addr.Address_Id
LEFT JOIN synBank AS BA
ON BA.Bank_Id =BR.Bank_Id
LEFT JOIN synBranchType AS BRTY
ON BRTY.BranchType_Code = BR.BranchType_Code
GO

----Creating trigger for Insert operation on the updatable View

CREATE TRIGGER  Trigg_Branch_Info_INSERT ON Branch_Info_View
INSTEAD OF INSERT
AS
BEGIN
	
	  DECLARE @BankId  VARCHAR(8)
	  DECLARE @BranchId VARCHAR(6)
	  DECLARE @AddressId  INT
	  SELECT @BankId = B.Bank_Id
	  FROM synBank AS B 
	  INNER JOIN Inserted AS I
	  ON B.Bank_Id = I.Bank_Id
	  IF (@BankId IS NULL)
	  BEGIN
	       RAISERROR('Bank Id does not exists',16,1)
           RETURN
	  END
	  SELECT @BranchId= BR.Branch_Id
	  FROM synBranch AS BR 
	  INNER JOIN Inserted AS I
	  ON BR.Branch_Id = I.Branch_Id
	  IF (@BranchId IS NOT NULL)
	  BEGIN
	       RAISERROR('Branch Id already exists',16,1)
	       RETURN
	  END
	  ELSE
	  BEGIN
		 DECLARE @BranchCode VARCHAR(5)
	     SELECT @BranchCode = BR.BranchType_Code
	     FROM synBranchType AS BR 
	     INNER JOIN Inserted AS I
	     ON BR.BranchType_Code = I.BranchType_Code
	     IF (@BranchCode IS NULL)
	     BEGIN
	       RAISERROR('The Branch Code Type is invalid',16,1)
	       RETURN
	     END
		SELECT @AddressId = BR.Address_Id
	    FROM synBranch AS BR 
	    INNER JOIN Inserted AS I
	    ON BR.Branch_Id = I.Branch_Id

	     IF (@AddressId IS NULL)
	      BEGIN	   
		     SET IDENTITY_INSERT dbo.Address_Table ON
		     INSERT INTO synAddress (Address_Id,Line1,Line2,Town_City,Zip_code,State_Prov_County,Country)
		     SELECT Address_Id,Line1,Line2,Town_City,Zip_code,State_Prov_County,Country FROM inserted
			 SET IDENTITY_INSERT dbo.Address_Table OFF
		  END

	      INSERT INTO synBranch (Branch_Id,Address_Id,Bank_Id,BranchType_Code,Branch_emailid,Branch_Manager_FirstName,Branch_Manager_LastName) 
	      SELECT Branch_Id,Address_Id,Bank_Id,BranchType_Code,Branch_emailid,Branch_Manager_FirstName,Branch_Manager_LastName FROM Inserted
	   END
  END 
     
GO

----Creating trigger for Update operation on the Updatable View

CREATE TRIGGER  Trigg_Branch_Info_UPDATE ON Branch_Info_View
INSTEAD OF UPDATE
AS
BEGIN
   
      IF (UPDATE(Bank_Id))
	  BEGIN
	  RAISERROR('Bank Id cannot be changed',16,1)
	  RETURN
	  END

	  IF (UPDATE(Branch_Id))
	  BEGIN
	  RAISERROR('Branch Id cannot be changed',16,1)
	  RETURN
	  END
	  IF (UPDATE(Address_Id))
	  BEGIN
	     UPDATE synBranch SET Address_Id = inst.Address_Id
		 FROM INSERTED AS inst
		 INNER JOIN synBranch AS BR
	     ON BR.Branch_Id = inst.Branch_Id

		 
		 INSERT INTO synAddress (Address_Id,Line1,Line2,Town_City,Zip_code,State_Prov_County,Country)
		 SELECT Address_Id,Line1,Line2,Town_City,Zip_code,State_Prov_County,Country FROM inserted

     END
	  IF(UPDATE(BranchType_Code))
	   BEGIN
	     UPDATE synBranch SET BranchType_Code = inst.BranchType_Code
	     FROM synBranch AS BR
	     INNER JOIN inserted AS inst
	     ON BR.Branch_Id = inst.Branch_Id
	   END	  
	  IF(UPDATE(Branch_Manager_FirstName))
	   BEGIN
	     UPDATE synBranch SET Branch_Manager_FirstName = inst.Branch_Manager_FirstName
	     FROM synBranch AS BR
	     INNER JOIN inserted AS inst
	     ON BR.Branch_Id = inst.Branch_Id
	   END

	  IF(UPDATE(Branch_Manager_LastName))
	   BEGIN
	     UPDATE synBranch SET Branch_Manager_LastName = inst.Branch_Manager_LastName
	     FROM synBranch AS BR
	     INNER JOIN inserted AS inst
	     ON BR.Branch_Id = inst.Branch_Id
	   END

	  IF(UPDATE(Branch_emailid))
	   BEGIN
	     UPDATE synBranch SET Branch_emailid = inst.Branch_emailid
	     FROM synBranch AS BR
	     INNER JOIN inserted AS inst
	     ON BR.Branch_Id = inst.Branch_Id
	   END


  END

GO



---Creating trigger for delete operation on Updatable View
CREATE TRIGGER TIGGER_Branch_Info_DELETE ON dbo.Branch_Info_View
INSTEAD OF DELETE 
AS BEGIN
	
	 
	  DECLARE @BranchId VARCHAR(6)
	  DECLARE @AddressId  INT
	 

	  SELECT @BranchId= BR.Branch_Id
	  FROM synBranch AS BR 
	  INNER JOIN Deleted AS D
	  ON BR.Branch_Id = D.Branch_Id

	  IF (@BranchId IS NULL)
	  BEGIN
	       RAISERROR('Branch Id does not exists',16,1)
	       RETURN
	  END
	  ELSE
	  BEGIN
		 SELECT @AddressId = BR.Address_Id
	     FROM synBranch AS BR 
	     INNER JOIN DELETED AS D
	     ON BR.Branch_Id = D.Branch_Id

	     IF (@AddressId IS NOT NULL)
	     BEGIN	   
		   
		     DELETE FROM synBranch WHERE Branch_Id = @BranchId
		     DELETE FROM synAddress WHERE Address_Id = @AddressId
		 END
    END 
  END
 GO
     

SELECT * FROM Branch_Info_View


INSERT INTO Branch_Info_View  VALUES('SCBLLD48','90327','03','ALICE','K','zbz@gmail.com',138,'12 Lin Ln',NULL,'Mumbai','Maharashtra','India',536579)
SELECT * FROM Branch_Info_View

DELETE FROM Branch_Info_View WHERE Branch_Id = '123456'

UPDATE Branch_Info_View SET Branch_Manager_FirstName = 'Leo' WHERE Branch_Id = '123456'

 
