package com.report.ware;

import java.util.Map;

public class ExpenseDTO {
	private String report_no;
	private String report_code;
	private String report_name;
	private String expense_field_code;
	private String expense_price;
	private String expense_method_code;

	private String expense_year;
	private String expense_month;
	private String expense_day;
	private String expense_date;
	private String receipt_no;
	private String remarks;
	private String emp_no;
	private String loginemp_no;
	
	private String[] return_emp_no; // 여러개 insert 할때 사용
	
	private String sign_state; // 안씀
	private String return_reason;
	private String sign_emp_no;
	private String sign_cnt;
	private String sign_finish_no;
	private String sign_date;
	private String sign_code;
	private String return_no;
	private String sign_name;
	
	private String noNextSigner;
	
	private Map<String, String> pickNextEmp;
	
	private String is_update;
	
	
	
	public String getIs_update() {
		return is_update;
	}
	public void setIs_update(String is_update) {
		this.is_update = is_update;
	}
	public Map<String, String> getPickNextEmp() {
		return pickNextEmp;
	}
	public void setPickNextEmp(Map<String, String> pickNextEmp) {
		this.pickNextEmp = pickNextEmp;
	}
	
	public String getLoginemp_no() {
		return loginemp_no;
	}
	public void setLoginemp_no(String loginemp_no) {
		this.loginemp_no = loginemp_no;
	}
	public String[] getReturn_emp_no() {
		return return_emp_no;
	}
	public void setReturn_emp_no(String[] return_emp_no) {
		this.return_emp_no = return_emp_no;
	}
	public String getNoNextSigner() {
		return noNextSigner;
	}
	public void setNoNextSigner(String noNextSigner) {
		this.noNextSigner = noNextSigner;
	}
	public String getSign_name() {
		return sign_name;
	}
	public void setSign_name(String sign_name) {
		this.sign_name = sign_name;
	}
	public String getReturn_reason() {
		return return_reason;
	}
	public void setReturn_reason(String return_reason) {
		this.return_reason = return_reason;
	}
	public String getSign_state() {
		return sign_state;
	}

	public void setSign_state(String sign_state) {
		this.sign_state = sign_state;
	}

	public String getReport_no() {
		return report_no;
	}

	public void setReport_no(String report_no) {
		this.report_no = report_no;
	}

	public String getReport_code() {
		return report_code;
	}

	public void setReport_code(String report_code) {
		this.report_code = report_code;
	}

	public String getReport_name() {
		return report_name;
	}

	public void setReport_name(String report_name) {
		this.report_name = report_name;
	}

	public String getExpense_field_code() {
		return expense_field_code;
	}

	public void setExpense_field_code(String expense_field_code) {
		this.expense_field_code = expense_field_code;
	}

	public String getExpense_price() {
		return expense_price;
	}

	public void setExpense_price(String expense_price) {
		this.expense_price = expense_price;
	}

	public String getExpense_method_code() {
		return expense_method_code;
	}

	public void setExpense_method_code(String expense_method_code) {
		this.expense_method_code = expense_method_code;
	}

	public String getExpense_year() {
		return expense_year;
	}

	public void setExpense_year(String expense_year) {
		this.expense_year = expense_year;
	}

	public String getExpense_month() {
		return expense_month;
	}

	public void setExpense_month(String expense_month) {
		this.expense_month = expense_month;
	}

	public String getExpense_day() {
		return expense_day;
	}

	public void setExpense_day(String expense_day) {
		this.expense_day = expense_day;
	}

	public String getExpense_date() {
		return expense_date;
	}

	public void setExpense_date(String expense_date) {
		this.expense_date = expense_date;
	}

	public String getReceipt_no() {
		return receipt_no;
	}

	public void setReceipt_no(String receipt_no) {
		this.receipt_no = receipt_no;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getEmp_no() {
		return emp_no;
	}

	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}

	public String getSign_emp_no() {
		return sign_emp_no;
	}

	public void setSign_emp_no(String sign_emp_no) {
		this.sign_emp_no = sign_emp_no;
	}

	public String getSign_cnt() {
		return sign_cnt;
	}

	public void setSign_cnt(String sign_cnt) {
		this.sign_cnt = sign_cnt;
	}

	public String getSign_finish_no() {
		return sign_finish_no;
	}

	public void setSign_finish_no(String sign_finish_no) {
		this.sign_finish_no = sign_finish_no;
	}

	public String getSign_date() {
		return sign_date;
	}

	public void setSign_date(String sign_date) {
		this.sign_date = sign_date;
	}

	public String getSign_code() {
		return sign_code;
	}

	public void setSign_code(String sign_code) {
		this.sign_code = sign_code;
	}

	public String getReturn_no() {
		return return_no;
	}

	public void setReturn_no(String return_no) {
		this.return_no = return_no;
	}
}
