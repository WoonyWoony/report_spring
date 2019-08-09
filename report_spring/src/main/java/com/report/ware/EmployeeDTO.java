package com.report.ware;

public class EmployeeDTO {
	//***********************************************
	// 속성변수 선언
	//***********************************************
	
	private String emp_no; 				// 사원번호 pk (접속시 아이디DB는 숫자지만 업무편의상 String으로 시작한다.)
	private String emp_name; 			// 사원이름
	private String emp_pwd;  			// 사원암호 (로그인 암호로 쓰임)
	private String jikup_code; 			// 직급코드
	private String email;       		// 이메일주소
	private String hire_date;   		// 입사일
	private String role;        		// 권한
	private String annual_paid_hoilday; // 남은 연차일수
	private String mgr_emp_no;			// 직속상관번호
	private String dep_no;              // 부서번호
	private String jumin_num;			// 주민번호
	private String phone_num;			// 전화번호
	private String new_emp_pwd;			// 바꿀 비번
	private String new_emp_pwd_chk;
	
	private String rowCntPerPage;
	private String SelectPageNo;
	
	
	private String beforeEmp_no;
	private String beforeEmail;
	private String beforeJumin_num;
	private String allow_code;
	
	
	public String getAllow_code() {
		return allow_code;
	}
	public void setAllow_code(String allow_code) {
		this.allow_code = allow_code;
	}
	public String getBeforeEmp_no() {
		return beforeEmp_no;
	}
	public void setBeforeEmp_no(String beforeEmp_no) {
		this.beforeEmp_no = beforeEmp_no;
	}
	public String getBeforeEmail() {
		return beforeEmail;
	}
	public void setBeforeEmail(String beforeEmail) {
		this.beforeEmail = beforeEmail;
	}
	public String getBeforeJumin_num() {
		return beforeJumin_num;
	}
	public void setBeforeJumin_num(String beforeJumin_num) {
		this.beforeJumin_num = beforeJumin_num;
	}
	public String getRowCntPerPage() {
		return rowCntPerPage;
	}
	public void setRowCntPerPage(String rowCntPerPage) {
		this.rowCntPerPage = rowCntPerPage;
	}
	public String getSelectPageNo() {
		return SelectPageNo;
	}
	public void setSelectPageNo(String selectPageNo) {
		SelectPageNo = selectPageNo;
	}
	public String getNew_emp_pwd() {
		return new_emp_pwd;
	}
	public void setNew_emp_pwd(String new_emp_pwd) {
		this.new_emp_pwd = new_emp_pwd;
	}
	public String getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}
	public String getEmp_name() {
		return emp_name;
	}
	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}
	public String getEmp_pwd() {
		return emp_pwd;
	}
	public void setEmp_pwd(String emp_pwd) {
		this.emp_pwd = emp_pwd;
	}
	public String getJikup_code() {
		return jikup_code;
	}
	public void setJikup_code(String jikup_code) {
		this.jikup_code = jikup_code;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getHire_date() {
		return hire_date;
	}
	public void setHire_date(String hire_date) {
		this.hire_date = hire_date;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getAnnual_paid_hoilday() {
		return annual_paid_hoilday;
	}
	public void setAnnual_paid_hoilday(String annual_paid_hoilday) {
		this.annual_paid_hoilday = annual_paid_hoilday;
	}
	public String getMgr_emp_no() {
		return mgr_emp_no;
	}
	public void setMgr_emp_no(String mgr_emp_no) {
		this.mgr_emp_no = mgr_emp_no;
	}
	public String getDep_no() {
		return dep_no;
	}
	public void setDep_no(String dep_no) {
		this.dep_no = dep_no;
	}
	public String getJumin_num() {
		return jumin_num;
	}
	public void setJumin_num(String jumin_num) {
		this.jumin_num = jumin_num;
	}
	public String getPhone_num() {
		return phone_num;
	}
	public void setPhone_num(String phone_num) {
		this.phone_num = phone_num;
	}
	public String getNew_emp_pwd_chk() {
		return new_emp_pwd_chk;
	}
	public void setNew_emp_pwd_chk(String new_emp_pwd_chk) {
		this.new_emp_pwd_chk = new_emp_pwd_chk;
	}


}
