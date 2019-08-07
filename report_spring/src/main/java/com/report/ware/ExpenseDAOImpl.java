package com.report.ware;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ExpenseDAOImpl implements ExpenseDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int first_insertExpenseReport(ExpenseDTO expenseDTO) {
		int expenseReportRegCnt = this.sqlSession.insert("com.report.ware.ExpenseDAO.first_insertExpenseReport", expenseDTO);
		return expenseReportRegCnt;
	}
	
	public int first_insertSignFinishReport(ExpenseDTO expenseDTO) {
		int signFinishReportRegCnt = this.sqlSession.insert("com.report.ware.ExpenseDAO.first_insertSignFinishReport",expenseDTO);
		return signFinishReportRegCnt;
	}
	
	public int first_insertSignFinishReport_Sign_emp(ExpenseDTO expenseDTO) {
		int signFinishReport_Sign_empRegCnt = this.sqlSession.insert("com.report.ware.ExpenseDAO.first_insertSignFinishReport_Sign_emp",expenseDTO);
		return signFinishReport_Sign_empRegCnt;
	}
	
	public int first_insertReturnReport(ExpenseDTO expenseDTO) {
		int returnReportRegCnt = this.sqlSession.insert("com.report.ware.ExpenseDAO.first_insertReturnReport",expenseDTO);
		return returnReportRegCnt;
	}
	
	public List<Map<String,String>> getExpenseList(ExpenseSearchDTO expenseSearchDTO){
		List<Map<String,String>> expenseList = sqlSession.selectList(
				"com.report.ware.ExpenseDAO.getExpenseList"	// 실행할 SQL 구문의 위치 지정
				,expenseSearchDTO							// 실행할 SQL 구문에서 사용할 데이터 지정
				);
		System.out.println(expenseSearchDTO.getSort());
		System.out.println(expenseSearchDTO.getAscDesc());
		return expenseList;
	}
	
	

	public int getExpenseListAllCnt(ExpenseSearchDTO expenseSearchDTO) {
		int expenseListCnt = sqlSession.selectOne(
				"com.report.ware.ExpenseDAO.getExpenseListAllCnt"	
				,expenseSearchDTO);
		return expenseListCnt;
	}

	@Override
	public List<Map<String, String>> getSuperiorList(String emp_no) {
		int abcd = Integer.parseInt(emp_no,10);
		List<Map<String, String>> superiorList = this.sqlSession.selectList("com.report.ware.ExpenseDAO.getSuperiorList", abcd);
		return superiorList;
	}
	
	// 하나의 지출보고서 가져오기
	public ExpenseDTO getExpenseDTO(Map<String,String> paramsMap) {
		ExpenseDTO expenseDTO = this.sqlSession.selectOne("com.report.ware.ExpenseDAO.getExpenseDTO",paramsMap);
		return expenseDTO;
	}

	@Override
	public List<Map<String, String>> getSignList(Map<String, String> paramsMap) {
		List<Map<String, String>> signList = this.sqlSession.selectList("com.report.ware.ExpenseDAO.getSignList", paramsMap);
		return signList;
	}

	@Override
	public int getMax_return_no(Map<String, String> paramsMap) {
		int max_return_no = this.sqlSession.selectOne("com.report.ware.ExpenseDAO.getMax_return_no", paramsMap);
		return max_return_no;
	}
	// ---------------------------------
	// update 보고서 내용물
	@Override
	public int updateExpenseReport_inside(ExpenseDTO expenseDTO) {
		int updateExpenseReport_inside = this.sqlSession.update("com.report.ware.ExpenseDAO.updateExpenseReport_inside", expenseDTO);
		return updateExpenseReport_inside;
	}

	// SIGN_FINISH_REPORT 의  record_code = 1 , record_no = 지금 들어온 값 , emp_no == 결재누른사람emp_no 인 행 update 하기
	@Override
	public int updateSignFinishReport(ExpenseDTO expenseDTO) {
		int updateSignFinishReport = this.sqlSession.update("com.report.ware.ExpenseDAO.updateSignFinishReport", expenseDTO);
		return updateSignFinishReport;
	}

	// sign_finish_report에 그 다음 결재자 insert 하기
	@Override
	public int insertSignFinishReport(ExpenseDTO expenseDTO) {
		int insertSignFinishReport = this.sqlSession.insert("com.report.ware.ExpenseDAO.insertSignFinishReport", expenseDTO);
		return insertSignFinishReport;
	}

	// 내것 업데이트 4 , return_no ++ 
	@Override
	public int updateSignFinishReport_Boryu(ExpenseDTO expenseDTO) {
		System.out.println(expenseDTO.getReport_no());
		System.out.println(expenseDTO.getLoginemp_no());
		int updateSignFinishReport = this.sqlSession.update("com.report.ware.ExpenseDAO.updateSignFinishReport_Boryu", expenseDTO);
		return updateSignFinishReport;
	}
	
	// Expense_report 테이블의 보고서 번호에 해당하는것 revice_cnt ++
	@Override
	public int updateExpenseReport(ExpenseDTO expenseDTO) {
		int updateExpenseReport = this.sqlSession.update("com.report.ware.ExpenseDAO.updateExpenseReport", expenseDTO);
		System.out.println("updateExpenseReport 성공");
		return updateExpenseReport;
	}

	// 내 return_no 보다 1 작은것중에서 중복제거한 emp_no값 List로 리턴
	@Override
	public List<String> getReturn_emp_no(ExpenseDTO expenseDTO) {
		System.out.println("getReturn_emp_no 시작전");
		List<String> return_emp_no = this.sqlSession.selectList("com.report.ware.ExpenseDAO.getReturn_emp_no", expenseDTO);
		System.out.println("ewqeq");
		System.out.println(return_emp_no.get(0));
		return return_emp_no;
	}

	// return_emp_no[] 개수 만큼  다중 insert 문
	@Override
	public int insertSignFinishReport_many(ExpenseDTO expenseDTO) {
		int insertSignFinishReport = this.sqlSession.insert("com.report.ware.ExpenseDAO.insertSignFinishReport_many", expenseDTO);
		return insertSignFinishReport;
	}
	
	@Override
	public int insertSignFinishReport_many_finish(ExpenseDTO expenseDTO) {
		int insertSignFinishReport = this.sqlSession.insert("com.report.ware.ExpenseDAO.insertSignFinishReport_many_finish", expenseDTO);
		return insertSignFinishReport;
	}

	@Override
	public int insertReturnReport(ExpenseDTO expenseDTO) {
		System.out.println("insertReturnReport 시작전");
		System.out.println(expenseDTO.getReport_no());
		System.out.println(expenseDTO.getLoginemp_no());
		System.out.println(expenseDTO.getReturn_reason());
		int insertReturnReport = this.sqlSession.insert("com.report.ware.ExpenseDAO.insertReturnReport", expenseDTO);
		System.out.println("insertReturnReport 성공");
		return insertReturnReport;
	}

	@Override
	public int updateNextSignFinishReport(ExpenseDTO expenseDTO) {
		int updateNextSignFinishReport = this.sqlSession.update("com.report.ware.ExpenseDAO.updateNextSignFinishReport", expenseDTO);
		return updateNextSignFinishReport;
	}


	@Override
	public Map<String, String> pickNextEmployee(Map<String,String> paramsMap) {
		Map<String, String> pickNextEmp = this.sqlSession.selectOne("com.report.ware.ExpenseDAO.pickNextEmployee", paramsMap);
		return pickNextEmp;
	}

}
