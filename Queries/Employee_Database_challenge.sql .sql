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

-- Retrieve number of titles from Unique Titles table into Retiring Titles table
SELECT COUNT(ut.title), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title 
ORDER BY COUNT(*) DESC;

DROP TABLE IF EXISTS mentorship_eligible;
-- Deliverable 2: Employees eligible for mentorship program 
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO mentorship_eligible 
FROM employees as e 
LEFT JOIN dept_emp as de 
ON (e.emp_no = de.emp_no)
LEFT JOIN titles as ti 
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no;

SELECT COUNT(*) FROM mentorship_eligible

-- Retrieve number of titles from mentorship eligible 
SELECT COUNT(me.title), me.title
--INTO retiring_titles
FROM  mentorship_eligible as me
GROUP BY me.title 
ORDER BY COUNT(*) DESC;
