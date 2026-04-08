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

SELECT ename, max(sal)		-- select절에 집계 함수가 사용될 경우 오류
FROM emp

SELECT dept_id, count(*)
FROM STUDENT
GROUP BY dept_id

SELECT dept_name, count(*)
FROM student s, department d
WHERE s.dept_id = d.DEPT_ID
GROUP by dept_name

SELECT dname, count(*) AS 부서별_직원수, avg(sal) AS 평균급여, max(sal) AS 최대급여, min(sal) AS 최소급여
FROM emp e, dept d
WHERE e.deptno = d.DEPTNO 
GROUP BY dname

SELECT dept_name, count(*) AS 학과별_교수_숫자, 
	avg(2012 - year_emp) AS 평균_재직연수, max(2012 - year_emp) AS 최대_재직연수
FROM professor p, department d
WHERE p.dept_id = d.dept_id
GROUP BY dept_name

-----------------------------------------------------------------------------------

SELECT dept_name, count(*), avg(2012-year_emp), max(2012-year_emp)
FROM professor p, DEPARTMENT d
WHERE p.dept_id = d.dept_id AND avg(2012-year_emp) >= 10		-- group에 대한 조건은 where절에 사용안된다
GROUP BY dept_name

SELECT dept_name, count(*), avg(2012-year_emp), max(2012-year_emp)
FROM professor p, department d
WHERE p.dept_id = d.DEPT_ID 
GROUP BY d.DEPT_NAME 
HAVING avg(2012-year_emp) >= 10

SELECT dname, count(*), avg(sal), max(sal), min(sal)
FROM emp e, dept d
WHERE e.deptno = d.DEPTNO
GROUP BY DNAME 
HAVING count(*) >= 5

-----------------------------------------------------------------------------

SELECT stu_id
from takes
WHERE grade IS NULL

SELECT stu_id
FROM takes
WHERE grade <> 'A+'		-- <> : 같지않다.

SELECT *
FROM EMP
WHERE comm IS NOT NULL

SELECT *
FROM emp
WHERE comm <> 500


--------------------------------------------------------

SELECT title
FROM course
WHERE course_id IN
		(SELECT DISTINCT COURSE_ID 
		FROM CLASS
		WHERE classroom = '301호');

SELECT DISTINCT title
FROM course c1, class c2
WHERE c1.course_id = c2.course_id AND classroom = '301호'

SELECT title
FROM course
WHERE course_id NOT IN 
		(SELECT DISTINCT course_id
		FROM class
		WHERE YEAR = 2012 AND semester = 2
		)

SELECT course_id, title
FROM course
WHERE 
MINUS 
SELECT title
FROM
WHERE

--------------------------------------------------------------------------

SELECT *
FROM takes

CREATE OR REPLACE VIEW V_TAKES AS
	SELECT stu_id, class_id
	FROM takes
	
SELECT *
FROM V_TAKES


CREATE OR REPLACE VIEW cs_student AS		-- student에서 컴공 학생 레코드만 추출하여 뷰 생성
	SELECT s.stu_id, s.resident_id, s.name, s.YEAR, s.address, s.dept_id
	FROM student s, department d
	WHERE s.dept_id = d.dept_id AND d.dept_name='컴퓨터공학과'

SELECT *
FROM cs_student


-----------------------------------------------------------------------------

INSERT INTO V_TAKES
values('1292502', 'C101-01')

SELECT * FROM V_TAKES

SELECT * FROM takes		-- takes에도 내용이 추가됨


-------------------------------------------------------------------------------

CREATE OR REPLACE VIEW v_takes AS
	SELECT stu_id, class_id
	FROM takes
	WITH READ ONLY;

INSERT INTO v_takes
	values('1292502', 'C101-01')		-- 읽기 전용이라 안됨


