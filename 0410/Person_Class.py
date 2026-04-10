class Person:                   # 클래스 - 속성, 메소드
    def __init__(self, empno, ename, job, mgr, hiredate, sal, comm, deptno):
        self.empno = empno
        self.ename = ename
        self.job = job
        self.mgr = mgr
        self.hiredate = hiredate
        self.sal = int(sal)
        self.comm = comm
        self.deptno = deptno

    def info(self):
        print(f"사원번호:{self.empno}   사원명:{self.ename}   직업:{self.job}   사수번호:{self.mgr}   고용일:{self.hiredate}   급여:{self.sal}   보너스:{self.comm}   부서번호:{self.deptno}")


'''
    def print_person(self):
        if self.sal is not None:
            print(f"{self.empno} : {self.ename:>10} : {int(self.sal):>7}")
        else:
            print(f"{self.empno} : {self.ename:>10} :       0")
'''
