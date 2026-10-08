mysql> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| insurance          |
| mysql              |
| performance_schema |
| productdb          |
| sakila             |
| sys                |
| world              |
+--------------------+
8 rows in set (0.00 sec)

mysql> CREATE DATABASE banking_ent;
Query OK, 1 row affected (0.01 sec)

mysql> USE banking_ent;
Database changed
mysql> CREATE TABLE BRANCH(branch-name VARCHAR(30), branch-city VARCHAR(20),ASSETS INT(10));
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '-name VARCHAR(30), branch-city VARCHAR(20),ASSETS INT(10))' at line 1
mysql> CREATE TABLE BRANCH(branch_name VARCHAR(30), branch_city VARCHAR(20),ASSETS INT(10));
Query OK, 0 rows affected, 1 warning (0.02 sec)

mysql> ALTER TABLE BRANCH RENAME TO Branch;
Query OK, 0 rows affected (0.01 sec)

mysql> CREATE TABLE branch(branch_name VARCHAR(30), branch_city VARCHAR(20),ASSETS INT);
ERROR 1050 (42S01): Table 'branch' already exists
mysql> CREATE TABLE BankAccount(accno INT PRIMARY KEY, branch_name VARCHAR(30), balance INT, FOREIGN KEY (branch_name) REFERENCES Branch(branch_name));
ERROR 1822 (HY000): Failed to add the foreign key constraint. Missing index for constraint 'bankaccount_ibfk_1' in the referenced table 'branch'
mysql> ALTER TABLE branch
    -> branch_name VARCHAR(30) PRIMARY KEY;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'branch_name VARCHAR(30) PRIMARY KEY' at line 2
mysql> ALTER TABLE BRANCH ADD PRIMARY KEY (branch_name);
Query OK, 0 rows affected (0.03 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> CREATE TABLE BankAccount(accno INT PRIMARY KEY, branch_name VARCHAR(30), balance INT, FOREIGN KEY (branch_name) REFERENCES Branch(branch_name));
Query OK, 0 rows affected (0.02 sec)

mysql> -- ERROR 1822 (HY000): Failed to add the foreign key constraint. Missing index for constraint...
mysql> DESC BankAccount;
+-------------+-------------+------+-----+---------+-------+
| Field       | Type        | Null | Key | Default | Extra |
+-------------+-------------+------+-----+---------+-------+
| accno       | int         | NO   | PRI | NULL    |       |
| branch_name | varchar(30) | YES  | MUL | NULL    |       |
| balance     | int         | YES  |     | NULL    |       |
+-------------+-------------+------+-----+---------+-------+
3 rows in set (0.00 sec)

mysql> CREATE TABLE BankCustomer (customer-name: VARCHAR(100), customer-street: VARCHAR(50), customer-city VARCHAR(50));
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '-name: VARCHAR(100), customer-street: VARCHAR(50), customer-city VARCHAR(50))' at line 1
mysql> CREATE TABLE BankCustomer (customer_name: VARCHAR(100), customer_street: VARCHAR(50), customer_city VARCHAR(50));
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near ': VARCHAR(100), customer_street: VARCHAR(50), customer_city VARCHAR(50))' at line 1
mysql> CREATE TABLE BankCustomer (customer_name VARCHAR(100), customer_street VARCHAR(50), customer_city VARCHAR(50));
Query OK, 0 rows affected (0.02 sec)

mysql> CREATE TABLE depositer(customer-name VARCHAR(100),accno INT, FOREIGN KEY (accno) REFERENCES BankAccount(accno));
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '-name VARCHAR(100),accno INT, FOREIGN KEY (accno) REFERENCES BankAccount(accno))' at line 1
mysql> CREATE TABLE depositer(customer_name VARCHAR(100),accno INT, FOREIGN KEY (accno) REFERENCES BankAccount(accno));
Query OK, 0 rows affected (0.02 sec)

mysql> CREATE TABLE Loan(loan_number INT PRIMARY KEY, branch_name VARCHAR(30),amount INT, FOREIGN KEY (branch_name) REFERENCES branch(branch_name));
Query OK, 0 rows affected (0.02 sec)

mysql> ALTER TABLE Depositer
    -> ADD PRIMARY KEY (customer_name);
Query OK, 0 rows affected (0.06 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE Depositer
    -> DROP PRIMARY KEY;
Query OK, 5 rows affected (0.06 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE BankCustomer
    -> ADD PRIMARY KEY (customer_name);
Query OK, 0 rows affected (0.06 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE Depositer
    -> ADD FOREIGN KEY (customer_name) REFERENCES BankCustomer(customer_name);
Query OK, 5 rows affected (0.06 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Branch (branch_name, branch_city, assets) VALUES
    -> ('SBI_Chamrajpet', 'Bangalore', 50000),
    -> ('SBI_ResidencyRoad', 'Bangalore', 10000),
    -> ('SBI_ShivajiRoad', 'Bombay', 20000),
    -> ('SBI_ParlimentRoad', 'Delhi', 10000),
    -> ('SBI_Jantarmantar', 'Delhi', 20000);
Query OK, 5 rows affected (0.00 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> INSERT INTO BankAccount (accno, branch_name, balance) VALUES
    -> (1, 'SBI_Chamrajpet', 2000),
    -> (2, 'SBI_ResidencyRoad', 5000),
    -> (3, 'SBI_ShivajiRoad', 6000),
    -> (4, 'SBI_ParlimentRoad', 9000),
    -> (5, 'SBI_Jantarmantar', 8000),
    -> (6, 'SBI_ShivajiRoad', 4000),
    -> (8, 'SBI_ResidencyRoad', 4000),
    -> (9, 'SBI_ParlimentRoad', 3000),
    -> (10, 'SBI_ResidencyRoad', 5000),
    -> (11, 'SBI_Jantarmantar', 2000);
Query OK, 10 rows affected (0.00 sec)
Records: 10  Duplicates: 0  Warnings: 0

mysql> INSERT INTO BankCustomer (customer_name, customer_street, customer_city) VALUES
    -> ('Avinash', 'Bull_Temple_Road', 'Bangalore'),
    -> ('Dinesh', 'Bannerghatta_Road', 'Bangalore'),
    -> ('Mohan', 'NationalCollege_Road', 'Bangalore'),
    -> ('Nikhil', 'Akbar_Road', 'Delhi'),
    -> ('Ravi', 'Prithviraj_Road', 'Delhi');
Query OK, 5 rows affected (0.00 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Depositer (customer_name, accno) VALUES
    -> ('Avinash', 1),
    -> ('Dinesh', 2),
    -> ('Nikhil', 4),
    -> ('Ravi', 5),
    -> ('Avinash', 8),
    -> ('Nikhil', 9),
    -> ('Dinesh', 10),
    -> ('Nikhil', 11);
Query OK, 8 rows affected (0.00 sec)
Records: 8  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Loan (loan_number, branch_name, amount) VALUES
    -> (1, 'SBI_Chamrajpet', 1000),
    -> (2, 'SBI_ResidencyRoad', 2000),
    -> (3, 'SBI_ShivajiRoad', 3000),
    -> (4, 'SBI_ParlimentRoad', 4000),
    -> (5, 'SBI_Jantarmantar', 5000);
Query OK, 5 rows affected (0.01 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM Branch;
+-------------------+-------------+--------+
| branch_name       | branch_city | ASSETS |
+-------------------+-------------+--------+
| SBI_Chamrajpet    | Bangalore   |  50000 |
| SBI_Jantarmantar  | Delhi       |  20000 |
| SBI_ParlimentRoad | Delhi       |  10000 |
| SBI_ResidencyRoad | Bangalore   |  10000 |
| SBI_ShivajiRoad   | Bombay      |  20000 |
+-------------------+-------------+--------+
5 rows in set (0.00 sec)

mysql> SELECT * FROM BankAccount;
+-------+-------------------+---------+
| accno | branch_name       | balance |
+-------+-------------------+---------+
|     1 | SBI_Chamrajpet    |    2000 |
|     2 | SBI_ResidencyRoad |    5000 |
|     3 | SBI_ShivajiRoad   |    6000 |
|     4 | SBI_ParlimentRoad |    9000 |
|     5 | SBI_Jantarmantar  |    8000 |
|     6 | SBI_ShivajiRoad   |    4000 |
|     8 | SBI_ResidencyRoad |    4000 |
|     9 | SBI_ParlimentRoad |    3000 |
|    10 | SBI_ResidencyRoad |    5000 |
|    11 | SBI_Jantarmantar  |    2000 |
+-------+-------------------+---------+
10 rows in set (0.00 sec)

mysql> SELECT * FROM BankCustomer;
+---------------+----------------------+---------------+
| customer_name | customer_street      | customer_city |
+---------------+----------------------+---------------+
| Avinash       | Bull_Temple_Road     | Bangalore     |
| Dinesh        | Bannerghatta_Road    | Bangalore     |
| Mohan         | NationalCollege_Road | Bangalore     |
| Nikhil        | Akbar_Road           | Delhi         |
| Ravi          | Prithviraj_Road      | Delhi         |
+---------------+----------------------+---------------+
5 rows in set (0.00 sec)

mysql> SELECT * FROM Depositer;
+---------------+-------+
| customer_name | accno |
+---------------+-------+
| Avinash       |     1 |
| Dinesh        |     2 |
| Nikhil        |     4 |
| Ravi          |     5 |
| Avinash       |     8 |
| Nikhil        |     9 |
| Dinesh        |    10 |
| Nikhil        |    11 |
+---------------+-------+
8 rows in set (0.00 sec)

mysql> SELECT * FROM Loan;
+-------------+-------------------+--------+
| loan_number | branch_name       | amount |
+-------------+-------------------+--------+
|           1 | SBI_Chamrajpet    |   1000 |
|           2 | SBI_ResidencyRoad |   2000 |
|           3 | SBI_ShivajiRoad   |   3000 |
|           4 | SBI_ParlimentRoad |   4000 |
|           5 | SBI_Jantarmantar  |   5000 |
+-------------+-------------------+--------+
5 rows in set (0.00 sec)

mysql> ALTER TABLE BankAccount
    -> ADD FOREIGN KEY (branch_name) REFERENCES Branch(branch_name) ON DELETE CASCADE
    -> ON UPDATE CASCADE;
Query OK, 10 rows affected (0.06 sec)
Records: 10  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE Depositer
    -> ADD FOREIGN KEY (accno) REFERENCES BankAccount(accno) ON DELETE CASCADE
    -> ON UPDATE CASCADE;
Query OK, 8 rows affected (0.06 sec)
Records: 8  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE Depositer
    -> ADD FOREIGN KEY (customer_name) REFERENCES BankAccount(customer_name) ON DELETE CASCADE
    -> ON UPDATE CASCADE;
mysql> ALTER TABLE Depositer
    -> ADD FOREIGN KEY (customer_name) REFERENCES BankCustomer(customer_name) ON DELETE CASCADE
    -> ON UPDATE CASCADE;
Query OK, 8 rows affected (0.06 sec)
Records: 8  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE Loan
    -> ADD FOREIGN KEY (branch_name) REFERENCES BankAccount(branch_name) ON DELETE CASCADE ON UPDATE CASCADE;
Query OK, 5 rows affected (0.06 sec)
Records: 5  Duplicates: 0  Warnings: 0
