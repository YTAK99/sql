SELECT * FROM tab;
purge recyclebin;

SELECT * FROM student

UPDATE STUDENT
SET YEAR=YEAR-1

UPDATE PROFESSOR
SET POSITION='교수', dept_id='923'		/* 주석 test */
WHERE name='고희석' 				-- professor에서 고희석의 직위를 교수로 수정, 번호를 923으로 수정 --

DELETE FROM PROFESSOR 
WHERE name='김태석'		-- table은 삭제되지 않음--


SELECT * FROM STUDENT

INSERT INTO STUDENT 
VALUES ('1292002', '900305*1730021', '김정현', 3, '서울', '920')





INSERT INTO department(dept_id, dept_name)
values('999', '컴퓨터공학과')

INSERT INTO STUDENT
values('1292505', '991112*1730021', '한영탁', 3, '서울', '999')




select name, 2026-year_emp
from professor



SELECT name, dept_name
FROM department, STUDENT
WHERE department.dept_id = student..dept_id


SELECT DISTINCT address		-- 중복 레코드 --   -- select * 하면 전체 --
FROM STUDENT


SELECT student.name, student.stu_id, department.dept_name
FROM student, department
WHERE student.dept_id = department.dept_id



SELECT dept_id, dept_name
FROM department


SELECT *
FROM student, department
WHERE student.dept_id = department.dept_id



SELECT student.stu_id, name
FROM student, DEPARTMENT
WHERE STUDENT.dept_id = department.dept_id AND student.YEAR = 3 AND 
	department.dept_name = '컴퓨터공학과'


	
SELECT name, stu_id
FROM student
WHERE year = 3 OR YEAR = 4
ORDER by name desc, stu_id


SELECT *
FROM STUDENT
ORDER BY stu_id


SELECT student.name, department.dept_name
FROM student, department
student.dept_id = department.dept_id


SELECT s.name, d.dept_name
FROM student s, department d
WHERE s.dept_id = d.dept_id



SELECT address
FROM student
WHERE name='김광식'		-- 김광식이 어딨는지 모를때 조회 --


SELECT name
FROM student
WHERE address = '서울'


SELECT s2.name
FROM student s1, student s2
WHERE s1.address = s2.address AND s1.name='김광식'


SELECT *
FROM student s1, student s2



SELECT name, POSITION, 2012-year_emp
FROM professor

SELECT name 이름, POSITION AS 직위, 2026-year_emp 재직연수
FROM professor
	


SELECT *
FROM student
WHERE resident_id LIKE '%*2%' OR resident_id LIKE '%*4%'


SELECT name FROM STUDENT
UNION all
SELECT name FROM professor



SELECT  s.stu_id
FROM student s, department d, takes t
WHERE s.dept_id = d.dept_id AND t.stu_id=s.stu_id AND dept_name='컴퓨터공학과' AND grade='A+'


SELECT stu_id
FROM student s, department d
WHERE s.dept_id = d.dept_id AND dept_name='컴퓨터공학과'
INTERSECT
SELECT stu_id
FROM TAKES
WHERE grade='A+'




SELECT stu_id FROM student s, department d
WHERE s.dept_id = d.dept_id AND dept_name = '산업공학과'
MINUS
SELECT stu_id FROM takes
WHERE grade='A+'


SELECT * FROM course

SELECT title, credit, YEAR, semester, division
FROM course, class
WHERE course.course_id = class.course_id







