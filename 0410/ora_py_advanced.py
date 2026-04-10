import oracledb

# =========================
# 1. DB 연결 설정
# =========================
dsn = oracledb.makedsn("localhost", 1521, service_name="XE")
conn = oracledb.connect(user="c##mbc", password="qwer1234", dsn=dsn)
cursor = conn.cursor()

# =========================
# 2. 전역 리스트 (캐시)
# =========================
PList = []  # DB 데이터를 메모리에 저장 (성능 최적화)

# =========================
# 3. Person 클래스
# =========================
class Person:
    def __init__(self, empno, ename, job, mgr, hiredate, sal, comm, deptno):
        self.empno = empno
        self.ename = ename
        self.job = job
        self.mgr = mgr
        self.hiredate = hiredate
        self.sal = sal
        self.comm = comm
        self.deptno = deptno

    # 직원 정보 출력
    def info(self):
        sal = int(self.sal) if self.sal is not None else 0
        print(f"{self.empno} : {self.ename:>10} : {sal:>7}")


# =========================
# 4. 메뉴 출력
# =========================
def show_menu():
    print("\n-- 임직원 관리 시스템 --")
    print("1. 직원 추가")
    print("2. 직원 삭제")
    print("3. 직원 조회")
    print("4. 프로그램 종료")

    try:
        return int(input("메뉴 선택: "))
    except ValueError:
        return 0  # 잘못된 입력 처리


# =========================
# 5. 직원 추가 (INSERT)
# =========================
def insert_emp():
    print("\n[직원 추가]")
    try:
        empno, ename = input("사번 이름 입력: ").split()
    except ValueError:
        print("입력 형식 오류 (예: 1001 홍길동)")
        return

    # 숫자 검사
    if not empno.isdigit():
        print("ERR: 사번은 숫자만 입력 가능")
        return

    try:
        # 바인딩 변수 사용 (SQL Injection 방지)
        cursor.execute(
            "INSERT INTO EMP (EMPNO, ENAME) VALUES (:1, :2)",
            [empno, ename.upper()]
        )
        conn.commit()

        print("✔ 직원 추가 완료")

        # 캐시 초기화 (DB와 동기화)
        PList.clear()

    except oracledb.DatabaseError as e:
        print("DB 오류:", e)


# =========================
# 6. 직원 삭제 (DELETE)
# =========================
def delete_emp():
    print("\n[직원 삭제]")
    empno = input("삭제할 사번 입력: ")

    if not empno.isdigit():
        print("ERR: 사번은 숫자만 입력")
        return

    try:
        cursor.execute(
            "DELETE FROM EMP WHERE EMPNO = :1",
            [empno]
        )
        conn.commit()

        # 삭제된 행 개수 확인
        if cursor.rowcount > 0:
            print("✔ 삭제 성공")

            # 캐시에서도 제거
            global PList
            PList = [p for p in PList if str(p.empno) != empno]

        else:
            print("❌ 해당 사번 없음")

    except oracledb.DatabaseError as e:
        print("DB 오류:", e)


# =========================
# 7. 직원 조회 (DB 조회)
# =========================
def search_emp():
    print("\n[직원 조회 - DB]")

    try:
        cursor.execute("""
            SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO
            FROM EMP
            ORDER BY EMPNO
        """)

        # 기존 리스트 초기화 (중복 방지 핵심!)
        PList.clear()

        for row in cursor:
            # 언패킹으로 객체 생성
            PList.append(Person(*row))

        # 출력
        for p in PList:
            p.info()

    except oracledb.DatabaseError as e:
        print("DB 오류:", e)


# =========================
# 8. 직원 조회 (캐시 사용)
# =========================
def search_emp_cached():
    print("\n[직원 조회 - 캐시]")

    if not PList:
        print("캐시 없음 → DB 조회 실행")
        search_emp()
        return

    for p in PList:
        p.info()


# =========================
# 9. 메인 루프
# =========================
def main():
    while True:
        menu = show_menu()

        if menu == 1:
            insert_emp()

        elif menu == 2:
            delete_emp()

        elif menu == 3:
            # 캐시 있으면 캐시 사용
            if len(PList) == 0:
                search_emp()
            else:
                search_emp_cached()

        elif menu == 4:
            print("프로그램 종료")
            break

        else:
            print("잘못된 입력입니다.")


# =========================
# 10. 실행
# =========================
if __name__ == "__main__":
    try:
        main()
    finally:
        # 프로그램 종료 시 반드시 닫기
        cursor.close()
        conn.close()
