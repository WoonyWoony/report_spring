package com.report.ware;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

// ===========================================================================
// [DAO 클래스] 인 [LoginDAOImpl 클래스]선언
// ===========================================================================
// @Repository 를 붙임으로써 [DAO 클래스] 임을 지정하게 되고, bean 태그로 자동등록된다
// ===========================================================================
@Repository
public class LoginDAOImpl implements LoginDAO {
	// ============================================================
	// SqlSessionTemplate 객체를 생성해 속성변수 sqlSession 에 저장
	// ============================================================
	@Autowired
	private SqlSessionTemplate sqlSession;

	// ============================================================
	// [로그인 아이디, 암호의 존재 개수]를 리턴하는 메소드 선언
	// ============================================================
	@Override
	public int getAdminCnt(Map<String, String> admin_id_pwd) {
		// ---------------------------------------------------------------
		// SqlSessionTemplate 객체의 selectOne 메소드 호출로
		// [로그인 아이디, 암호의 존재개수]를 리턴.
		// ---------------------------------------------------------------
		// selectOne("com.naver.erp.LoginDAO.getAdminCnt", admin_id_pwd); 의미
		// ---------------------------------------------------------------
		// mybatis SQL 구문 설정 XML파일 (=mapper_login.xml) 에서
		// <mapper namespace="com.naver.erp.LoginDAO"> 태그 내부의
		// <select id = "getAdminCnt" ~> 태그 내부의
		// [1행 리턴 select 쿼리문]을 실행하고 얻은 데이터를 int 로 리턴한다.
		// 2번째 인자는 [1행 리턴 select 쿼리문]에 삽입될 데이터이다.
		// selectOne 의 리턴 자료형은 String, int, double, DTO, Map<String, String> 이 가능하다
		// ---------------------------------------------------------------
		System.out.println("DAO 1");
		int adminCnt = this.sqlSession.selectOne("com.report.ware.LoginDAO.getAdminCnt", admin_id_pwd);
		System.out.println("DAO 2");
		return adminCnt;
	}

	@Override
	public String getAdminName(Map<String, String> admin_id_pwd) {
		String emp_name = this.sqlSession.selectOne("com.report.ware.LoginDAO.getAdminName", admin_id_pwd);
		return emp_name;
	}
	@Override
	public String getEmpRole(Map<String, String> admin_id_pwd) {
		String emp_role = this.sqlSession.selectOne("com.report.ware.LoginDAO.getEmpRole", admin_id_pwd);
		return emp_role;
	}

	@Override
	public String getEmpJikup(Map<String, String> admin_id_pwd) {
		String emp_jikup = this.sqlSession.selectOne("com.report.ware.LoginDAO.getEmpJikup", admin_id_pwd);
		return emp_jikup;
	}
	
	@Override
	public String getEmpAllow(Map<String, String> admin_id_pwd) {
		String emp_allow = this.sqlSession.selectOne("com.report.ware.LoginDAO.getEmpAllow", admin_id_pwd);
		return emp_allow;
	}

}
