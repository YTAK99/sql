import oracledb

# 데이터베이스 접속 정보 설정
dsn = oracledb.makedsn("localhost", 1521, service_name="XE")
conn = oracledb.connect(user="c##mbc", password="qwer1234", dsn=dsn)

# 쿼리 실행을 위한 커서 생성
cursor = conn.cursor()


class Person:                   # 클래스 - 속성, 메소드
    def __init__(self, empno, ename, job, mgr, hiredate, sal, comm, deptno):
        self.empno = empno
        self.ename = ename
        self.job = job
        self.mgr = mgr
        self.hiredate = hiredate
        self.sal = sal
        self.comm = comm
        self.deptno = deptno

    def info(self):
        print(f"사원번호:{self.empno}   사원명:{self.ename}   직업:{self.job}   사수번호:{self.mgr}   고용일:{self.hiredate}   급여:{self.sal}   보너스:{self.comm}   부서번호:{self.deptno}")



def show_menu():
    print("-- 임직원 관리 시스템 --")
    print("- 1. 직원 추가    -")
    print("- 2. 직원 삭제    -")
    print("- 3. 직원 조회    -")
    print("- 4. 프로그램 종료 -")
    menu_num = input("메뉴를 선택해 주세요: ")
    print(menu_num)
    return menu_num

def insert_emp(): # empno, ename, job, mgr, hiredate, sal, comm, deptno  
    print("새로운 직원의 사번, 이름을 입력하세요....")
    empno, ename = input().split()
    print(empno, ename)

    if empno.isdigit():        
#INSERT 예제
        try:
            # INSERT INTO EMP(EMPNO, ENAME) VALUES('1234','LEO')
            cursor.execute("INSERT INTO EMP(EMPNO, ENAME) VALUES (:1, :2)", [empno, ename.upper()])
            conn.commit()
            print("Data inserted successfully")
        except oracledb.DatabaseError as e:
            print(f"Error inserting data: {e}")
    else:
        print("ERR-INSERT-001 : 사번 입력 오류 입니다. 숫자만 입력 가능합니다.")


def delete_emp():
    print("삭제... 허쉴?")
    empno, ename = input().split()
    print(empno, ename)

    try:
        cursor.execute("DELETE FROM EMP(EMPNO, ENAME) VALUES (:1, :2)", [empno, ename.upper()])
        for row in cursor:
            print(row)
    except oracledb.DatabaseError as e:
        print(f"Error fetching data: {e}")



def search_emp():
# SELECT 예제
    try:
        cursor.execute('''
                        SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO
                        FROM emp 
                        ORDER BY EMPNO
                        ''')
        for row in cursor:
            p = Person(*row[:8])                # row의 0번부터 7번 인덱스까지 슬라이싱한 후 언패킹
                                                # 동일 표현1 : p = Person(*(row[x] for x in range(8)))
                                                # 동일 표현2 : p = Person(row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7])
            p.info()
            
            
    except oracledb.DatabaseError as e:
        print(f"Error fetching data: {e}")

loop = True
while loop:
    select = int(show_menu())
    if select == 1:
        print("1. 직원 추가 메뉴")
        insert_emp()

    elif select == 2:
        print("2. 직원 삭제 메뉴")
        delete_emp()

    elif select == 3:
        print("3. 직원 조회 메뉴")
        search_emp()

    else:
        print("*** 프로그램 종료 ***")
        loop = False                    # break 써도 됨

# 커서 및 커넥션 닫기
cursor.close()
conn.close()
