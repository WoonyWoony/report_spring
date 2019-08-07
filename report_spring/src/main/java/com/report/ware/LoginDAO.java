package com.report.ware;

import java.util.Map;

// ===========================================================================
// 로그인 관련 메소드 이름을 제공하는 [DAO 인터페이스] 선언
// ===========================================================================
public interface LoginDAO {
	// ==============================================
	// [로그인 아이디, 암호 존개개수] 검색 메소드 선언
	// ==============================================
	int getAdminCnt(Map<String, String> admin_id_pwd);
	String getAdminName(Map<String, String> admin_id_pwd);
	String getEmpRole(Map<String, String> admin_id_pwd);
	String getEmpJikup(Map<String, String> admin_id_pwd);
	String getEmpAllow(Map<String, String> admin_id_pwd);
}
