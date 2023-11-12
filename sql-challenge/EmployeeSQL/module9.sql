CREATE TABLE departments(
	dept_no CHAR(5) PRIMARY KEY NOT NULL,
	dept_name VARCHAR(50) NOT NULL
);

CREATE TABLE titles(
	title_id CHAR(5) PRIMARY KEY NOT NULL,
	title VARCHAR(50) NOT NULL
);

CREATE TABLE employees(
	emp_no INT PRIMARY KEY NOT NULL,
	emp_title_id CHAR(5) NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	sex CHAR(1) NOT NULL,
	hire_date DATE NOT NULL
);

CREATE TABLE dept_emp(
	emp_no INT NOT NULL,
	dept_no CHAR(5) NOT NULL
);

CREATE TABLE dept_manager(
	dept_no CHAR(5) NOT NULL,
	emp_no INT NOT NULL
);

CREATE TABLE salaries(
	emp_no INT NOT NULL,
	salary INT NOT NULL
);

SELECT * FROM departments;
SELECT * FROM titles;
SELECT * FROM employees;
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM salaries;

-- 1. List the employee number, last name, first name, sex, and salary of each employee
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM salaries s
JOIN employees e ON s.emp_no = e.emp_no
;

-- 2. List the first name, last name, and hire date for the employees who were hired in 1986
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date >= '1986-01-01' AND hire_date <= '1986-12-31'
;

-- 3. List the manager of each department along with their department number,
-- department name, employee number, last name, and first name
SELECT 
	t.title, 
	d.dept_no as "department_number", 
	d.dept_name as "department_name",
	e.emp_no as "employee_number", 
	e.last_name,
	e.first_name
	
FROM titles t
JOIN employees e     on t.title_id = e.emp_title_id
JOIN dept_manager dm on e.emp_no = dm.emp_no
JOIN departments d   on dm.dept_no = d.dept_no
WHERE t.title = 'Manager'
;

-- 4. List the department number for each employee along with that employee’s employee 
-- number, last name, first name, and department name.
SELECT 
	de.dept_no,
	e.emp_no,
	e.last_name,
	e.first_name,
	d.dept_name
FROM employees e
JOIN dept_emp de ON de.emp_no = e.emp_no
JOIN departments d ON d.dept_no = de.dept_no;

-- 5. List first name, last name, and sex of each employee whose first name is Hercules 
-- and whose last name begins with the letter B.
SELECT 
	e.first_name,
	e.last_name,
	e.sex
FROM employees e
WHERE e.first_name = 'Hercules'
AND e.last_name ilike 'b%'
;

-- 6. List each employee in the Sales department, including their employee number, 
-- last name, and first name.
SELECT
	d.dept_name as "sales_dept",
	de.emp_no,
	e.last_name,
	e.first_name
FROM departments d
JOIN dept_emp de on de.dept_no = d.dept_no
JOIN employees e on e.emp_no = de.emp_no
WHERE d.dept_name = 'Sales'
;

-- 7. List each employee in the Sales and Development departments, including their 
-- employee number, last name, first name, and department name.
SELECT
	d.dept_name,
	e.emp_no,
	e.last_name,
	e.first_name
FROM employees e
JOIN dept_emp de on de.emp_no = e.emp_no
JOIN departments d on d.dept_no = de.dept_no
WHERE d.dept_name IN ('Sales', 'Development');

-- 8. List the frequency counts, in descending order, of all the employee last names 
-- (that is, how many employees share each last name).
SELECT
	e.last_name,
	COUNT(e.last_name) AS "frequency_counts"
FROM employees e
GROUP BY e.last_name
HAVING COUNT(last_name) > 1
ORDER BY frequency_counts
;
