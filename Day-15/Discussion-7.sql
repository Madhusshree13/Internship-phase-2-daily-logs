--Write a query to find the name (first_name, last_name) and the salary of the employees who have a higher salary than the employee whose last_name='Bull'.
select concat(first_name," ",last_name) as name, salary from employee where salary>(select salary from employee where last_name='bull');


-- 2. Write a query to find the name (first_name, last_name) of all employees who works in the IT department.
select concat(first_name," ",last_name) as name, salary from employee e where e.department_id in (select department_id from department d where department_name="IT");


-- 3. Write a query to find the name (first_name, last_name) of the employees who have a manager and worked in a USA-based department.
select concat(first_name," ",last_name) as name from employee e where manager_id in 
(select employee_id from employee where employee_id in (select manager_id from department where location_id="USA"));


-- 4. Write a query to find the name (first_name, last_name) of the employees who are managers.
select concat(first_name," ",last_name) as name from employee e where employee_id in (select manager_id from department);


-- 5. Write a query to find the name (first_name, last_name), and salary of the employees whose salary is greater than the average salary.
select concat(first_name," ",last_name) as name,salary from employee e where salary>(select avg(salary) from employee);


-- 6. Write a query to find the name (first_name, last_name), and salary of the employees whose salary is equal to the minimum salary for their jobs.
select concat(first_name," ",last_name) as name,salary,job_id from employee e where salary>(select min(salary) from employee group by job_id);


-- 7. Write a query to find the name (first_name, last_name), and salary of the employees who earns more than the average salary and works in any of the IT departments.
select concat(first_name," ",last_name) as name,salary from employee e where salary>(select avg(salary) from employee) 
and department_id in (select department_id from department where department_name="IT");


-- 8. Write a query to find the name (first_name, last_name), and salary of the employees who earns more than the earnings of Mr. Bell.
select concat(first_name," ",last_name) as name, salary from employee where salary>(select salary from employee where last_name='bell');


-- 9. Write a query to find the name (first_name, last_name), and salary of the employees who earn the same salary as the minimum salary for all departments.
select concat(first_name," ",last_name) as name, salary from employee where salary=(select min(salary) from employee group by department_id);


-- 10. Write a query to find the name (first_name, last_name), and salary of the employees whose salary is greater than the average salary of all departments.
select concat(first_name," ",last_name) as name, salary from employee where salary>(select avg(salary) from employee group by department_id);


-- 11. Write a query to find the name (first_name, last_name) and salary of the employees who earn a salary that is higher than the salary of 
-- all the Shipping Clerk (JOB_ID = 'SH_CLERK'). Sort the results of the salary from the lowest to highest.
select concat(first_name," ",last_name) as name, salary from employee where salary>(select salary from employee where job_id="SH_CLERK") order by salary;


-- 12. Write a query to find the name (first_name, last_name) of the employees who are not managers.
select concat(first_name," ",last_name) as name from employee e where employee_id not in (select manager_id from department);


-- 13. Write a query to display the employee ID, first name, last name, and department names of all employees.
select employee_id, first_name, last_name,(select department_name from department d where e.department_id=d.department_id) as department_name from employee e;


-- 14. Write a query to display the employee ID, first name, last name, salary of all employees whose salary is above average for their departments.
select employee_id, first_name, last_name,salary from employee e1 where salary>(select avg(salary) from employee e2 where e1.department_id=e2.department_id 
group by department_id);


-- 15. Write a query to fetch even numbered records from employees table.
select * from employee where employee_id%2=0;


-- 16. Write a query to find the 5th maximum salary in the employees table.
select distinct(salary) from employee where salary=(select salary from employee order by salary desc skip 4 limit 1);


-- 17. Write a query to find the 4th minimum salary in the employees table.
select distinct(salary) from employee where salary=(select salary from employee order by salary asc skip 3 limit 1);


-- 18. Write a query to select the last 10 records from a table.
select * from (select * from employee order by employee_id desc limit 10) order by employee_id;


-- 19. Write a query to list the department ID and name of all the departments where no employee is working.
select department_id,department_name from department where department_id not in (select department_id from employee);


-- 20. Write a query to get 3 maximum salaries.
select salary from (select distinct(salary) from employee order by salary desc limit 3) as max_salaries;


-- 21. Write a query to get 3 minimum salaries.
select salary from (select distinct(salary) from employee order by salary asc limit 3) as min_salaries;


-- 22. Write a query to get nth max salaries of employees.
SELECT DISTINCT SALARY FROM employees e1 WHERE (SELECT COUNT(DISTINCT(e2.SALARY)) FROM employees e2 WHERE e2.SALARY > e1.SALARY) LIMIT 1;