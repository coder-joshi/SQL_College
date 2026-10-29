mysql> SELECT BC.customer_name
    -> FROM BankCustomer BC
    -> JOIN Depositer D ON BC.customer_name = D.customer_name
    -> JOIN BankAccount BA ON D.accno = BA.accno
    -> JOIN Branch B ON BA.branch_name = B.branch_name
    -> WHERE B.branch_city = 'Delhi'
    -> GROUP BY BC.customer_name
    -> HAVING COUNT(DISTINCT B.branch_name) = (
    ->     SELECT COUNT(*)
    ->     FROM Branch
    ->     WHERE branch_city = 'Delhi'
    -> );
+---------------+
| customer_name |
+---------------+
| Amit          |
+---------------+
1 row in set (0.00 sec)

mysql> SELECT DISTINCT L.customer_name
    -> FROM LOAN L
    -> WHERE L.customer_name NOT IN (
    ->     SELECT D.customer_name
    ->     FROM Depositer D
    -> );
Empty set (0.00 sec)

mysql> SELECT DISTINCT D.customer_name
    -> FROM Depositer D
    -> JOIN BankAccount BA ON D.accno = BA.accno
    -> JOIN LOAN L ON BA.branch_name = L.branch_name
    -> JOIN Branch B ON BA.branch_name = B.branch_name
    -> WHERE B.branch_city = 'Bangalore'
    ->   AND D.customer_name IN (
    ->       SELECT customer_name
    ->       FROM LOAN
    ->   );
+---------------+
| customer_name |
+---------------+
| Priya         |
+---------------+
1 row in set (0.00 sec)

mysql> SELECT branch_name
    -> FROM Branch
    -> WHERE assets > ALL (
    ->     SELECT assets
    ->     FROM Branch
    ->     WHERE branch_city = 'Bangalore'
    -> );
+-------------+
| branch_name |
+-------------+
| Bombay Main |
| Delhi North |
+-------------+
2 rows in set (0.00 sec)

mysql> DELETE FROM BankAccount
    -> WHERE branch_name IN (
    ->     SELECT branch_name
    ->     FROM Branch
    ->     WHERE branch_city = 'Bombay'
    -> );
ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails (`bankdb`.`depositer`, CONSTRAINT `depositer_ibfk_2` FOREIGN KEY (`accno`) REFERENCES `bankaccount` (`accno`))
mysql> UPDATE BankAccount
    -> SET balance = balance * 1.05;
Query OK, 5 rows affected (0.00 sec)
Rows matched: 5  Changed: 5  Warnings: 0
