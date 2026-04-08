--table 목록 --
SELECT * FROM tab;


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


-- 레코드 삭제 --
DELETE FROM <테이블 이름>
WHERE <조건>


























































-- 기본구조 --	 -- 2차원의 table 형태 --
SELECT <잘의 결과로 출력할 "필드"들의 리스트>
FROM <질의 실행과정에 필요한 "테이블"들의 리스트>
WHERE <검색되어야 하는 "레코드"에 대한 조건>














