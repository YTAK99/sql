SELECT title, credit, YEAR, semester
FROM course LEFT OUTER JOIN class
USING (course_id)
ORDER BY title

SELECT title, credit, YEAR, semester
FROM course, class
WHERE course.course_ID = class.course_ID (+)	--오라클에서만 쓸 수 있음
ORDER BY title



SELECT title, credit, YEAR, semester
FROM course RIGHT OUTER JOIN CLASS
USING (course_id)

SELECT title, credit, YEAR, semester
FROM course c, CLASS s
WHERE c.course_ID (+) = s.course_ID



SELECT title, credit, YEAR, semester
FROM course FULL OUTER JOIN class
USING (course_id)

-----------------------------------------------------------------------------------

SELECT count(*)
FROM student
WHERE YEAR = 3

SELECT *
FROM emp

SELECT count(comm)		-- null 값은 count 안함
FROM emp

SELECT count(DISTINCT dept_id)
FROM student

SELECT count(*)
FROM student s, department d
WHERE s.dept_id = d.dept_id AND d.dept_name = '컴퓨터공학과'

-------------------------------------------------------------------------

INSERT INTO PROFESSOR 
	values('92032', '750728*1102458', '김태석', 923, '교수', 1999);

SELECT *
FROM professor

SELECT  sum(2026 - year_emp)
FROM professor

-------------------------------------------------------------------------

SELECT * FROM EMP;
SELECT * FROM dept;

SELECT *
FROM emp, DEPT
WHERE emp.deptno = dept.deptno

SELECT ename, dname, LOC		-- SMITH의 이름, 부서명, 부서 위치
FROM emp e, dept d
WHERE e.deptno = d.deptno
AND ename = 'SMITH'

-------------------------------------------------------------------------

SELECT sum(sal)
FROM emp

SELECT sum(sal)
FROM EMP
WHERE job = 'ANALYST'

SELECT sum(sal)
FROM emp e, dept d
WHERE e.deptno = d.deptno AND dname = 'RESEARCH'

-------------------------------------------------------------------------

SELECT avg(2026- year_emp)
FROM professor

-------------------------------------------------------------------------

SELECT max(sal)
FROM emp e, dept d
WHERE e.deptno = d.deptno AND dname = 'ACCOUNTING'







-------------------------------------------------------------------------
















-----------------------------------------------------------------------------------

















-----------------------------------------------------------------------------------














