package com.report.ware;

public class ExpenseSearchDTO {
	private String sign_year_min;
	private String sign_month_min;
	private String sign_date_min;
	private String sign_year_max;
	private String sign_month_max;
	private String sign_date_max;
	private String expense_year_min;
	private String expense_month_min;
	private String expense_date_min;
	private String expense_year_max;
	private String expense_month_max;
	private String expense_date_max;
	private String[] sign_state;
	private String[] expense_method;
	private String[] expense_field;
	private String expense_price_min;
	private String expense_price_max;
	private String keyword;
	private String emp_no;
	// 현재 선택된 페이지 번호를 저장하는 속성변수 선언
	private String selectPageNo="1";
	// 한 화면에 보여줄 행의 개수를 저장하는 속성변수 선언
	private String rowCntPerPage="10";
	
	private String sort;
	private String ascDesc;
	private String str;
	private double scrollValue;
	
	
	public double getScrollValue() {
		return scrollValue;
	}
	public void setScrollValue(double scrollValue) {
		this.scrollValue = scrollValue;
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
	public String getSign_year_min() {
		return sign_year_min;
	}
	public void setSign_year_min(String sign_year_min) {
		this.sign_year_min = sign_year_min;
	}
	public String getSign_month_min() {
		return sign_month_min;
	}
	public void setSign_month_min(String sign_month_min) {
		this.sign_month_min = sign_month_min;
	}
	public String getSign_date_min() {
		return sign_date_min;
	}
	public void setSign_date_min(String sign_date_min) {
		this.sign_date_min = sign_date_min;
	}
	public String getSign_year_max() {
		return sign_year_max;
	}
	public void setSign_year_max(String sign_year_max) {
		this.sign_year_max = sign_year_max;
	}
	public String getSign_month_max() {
		return sign_month_max;
	}
	public void setSign_month_max(String sign_month_max) {
		this.sign_month_max = sign_month_max;
	}
	public String getSign_date_max() {
		return sign_date_max;
	}
	public void setSign_date_max(String sign_date_max) {
		this.sign_date_max = sign_date_max;
	}
	public String getExpense_year_min() {
		return expense_year_min;
	}
	public void setExpense_year_min(String expense_year_min) {
		this.expense_year_min = expense_year_min;
	}
	public String getExpense_month_min() {
		return expense_month_min;
	}
	public void setExpense_month_min(String expense_month_min) {
		this.expense_month_min = expense_month_min;
	}
	public String getExpense_date_min() {
		return expense_date_min;
	}
	public void setExpense_date_min(String expense_date_min) {
		this.expense_date_min = expense_date_min;
	}
	public String getExpense_year_max() {
		return expense_year_max;
	}
	public void setExpense_year_max(String expense_year_max) {
		this.expense_year_max = expense_year_max;
	}
	public String getExpense_month_max() {
		return expense_month_max;
	}
	public void setExpense_month_max(String expense_month_max) {
		this.expense_month_max = expense_month_max;
	}
	public String getExpense_date_max() {
		return expense_date_max;
	}
	public void setExpense_date_max(String expense_date_max) {
		this.expense_date_max = expense_date_max;
	}
	public String[] getSign_state() {
		return sign_state;
	}
	public void setSign_state(String[] sign_state) {
		this.sign_state = sign_state;
	}
	public String[] getExpense_method() {
		return expense_method;
	}
	public void setExpense_method(String[] expense_method) {
		this.expense_method = expense_method;
	}
	public String[] getExpense_field() {
		return expense_field;
	}
	public void setExpense_field(String[] expense_field) {
		this.expense_field = expense_field;
	}
	public String getExpense_price_min() {
		return expense_price_min;
	}
	public void setExpense_price_min(String expense_price_min) {
		this.expense_price_min = expense_price_min;
	}
	public String getExpense_price_max() {
		return expense_price_max;
	}
	public void setExpense_price_max(String expense_price_max) {
		this.expense_price_max = expense_price_max;
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
	
	
}


