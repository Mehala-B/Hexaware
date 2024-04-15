--TASK 1


CREATE DATABASE HMBank;


CREATE TABLE dbo.Customers(
customer_id INT PRIMARY KEY,
first_name VARCHAR(10),
last_name VARCHAR(10),
DOB DATE,
email VARCHAR(20),
phone_number INT,
address VARCHAR(20));


CREATE TABLE dbo.Accounts(
account_id INT PRIMARY KEY,
customer_id INT REFERENCES Customers(customer_id),
account_type VARCHAR(10),        --(e.g., savings, current, zero_balance)
balance INT);

CREATE TABLE Transactions(
transaction_id INT PRIMARY KEY,
account_id INT REFERENCES Accounts(account_id),
transaction_type VARCHAR(10),      --(e.g., deposit, withdrawal, transfer)
amount INT,
transaction_date DATE);


--TASK 2

--1.Insert at least 10 sample records.

INSERT INTO Customers VALUES
(1,'John','Petter','2001-02-12','john@gmail.com',1234532332,'541 Main St,Pune'),
(2,'Benny','George','1999-09-04','benny@gmail.com',1456327241,'564 Pink St,Chennai'),
(3,'John','Davis','2000-02-21','john@gmail.com',1246787466,'234 Main St,Kolkata'),
(4,'Caren','David','1997-09-17','caren@gmail.com',1332642756,'764 Mount St,Pune'),
(5,'Henry','Jones','2001-12-06','henry@gmail.com',1286653326,'654 Head St,Patna'),
(6,'Harry','Potter','2003-02-19','harry@gmail.com',1545443253,'542 Cross St,Chennai'),
(7,'Charlie','Lewis','1998-03-31','charlie@gmail.com',1423535675,'239 Link St,Delhi'),
(8,'Marry','Willams','1997-06-10','marry@gmail.com',1237654686,'324 Main St,Mumbai'),
(9,'Jenny','Dooms','1998-02-15','jenny@gmail.com',1753442544,'464 Line St,Punjab'),
(10,'Sara','Diana','2000-02-18','sara@gmail.com',1433562354,'232 Cross St,Mumbai');


INSERT INTO Accounts VALUES
(101,2,'savings',150000),
(102,8,'savings',200000),
(103,1,'current',250000),
(104,5,'zero_bal',50000),
(105,10,'savings',10000),
(106,3,'zero_bal',25000),
(107,7,'current',70000),
(108,9,'savings',130000),
(109,4,'current',85000),
(110,6,'zero_bal',45000);


INSERT INTO Transactions VALUES
(1001,105,'transfer',1000,'2024-03-21'),
(1002,101,'withdrawal',10000,'2024-02-27'),
(1003,107,'withdrawal',5000,'2024-02-18'),
(1004,102,'deposit',20000,'2024-03-31'),
(1005,109,'transfer',15000,'2024-01-05'),
(1006,106,'deposit',7000,'2024-01-13'),
(1007,108,'transfer',25000,'2024-03-17'),
(1008,110,'withdrwal',3000,'2024-01-28'),
(1009,103,'deposit',12000,'2024-01-13'),
(1010,104,'transfer',6000,'2024-03-11');



--2.Write SQL queries for the following tasks:

--1.Write a SQL query to retrieve the name, account type and email of all customers.

SELECT first_name,last_name,account_type,email FROM Customers,Accounts
WHERE Accounts.customer_id=Customers.customer_id;

--2.Write a SQL query to list all transaction corresponding customer.

SELECT C.customer_id,first_name,last_name,T.transaction_id,T.account_id,T.transaction_type,T.transaction_date,T.amount
FROM Customers C,Transactions T,Accounts  A 
WHERE C.customer_id=A.customer_id AND T.account_id=A.account_id;

--3.Write a SQL query to increase the balance of a specific account by a certain amount.

UPDATE Accounts 
SET balance=balance+5000 WHERE account_id=105;

--4.Write a SQL query to Combine first and last names of customers as a full_name.

SELECT CONCAT(first_name,' ',last_name) AS full_name FROM Customers;

--5.Write a SQL query to remove accounts with a balance of zero where the account type is savings.

INSERT INTO Accounts VALUES
(111,3,'savings',0);

DELETE FROM Accounts WHERE balance=0 AND account_type='savings';

--6.Write a SQL query to Find customers living in a specific city.

SELECT * FROM Customers
WHERE address LIKE '%Chennai';

--7.Write a SQL query to Get the account balance for a specific account.

SELECT balance FROM Accounts WHERE account_id=108;

--8.Write a SQL query to List all current accounts with a balance greater than $1,000.

SELECT * FROM Accounts WHERE account_type='current' AND balance>1000;

--9.Write a SQL query to Retrieve all transactions for a specific account.

SELECT * FROM Transactions WHERE account_id=105;

--10.Write a SQL query to Calculate the interest accrued on savings accounts based on a given interest rate.

DECLARE @Interest_rate INT;
SET @Interest_rate=10;

SELECT account_id,((balance*@Interest_rate)/100) AS Interest_Accured FROM Accounts 


--11.Write a SQL query to Identify accounts where the balance is less than a specified overdraft limit.

INSERT INTO Accounts VALUES
(111,3,'Current',500);

DECLARE @OverDraftLimit INT;
SET @OverDraftLimit=1000;
SELECT * FROM Accounts WHERE balance<@OverDraftLimit;

DELETE FROM Accounts WHERE account_id=111; 

--12.Write a SQL query to Find customers not living in a specific city.

SELECT * FROM Customers
WHERE Address  NOT LIKE '%Chennai';


--TASK 3

--1.Write a SQL query to Find the average account balance for all customers.

SELECT C.customer_id,AVG(balance) AS Avg_acc_balance FROM Customers C
JOIN Accounts A ON C.customer_id=A.customer_id
GROUP BY C.customer_id;

--2.Write a SQL query to Retrieve the top 10 highest account balances.

SELECT TOP 10 * FROM Accounts ORDER BY balance DESC;

--3.Write a SQL query to Calculate Total Deposits for All Customers in specific date.

SELECT SUM(amount) AS Total_Deposits FROM Transactions
WHERE transaction_type = 'Deposit' AND transaction_date = '2024-03-31';

--4.Write a SQL query to Find the Oldest and Newest Customers.

--OLD

SELECT TOP 1 MIN(t.transaction_date) AS OldestTransactionDate,c.customer_id,CONCAT(first_name,' ',last_name) AS OLDEST_CUSTOMER
FROM Customers c
INNER JOIN Accounts a ON c.customer_id = a.customer_id
INNER JOIN Transactions t ON a.account_id= t.account_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY OldestTransactionDate ASC;

--NEW


SELECT TOP 1 MAX(t.transaction_date) AS NewestTransactionDate,c.customer_id,CONCAT(first_name,' ',last_name) AS NEWEST_CUSTOMER
FROM Customers c
INNER JOIN Accounts a ON c.customer_id = a.customer_id
INNER JOIN Transactions t ON a.account_id= t.account_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY NewestTransactionDate DESC;


--5.Write a SQL query to Retrieve transaction details along with the account type.

SELECT transaction_id,t.account_id,transaction_type,amount,transaction_date,account_type FROM Transactions t 
INNER JOIN Accounts a ON a.account_id= t.account_id
GROUP BY transaction_id,t.account_id,transaction_type,amount,transaction_date,account_type;



--6.Write a SQL query to Get a list of customers along with their account details.

SELECT c.customer_id,CONCAT(first_name,' ',last_name) AS Customer_Name,account_id,account_type,balance FROM Customers c
INNER JOIN Accounts a ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name,account_id,account_type,balance;

--7.Write a SQL query to Retrieve transaction details along with customer information for a specific account.

SELECT transaction_id,t.account_id,transaction_type,amount,transaction_date,c.customer_id,CONCAT(first_name,' ',last_name) AS Customer_Name
FROM Customers c
INNER JOIN Accounts a ON c.customer_id = a.customer_id
INNER JOIN Transactions t ON a.account_id= t.account_id 
WHERE c.customer_id=3
GROUP BY transaction_id,t.account_id,transaction_type,amount,transaction_date,c.customer_id, c.first_name, c.last_name;


--8.Write a SQL query to Identify customers who have more than one account.

INSERT INTO Accounts VALUES
(111,2,'transfer',14000);

SELECT customer_id,COUNT(account_id) AS NumberOfAccounts FROM Accounts
GROUP BY customer_id
HAVING COUNT(account_id) > 1;

DELETE FROM Accounts WHERE account_id=111;

--9.Write a SQL query to Calculate the difference in transaction amounts between deposits and withdrawals.

SELECT (SELECT SUM(amount) FROM Transactions WHERE transaction_type='deposit')-
(SELECT SUM(amount) FROM Transactions WHERE transaction_type='withdrawal') AS Difference;

--10.Write a SQL query to Calculate the average daily balance for each account over a specified period.

SELECT SUM(balance) AS Avg_daily_balance FROM Accounts a
INNER JOIN Transactions t ON a.account_id=t.account_id
WHERE transaction_date BETWEEN '2024-01-30' AND '2024-02-28'; 

--11.Calculate the total balance for each account type.

SELECT SUM(balance) AS Total_balance,account_type FROM Accounts GROUP BY account_type;

--12.Identify accounts with the highest number of transactions order by descending order.

INSERT INTO Transactions VALUES
(1011,101,'transfer',500,'2024-01-03');


SELECT COUNT(*) AS No_of_transactions,account_id FROM Transactions 
GROUP BY account_id ORDER BY No_of_transactions DESC;

DELETE FROM Transactions WHERE transaction_id=1011;

--13.List customers with high aggregate account balances, along with their account types.

SELECT c.customer_id,c.first_name,c.last_name,a.account_type,SUM(a.balance) AS Total_balance FROM Customers c
INNER JOIN Accounts a ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, a.account_type
ORDER BY Total_balance DESC;

--14.Identify and list duplicate transactions based on transaction amount, date, and account.

INSERT INTO Transactions VALUES
(1012,101,'transfer',10000,'2024-02-27');


SELECT t1.transaction_id,t1.amount,t1.transaction_date,t1.account_id FROM Transactions t1
JOIN Transactions t2 ON t1.account_id = t2.account_id AND t1.amount = t2.amount AND t1.transaction_date = t2.transaction_date
AND t1.transaction_id <> t2.transaction_id;


DELETE FROM Transactions WHERE transaction_id=1012;


--TASK 4

--1.Retrieve the customer(s) with the highest account balance.

SELECT * FROM Customers WHERE customer_id=
(SELECT customer_id FROM Accounts WHERE balance=
(SELECT MAX(balance) FROM Accounts));

--2.Calculate the average account balance for customers who have more than one account.

INSERT INTO Accounts VALUES
(112,2,'current',20000);

SELECT AVG(balance) AS Avg_account_balance FROM Accounts WHERE customer_id IN
(SELECT customer_id FROM Accounts GROUP BY customer_id HAVING COUNT(account_id)>1);

DELETE FROM Accounts WHERE account_id=112;

--3.Retrieve accounts with transactions whose amounts exceed the average transaction amount.

SELECT account_id,amount FROM Transactions WHERE amount>
(SELECT AVG(amount) FROM Transactions);

--4.Identify customers who have no recorded transactions.

INSERT INTO Customers VALUES
(11,'Lilly','Adams','2021-01-02','lilly@gmail.com',1234543242,'756 Main St,Pune');

SELECT * FROM Customers WHERE customer_id NOT IN
(SELECT customer_id FROM Accounts WHERE account_id IN
(SELECT account_id FROM Transactions));


--5.Calculate the total balance of accounts with no recorded transactions.

INSERT INTO Accounts VALUES
(113,11,'current',20000);

SELECT SUM(balance) AS Toatal_balance FROM Accounts WHERE account_id NOT IN 
(SELECT account_id FROM Transactions);

--6.Retrieve transactions for accounts with the lowest balance.

SELECT * FROM Transactions WHERE account_id=
(SELECT TOP 1 account_id FROM Accounts ORDER BY balance ASC);

--7.Identify customers who have accounts of multiple types.

INSERT INTO Accounts VALUES
(114,1,'savings',20000);

SELECT CONCAT(first_name,' ',last_name)  AS Full_name FROM Customers WHERE customer_id IN 
(SELECT customer_id FROM Accounts  GROUP BY customer_id HAVING COUNT( DISTINCT account_type)>1);

--8.Calculate the percentage of each account type out of the total number of accounts.

SELECT account_type, (COUNT(*) * 100/(SELECT COUNT(*) FROM Accounts)) AS Percentage FROM Accounts GROUP BY account_type;


--9.Retrieve all transactions for a customer with a given customer_id.

DECLARE @CustomerID INT =5;
SELECT t.transaction_id , t.transaction_type , t.transaction_date ,t.account_id , t.amount 
FROM Transactions t WHERE t.account_id IN 
(SELECT account_id FROM Accounts a  WHERE a.customer_id = @CustomerID);

--10.Calculate the total balance for each account type, including a subquery within the SELECT clause.

SELECT account_type ,(SELECT SUM(balance) FROM Accounts a1 WHERE a1.account_type=a2.account_type ) AS TotalBalance  
FROM Accounts a2 GROUP BY account_type;


SELECT * FROM Customers
SELECT * FROM Accounts
SELECT * FROM Transactions

