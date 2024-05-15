-- 1.) Write a query to find the addresses (location_id, street_address, city, state_province, country_name) of all the departments.
SELECT LOCATION_ID, STREET_ADDRESS, CITY, STATE_PROVINCE, COUNTRY_NAME FROM locations INNER JOIN countries USING(COUNTRY_ID);

-- 2.) Write a query to find the name (first_name, last name), department ID, and department name of all the employees.
SELECT CONCAT(FIRST_NAME, " ", LAST_NAME) AS NAME, DEPARTMENT_ID, DEPARTMENT_NAME FROM employees INNER JOIN departments USING (DEPARTMENT_ID);

-- 3.) Write a query to find the name (first_name, last_name), job, department ID, and name of the employees who work in London.
SELECT CONCAT(FIRST_NAME, " ", LAST_NAME) AS NAME, JOB_TITLE, DEPARTMENT_ID FROM employees INNER JOIN jobs USING(JOB_ID) INNER JOIN departments USING(DEPARTMENT_ID) INNER JOIN locations USING (LOCATION_ID) WHERE locations.city = "London";

-- 4.) Write a query to find the employee id, name (last_name) along with their manager_id, and name (last_name).
SELECT e.EMPLOYEE_ID, e.LAST_NAME, e.MANAGER_ID, e2.LAST_NAME FROM employees e INNER JOIN employees e2 ON e.MANAGER_ID = e2.EMPLOYEE_ID;

-- 5.) Write a query to find the name (first_name, last_name) and hire date of the employees who were hired after 'Jones'.
SELECT CONCAT(e1.FIRST_NAME, " ", e1.LAST_NAME) AS NAME, e1.HIRE_DATE FROM employees e1 INNER JOIN employees e2 ON e2.LAST_NAME = 'Jones' WHERE e1.HIRE_DATE > e2.HIRE_DATE;

-- 6.) Write a query to get the department name and number of employees in the department.
SELECT DEPARTMENT_NAME, COUNT(EMPLOYEE_ID) FROM employees INNER JOIN departments USING (DEPARTMENT_ID) GROUP BY DEPARTMENT_NAME;

-- 7.) Write a query to find the employee ID, job title, number of days between the ending date and the starting date for all jobs in department 90.
SELECT EMPLOYEE_ID, JOB_TITLE, (END_DATE - START_DATE) AS NUMBER_OF_DAYS FROM jobs INNER JOIN job_history USING (JOB_ID) WHERE DEPARTMENT_ID = 90;

-- 8.) Write a query to display the department ID and name and first name of the manager.
SELECT departments.DEPARTMENT_ID, DEPARTMENT_NAME, FIRST_NAME FROM departments INNER JOIN employees USING(DEPARTMENT_ID) WHERE departments.MANAGER_ID = employees.EMPLOYEE_ID;

-- 9.) Write a query to display the department name, manager name, and city.
SELECT DEPARTMENT_NAME, CONCAT(FIRST_NAME, " ", LAST_NAME) AS NAME, CITY FROM departments INNER JOIN employees USING (DEPARTMENT_ID) INNER JOIN locations USING (LOCATION_ID) WHERE departments.MANAGER_ID = employees.EMPLOYEE_ID;

-- 10.) Write a query to display the job title and average salary of employees.
SELECT JOB_TITLE, AVG(SALARY) FROM employees INNER JOIN JOBS USING(JOB_ID) GROUP BY JOB_TITLE;

-- 11.) Write a query to display job title, employee name, and the difference between the salary of the employee and minimum salary for the job.
SELECT JOB_TITLE, CONCAT(FIRST_NAME," ",LAST_NAME) AS NAME, (SALARY - MIN_SALARY) AS SALARY_DIFFERENCE FROM employees INNER JOIN jobs USING (JOB_ID);

-- 12.) Write a query to display the job history of any employee who is currently drawing more than 10000 of salary.
SELECT job_history.* FROM job_history INNER JOIN employees USING (EMPLOYEE_ID) WHERE SALARY > 10000;

-- 13.) Write a query to display department name, name (first_name, last_name), hire date, the salary of the manager for all managers whose experience is more than 15 years.
SELECT DEPARTMENT_NAME, CONCAT(FIRST_NAME," ", LAST_NAME) AS NAME, HIRE_DATE, SALARY FROM employees INNER JOIN departments USING (DEPARTMENT_ID) INNER JOIN job_history USING (EMPLOYEE_ID) WHERE END_DATE-START_DATE > 15;
