package com.report.ware;

import java.util.Map;

public class SalesDTO {
	private String report_no;
	private String report_code;
	private String report_name;
	private String sales_type_code;
	private String sales_type_name;

	private String sales_year_start;
	private String sales_month_start;
	private String sales_day_start;
	private String sales_hour_start;
	private String sales_minute_start;
	private String sales_year_end;
	private String sales_month_end;
	private String sales_day_end;
	private String sales_hour_end;
	private String sales_minute_end;
	private String sales_date_start;
	private String sales_date_end;
	private String sales_content;
	private String sales_result;
	private String sales_company;
	private String sales_name;
	private String sales_jikup;
	private String sales_phone;
	
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

	
	
	
	public String getSales_content() {
		return sales_content;
	}

	public void setSales_content(String sales_content) {
		this.sales_content = sales_content;
	}

	public String getSales_result() {
		return sales_result;
	}

	public void setSales_result(String sales_result) {
		this.sales_result = sales_result;
	}

	public String getSales_company() {
		return sales_company;
	}

	public void setSales_company(String sales_company) {
		this.sales_company = sales_company;
	}

	public String getSales_name() {
		return sales_name;
	}

	public void setSales_name(String sales_name) {
		this.sales_name = sales_name;
	}

	public String getSales_jikup() {
		return sales_jikup;
	}

	public void setSales_jikup(String sales_jikup) {
		this.sales_jikup = sales_jikup;
	}

	public String getSales_phone() {
		return sales_phone;
	}

	public void setSales_phone(String sales_phone) {
		this.sales_phone = sales_phone;
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

	public String getSales_type_code() {
		return sales_type_code;
	}

	public void setSales_type_code(String sales_type_code) {
		this.sales_type_code = sales_type_code;
	}

	public String getSales_type_name() {
		return sales_type_name;
	}

	public void setSales_type_name(String sales_type_name) {
		this.sales_type_name = sales_type_name;
	}

	public String getSales_year_start() {
		return sales_year_start;
	}

	public void setSales_year_start(String sales_year_start) {
		this.sales_year_start = sales_year_start;
	}

	public String getSales_month_start() {
		return sales_month_start;
	}

	public void setSales_month_start(String sales_month_start) {
		this.sales_month_start = sales_month_start;
	}

	public String getSales_day_start() {
		return sales_day_start;
	}

	public void setSales_day_start(String sales_day_start) {
		this.sales_day_start = sales_day_start;
	}

	public String getSales_hour_start() {
		return sales_hour_start;
	}

	public void setSales_hour_start(String sales_hour_start) {
		this.sales_hour_start = sales_hour_start;
	}

	public String getSales_minute_start() {
		return sales_minute_start;
	}

	public void setSales_minute_start(String sales_minute_start) {
		this.sales_minute_start = sales_minute_start;
	}

	public String getSales_year_end() {
		return sales_year_end;
	}

	public void setSales_year_end(String sales_year_end) {
		this.sales_year_end = sales_year_end;
	}

	public String getSales_month_end() {
		return sales_month_end;
	}

	public void setSales_month_end(String sales_month_end) {
		this.sales_month_end = sales_month_end;
	}

	public String getSales_day_end() {
		return sales_day_end;
	}

	public void setSales_day_end(String sales_day_end) {
		this.sales_day_end = sales_day_end;
	}

	public String getSales_hour_end() {
		return sales_hour_end;
	}

	public void setSales_hour_end(String sales_hour_end) {
		this.sales_hour_end = sales_hour_end;
	}

	public String getSales_minute_end() {
		return sales_minute_end;
	}

	public void setSales_minute_end(String sales_minute_end) {
		this.sales_minute_end = sales_minute_end;
	}

	public String getSales_date_start() {
		return sales_date_start;
	}

	public void setSales_date_start(String sales_date_start) {
		this.sales_date_start = sales_date_start;
	}

	public String getSales_date_end() {
		return sales_date_end;
	}

	public void setSales_date_end(String sales_date_end) {
		this.sales_date_end = sales_date_end;
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
