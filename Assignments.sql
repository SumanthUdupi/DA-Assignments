/*-SET2-1-*/
SELECT * FROM assignment.emp
WHERE salary > 3000;
SELECT 
    *
FROM
    assignment.emp
WHERE
    deptno = 10;
    /*-SET2-2-*/
    SELECT * FROM assignment.students;
SELECT 
    CASE
        WHEN marks BETWEEN 81 AND 100 THEN 'Distinction'
        WHEN marks BETWEEN 51 AND 80 THEN 'First Class'
        WHEN marks BETWEEN 40 AND 50 THEN 'Second class'
        ELSE 'No Grade Available'
    END Grade,
    COUNT(*) AS stud_count
FROM
    assignment.students
WHERE
    marks > 50
GROUP BY CASE
    WHEN marks BETWEEN 81 AND 100 THEN 'Distinction'
    WHEN marks BETWEEN 51 AND 80 THEN 'First Class'
    WHEN marks BETWEEN 40 AND 50 THEN 'Second class'
    ELSE 'No Grade Available'
END;
    /*-SET2-3-*/
    
SELECT * FROM assignment.station;
SELECT CITY
FROM STATION
WHERE MOD(ID, 2) = 0;
    /*-SET2-4-*/
    SELECT * FROM assignment.station;
SELECT 
    (COUNT(CITY) - COUNT(DISTINCT CITY))
FROM
    STATION;
    /*-SET2-5a-*/
    SELECT * FROM assignment.station;
SELECT DISTINCT
    city
FROM
    station
WHERE
    REGEXP_LIKE(city, '^[aeiouAEIOU]');
    /*-SET2-5b-*/
    SELECT * FROM assignment.station;
SELECT DISTINCT
    city
FROM
    station
WHERE
    REGEXP_LIKE(city, '^[aeiouAEIOU]')
        AND REGEXP_LIKE(city, '[aeiouAEIOU]$');
    /*-SET2-5c-*/
    SELECT * FROM assignment.station;
SELECT DISTINCT
    CITY
FROM
    STATION
WHERE
    CITY RLIKE '^[^aeiouAEIOU].*';
    /*-SET2-5d-*/
    SELECT * FROM assignment.station;
 SELECT DISTINCT
    city
FROM
    station
WHERE
    city RLIKE '^[^aeiouAEIOU].*[^aeiouAEIOU]$';
    /*-SET2-6-*/
    SELECT * FROM assignment.emp;
SELECT 
    *
FROM
    Emp
WHERE
    Salary > 2000
        AND Hire_Date >= DATE_SUB(CURRENT_DATE,
        INTERVAL 36 MONTH)
ORDER BY emp_no DESC;
    /*-SET2-7-*/
    SELECT * FROM assignment.employee;
SELECT deptno, SUM(salary)
FROM assignment.employee
GROUP BY deptno;
    /*-SET2-8-*/
    SELECT * FROM assignment.city;
SELECT 
    COUNT(name)
FROM
    assignment.city
WHERE
    population > 100000;
    /*-SET2-9-*/
    SELECT * FROM assignment.city;
SELECT 
    SUM(POPULATION)
FROM
    assignment.city
WHERE
    DISTRICT = 'California';
    /*-SET2-10-*/
    SELECT * FROM assignment.city;
SELECT 
    countrycode, AVG(population) AS avg_population
FROM
    city
WHERE
    countrycode IN ('JPN' , 'USA', 'NLD')
GROUP BY countrycode;
    /*-SET2-11-*/
    SELECT 
    *
FROM
    assignment.orders;
SELECT 
    a.orderNumber,
    a.status,
    a.customerNumber,
    b.customerName,
    a.comments
FROM
    assignment.orders a
        INNER JOIN
    assignment.customers b ON a.customerNumber = b.customerNumber
WHERE
    comments LIKE '%disputed%';  
    /*-SET3-1-*/
    delimiter //

create procedure order_status(in param_year int, in param_month int)

begin

  select orderNumber,orderDate,status 
  from orders where year(orderDate) = param_year and month(orderDate) = param_month;
  
end //																																																	 

call order_status(2003,01);
    /*-SET3-2a-*/
    CREATE TABLE `assignment`.`cancellations` (
  `id` INT NOT NULL,
  `customernumber` INT NULL,
  `ordernumber` INT NULL,
  `comments` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `customernumber_idx` (`customernumber` ASC) VISIBLE,
  INDEX `ordernumber_idx` (`ordernumber` ASC) VISIBLE,
  CONSTRAINT `customernumber`
    FOREIGN KEY (`customernumber`)
    REFERENCES `assignment`.`customers` (`customerNumber`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `ordernumber`
    FOREIGN KEY (`ordernumber`)
    REFERENCES `assignment`.`orders` (`orderNumber`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
    /*-SET3-2b-*/
    SELECT * FROM assignment.orders;
delimiter //
drop procedure cancelled_orders;
create procedure cancelled_orders()
begin
    insert into cancellations(customernumber, ordernumber)
    select customers.customernumber, orders.ordernumber 
    from customers join orders
    on customers.customernumber = orders.customernumber
    where orders.status = 'cancelled';
end //
call cancelled_orders()
    /*-SET3-3a-*/
    delimiter $$
create function pur_stat(
cid int
)
returns varchar(100)
deterministic 
begin
    declare stat varchar(100);
    declare credit numeric;
    set credit = (select sum(amount) from payments where customerNumber=cid);

   if credit > 50000 then 
      set stat='platinum';
   elseif (credit >= 25000 and
           credit <= 50000) then
	  set stat = 'gold';
   elseif credit < 25000 then 
      set stat = 'silver';
   end if;
   return(stat);
end $$
select pur_stat(103);
    /*-SET3-3b-*/
    SELECT * FROM assignment.payments;
SELECT 
    customerNumber,
    customerName,
    PUR_STAT(customerNumber) AS purchase_status
FROM
    customers;
    /*-SET3-4-*/
    delimiter //
drop trigger update_table;
create trigger update_table
before update on assignment.movies for each row
begin
  update assignment.rentals 
  set movieid = new.id
  where moveid = old.id;
end //

select * from assignment.movies;
update assignment.movies set id = 20 where title = 'Real Steel';

delimiter //
drop trigger delete_record;
create trigger delete_record 
after delete on assignment.movies for each row
begin 
   delete from assignment.rentals
   where movieid = old.id;
end //
    /*-SET3-5-*/
    SELECT 
    *
FROM
    assignment.employee;
SELECT 
    fname
FROM
    assignment.employee
ORDER BY salary DESC
LIMIT 2 , 1;
    /*-SET3-6-*/
SELECT 
    *
FROM
    assignment.employee;
select empid, fname, salary, rank() over(order by salary desc) as salary_rank from assignment.employee;