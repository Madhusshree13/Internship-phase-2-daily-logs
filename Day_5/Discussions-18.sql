---1.) Write a SQL statement to create a table countries including columns country_id, country_name, and region_id, and make sure that the combination of columns country_id and region_id will be unique.
create table countries(
    country_id varchar(10) not null unique,
    country_name varchar(30) not null unique,
    region_id varchar(10) not null,
    constraint_id pk_countries primary key(country_id,region_id)
);

---2.)Write a SQL statement to create a table named jobs including columns job_id, job_title, min_salary, and max_salary, and make sure that, the default value for job_title is blank and min_salary is 8000 and max_salary is NULL will be entered automatically at the time of insertion if no value assigned for the specified columns.
create table jobs (
    job_id varchar(10) unique,
    job_title varchar(35),
    min_salary decimal(6,0) default null,
    max_salary decimal(6,0) default null,
    index idx_job_id(job_id),
    check(min_salary>=8000 and (max_salary is null or max_salary>=min_salary)),
    constraint pk_jobs primary key (job_id),
    index idx_job_id(job_id)
);

---3.)Write a SQL statement to create a table job_history including columns employee_id, start_date, end_date, job_id, and department_id and make sure that, the employee_id column does not contain any duplicate value at the time of insertion and the foreign key column job_id contain only those values which exist in the jobs table.
create table job_history(
    employee_id varchar(10) not null unique,
    start_date datetime,
    end_date datetime,
    job_id varchar(10),
    department_id varchar(10) not null,
    constraint pk_job_history primary key(employee_id),
    constraint fk_jobs_job_history foreign key (job_id) references jobs(job_id)
);

---4.)Write a SQL statement to create a table employees including columns employee_id, first_name, last_name, email, phone_number hire_date, job_id, salary, commission, manager_id, and department_id and make sure that the employee_id column does not contain any duplicate value at the time of insertion and the foreign key columns
--- combined by department_id and manager_id columns contain only those unique combination values, which combinations exist in the departments table.
create table departments (
department_id varchar(10) not null primary key,
department_name varchar(30) not null,
manager_id varchar(10) not null,
location_id varchar(10),
constraint pk_departments primary key(department_id)
index idx_department_id_manager_id(department_id,manager_id)
);

create table employees(
    employee_id varchar(10) not null unique primary key,
    first_name varchar(20) not null,
    last_name varchar(20),
    email varchar(30) not null,
    phone_number int(10)not null,
    hire_date datetime,
    job_id varchar(10),
    salary decimal(10, 2),
    commission int(5),
    manager_id varchar(10) not null,
    department_id varchar(10) not null,
    constraint fk_department_manager foreign key (department_id, manager_id) references departments(department_id, manager_id)
)engine=InnoDB;

---5.)Write a SQL statement to create a table employees including columns employee_id, first_name, last_name, email, phone_number hire_date, job_id, salary, commission, manager_id and department_id and make sure that, the employee_id column does not contain any duplicate value at the time of insertion, and the foreign key column department_id, 
---reference by the column department_id of departments table, can contain only those values which are exists in the departments table and another foreign key column job_id, referenced by
--- the column job_id of jobs table, can contain only those values which are exists in the jobs table. The InnoDB Engine have been used to create the tables.
alter table employees add constraint fk_jobs_employees foreign key (job_id) references jobs(job_id);

---6.)Write a SQL statement to create a table employees including columns employee_id, first_name, last_name, job_id, salary and make sure that, the employee_id column does not contain any duplicate value at the time of insertion, and the foreign key column job_id, referenced by the column job_id of jobs table, can contain only those values 
---which are exists in the jobs table. The InnoDB Engine have been used to create the tables. The specialty of the statement is that, The ON DELETE CASCADE that lets you allow to delete records in the employees(child) table that refer to a record in the jobs(parent) table when the record in the parent table is deleted and the ON UPDATE RESTRICT actions reject any updates.
alter table employees add constraint fk_jobs_employees_1 foreign key(job_id) references jobs(job_id) on delete cascade on update restrict;


---7.)Write a SQL statement to create a table employees including columns employee_id, first_name, last_name, job_id, salary and make sure that, the employee_id column does not contain any duplicate value at the time of insertion, and the foreign key column job_id, referenced by the column job_id of jobs table, can contain only those values which are exists in the jobs table. 
-- The InnoDB Engine have been used to create the tables. The specialty of the statement is that, The ON DELETE SET NULL action will set the foreign key column values in the child table(employees) to NULL when the record in the parent table(jobs) is deleted, with a condition that the foreign key column in the child table must accept NULL values and the ON UPDATE SET NULL action
--  resets the values in the rows in the child table(employees) to NULL values when the
--  rows in the parent table(jobs) are updated.
alter table employees add constraint fk_jobs_employees_2 foreign key(job_id) references jobs(job_id) on delete set null on update set null;

---8.)Write a SQL statement to create a table employees including columns employee_id, first_name, last_name, job_id, salary and make sure that, the employee_id column does not contain any duplicate value at the time of insertion, and the foreign key column job_id, referenced by the column job_id of jobs table, can contain only those values which are exists in the jobs table. 
---The InnoDB Engine have been used to create the tables. The specialty of the statement is that, The ON DELETE NO ACTION and the ON UPDATE NO ACTION actions will reject the deletion and any updates.
alter table employees add constraint fk_jobs_employees_3 foreign key(job_id) references jobs(job_id) on delete no action on update no action