package com.report.ware;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class DashboardServiceImpl implements DashboardService {

	@Autowired
	private DashboardDAO dashboardDAO;

	@Override
	public List<Map<String, String>> getDailyStatList(DashboardDTO dashboardDTO) {
		List<Map<String,String>> dailyStatList = this.dashboardDAO.getDailyStatList(dashboardDTO);
		return dailyStatList;
	}
	
	@Override
	public List<Map<String, String>> getSaleStatList(DashboardDTO dashboardDTO) {
		List<Map<String,String>> saleStatList = this.dashboardDAO.getSaleStatList(dashboardDTO);
		return saleStatList;
	}
	
	@Override
	public List<Map<String, String>> getExpenseStatList(DashboardDTO dashboardDTO) {
		List<Map<String,String>> expenseStatList = this.dashboardDAO.getExpenseStatList(dashboardDTO);
		return expenseStatList;
	}

	@Override
	public List<Map<String, String>> getRoundDailyStatList(DashboardDTO dashboardDTO) {
		List<Map<String,String>> roundStatList = this.dashboardDAO.getRoundDailyStatList(dashboardDTO);
		return roundStatList;
	}

	@Override
	public List<Map<String, String>> getRoundSalesStatList(DashboardDTO dashboardDTO) {
		List<Map<String,String>> roundStatList = this.dashboardDAO.getRoundSalesStatList(dashboardDTO);
		return roundStatList;
	}

	@Override
	public List<Map<String, String>> getRoundExpenseStatList(DashboardDTO dashboardDTO) {
		List<Map<String,String>> roundStatList = this.dashboardDAO.getRoundExpenseStatList(dashboardDTO);
		return roundStatList;
	}


	@Override
	public List<Map<String, String>> getDailySignList(DashboardDTO dashboardDTO) {
		List<Map<String,String>> dailySignList = this.dashboardDAO.getDailySignList(dashboardDTO);
		return dailySignList;
	}

	@Override
	public List<Map<String, String>> getSaleSignList(DashboardDTO dashboardDTO) {
		List<Map<String,String>> salesSignList = this.dashboardDAO.getSaleSignList(dashboardDTO);
		return salesSignList;
	}

	@Override
	public List<Map<String, String>> getExpenseSignList(DashboardDTO dashboardDTO) {
		List<Map<String,String>> expenseSignList = this.dashboardDAO.getExpenseSignList(dashboardDTO);
		return expenseSignList;
	}

	@Override
	public List<Map<String, String>> getBeforSignList(DashboardDTO dashboardDTO) {
		List<Map<String,String>> beforeSignList = this.dashboardDAO.getBeforSignList(dashboardDTO);
		return beforeSignList;
	}
}
