-- 1.1
SELECT job_title, job_id, min_salary FROM jobs;

-- 1.2
SELECT '직업:', job_title, job_id, min_salary FROM jobs;

-- 1.3
SELECT job_title AS 직업명, job_id AS 작업코드, min_salary AS 최소임금 FROM jobs;

-- 2.1
SELECT employee_id, salary FROM employees WHERE salary >= 9000;

-- 2.2
SELECT employee_id, salary FROM employees WHERE salary >=9000 and employee_id >= 200;

-- 2.3
SELECT employee_id, salary FROM employees WHERE salary >=15000 or employee_id >= 200;

-- 3.1
SELECT employee_id, salary, manager_id FROM employees WHERE manager_id = '';

-- 3.2
SELECT employee_id, salary, manager_id FROM employees WHERE manager_id IS NULL;

-- 3.3
SELECT employee_id, salary, manager_id FROM employees WHERE manager_id IN ('100', '110', '120');

-- 4.1
SELECT employee_id, salary FROM employees WHERE salary >=15000 or employee_id >= 200 ORDER BY salary;

-- 4.2
SELECT employee_id, salary FROM employees WHERE salary >=15000 or employee_id >= 200 ORDER BY salary DESC;

-- 4.3
SELECT employee_id, salary FROM employees WHERE salary >=15000 or employee_id >= 200
ORDER BY manager_id ASC, salary DESC;

-- 5.1
SELECT job_id FROM employees ORDER BY job_id;

-- 5.2
SELECT DISTINCT job_id FROM employees ORDER BY job_id;

-- 5.3
SELECT COUNT (job_id), COUNT (DISTINCT job_id) FROM employees;

-- 6.1
SELECT AVG (salary), SUM (salary), COUNT (salary) FROM employees;

-- 6.2
SELECT job_id, AVG (salary), SUM (salary), COUNT (salary) FROM employees
GROUP BY job_id;

-- 6.3
SELECT job_id, AVG (salary), SUM (salary), COUNT (salary) FROM employees
GROUP BY job_id
HAVING COUNT (salary) >= 5;