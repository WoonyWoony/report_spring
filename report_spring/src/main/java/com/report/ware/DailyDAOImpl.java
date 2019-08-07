package com.report.ware;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class DailyDAOImpl implements DailyDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int first_insertDailyReport(DailyBusiDTO dailyBusiDTO) {
		int dailyReportRegCnt = this.sqlSession.insert("com.report.ware.DailyDAO.first_insertDailyReport", dailyBusiDTO);
		return dailyReportRegCnt;
	}
	
	public int first_insertSignFinishReport(DailyBusiDTO dailyBusiDTO) {
		int signFinishReportRegCnt = this.sqlSession.insert("com.report.ware.DailyDAO.first_insertSignFinishReport",dailyBusiDTO);
		return signFinishReportRegCnt;
	}
	
	public int first_insertSignFinishReport_Sign_emp(DailyBusiDTO dailyBusiDTO) {
		int signFinishReport_Sign_empRegCnt = this.sqlSession.insert("com.report.ware.DailyDAO.first_insertSignFinishReport_Sign_emp",dailyBusiDTO);
		return signFinishReport_Sign_empRegCnt;
	}
	
	public int first_insertReturnReport(DailyBusiDTO dailyBusiDTO) {
		int returnReportRegCnt = this.sqlSession.insert("com.report.ware.DailyDAO.first_insertReturnReport",dailyBusiDTO);
		return returnReportRegCnt;
	}
	
	public List<Map<String,String>> getDailyList(DailyBusiSearchDTO dailyBusiSearchDTO){
		List<Map<String,String>> dailyList = sqlSession.selectList(
				"com.report.ware.DailyDAO.getDailyList"	// 실행할 SQL 구문의 위치 지정
				,dailyBusiSearchDTO							// 실행할 SQL 구문에서 사용할 데이터 지정
				);
		return dailyList;
	}
	
	

	public int getDailyListAllCnt(DailyBusiSearchDTO dailyBusiSearchDTO) {
		int dailyListCnt = sqlSession.selectOne(
				"com.report.ware.DailyDAO.getDailyListAllCnt"	
				,dailyBusiSearchDTO);
		return dailyListCnt;
	}

	@Override
	public List<Map<String, String>> getSuperiorList(String emp_no) {
		int abcd = Integer.parseInt(emp_no,10);
		List<Map<String, String>> superiorList = this.sqlSession.selectList("com.report.ware.ExpenseDAO.getSuperiorList", abcd);
		return superiorList;
	}
	
	// 하나의 지출보고서 가져오기
	public DailyBusiDTO getDailyDTO(Map<String,String> paramsMap) {
		DailyBusiDTO dailyDTO = this.sqlSession.selectOne("com.report.ware.DailyDAO.getDailyDTO",paramsMap);
		return dailyDTO;
	}

	@Override
	public List<Map<String, String>> getSignList(Map<String, String> paramsMap) {
		List<Map<String, String>> signList = this.sqlSession.selectList("com.report.ware.DailyDAO.getSignList", paramsMap);
		return signList;
	}

	@Override
	public int getMax_return_no(Map<String, String> paramsMap) {
		int max_return_no = this.sqlSession.selectOne("com.report.ware.DailyDAO.getMax_return_no", paramsMap);
		return max_return_no;
	}
	// ---------------------------------
	// update 보고서 내용물
	@Override
	public int updateDailyReport_inside(DailyBusiDTO dailyBusiDTO) {
		int updateExpenseReport_inside = this.sqlSession.update("com.report.ware.DailyDAO.updateDailyReport_inside", dailyBusiDTO);
		return updateExpenseReport_inside;
	}

	// SIGN_FINISH_REPORT 의  record_code = 1 , record_no = 지금 들어온 값 , emp_no == 결재누른사람emp_no 인 행 update 하기
	@Override
	public int updateSignFinishReport(DailyBusiDTO dailyBusiDTO) {
		int updateSignFinishReport = this.sqlSession.update("com.report.ware.DailyDAO.updateSignFinishReport", dailyBusiDTO);
		return updateSignFinishReport;
	}

	// sign_finish_report에 그 다음 결재자 insert 하기
	@Override
	public int insertSignFinishReport(DailyBusiDTO dailyBusiDTO) {
		int insertSignFinishReport = this.sqlSession.insert("com.report.ware.DailyDAO.insertSignFinishReport", dailyBusiDTO);
		return insertSignFinishReport;
	}

	// 내것 업데이트 4 , return_no ++ 
	@Override
	public int updateSignFinishReport_Boryu(DailyBusiDTO dailyBusiDTO) {
		System.out.println(dailyBusiDTO.getReport_no());
		System.out.println(dailyBusiDTO.getLoginemp_no());
		int updateSignFinishReport = this.sqlSession.update("com.report.ware.DailyDAO.updateSignFinishReport_Boryu", dailyBusiDTO);
		return updateSignFinishReport;
	}
	
	// Expense_report 테이블의 보고서 번호에 해당하는것 revice_cnt ++
	@Override
	public int updateDailyReport(DailyBusiDTO dailyBusiDTO) {
		int updateExpenseReport = this.sqlSession.update("com.report.ware.DailyDAO.updateDailyReport", dailyBusiDTO);
		System.out.println("updateExpenseReport 성공");
		return updateExpenseReport;
	}

	// 내 return_no 보다 1 작은것중에서 중복제거한 emp_no값 List로 리턴
	@Override
	public List<String> getReturn_emp_no(DailyBusiDTO dailyBusiDTO) {
		System.out.println("getReturn_emp_no 시작전");
		List<String> return_emp_no = this.sqlSession.selectList("com.report.ware.DailyDAO.getReturn_emp_no", dailyBusiDTO);
		System.out.println("ewqeq");
		System.out.println(return_emp_no.get(0));
		return return_emp_no;
	}

	// return_emp_no[] 개수 만큼  다중 insert 문
	@Override
	public int insertSignFinishReport_many(DailyBusiDTO dailyBusiDTO) {
		int insertSignFinishReport = this.sqlSession.insert("com.report.ware.DailyDAO.insertSignFinishReport_many", dailyBusiDTO);
		return insertSignFinishReport;
	}
	
	@Override
	public int insertSignFinishReport_many_finish(DailyBusiDTO dailyBusiDTO) {
		int insertSignFinishReport = this.sqlSession.insert("com.report.ware.DailyDAO.insertSignFinishReport_many_finish", dailyBusiDTO);
		return insertSignFinishReport;
	}

	@Override
	public int insertReturnReport(DailyBusiDTO dailyBusiDTO) {
		System.out.println("insertReturnReport 시작전");
		System.out.println(dailyBusiDTO.getReport_no());
		System.out.println(dailyBusiDTO.getLoginemp_no());
		System.out.println(dailyBusiDTO.getReturn_reason());
		int insertReturnReport = this.sqlSession.insert("com.report.ware.DailyDAO.insertReturnReport", dailyBusiDTO);
		System.out.println("insertReturnReport 성공");
		return insertReturnReport;
	}

	@Override
	public int updateNextSignFinishReport(DailyBusiDTO dailyBusiDTO) {
		int updateNextSignFinishReport = this.sqlSession.update("com.report.ware.DailyDAO.updateNextSignFinishReport", dailyBusiDTO);
		return updateNextSignFinishReport;
	}


	@Override
	public Map<String, String> pickNextEmployee(Map<String,String> paramsMap) {
		Map<String, String> pickNextEmp = this.sqlSession.selectOne("com.report.ware.DailyDAO.pickNextEmployee", paramsMap);
		return pickNextEmp;
	}

}
