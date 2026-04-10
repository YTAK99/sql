--table 목록 --
SELECT * FROM tab;


-- 쓰레기통 비우기 --
purge recyclebin;


-- 테이블 생성 --
CREATE TABLE <테이블_이름>;		## 아니면 create table <테이블_이름> (<필드 리스트>)


(예시 - 기본키 외래키 설정)
CREATE TABLE student 
(
	stu_id varchar2(10),
	resident_id varchar2(14) NOT NULL,
	name varchar2(14) NOT null,
	YEAR int,
	address varchar2(10),
	dept_id varchar2(10),

	CONSTRAINT pk_department PRIMARY key(stu_id),		## pk_department : 제약식의 이름
	CONSTRAINT fk_student FOREIGN KEY(dept_id) REFERENCES department(dept_id)
)


CREATE TABLE takes
(
	stu_id varchar2(10),
	class_id varchar2(10),
	grade char(5),
	CONSTRAINT pk_takes PRIMARY key(stu_id, class_id),
	CONSTRAINT fk_takes1 FOREIGN key(stu_id) REFERENCES student(stu_id),
	CONSTRAINT fk_takes2 FOREIGN key(class_id) REFERENCES class(class_id)
)


-- 테이블 삭제 --
DROP TABLE <테이블_이름>		## 다른 테이블에서 외래키로 참조되는 경우 다른 테이블 먼저 삭제해야 함


-- 테이블 수정(필드 추가) --
ALTER TABLE <테이블_이름> ADD <추가할_필드>

(예시)
ALTER TABLE student ADD age int		## student 테이블에 age 필드를 추가


-- 테이블 수정(필드 삭제) --
ALTER TABLE <테이블_이름> DROP COLUMN <삭제할_필드>

(예시)
ALTER TABLE student DROP COLUMN age



------------------------------------------------------------------------------------------------------------------




-- 레코드 삽입 --
INSERT INTO <테이블_이름> (<필드리스트>) VALUES (<값리스트>)	# 필드리스트 : 삽입에 사용될 테이블들의 필드
														# 값리스트 : 필드리스트의 순서에 맞춰 삽입될 값	
														# 나열되지 않은 필드에 대해서는 NULL 값이 입력됨
(예시)
INSERT INTO department(office, dept_id, dept_name)
values('201호', '920', '컴퓨터공학과')

INSERT INTO department		## 필드리스트 사용하지 않고 데이터를 삽입
VALUES('920','컴퓨터공학과')

## 외래키로 사용되는 필드에 데이터를 삽입할 때, 참조하는 테이블의 해당 필드에 그 값을 먼저 삽입해야 함


-- 레코드 수정 --
UPDATE <테이블 이름>
SET <수정내역>
WHERE <조건>

(예시)
UPDATE student
SET YEAR = YEAR + 1		## 테이블에서 모든 학생들의 학년을 하나씩 증가

UPDATE professor
SET POSITION='교수', dept_id='923'
WHERE name='고희석'

## 외래키로 사용되는 필드의 값을 수정할 때, 외래키가 참조하는 테이블에 삽입되어 있는 값으로만 수정 가능


-- 레코드 삭제 --
DELETE FROM <테이블 이름>
WHERE <조건>		## 조건을 만족하는 레코드를 삭제. 생략되면 모든 레코드 삭제

(예시)
DELETE FROM professor
WHERE name='김태석'

## 외래키로 참조되는 필드를 가지고 있는 테이블에서 레코드를 삭제할 경우에도 오류 발생



---------------------------------------------------------------------------------------------------------------


-- 기본구조 --	 -- 2차원의 table 형태 --
SELECT <잘의 결과로 출력할 "필드"들의 리스트>
FROM <질의 실행과정에 필요한 "테이블"들의 리스트>		## 두개 이상의 테이블을 포함하면 자연조인이 대부분
WHERE <검색되어야 하는 "레코드"에 대한 조건>

-------

SELECT DISTINCT <필드> : 중복된 레코드를 제거하고 검색하려면

(예시)
SELECT DISTINCT address
FROM student

-------

SELECT * : FROM 절에 나타난 테이블에서 모든 필드의 값을 추출할 경우

-------

SELECT 절에 필드이름 외에 산술식이나 상수 사용 가능

(예시)
SELECT name, 2012-year_emp
FROM professor

-------

(예시 - 컴퓨터공학과 3학년 학생들의 학번을 검색)
SELECT student.stu_id
FROM student, department
WHERE student.dept_id = department.dept_id AND 
	student.YEAR = 3 AND department.dept_name='컴퓨터공학과'


---------------------------------------------------------------------------------------------------------------

-- 레코드의 순서 지정 --		## 검색 결과를 정렬하여 출력

ORDER BY <필드리스트>			## 오름차순을 기본으로 함. select문 맨 마지막에. 여러 개의 필드를 나열할 경우 나열된 순서대로 정렬
ORDER BY <필드리스트> desc		## 내림차순

## 필드리스트에 이름 대신 select에 적은 필드 ㅎ순서대로 1, 2, ... n 을 써도 됨


---------------------------------------------------------------------------------------------------------------

-- 재명명 연산 --		## 질의를 처리하는 과정 동안만 일시적으로 사용

(예시)
SELECT name 이름, POSITION 직위, 2012-year_emp 재직연수
FROM professor


---------------------------------------------------------------------------------------------------------------

-- LIKE 연산자 --		# 문자열에 대해서는 일부분만 일치하는 경우를 찾아야 할때 사용
WHERE <필드이름> LIKE <문자열패턴>		# 필드이름에 지정된 문자열패턴이 들어있는지를 판단

*문자열 패턴 종류
_ : 임의의 한 개 문자
% : 임의의 여러 개 문자

(예)
'%서울%' : '서울'이란 단어가 포함된 문자열
'%서울' : '서울'이란 단어로 끝나는 문자열
'서울%' : '서울'이란 단어로 시작하는 문자열
'___' : 정확히 세 개의 문자로 구성된 문자열
'___%' : 최소한 세 개의 문자록 구성된 문자열


(예시 - student 테이블에서 여학생들만을 검색)
SELECT *
FROM student
WHERE resident_id LIKE '%-2%'


---------------------------------------------------------------------------------------------------------------

-- 집합연산 --
<select문1>
<집합연산자(UNION / INTERSECT / MINUS)>
<select문2>									 ## 조건 : SELECT 1과 2의 필드의 개수와 데이터타입이 서로 같아야 함

* UNION 연산자는 중복 자동 제거 => 제거하고 싶지 않다면 UNION ALL 사용


---------------------------------------------------------------------------------------------------------------

-- JOIN --		# 두 테이블로 부터 특정 조건을 만족하는 레코드들을 하나의 레코드로 결합하는 연산군
WHERE 테이블1 = 테이블2


-- 왼쪽 외부조인 --
- 연산자의 왼쪽에 위치한 테이블의 각 레코드에 대해서 오른쪽 테이블에 조인 조건에 부합하는 레코드가 없을 경우에도 검색 결과에 포함
- 생성되는 결과 레코드에서 오른쪽 테이블의 나머지 필드에는 널이 삽입

(예)
SELECT title, credit, YEAR, semester
FROM course LEFT OUTER JOIN class
using(course_id)					## 조인 조건이 course.course_id = class.course_id 라는 것을 의미

(동일한 표현)
SELECT title, credit, YEAR, semester
FROM course, class
WHERE course.course_id = class.course_id (+)			--오라클에서만 쓸 수 있음


-- 오른쪽 외부조인 --

(예)
SELECT title, credit, YEAR, semester
FROM course RIGHT OUTER JOIN class
USING (course_id)

(동일한 표현)
SELECT title, credit, YEAR, semester
FROM course, class
WHERE course.course_id (+) = class.course_id


-- 완전 외부조인 --
양쪽 테이블에서 서로 일치하는 레코드가 없을 경우, 해당 레코드들도 결과 테이블에 포함시키며 나머지 필드에 대해서는 모두 널을 삽입

(예)
SELECT title, credit, YEAR, semester
FROM course FULL OUTER JOIN class
USING (course_id)

---------------------------------------------------------------------------------------------------------------

-- 집계 함수 --		## 통계연산 기능 제공
count / sum / avg / max / min(<필드이름>)

- SELECT 절과 HAVING 절 에서만 사용가능
- sum, avg 는 숫자형 데이터 타입을 갖는 필드에만 적용가능


-- COUNT --
count(DISTINCT <필드이름>)		## DISTINCT 는 서로 구별되는 값의 개수가 필요한 경우에만 사용
						## NULL 은 계산에서 제외됨(null 값은 count 안함)

(예)
SELECT count(*)		# student 테이블에서 3학년 학생이 몇명인지 출력
FROM student
WHERE YEAR = 3

SELECT count(DISTINCT dept_id)		## DISTINCT 키워드를 사용하면 중복되는 데이터를 제외한 개수를 리턴
FROM student


---------------------------------------------------------------------------------------------------------------

-- GROUP BY --		
GROUP BY <필드리스트>

## GROUP BY 절은 SELECT 문에서 WHERE 절 다음에 위치			-- group에 대한 조건은 where절에 사용안된다
## 지정된 필드의 값이 같은 레코드들끼리 그룹을 지어 각 그룹별로 집계 함수를 적용한 결과를 출력

* select 절에 집게 함수가 사용될 경우 다른 필드는 select 절에 사용 불가능
* GROUP BY 를 이용하면 그룹별로 집계함수 적용 가능

(예시)
SELECT dname, count(*), avg(sal), max(sal), min(sal)
FROM emp e, dept d		
WHERE e.deptno = d.deptno
GROUP BY dname					# emp, dept 테이블에서 부서별 직원수, 평균급여, 최대급여, 최소급여를 출력

SELECT dept_name, count(*), avg(2012 - year_emp), max(2012 - year_emp)
FROM professor p, department d
WHERE p.dept_id = d.dept_id
GROUP BY dept_name				# 학사 데이터베이스에서 학과별 교수 숫자와 평균 재직연수, 최대 재직연수를 출력


---------------------------------------------------------------------------------------------------------------

-- HAVING --		## 그룹에 대한 조건을 명시할 때 사용. group에 대한 조건은 where 절에 사용 못함
HAVING <집계함수 조건>

(예 - 직원 숫자가 5명 이상인 부서에 대해서 부서별 직원수, 평균급여, 최대급여, 최소급여를 출력)
SELECT dname, count(*), avg(sal), max(sal), min(sal)
FROM emp e, dept d
WHERE e.deptno = d.deptno		## where절에 명시된 조건을 만족하는 레코드들을 검색
GROUP BY dname				## GROUP BY 절에 명시된 필드의 값이 서로 일치하는 레코드들끼리 그룹을 지어 집계 함수를 적용
HAVING count(*) >= 5			## 마지막으로 그 집계 함수를 적용한 결과들 중에서 HAVING 절을 만족하는 결과만 골라서 출력


---------------------------------------------------------------------------------------------------------------

-- 널의 처리 --
<필드이름> IS NULL
<필드이름> IS NO NULL

(예 - takes 테이블에서 아직 학점이 부여되지 않은 학생의 학번을 검색)
SELECT stu_id
FROM takes
WHERE grade IS NULL

(예 - takes 테이블에서 학점이 A+가 아닌 학생들의 학번을 검색)
SELECT stu_id
FROM takes
WHERE grade <>'A+'		## grade 필드 값이 null인 레코드에 대해서는 질의 결과에 포함X
						-- <> : 같지않다.

---------------------------------------------------------------------------------------------------------------

-- 중첩 질의 --

# 내부질의, 부질의 : 내부에 포함된 SQL문
# 외부질의 : 부 질의를 내부적으로 갖는 SQL문

# 부 질의는 외부 질의의 FROM 절이나 WHERE 절에 위치

종류
- IN, NOT IN
- =SOME, <=SOME, <SOME, >SOME, >=SOME, <>SOME  (SOME 대신 ANY 사용 가능)
- =ALL, <=ALL, <ALL, >ALL, >=ALL, <>ALL
- EXISTS, NOT EXISTS


-------

-- IN, NOI IN --

(예1 - 301호 강의실에서 개설된 강좌의 과목명을 출력)
SELECT title
FROM course
WHERE course_id IN			## 외부 질의 : course 테이블에서 course_id 필드 값이 부 질의의 검색 결과에 포함되는 경우만 과목명을 출력
		(SELECT DISTINCT course_id		## 부 질의
		FROM class						## 키워드 IN 뒤에 나오는 SQL 문으로서 class 테이블에서 강의실이 301호인 교과목 번호를 검색
		WHERE classroom = '301호')
		
(예1 - 동일한 표현)
SELECT DISTINCT title
FROM course c1, class c2
WHERE c1.course_id = c2.course_id AND classroom = '301호'



(예2 - 2012년 2학기에 개설되지 않은 과목명을 검색)
SELECT title
FROM course
WHERE course_id NOT IN
		(SELECT DISTINCT course_id
		FROM class
		WHERE YEAR = 2012 AND semester = 2)
	

-------

-- SOME, ALL --
		
=SOME : IN 과 같은 의미 (지정된 필드의 값이 부 질의 검색 결과에 존재하는 임의의 값과 같은지를 나타낼 때 사용)
<=SOME : 부 질의의 검색 결과에 존재하는 임의의 값보다 작거나 같은지를 나타날 때 사용
=ALL : 지정된 필드의 값이 부 질의 검색 결과에 포함된 모든 값과 같은지를 판단
<=ALL : 지정된 필드의 값이 부 질의 검색 결과에 포함된 모든 값보다 작거나 같은지를 판단

(예)
SELECT c1.course_id, title, YEAR, semester, prof_id
FROM class c1, cousre c2
WHERE c1.course_id = c2.course_id AND enroll >= ALL (SELECT enroll FROM class)
		
		

-------

-- EXISTS, NOT EXIST --
# 부 질의 검색 결과에 최소한 하나 이상의 레코드가 존재하는지의 여부를 표현

EXISTS : 최소한 한 개의 레코드가 존재하면 참이 되고 그렇지 않으면 거짓
NOT EXISTS : 부 질의의 결과에 레코드가 하나도 없으면 참이 되고 하나라도 존재하면 거짓

(예)
SELECT title
FROM course
WHERE EXISTS
	(SELECT *
	FROM class
	WHERE classroom = '301호' AND course.course_id = class.course_id)
	

---------------------------------------------------------------------------------------------------------------

-- 뷰(VIEW) --
# 기존의 테이블들로부터 생성되는 가상의 테이블
# 물리적으로 생성 X
# 기존의 테이블들을 조합하여 사용자에게 실제로 존재하는 테이블인 것처럼 보이게 함


-- 뷰 생성 --		## 생성된 뷰는 테이블과 동등하게 사용
CREATE OR REPLACE VIEW <뷰 이름> AS
<SELECT 문>

## OR REPLACE 키워드를 추가하면 <뷰이름> 중복 시 기존의 뷰를 지우고 새로 생성

# 사용자 계정에서 뷰 생성 권한 부여 : GRANT CREATE VIEW TO <사용자 계정>

* 마지막에 WITH READ ONLY 키워드 추가 : 읽기 전용 뷰. 뷰를 생성할 때 데이터 조작 언어의 사용을 불가능하게 만듦



(예 - takes 테이블에서 grade 필드를 제외한 나머지 필드만으로 구성된 뷰를 생성)
CREATE OR REPLACE VIEW V_TAKES AS
			SELECT stu_id, class_id
			FROM takes
			
(예 - student 테이블에서 컴퓨터공학과 학생들 레코드만 추출하여 뷰를 생성)
CREATE OR REPLACE VIEW cs_student AS
		SELECT s.stu_id, s.resident_id, s.name, s.YEAR, s.address, s.dept_id
		WHERE s.dept_id = d.dept_id AND d.dept_name = '컴퓨터공학과'

		

-- 뷰 사용 --
# 뷰에 대해서 INSERT, UPDATE, DELETE 문을 실행

(예)
INSERT INTO V_TAKES			# V_TAKES 뷰에 포함되지 않은 grade 필드에는 널이 삽입
values('1292502', 'C101-01')
		
SELECT * FROM takes		-- 조회해보면 V_TAKES 뿐만 아니라 TAKES에도 내용이 추가되어 있음

		
-- 뷰 삭제 --
DROP VIEW <뷰이름>


(예)
CREATE OR REPLACE VIEW v_takes AS
	SELECT stu_id, class_id
	FROM takes
	WITH READ ONLY;

INSERT INTO v_takes
	values('1292502', 'C101-01')		-- 읽기 전용이라 안됨
