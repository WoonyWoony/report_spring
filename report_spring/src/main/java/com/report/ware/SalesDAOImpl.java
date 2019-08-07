package com.report.ware;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class SalesDAOImpl implements SalesDAO {
	
	@Autowired
	SqlSession sqlSession;

	
	public int getSalesListAllCnt(SalesSearchDTO salesSearchDTO) {
		int salesListAllCnt = this.sqlSession.selectOne("com.report.ware.SalesDAO.getSalesListAllCnt",salesSearchDTO);
		return salesListAllCnt;
	}
	
	@Override
	public List<Map<String, String>> getSalesList(SalesSearchDTO salesSearchDTO) {
		List<Map<String,String>> salesList = this.sqlSession.selectList("com.report.ware.SalesDAO.getSalesList",salesSearchDTO);
		return salesList;
	}
	
	@Override
	public int first_insertSalesReport(SalesDTO salesDTO) {
		System.out.println("first_insertSalesReport DAO 들어옴");
		int salesReportRegCnt = this.sqlSession.insert("com.report.ware.SalesDAO.first_insertSalesReport", salesDTO);
		System.out.println("first_insertSalesReport DAO 성공");
		return salesReportRegCnt;
	}

	@Override
	public int first_insertSignFinishReport(SalesDTO salesDTO) {
		int signFinishReportRegCnt = this.sqlSession.insert("com.report.ware.SalesDAO.first_insertSignFinishReport",salesDTO);
		return signFinishReportRegCnt;
	}

	@Override
	public int first_insertSignFinishReport_Sign_emp(SalesDTO salesDTO) {
		int signFinishReport_Sign_empRegCnt = this.sqlSession.insert("com.report.ware.SalesDAO.first_insertSignFinishReport_Sign_emp",salesDTO);
		return signFinishReport_Sign_empRegCnt;
	}

	@Override
	public int first_insertReturnReport(SalesDTO salesDTO) {
		int returnReportRegCnt = this.sqlSession.insert("com.report.ware.SalesDAO.first_insertReturnReport",salesDTO);
		return returnReportRegCnt;
	}

	@Override
	public SalesDTO getSalesDTO(Map<String, String> paramsMap) {
		SalesDTO salesDTO = this.sqlSession.selectOne("com.report.ware.SalesDAO.getSalesDTO",paramsMap);
		return salesDTO;
	}

	@Override
	public List<Map<String, String>> getSignList(Map<String, String> paramsMap) {
		List<Map<String, String>> signList = this.sqlSession.selectList("com.report.ware.SalesDAO.getSignList", paramsMap);
		return signList;
	}

	@Override
	public int getMax_return_no(Map<String, String> paramsMap) {
		int max_return_no = this.sqlSession.selectOne("com.report.ware.SalesDAO.getMax_return_no", paramsMap);
		return max_return_no;
	}

	@Override
	public Map<String, String> pickNextEmployee(Map<String, String> paramsMap) {
		Map<String, String> pickNextEmp = this.sqlSession.selectOne("com.report.ware.SalesDAO.pickNextEmployee", paramsMap);
		return pickNextEmp;
	}
	
	// ---------------------------------
	// update 보고서 내용물
	@Override
	public int updateSalesReport_inside(SalesDTO salesDTO) {
		int updateSalesReport_inside = this.sqlSession.update("com.report.ware.SalesDAO.updateSalesReport_inside", salesDTO);
		return updateSalesReport_inside;
	}

	// SIGN_FINISH_REPORT 의  record_code = 1 , record_no = 지금 들어온 값 , emp_no == 결재누른사람emp_no 인 행 update 하기
	@Override
	public int updateSignFinishReport(SalesDTO salesDTO) {
		int updateSignFinishReport = this.sqlSession.update("com.report.ware.SalesDAO.updateSignFinishReport", salesDTO);
		return updateSignFinishReport;
	}

	// sign_finish_report에 그 다음 결재자 insert 하기
	@Override
	public int insertSignFinishReport(SalesDTO salesDTO) {
		int insertSignFinishReport = this.sqlSession.insert("com.report.ware.SalesDAO.insertSignFinishReport", salesDTO);
		return insertSignFinishReport;
	}

	// 내것 업데이트 4 , return_no ++ 
	@Override
	public int updateSignFinishReport_Boryu(SalesDTO salesDTO) {
		int updateSignFinishReport = this.sqlSession.update("com.report.ware.SalesDAO.updateSignFinishReport_Boryu", salesDTO);
		return updateSignFinishReport;
	}
	
	// Sales_report 테이블의 보고서 번호에 해당하는것 revice_cnt ++
	@Override
	public int updateSalesReport(SalesDTO salesDTO) {
		int updateSalesReport = this.sqlSession.update("com.report.ware.SalesDAO.updateSalesReport", salesDTO);
		System.out.println("updateSalesReport 성공");
		return updateSalesReport;
	}

	// 내 return_no 보다 1 작은것중에서 중복제거한 emp_no값 List로 리턴
	@Override
	public List<String> getReturn_emp_no(SalesDTO salesDTO) {
		System.out.println("getReturn_emp_no 시작전");
		List<String> return_emp_no = this.sqlSession.selectList("com.report.ware.SalesDAO.getReturn_emp_no", salesDTO);
		System.out.println("ewqeq");
		System.out.println(return_emp_no.get(0));
		return return_emp_no;
	}

	// return_emp_no[] 개수 만큼  다중 insert 문
	@Override
	public int insertSignFinishReport_many(SalesDTO salesDTO) {
		int insertSignFinishReport = this.sqlSession.insert("com.report.ware.SalesDAO.insertSignFinishReport_many", salesDTO);
		return insertSignFinishReport;
	}
	
	@Override
	public int insertSignFinishReport_many_finish(SalesDTO salesDTO) {
		int insertSignFinishReport = this.sqlSession.insert("com.report.ware.SalesDAO.insertSignFinishReport_many_finish", salesDTO);
		return insertSignFinishReport;
	}

	@Override
	public int insertReturnReport(SalesDTO salesDTO) {
		System.out.println("insertReturnReport 시작전");
		System.out.println(salesDTO.getReport_no());
		System.out.println(salesDTO.getLoginemp_no());
		System.out.println(salesDTO.getReturn_reason());
		int insertReturnReport = this.sqlSession.insert("com.report.ware.SalesDAO.insertReturnReport", salesDTO);
		System.out.println("insertReturnReport 성공");
		return insertReturnReport;
	}

	@Override
	public int updateNextSignFinishReport(SalesDTO salesDTO) {
		int updateNextSignFinishReport = this.sqlSession.update("com.report.ware.SalesDAO.updateNextSignFinishReport", salesDTO);
		return updateNextSignFinishReport;
	}
}
