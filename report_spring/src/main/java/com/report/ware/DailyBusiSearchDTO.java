package com.report.ware;

public class DailyBusiSearchDTO {
	private String busi_year_min;
	private String busi_month_min;
	private String busi_date_min;
	private String busi_year_max;
	private String busi_month_max;
	private String busi_date_max;
	private String busi_hours_min;
	private String busi_minutes_min;
	private String busi_time_min;
	private String busi_hours_max;
	private String busi_minutes_max;
	private String busi_time_max;
	private String[] sign_state;
	private String[] busi_type_code;
	private String keyword;
	private String emp_no;
	// 현재 선택된 페이지 번호를 저장하는 속성변수 선언
	private String selectPageNo="1";
	// 한 화면에 보여줄 행의 개수를 저장하는 속성변수 선언
	private String rowCntPerPage="10";
	private String str;
	private String sort;
	private String ascDesc;

	private double scrollValue;
	
	
	public double getScrollValue() {
		return scrollValue;
	}
	public void setScrollValue(double scrollValue) {
		this.scrollValue = scrollValue;
	}
	
	
	public String getStr() {
		return str;
	}
	public void setStr(String str) {
		this.str = str;
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
	public String getBusi_year_min() {
		return busi_year_min;
	}
	public void setBusi_year_min(String busi_year_min) {
		this.busi_year_min = busi_year_min;
	}
	public String getBusi_month_min() {
		return busi_month_min;
	}
	public void setBusi_month_min(String busi_month_min) {
		this.busi_month_min = busi_month_min;
	}
	public String getBusi_date_min() {
		return busi_date_min;
	}
	public void setBusi_date_min(String busi_date_min) {
		this.busi_date_min = busi_date_min;
	}
	public String getBusi_year_max() {
		return busi_year_max;
	}
	public void setBusi_year_max(String busi_year_max) {
		this.busi_year_max = busi_year_max;
	}
	public String getBusi_month_max() {
		return busi_month_max;
	}
	public void setBusi_month_max(String busi_month_max) {
		this.busi_month_max = busi_month_max;
	}
	public String getBusi_date_max() {
		return busi_date_max;
	}
	public void setBusi_date_max(String busi_date_max) {
		this.busi_date_max = busi_date_max;
	}
	public String getBusi_hours_min() {
		return busi_hours_min;
	}
	public void setBusi_hours_min(String busi_hours_min) {
		this.busi_hours_min = busi_hours_min;
	}
	public String getBusi_minutes_min() {
		return busi_minutes_min;
	}
	public void setBusi_minutes_min(String busi_minutes_min) {
		this.busi_minutes_min = busi_minutes_min;
	}
	public String getBusi_time_min() {
		return busi_time_min;
	}
	public void setBusi_time_min(String busi_time_min) {
		this.busi_time_min = busi_time_min;
	}
	public String getBusi_hours_max() {
		return busi_hours_max;
	}
	public void setBusi_hours_max(String busi_hours_max) {
		this.busi_hours_max = busi_hours_max;
	}
	public String getBusi_minutes_max() {
		return busi_minutes_max;
	}
	public void setBusi_minutes_max(String busi_minutes_max) {
		this.busi_minutes_max = busi_minutes_max;
	}
	public String getBusi_time_max() {
		return busi_time_max;
	}
	public void setBusi_time_max(String busi_time_max) {
		this.busi_time_max = busi_time_max;
	}
	public String[] getSign_state() {
		return sign_state;
	}
	public void setSign_state(String[] sign_state) {
		this.sign_state = sign_state;
	}
	public String[] getBusi_type_code() {
		return busi_type_code;
	}
	public void setBusi_type_code(String[] busi_type_code) {
		this.busi_type_code = busi_type_code;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
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


