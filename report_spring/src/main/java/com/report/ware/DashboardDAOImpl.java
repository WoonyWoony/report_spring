package com.report.ware;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class DashboardDAOImpl implements DashboardDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<Map<String, String>> getDailyStatList(DashboardDTO dashboardDTO) {
		List<Map<String,String>> dailyStatList = this.sqlSession.selectList("com.report.ware.DashboardDAO.getDailyStatList", dashboardDTO);
		return dailyStatList;
	}
	
	@Override
	public List<Map<String, String>> getSaleStatList(DashboardDTO dashboardDTO) {
		List<Map<String,String>> saleStatList = this.sqlSession.selectList("com.report.ware.DashboardDAO.getSaleStatList", dashboardDTO);
		return saleStatList;
	}

	@Override
	public List<Map<String, String>> getExpenseStatList(DashboardDTO dashboardDTO) {
		List<Map<String,String>> expenseStatList = this.sqlSession.selectList("com.report.ware.DashboardDAO.getExpenseStatList", dashboardDTO);
		return expenseStatList;
	}

	@Override
	public List<Map<String, String>> getRoundDailyStatList(DashboardDTO dashboardDTO) {
		List<Map<String,String>> roundStatList = this.sqlSession.selectList("com.report.ware.DashboardDAO.getRoundDailyStatList", dashboardDTO);
		return roundStatList;
	}

	@Override
	public List<Map<String, String>> getRoundSalesStatList(DashboardDTO dashboardDTO) {
		List<Map<String,String>> roundStatList = this.sqlSession.selectList("com.report.ware.DashboardDAO.getRoundSalesStatList", dashboardDTO);
		return roundStatList;
	}

	@Override
	public List<Map<String, String>> getRoundExpenseStatList(DashboardDTO dashboardDTO) {
		List<Map<String,String>> roundStatList = this.sqlSession.selectList("com.report.ware.DashboardDAO.getRoundExpenseStatList", dashboardDTO);
		return roundStatList;
	}

	@Override
	public List<Map<String, String>> getDailySignList(DashboardDTO dashboardDTO) {
		List<Map<String,String>> dailySignList = this.sqlSession.selectList("com.report.ware.DashboardDAO.getDailySignList", dashboardDTO);
		return dailySignList;
	}

	@Override
	public List<Map<String, String>> getSaleSignList(DashboardDTO dashboardDTO) {
		List<Map<String,String>> saleSignList = this.sqlSession.selectList("com.report.ware.DashboardDAO.getSaleSignList", dashboardDTO);
		return saleSignList;
	}

	@Override
	public List<Map<String, String>> getExpenseSignList(DashboardDTO dashboardDTO) {
		List<Map<String,String>> expenseSignList = this.sqlSession.selectList("com.report.ware.DashboardDAO.getExpenseSignList", dashboardDTO);
		return expenseSignList;
	}

	@Override
	public List<Map<String, String>> getBeforSignList(DashboardDTO dashboardDTO) {
		List<Map<String,String>> beforeSignList = this.sqlSession.selectList("com.report.ware.DashboardDAO.getBeforSignList", dashboardDTO);
		return beforeSignList;
	}
}
