package com.report.ware;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class SalesController {
	@Autowired
	private SalesService salesService;

	@Autowired
	private ExpenseService expenseService; // 상사 직원 목록 가져올때 사용

	@RequestMapping(value = "/salesListForm.do")
	public ModelAndView salesListForm(HttpSession session, SalesSearchDTO salesSearchDTO) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("salesListForm.jsp");
		try {
			String uri = (String) session.getAttribute("uri");
			if (uri == null || uri.equals("dashboard") || uri.equals("boardListForm") || uri.equals("dailyList")
					|| uri.equals("expenseList") || uri.equals("salesList") || uri.equals("employeeListForm")
					|| uri.equals("employeeRegForm") || uri.equals("employeeUpDelForm")
					|| uri.equals("employeeListForm_beforeAllow")) {
				session.setAttribute("salesSearchDTO", salesSearchDTO);
			} else {
				salesSearchDTO = (SalesSearchDTO) session.getAttribute("salesSearchDTO");
			}
			session.setAttribute("uri", "salesList");

			// =========================================================================

			// <1> 만약 매개변수의 BoardSearchDTO 객체의 속성변수 selectPageNo 에 0 이
			// 저장되어 있으면 1로 대체 저장하기
			// <2> 만약 매개변수의 BoardSearchDTO 객체의 속성변수 rowCntPerPage 에 0 이
			// 저장되어 있으면 10로 대체 저장하기
			// ------------------------
			// 속성변수 selectPageNo, rowCntPerPage 는 select 구문으로 DB 연동시 가져올 행의
			// 범위에 사용되는 중요한 데이터이므로 기본값으로 1과 10을 세팅한다.
			if (salesSearchDTO.getSelectPageNo() == null || salesSearchDTO.getSelectPageNo().length() == 0) { // <1>
				salesSearchDTO.setSelectPageNo("1");
			}
			if (salesSearchDTO.getRowCntPerPage() == null || salesSearchDTO.getRowCntPerPage().length() == 0) { // <2>
				salesSearchDTO.setRowCntPerPage("10");
			}

			// =========================================================================

			if (salesSearchDTO.getSign_year_min() != null && salesSearchDTO.getSign_year_min().length() > 0) {
				salesSearchDTO.setSign_date_min(salesSearchDTO.getSign_year_min() + salesSearchDTO.getSign_month_min());
			}
			if (salesSearchDTO.getSign_year_max() != null && salesSearchDTO.getSign_year_max().length() > 0) {
				salesSearchDTO.setSign_date_max(salesSearchDTO.getSign_year_max() + salesSearchDTO.getSign_month_max());
			}

			if (salesSearchDTO.getSales_year_min() != null && salesSearchDTO.getSales_year_min().length() > 0) {
				salesSearchDTO
						.setSales_date_min(salesSearchDTO.getSales_year_min() + salesSearchDTO.getSales_month_min());
			}
			if (salesSearchDTO.getSales_year_max() != null && salesSearchDTO.getSales_year_max().length() > 0) {
				salesSearchDTO
						.setSales_date_max(salesSearchDTO.getSales_year_max() + salesSearchDTO.getSales_month_max());
			}

			salesSearchDTO.setEmp_no((String) session.getAttribute("emp_no"));
			System.out.println(salesSearchDTO.getEmp_no());

			int salesListAllCnt = this.salesService.getSalesListAllCnt(salesSearchDTO);
			System.out.println(salesListAllCnt);

			// --------------------------
			// [선택된 페이지 번호]에 [시작행 번호] 얻기
			// --------------------------
			int beginRowNo = Integer.parseInt(salesSearchDTO.getSelectPageNo(), 10)
					* Integer.parseInt(salesSearchDTO.getRowCntPerPage(), 10)
					- Integer.parseInt(salesSearchDTO.getRowCntPerPage(), 10) + 1;
			// --------------------------
			// [선택된 페이지 번호]와 [총 검색 개수]와의 관계가 비합리적이면
			// [선택된 페이지 번호]를 1로 하고 검색 행의 [시작행 번호]를 1로 하기
			// --------------------------
			if (salesListAllCnt < beginRowNo) {
				salesSearchDTO.setSelectPageNo("1");
			}

			List<Map<String, String>> salesList = this.salesService.getSalesList(salesSearchDTO);
			for (int x = 0; x < salesList.size(); x++) {
				Map<String, String> beforeSignMap = salesList.get(x);
				if (beforeSignMap.get("SIGN_DATE2") != null) {
					SimpleDateFormat y = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
					Date y1 = y.parse(beforeSignMap.get("SYSDATE2").substring(0, 8));
					Date y2 = y.parse(beforeSignMap.get("SIGN_DATE2").substring(0, 8));
					long yiff = y1.getTime() - y2.getTime();
					long date = yiff / (24 * 60 * 60 * 1000);
					SimpleDateFormat f = new SimpleDateFormat("HH:mm", Locale.KOREA);
					Date d1 = f.parse(beforeSignMap.get("SYSDATE2").substring(9, 14));
					Date d2 = f.parse(beforeSignMap.get("SIGN_DATE2").substring(9, 14));
					long diff = d1.getTime() - d2.getTime();
					long sec = diff / (1000 * 60);
					if (date == 0) {
						int hour = Integer.parseInt(beforeSignMap.get("SYSDATE2").substring(9, 11))
								- Integer.parseInt(beforeSignMap.get("SIGN_DATE2").substring(9, 11));
						if (sec < 60) {
							hour = Integer.parseInt(beforeSignMap.get("SYSDATE2").substring(12, 14))
									- Integer.parseInt(beforeSignMap.get("SIGN_DATE2").substring(12, 14));
							beforeSignMap.put("SIGN_DATE", sec + "분 전");
						} else {
							beforeSignMap.put("SIGN_DATE", hour + "시간 전");
						}
					}
				}
			}
			mav.addObject("salesListAllCnt", salesListAllCnt);
			mav.addObject("salesList", salesList);
			mav.addObject("scrollValue", salesSearchDTO.getScrollValue());
			session.setAttribute("salesList", salesList);

		} catch (Exception e) {
			System.out.println(e);
			System.out.println("SalesController.getSalesList(~)에서 에러발생");
		}
		return mav;
	}

	@RequestMapping(value = "/salesRegForm.do")
	public ModelAndView goSalesRegForm(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("salesRegForm.jsp");
		try {
			String emp_no = (String) session.getAttribute("emp_no");
			List<Map<String, String>> superiorList = this.expenseService.getSuperiorList(emp_no);
			System.out.println("superiorList 성공");
			mav.addObject("superiorList", superiorList);
		} catch (Exception e) {
			System.out.println("SalesController.goSalesRegForm(~)에서 에러발생");
		}
		return mav;
	}

	@RequestMapping(value = "/salesRegProc.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public int insertSalesReport(HttpSession session, SalesDTO salesDTO) {
		int salesReportRegCnt = 0;
		StringBuffer sales_date_start = new StringBuffer();
		StringBuffer sales_date_end = new StringBuffer();
		try {
			System.out.println("들어옴");
			sales_date_start.append(salesDTO.getSales_year_start());
			sales_date_start.append(salesDTO.getSales_month_start());
			sales_date_start.append(salesDTO.getSales_day_start());
			sales_date_start.append(salesDTO.getSales_hour_start());
			sales_date_start.append(salesDTO.getSales_minute_start());
			salesDTO.setSales_date_start(sales_date_start.toString());
			System.out.println("setSales_date_start 성공");
			System.out.println(salesDTO.getSales_date_start());

			sales_date_end.append(salesDTO.getSales_year_end());
			sales_date_end.append(salesDTO.getSales_month_end());
			sales_date_end.append(salesDTO.getSales_day_end());
			sales_date_end.append(salesDTO.getSales_hour_end());
			sales_date_end.append(salesDTO.getSales_minute_end());
			salesDTO.setSales_date_end(sales_date_end.toString());
			System.out.println("setSales_date_end 성공");
			System.out.println(salesDTO.getSales_date_end());

			salesReportRegCnt = this.salesService.first_insertSalesReport(salesDTO);
		} catch (Exception e) {
			System.out.println("SalesController.insertSalesReport(~) 에서 에러발생");
			salesReportRegCnt = -1;
		}
		return salesReportRegCnt;
	}

	@RequestMapping(value = "/salesUpdelForm.do")
	public ModelAndView gosalesUpdelForm(HttpSession session, @RequestParam Map<String, String> paramsMap) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("salesUpdelForm.jsp");
		try {
			SalesDTO salesDTO = this.salesService.getSalesDTO(paramsMap);
			List<Map<String, String>> superiorList = this.expenseService.getSuperiorList(paramsMap.get("emp_no"));
			System.out.println("superiorList 성공");

			List<Map<String, String>> signList = this.salesService.getSignList(paramsMap);

			int max_return_no = this.salesService.getMax_return_no(paramsMap);

			Map<String, String> pickNextEmp = this.salesService.pickNextEmployee(paramsMap);

			session.setAttribute("pickNextEmp", pickNextEmp);

			mav.addObject("superiorList", superiorList);
			mav.addObject("salesDTO", salesDTO);
			mav.addObject("signList", signList);
			mav.addObject("max_return_no", max_return_no);
			mav.addObject("pickNextEmp", pickNextEmp);

		} catch (Exception e) {
			System.out.println("SalesController.gosalesUpdelForm(~)에서 에러발생");
		}
		return mav;
	}

	@RequestMapping(value = "/salesUpdelProc.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public int signSalesReport(HttpSession session, SalesDTO salesDTO) {
		int signSignReportCnt = 0;
		try {
			salesDTO.setLoginemp_no((String) session.getAttribute("emp_no"));
			salesDTO.setPickNextEmp((Map<String, String>) session.getAttribute("pickNextEmp"));

			StringBuffer sales_date_start = new StringBuffer();
			StringBuffer sales_date_end = new StringBuffer();

			sales_date_start.append(salesDTO.getSales_year_start());
			sales_date_start.append(salesDTO.getSales_month_start());
			sales_date_start.append(salesDTO.getSales_day_start());
			sales_date_start.append(salesDTO.getSales_hour_start());
			sales_date_start.append(salesDTO.getSales_minute_start());
			salesDTO.setSales_date_start(sales_date_start.toString());

			sales_date_end.append(salesDTO.getSales_year_end());
			sales_date_end.append(salesDTO.getSales_month_end());
			sales_date_end.append(salesDTO.getSales_day_end());
			sales_date_end.append(salesDTO.getSales_hour_end());
			sales_date_end.append(salesDTO.getSales_minute_end());
			salesDTO.setSales_date_end(sales_date_end.toString());

			signSignReportCnt = this.salesService.signSalesReport(salesDTO);
		} catch (Exception e) {
			System.out.println("SalesController.signSalesReport(~) 에서 에러발생");
			signSignReportCnt = -1;
		}
		return signSignReportCnt;
	}

}
