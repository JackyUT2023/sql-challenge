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

