package com.report.ware;


//========================================================
// 게시판 검색 관련 정보 저장 [BoardSearchDTO 클래스] 선언
//========================================================
	// <문> 게시판 검색 조건들을 하나의 [BoardSearchDTO 객체]에 저장하는 이유는?
	//			 ==> 다량의 데이터를 하나로 단위화 시킴으로써 DB 연동 시 편리함을 추구한다.
	//			 ==> 특히 스프링에서는 다량의 파라미터값이 자동으로 DTO에 저장되기 때문에 많이 사용된다.
//--------------------------------------------------
// <주의> 스프링에서 DTO 객체의 이름은 관용적으로 XxxDTO, XxxVo, Xxx 형식으로 준다.
//--------------------------------------------------
public class EmployeeSearchDTO {
	//-------------------------------
	// 속성변수 선언
	//-------------------------------
	private String keyword;		// 키워드1
	private String dep_no;			// 부서
	private String jikup_code;		// 직급
	private String selectPageNo;	// 선택한 페이지번호
	private String rowCntPerPage;	// 선택한 페이지당 행개수
	
	private String sort;
	private String ascDesc;
	private String str;
	
	
	
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getAscDesc() {
		return ascDesc;
	}
	public void setAscDesc(String ascDesc) {
		this.ascDesc = ascDesc;
	}
	public String getStr() {
		return str;
	}
	public void setStr(String str) {
		this.str = str;
	}
	public String getDep_no() {
		return dep_no;
	}
	public void setDep_no(String dep_no) {
		this.dep_no = dep_no;
	}
	public String getJikup_code() {
		return jikup_code;
	}
	public void setJikup_code(String jikup_code) {
		this.jikup_code = jikup_code;
	}
	public String getSelectPageNo() {
		return selectPageNo;
	}
	public void setSelectPageNo(String selectPageNo) {
		this.selectPageNo = selectPageNo;
	}
	public String getRowCntPerPage() {
		return rowCntPerPage;
	}
	public void setRowCntPerPage(String rowCntPerPage) {
		this.rowCntPerPage = rowCntPerPage;
	}
	

	
}
