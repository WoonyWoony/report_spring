package com.report.ware;

import java.util.List;
import java.util.Map;

public interface DashboardDAO {
	List<Map<String,String>> getDailyStatList(DashboardDTO dashboardDTO);
	List<Map<String,String>> getSaleStatList(DashboardDTO dashboardDTO);
	List<Map<String,String>> getExpenseStatList(DashboardDTO dashboardDTO);
	
	List<Map<String,String>> getRoundDailyStatList(DashboardDTO dashboardDTO);
	List<Map<String,String>> getRoundSalesStatList(DashboardDTO dashboardDTO);
	List<Map<String,String>> getRoundExpenseStatList(DashboardDTO dashboardDTO);

	List<Map<String,String>> getDailySignList(DashboardDTO dashboardDTO);
	List<Map<String,String>> getSaleSignList(DashboardDTO dashboardDTO);
	List<Map<String,String>> getExpenseSignList(DashboardDTO dashboardDTO);

	List<Map<String,String>> getBeforSignList(DashboardDTO dashboardDTO);
}
