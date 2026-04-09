-- ALIAS 부여하기 --		# 조회된 결과에 별명을 부여해서 칼럼 레이블 변경 가능
SELECT deptno AS 부서코드, dname AS 부서명, loc AS 지역
FROM dept;


-- 합성 연산자 --		# 문자와 문자를 연결하는 기능 (||)
SELECT empno, ename || '('|| job ||')' employee
FROM emp;

-----------------------------------------------------------------------------------------

-- 숫자형 함수 --
ABS(숫자) : 절대값
SIGN(숫자) : 숫자가 양수인지, 음수인지, 0인지 구별
MOD(숫자1, 숫자2) : 숫자1을 숫자2로 나누어 나머지 값을 리턴. % 연산자로도 대체 가능
CEIL/CEILING(숫자) : 숫자보다 크거나 같은 최소 정수를 리턴
FLOOR(숫자) : 숫자보다 작거나 같은 최소 정수를 리턴
ROUND(숫자 [,m]) : 숫자를 소수점 m+1 자리에서 반올림하여 리턴. m 생략시 0
TRUNC(숫자, [,m]) : 숫자를 소수점 m+1 자리에서 잘라서 버림
SIN, COS, TAN : 숫자의 삼각함수 값을 리턴
EXP, POWER, SQRT, LOG, LN : 숫자의 지수, 거듭 제곱, 제곱근, 자연 로그 값을 리턴

(예시)
SELECT ename, round(sal/12, 1), trunc(sal/12, 1)
FROM emp;

-----------------------------------------------------------------------------------------

-- 변환형 함수 --
TO_NUMBER(문자열) : 문자열을 숫자로 변환
TO_CHAR(숫자|날짜[,FORMAT]) : 숫자나 날짜를 주어진 FORMAT 형태로 문자열 타입으로 변환
TO_DATE(문자열, [,FORMAT]) : 문자열을 주어진 FORMAT 형태로 날짜 타입으로 변환

(예시)
SELECT sysdate FROM dual;

SELECT TO_char(sysdate, 'YYYY/MM/DD') 날짜,
TO_char(sysdate, 'YYYY. MON. DAY') 문자형
FROM dual;

-----------------------------------------------------------------------------------------

-- 날짜형 함수 --
STSDATE : 현재 날짜와 시각을 출력
EXTRACT('YEAR' | 'MONTH' | 'DAY' FROM d) : 날짜 데이터에서 년/월/일 데이터를 출력 (시/분/초 도 가능)
TO_NUMBER(TO_CHAR(d, 'YYYY'))
TO_NUMBER(TO_CHAR(d,'MM'))	
TO_NUMBER(TO_CHAR(d, 'DD'))

(에시)
SELECT sysdate, extract(MONTH FROM sysdate),
EXTRACT(DAY FROM sysdate)
FROM dual;

SELECT sysdate FROM dual;

SELECT * FROM dual;

SELECT ename, hiredate, to_number(to_char(hiredate, 'YYYY')) 입사년도,
TO_NUMBER(TO_CHAR(hiredate,'MM')) 입사월,
TO_NUMBER(TO_CHAR(hiredate, 'DD')) 입사일			## TO_NUMBER 함수 제외 시 문자형으로 출력됨
FROM emp;

SELECT ename, hiredate,
to_char(hiredate, 'YYYY') 입사년도,
to_char(hiredate, 'MM') 월,
to_char(hiredate, 'DD') 일
FROM emp;

-----------------------------------------------------------------------------------------

-- CASE 표현 --		## IF-THEN-ELSE 논리와 유사한 방식으로 표현식 작성
CASE
	SIMPLE_CASE_EXPRESSION 조건		# 조건 맞으면 그 안의 then절 수행 아니면 else절 수행
	ELSE 표현절
END


(예시)

SELECT ename, sal
FROM emp;

SELECT ename,
CASE WHEN sal > 2000
THEN sal
ELSE 2000
END revised_salary
FROM emp;

SELECT * FROM dept;

SELECT loc,
CASE loc
WHEN 'NEW YORK' THEN 'EAST'
WHEN 'BOSTION' THEN 'EAST'
WHEN 'CHICAGO' THEN 'CENTER'
WHEN 'DALLAS' THEN 'CENTER'
ELSE 'ETC'
END AS AREA
FROM dept;

SELECT loc,
decode(loc,
'NEW YORK', 'EAST',
'BOSTON', 'EAST',
'DALLAS', 'CENTER',
'CHICAGO', 'CENTER') area
FROM dept;

SELECT ename,
CASE WHEN sal>=3000 THEN 'high'
WHEN sal>=1000 THEN 'mid'
ELSE 'low'
END AS salary_grade
FROM emp;



-----------------------------------------------------------------------------------------

-- NULL 관련 함수 --
NVL(표현식1, 표현식2) : 오라클. 표현식1의 결과값이 NULL이면 표현식2 값 출력. 단 두 표현식의 결과 데이터 타입이 같아야 함
NULLIF(표현식1, 표현식2) : 표현시1이 표현식2와 같으면 NULL, 같지 않으면 표현식1을 리턴한다

SELECT empno, ename, sal, nvl,(comm, 0) FROM emp;

SELECT empno, ename, sal,
CASE WHEN comm IS NULL
THEN 0
ELSE comm
END AS cmmision
FROM emp;

SELECT empno, ename, sal,
CASE WHEN comm IS NULL
THEN 0
ELSE comm
END AS commision,
SAL + (CASE WHEN comm IS NULL
		THEN 0
		ELSE comm
		END) RESULT
FROM emp


-----------------------------------------------------------------------------------------

-- EXIST --
단지 해당 row가 존재하는 지만 확인하고, 더 이상 수행되지 않는다


-- IN --
실제 존재하는 데이터들의 모든 값까지 확인


-----------------------------------------------------------------------------------------

-- ROWNUM --		# select 절에 의해 추출되는 데이터에 붙는 순번
<   <=   =1   를 이용하여 비교 (>   >=   =2 는 동작하지 않는다)

(예씨)
SELECT * FROM emp
WHERE rownum<=5;

SELECT ename, sal, comm, sal+nvl(comm, 0) salsum 
FROM emp
ORDER BY 4 DESC;

SELECT *
FROM (SELECT ename, sal, comm, sal+nvl(comm, 0) salsum
	FROM emp
	ORDER BY 4 DESC)
WHERE rownum<=5;

SELECT *
FROM (SELECT ename, sal, comm, sal+nvl(comm, 0) salsum
	FROM emp
	ORDER BY 4)
WHERE rownum<=4
ORDER BY sal

-----------------------------------------------------------------------------------------

-- BETWEEN --

(예 - emp 테이블의 직원 중, 급여가 1500 이상 2500 이하인 직원을 구하시오.)
SELECT * FROM emp
WHERE sal BETWEEN 1500 AND 2500;


-----------------------------------------------------------------------------------------

-- GROUP FUNCTION -- 		## 일반적인 GROUP BY 절 사용

(예시 - 부서명과 업무명을 기준으로 사원수와 급여 합을 집계한 일반적인 GROUP BY SQL 문장을 수행)
SELECT dname, job,
	count(*) "Total Emp1",
	sum(sal) "Total Sal"
FROM emp, dept
WHERE dept.deptno = emp.deptno
GROUP BY dname, job;
ORDER BY 1, 2



* ROLLUP 함수 사용

(예)
SELECT dname, job,
	count(*) "Total Emp1",
	sum(sal) "Total Sal"
FROM emp, dept
WHERE dept.deptno = emp.deptno
GROUP BY ROLLUP (dname, job)
ORDER BY 1, 2

