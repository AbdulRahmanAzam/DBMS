# TRANSACTIONS

# Q1Create a new table named product_inventory with columns for product_id, product_name, stock,
# and price. Insert three different product records with initial stock values. Without committing the
# transaction, reduce the stock of one of the products and create a savepoint named stock_update.
```sql
create table product_inventory (
  productId number primary key,
  productName varchar2(50),
  stock number,
  price number(10, 2)
);

INSERT INTO product_inventory VALUES (1, 'Keyboard', 50, 3500.00);
INSERT INTO product_inventory VALUES (2, 'Mouse',    80, 1500.00);
INSERT INTO product_inventory VALUES (3, 'Monitor',  20, 25000.00);

-- reduct stock without committing
update product_inventory
set stock = stock-5
where productId = 2;

-- 4 create savepoint
savepoint stock_update;

select * from product_inventory order by productId;
```

# Q2: In the employee table, add a new employee with a salary. Then, increase their salary by 10%, set
# a savepoint named salary_increase, and then further increase it by another 5%. Rollback to the
# salary_increase savepoint.
```sql
create table emp(
  empno number primary key,
  ename varchar2(50),
  salary number(12,2)
);
  
INSERT INTO emp (empno, ename, salary)
VALUES (1001, 'New Hire', 50000);

update emp
set salary = salary * 1.10
where empno = 1001;

savepoint salaryIncrease;

update emp
set salary = salary * 0.10
where empno = 1001;

rollback to salaryIncrease;

select * 
from emp
where empno = 1001;
```

# Q3
```sql

create table customer (
  customerId number primary key,
  customerName varchar2(50),
  contact varchar2(50)
);

create table orders (
  orderId number primary key,
  customerId number,
  orderDate Date,
  amount number,
  constraint fk_order_customer FOREIGN key (customerId) references customer(customerId)
);

begin 
  insert into customer (customerId, customerName, contact)
  values (101, 'hehe', '234523452345');
  
  insert into orders (orderId, customerId, orderDate, amount)
  values (5005, 101, SYSDATE, 3500);
  
  commit;
  
  exception
    when others then
      rollback to startTransaction;
      dbms_output.put_line('Transaction rolled back');
      raise;
end;
/

savepoint startTransaction;

begin 
  insert into customer (customerId, customerName, contact)
  values (102, 'hehe', '234523452345');
  
  insert into orders (orderId, customerId, orderDate, amount)
  values (5005, 102, SYSDATE, 3500);
  
  commit;
  
  exception
    when others then
      rollback to startTransaction;
      dbms_output.put_line('Transaction rolled back');
      raise;
end;
/

select * from customer;
```

# Q4
```sql

```
