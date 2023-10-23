-- Drop table if exists
	-- Drop corresponding tables first
	drop table dept_emp;
	drop table dept_manager;
	drop table salaries;
	-- Drop indepantant table first
	drop table employees;
	drop table departments;
	drop table titles;

-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/DqaSwB
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- ---------Challenge 9

CREATE TABLE "titles" (
    -- CSV max length title_id = 5
    "title_id" varchar(5)   NOT NULL,
    -- CSV max length title = 18
    "title" varchar(20)   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

CREATE TABLE "employees" (
    -- CSV max length emp_no = 6
    "emp_no" varchar(6)   NOT NULL,
    -- same size as FK
    "emp_title_id" varchar(5)   NOT NULL,
    "birth_date" date   NOT NULL,
    -- CSV max length first_name = 14
    "first_name" varchar(30)   NOT NULL,
    -- CSV max length last_name = 16
    "last_name" varchar(30)   NOT NULL,
    "sex" varchar(1)   NOT NULL,
    -- CSV max length sex = 1.
    -- Considering there might be different gender identities, data type has been set as varchar, instead of boolean.
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "departments" (
    -- CSV max length dept_no = 4
    "dept_no" varchar(4)   NOT NULL,
    -- CSV max dept_name = 18
    "dept_name" varchar(20)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    -- same size as FK
    "emp_no" varchar(6)   NOT NULL,
    -- same size as FK
    "dept_no" varchar(4)   NOT NULL,
    CONSTRAINT "pk_dept_emp" PRIMARY KEY (
        "emp_no","dept_no"
     )
);

CREATE TABLE "dept_manager" (
    -- same size as FK
    "dept_no" varchar(4)   NOT NULL,
    -- same size as FK
    "emp_no" varchar(6)   NOT NULL,
    CONSTRAINT "pk_dept_manager" PRIMARY KEY (
        "dept_no","emp_no"
     )
);

CREATE TABLE "salaries" (
    -- same size as FK
    "emp_no" varchar(6)   NOT NULL,
    -- CSV max salary = 6
    "salary" int   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "emp_no"
     )
);

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");


-- import data from CSV files.

-- Data Analysis
-- 1. List the employee number, last name, first name, sex, and salary of each employee.
select employees.emp_no as employment_number, employees.last_name, employees.first_name, employees.sex, salaries.salary
from employees
join salaries
on employees.emp_no = salaries.emp_no;

-- 2.List the first name, last name, and hire date for the employees who were hired in 1986.
select first_name, last_name, hire_date
from employees
where extract('year' from hire_date) = 1986;

-- 3.List the manager of each department along with their department number, department name, employee number, last name, and first name.
select 
	dept_manager.emp_no as employment_number,
	employees.last_name,
	employees.first_name,
	dept_manager.dept_no as department_number, 
	departments.dept_name as department_name
from dept_manager
	join employees
	on dept_manager.emp_no = employees.emp_no
		join departments
		on dept_manager.dept_no = departments.dept_no;
		
-- 4.List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
select 
	dept_emp.emp_no as employment_number,
	employees.last_name,
	employees.first_name,
	departments.dept_name as department_name
from dept_emp
	join employees
	on dept_emp.emp_no = employees.emp_no
		join departments
		on dept_emp.dept_no = departments.dept_no
		order by dept_emp.emp_no;
		
-- 5.List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
select first_name, last_name, sex
from employees
where first_name = 'Hercules'
and last_name like 'B%';

-- 6.List each employee in the Sales department, including their employee number, last name, and first name.
select dept_emp.emp_no as employee_number,employees.last_name,employees.first_name
from dept_emp
	join employees
	on dept_emp.emp_no = employees.emp_no
		join departments
		on dept_emp.dept_no = departments.dept_no
		where departments.dept_name = 'Sales'
		order by dept_emp.emp_no;

-- 7.List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
select dept_emp.emp_no as employee_number,employees.last_name,employees.first_name, departments.dept_name as department_name
from dept_emp
	join employees
	on dept_emp.emp_no = employees.emp_no
		join departments
		on dept_emp.dept_no = departments.dept_no
		where departments.dept_name in ('Sales','Development')
		order by dept_emp.emp_no;

-- 8.List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
select last_name, count(last_name)
from employees
group by last_name
order by count(last_name) desc;




