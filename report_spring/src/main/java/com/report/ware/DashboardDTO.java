package com.report.ware;

public class DashboardDTO {
	
	private String loginemp_no;
	private String mySignCount_year = "2019";
	
	private String roundStat_kinds = "일일";
	private String roundStat_year = "2019";

	private String signCodeCnt_year = "2019";
	private String signCodeCnt_month = "08";
	private String reportCode = "1";
	

	public String getSignCodeCnt_year() {
		return signCodeCnt_year;
	}
	public void setSignCodeCnt_year(String signCodeCnt_year) {
		this.signCodeCnt_year = signCodeCnt_year;
	}
	public String getSignCodeCnt_month() {
		return signCodeCnt_month;
	}
	public void setSignCodeCnt_month(String signCodeCnt_month) {
		this.signCodeCnt_month = signCodeCnt_month;
	}
	public String getReportCode() {
		return reportCode;
	}
	public void setReportCode(String reportCode) {
		this.reportCode = reportCode;
	}
	private double scrollValue;
	
	public String getLoginemp_no() {
		return loginemp_no;
	}
	public void setLoginemp_no(String loginemp_no) {
		this.loginemp_no = loginemp_no;
	}
	public String getMySignCount_year() {
		return mySignCount_year;
	}
	public void setMySignCount_year(String mySignCount_year) {
		this.mySignCount_year = mySignCount_year;
	}
	public String getRoundStat_kinds() {
		return roundStat_kinds;
	}
	public void setRoundStat_kinds(String roundStat_kinds) {
		this.roundStat_kinds = roundStat_kinds;
	}
	public String getRoundStat_year() {
		return roundStat_year;
	}
	public void setRoundStat_year(String roundStat_year) {
		this.roundStat_year = roundStat_year;
	}
	public double getScrollValue() {
		return scrollValue;
	}
	public void setScrollValue(double scrollValue) {
		this.scrollValue = scrollValue;
	}
	
	
}
