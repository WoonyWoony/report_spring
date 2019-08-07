package com.report.ware;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

// ===========================================================================
// [서비스 클래스] 인 [LoginServiceImpl 클래스]선언
// ===========================================================================
// [서비스 클래스] 에는 @Service 와 @Transactional 를 붙인다.
// -----------------------------------------------------------
// @Service			=> [서비스 클래스]임을 지정하고 bean 태그로 자동 등록된다.
// @Transactional 	=> [서비스 클래스]의 메소드 내부에서 일어나는 모든 작업에는 [트랜잭션]이 걸린다.
// 여기선 SELECT 쿼리만 이루어지므로 굳이 트랜잭션을 걸지 않아도 된다. 
@Service
public class LoginServiceImpl implements LoginService {
	// ===========================================================================
	// 속성변수 loginDAO 선언하고, LoginDAO 라는 인터페이스를 구현한 클래스를 객체화하여 저장
	// ===========================================================================
	// @Autowired 이 붙은 속성변수에는 인터페이스 자료형을 쓰고
	// 이 인터페이스를 구현한 클래스를 객체화하여 저장한다.
	// LoginDAO 라는 인터페이스를 구현한 클래스의 이름을 몰라도 상관없다. 1개 존재하면 된다.
	// ===========================================================================
	@Autowired
	private LoginDAO loginDAO;

	// =============================================
	// 로그인 정보의 개수를 리턴하는 메소드 선언
	// =============================================
	@Override
	public int getAdminCnt(Map<String, String> admin_id_pwd) {
		int adminCnt = this.loginDAO.getAdminCnt(admin_id_pwd);
		return adminCnt;
	}

	@Override
	public String getAdminName(Map<String, String> admin_id_pwd) {
		String emp_name = this.loginDAO.getAdminName(admin_id_pwd);
		return emp_name;
	}
	@Override
	public String getEmpRole(Map<String, String> admin_id_pwd) {
		String emp_role = this.loginDAO.getEmpRole(admin_id_pwd);
		return emp_role;
	}

	public String getEmpJikup(Map<String, String> admin_id_pwd) {
		String emp_jikup = this.loginDAO.getEmpJikup(admin_id_pwd);
		return emp_jikup;
	}
	
	public String getEmpAllow(Map<String, String> admin_id_pwd) {
		String emp_allow = this.loginDAO.getEmpAllow(admin_id_pwd);
		return emp_allow;
	}
}
