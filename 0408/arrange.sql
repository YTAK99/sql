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

	CONSTRAINT pk_department PRIMARY key(stu_id),
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













































-- 테이블 삭제 --

-- 테이블 수정 --














-- 기본구조 --	 -- 2차원의 table 형태 --
SELECT <잘의 결과로 출력할 "필드"들의 리스트>
FROM <질의 실행과정에 필요한 "테이블"들의 리스트>
WHERE <검색되어야 하는 "레코드"에 대한 조건>














