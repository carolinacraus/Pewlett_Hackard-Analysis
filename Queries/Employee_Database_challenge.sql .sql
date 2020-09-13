-- Deliverable 1: Number of retiring employees by titles 
DROP TABLE IF EXISTS retirement_titles;
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
INTO retirement_titles
FROM employees as e
JOIN titles as ti 
ON (e.emp_no = ti.emp_no) 
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title
INTO unique_titles 
FROM retirement_titles as rt
ORDER BY rt.emp_no, 
	rt.to_date DESC

    