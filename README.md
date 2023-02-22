# SQLproject Requirement
Requirement:
*Create a database for a banking environment. 

*Perform all possible SQL Development operations based on this database.

*The complete project includes DB Creation, Schema Creation, Tables Creation, 

*Relationships, Data Insertions (Test Data for Data Validations only) and queries based on a set of given requirements from Reporting Clients.

*Programs [Stored Procedures with Views, Triggers & Functions in a Transaction Environment] for automating Data Insertions based on the Validation Logic. 

Create database-- BankdB

Create Schema-- 
  Child                Parents
Branches           Banks,Addresses,Ref_BranchTypes
Customers          Address,Branches
Accounts           Customers,Ref_AccountStatus,Ref_AccountTypes
Transactions       Accounts,Ref_TransactionTypes

Schemas-
dbo-Bank,Address 
Branches_Schema - Branch,Ref_BranchTypes
Accounts_Schema - Accounts, Ref_AccountStatus, Ref_AccountTypes
Customers_Schema - Customer
Transactions_Schema - Transactions, Ref_TransactionTypes

Filegroups- 
Primary-Banks, Address
Account_FG-Accounts,Ref_AccountStatus,Ref_AccountTypes
Customer_FG-Customers
Branch_FG-Branches,Ref_BranchTypes
Transaction_FG- Transactions, Ref_TransactionTypes

Tables:
Banks - Bank_ID (Primary Key), Bank_FullName, Num_Braches,Num_Outlets,Business_type, Num_Severs,Num_Apps

Branch - Branch_ID (Primary Key), Address_ID(FK),Bank_ID(FK),Branch_Type_Code(FK), branch_emailid,branch_manager_first_name,branch_manager_last_name

Address - Address_ID(PK),Line_1, Line_2, Town_City, Zip_Postcode, State_ProvC_County,Country

Transaction - Transaction_ID(PK), Account_Num(FK)

Transaction_Type_Code(FK),Transaction_Date_Time,Transaction_Amt, Transaction_Status,Routing_num

Account-Account_Num(PK),Account_Status_Code,Account_Type_Code,Customer_ID,Current_Balance,Date_of_opening,Routing_num, Check_num,first_name,last_name

Ref_Branch_Types- Branch_Type_Code(PK),Branch_Type_Description

Customers- CustomerFirst_name,CustomerLast_name,Customer_ID(PK), Address_ID(FK),Branch_ID(FK),Customer_DOB,Customer_gender

Ref_Account_Status- Account_Status_Code(PK),Account_Status_Description

Ref_Account_Type-  Account_Type_Code(PK),Account_Type_Description

Ref_Transaction_Type - Ref_TypeCode(PK),Transaction_Type_Description
