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
public class BoardSearchDTO {
	//-------------------------------
	// 속성변수 선언
	//-------------------------------
	private String keyword1;
	private String keyword2;
	private String or_and;
	// 어제 또는 오늘을 저장
	private String[] date;
	// 현재 선택된 페이지 번호
	private String selectPageNo;
	// 한 화면에 보여줄 행의 개수
	private String rowCntPerPage;
	

	
	public String getKeyword1() {
		return keyword1;
	}
	public void setKeyword1(String keyword1) {
		this.keyword1 = keyword1;
	}
	public String getKeyword2() {
		return keyword2;
	}
	public void setKeyword2(String keyword2) {
		this.keyword2 = keyword2;
	}
	public String getOr_and() {
		return or_and;
	}
	public void setOr_and(String or_and) {
		this.or_and = or_and;
	}
	public String[] getDate() {
		return date;
	}
	public void setDate(String[] date) {
		this.date = date;
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
