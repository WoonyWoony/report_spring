package com.report.ware;

import java.util.Map;

public class DailyBusiDTO {
	private String report_no;
	private String report_code;
	private String report_name;
	private String busi_type_code;
	private String busi_content;
	private String expense_method_code;
	private String emp_name;

	private String busi_year_min;
	private String busi_month_min;
	private String busi_day_min;
	private String busi_hours_min;
	private String busi_minutes_min;
	private String busi_start_date;
	private String busi_year_max;
	private String busi_month_max;
	private String busi_day_max;
	private String busi_hours_max;
	private String busi_minutes_max;
	private String busi_end_date;
	private String busi_date;
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

	
	
	public String getBusi_date() {
		return busi_date;
	}

	public void setBusi_date(String busi_date) {
		this.busi_date = busi_date;
	}

	public String getEmp_name() {
		return emp_name;
	}

	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
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

	public String getBusi_type_code() {
		return busi_type_code;
	}

	public void setBusi_type_code(String busi_type_code) {
		this.busi_type_code = busi_type_code;
	}

	public String getBusi_content() {
		return busi_content;
	}

	public void setBusi_content(String busi_content) {
		this.busi_content = busi_content;
	}

	public String getExpense_method_code() {
		return expense_method_code;
	}

	public void setExpense_method_code(String expense_method_code) {
		this.expense_method_code = expense_method_code;
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

	public String getBusi_day_min() {
		return busi_day_min;
	}

	public void setBusi_day_min(String busi_day_min) {
		this.busi_day_min = busi_day_min;
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

	public String getBusi_start_date() {
		return busi_start_date;
	}

	public void setBusi_start_date(String busi_start_date) {
		this.busi_start_date = busi_start_date;
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

	public String getBusi_day_max() {
		return busi_day_max;
	}

	public void setBusi_day_max(String busi_day_max) {
		this.busi_day_max = busi_day_max;
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

	public String getBusi_end_date() {
		return busi_end_date;
	}

	public void setBusi_end_date(String busi_end_date) {
		this.busi_end_date = busi_end_date;
	}

	public String getEmp_no() {
		return emp_no;
	}

	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
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

	public String getSign_state() {
		return sign_state;
	}

	public void setSign_state(String sign_state) {
		this.sign_state = sign_state;
	}

	public String getReturn_reason() {
		return return_reason;
	}

	public void setReturn_reason(String return_reason) {
		this.return_reason = return_reason;
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

	public String getSign_name() {
		return sign_name;
	}

	public void setSign_name(String sign_name) {
		this.sign_name = sign_name;
	}

	public String getNoNextSigner() {
		return noNextSigner;
	}

	public void setNoNextSigner(String noNextSigner) {
		this.noNextSigner = noNextSigner;
	}

	public Map<String, String> getPickNextEmp() {
		return pickNextEmp;
	}

	public void setPickNextEmp(Map<String, String> pickNextEmp) {
		this.pickNextEmp = pickNextEmp;
	}

	public String getIs_update() {
		return is_update;
	}

	public void setIs_update(String is_update) {
		this.is_update = is_update;
	}
	
	
	
}
