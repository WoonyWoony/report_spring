package com.report.ware;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class SalesServiceImpl implements SalesService {

	@Autowired
	private SalesDAO salesDAO;

	@Override
	public int getSalesListAllCnt(SalesSearchDTO salesSearchDTO) {
		int salesListAllCnt = this.salesDAO.getSalesListAllCnt(salesSearchDTO);
		return salesListAllCnt;
	}

	@Override
	public List<Map<String, String>> getSalesList(SalesSearchDTO salesSearchDTO) {
		List<Map<String, String>> salesList = this.salesDAO.getSalesList(salesSearchDTO);
		return salesList;
	}

	@Override
	public int first_insertSalesReport(SalesDTO salesDTO) {
		int salesReportRegCnt = this.salesDAO.first_insertSalesReport(salesDTO);
		int signFinishReportRegCnt = this.salesDAO.first_insertSignFinishReport(salesDTO);
		if (salesDTO.getSign_state().equals("1")) {
			int signFinishReport_Sign_empRegCnt = this.salesDAO.first_insertSignFinishReport_Sign_emp(salesDTO);
		}
		if (salesDTO.getSign_state().equals("4")) {
			int returnReportRegCnt = this.salesDAO.first_insertReturnReport(salesDTO);
		}
		return salesReportRegCnt;
	}

	@Override
	public SalesDTO getSalesDTO(Map<String, String> paramsMap) {
		SalesDTO salesDTO = this.salesDAO.getSalesDTO(paramsMap);
		return salesDTO;
	}

	@Override
	public List<Map<String, String>> getSignList(Map<String, String> paramsMap) {
		List<Map<String, String>> signList = this.salesDAO.getSignList(paramsMap);
		return signList;
	}

	@Override
	public int getMax_return_no(Map<String, String> paramsMap) {
		int max_return_no = this.salesDAO.getMax_return_no(paramsMap);
		return max_return_no;
	}

	@Override
	public Map<String, String> pickNextEmployee(Map<String, String> paramsMap) {
		Map<String, String> pickNextEmp = this.salesDAO.pickNextEmployee(paramsMap);
		return pickNextEmp;
	}

	@Override
	public int signSalesReport(SalesDTO salesDTO) {
		// 결재를 선택했을때
		int updateSignFinishReport = 0;
		if (salesDTO.getSign_state().equals("1")) {
			// 반려상태 보고서
			if (salesDTO.getSign_name().equals("4")) {
				System.out.println("반려였던 보고서");
				// update 보고서 내용;
				int updateSalesReport_inside = this.salesDAO.updateSalesReport_inside(salesDTO);
				// updateSignFinishReport의 내 sign_code = 1로 변경;
				updateSignFinishReport = this.salesDAO.updateSignFinishReport(salesDTO);
				// updateNextSignFinishReport 다음 사람;
				int updateNextSignFinishReport = this.salesDAO.updateNextSignFinishReport(salesDTO);
			}
			// 반려상태 아닌
			else {
				if(salesDTO.getEmp_no().equals(salesDTO.getLoginemp_no())) {
					System.out.println("들어옴");
					Map<String,String> paramsMap = new HashMap<String, String>();
					paramsMap.put("loginemp_no", salesDTO.getLoginemp_no());
					paramsMap.put("report_no", salesDTO.getReport_no());
					Map<String, String> pickNextEmployee = this.salesDAO.pickNextEmployee(paramsMap);
					String checkNextSign_Code = pickNextEmployee.get("SIGN_NAME");
					if(!checkNextSign_Code.equals("3")) {
						return -10;
					}
				}
				System.out.println("반려아닌 보고서");
				// 다음 결재자가 있으면
				if (salesDTO.getNoNextSigner() == null || salesDTO.getNoNextSigner().length() == 0) {
					if (salesDTO.getIs_update().equals("true")) {
						int updateSalesReport_inside = this.salesDAO.updateSalesReport_inside(salesDTO);
					}
					// SIGN_FINISH_REPORT 의 record_code = 1 , record_no = 지금 들어온 값 , emp_no ==
					// 결재누른사람emp_no 인 행 결재로 update 하기
					updateSignFinishReport = this.salesDAO.updateSignFinishReport(salesDTO);
					// sign_finish_report에 그 다음 결재자 insert 하기
					Map<String, String> pickNextEmp = salesDTO.getPickNextEmp();
					System.out.println("pick 후");
					System.out.println(salesDTO.getPickNextEmp());
					// 기존에 반려였다가 다시 나에게 온 보고서면 update
					if (pickNextEmp != null && pickNextEmp.get("EMP_NO").length() > 0) {
						int updateNextSignFinishReport = this.salesDAO.updateNextSignFinishReport(salesDTO);
					}
					// 처음으로 내게 온 보고서면 insert
					else {
						int insertSignFinishReport = this.salesDAO.insertSignFinishReport(salesDTO);
					}
				}
				// 다음 결재자가 없으면
				else {
					System.out.println("육");
					// sign_state를 결재완료로 변경후 update
					salesDTO.setSign_state("2");
					// 내것 업데이트 2 , return_no ++
					updateSignFinishReport = this.salesDAO.updateSignFinishReport_Boryu(salesDTO);
					System.out.println("칠");
					// Sales_report 테이블의 보고서 번호에 해당하는것 revice_cnt ++
					int updateSalesReport = this.salesDAO.updateSalesReport(salesDTO);
					System.out.println("팔");
					// 내 return_no 보다 1 작은것중에서 중복제거한 emp_no값 List로 리턴
					List<String> return_emp_no = this.salesDAO.getReturn_emp_no(salesDTO);
					String[] a = new String[return_emp_no.size()];
					for (int i = 0; i < return_emp_no.size(); i++) {
						a[i] = return_emp_no.get(i);
					}
					salesDTO.setReturn_emp_no(a);
					int insertSignFinishReport = this.salesDAO.insertSignFinishReport_many_finish(salesDTO); // 다중
																													// insert
																													// 문
				}
			}
		}
		// 반려를 선택했을때
		if (salesDTO.getSign_state().equals("4")) {
			// 내것 업데이트 4 , return_no ++
			updateSignFinishReport = this.salesDAO.updateSignFinishReport_Boryu(salesDTO);
			int insertReturnReport = this.salesDAO.insertReturnReport(salesDTO);
			// Sales_report 테이블의 보고서 번호에 해당하는것 revice_cnt ++
			int updateSalesReport = this.salesDAO.updateSalesReport(salesDTO);
			// 내 return_no 보다 1 작은것중에서 중복제거한 emp_no값 List로 리턴
			List<String> return_emp_no = this.salesDAO.getReturn_emp_no(salesDTO);
			String[] a = new String[return_emp_no.size()];
			for (int i = 0; i < return_emp_no.size(); i++) {
				a[i] = return_emp_no.get(i);
			}
			salesDTO.setReturn_emp_no(a);
			int insertSignFinishReport = this.salesDAO.insertSignFinishReport_many(salesDTO); // 다중 insert 문
		}
		return updateSignFinishReport;
	}

}
