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
public class ExpenseController {

	@Autowired
	private ExpenseService expenseService;

	@RequestMapping(value = "/expenseListForm.do")
	public ModelAndView goexpenseListForm(HttpSession session,ExpenseSearchDTO expenseSearchDTO) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("expenseListForm.jsp");
		try {

			String uri = (String)session.getAttribute("uri");				
			if(uri == null || uri.equals("dashboard") || uri.equals("boardListForm") || uri.equals("dailyList") || uri.equals("expenseList") || uri.equals("salesList") || uri.equals("employeeListForm") || uri.equals("employeeRegForm") || uri.equals("employeeUpDelForm") || uri.equals("employeeListForm_beforeAllow")) {					
				session.setAttribute("expenseSearchDTO", expenseSearchDTO);
			}else {															
				expenseSearchDTO = (ExpenseSearchDTO)session.getAttribute("expenseSearchDTO");
			}
			session.setAttribute("uri", "expenseList");	
			
			//=========================================================================
			
			// <1> 만약 매개변수의 BoardSearchDTO 객체의 속성변수 selectPageNo 에 0 이
			//	   저장되어 있으면 1로 대체 저장하기
			// <2> 만약 매개변수의 BoardSearchDTO 객체의 속성변수 rowCntPerPage 에 0 이
			//	   저장되어 있으면 10로 대체 저장하기
			//------------------------
			// 속성변수 selectPageNo, rowCntPerPage 는 select 구문으로 DB 연동시 가져올 행의
			// 범위에 사용되는 중요한 데이터이므로 기본값으로 1과 10을 세팅한다.
			if(expenseSearchDTO.getSelectPageNo()== null || expenseSearchDTO.getSelectPageNo().length() == 0) {		// <1>
				expenseSearchDTO.setSelectPageNo("1");
			}
			if(expenseSearchDTO.getRowCntPerPage() == null || expenseSearchDTO.getRowCntPerPage().length() == 0) {		// <2>
				expenseSearchDTO.setRowCntPerPage("10");
			}
			
			//=========================================================================
			
			if(expenseSearchDTO.getSign_year_min() != null && expenseSearchDTO.getSign_year_min().length() > 0) {
				expenseSearchDTO.setSign_date_min(expenseSearchDTO.getSign_year_min()+expenseSearchDTO.getSign_month_min());
			}
			if(expenseSearchDTO.getSign_year_max() != null && expenseSearchDTO.getSign_year_max().length() > 0) {
				expenseSearchDTO.setSign_date_max(expenseSearchDTO.getSign_year_max()+expenseSearchDTO.getSign_month_max());
			}

			if(expenseSearchDTO.getExpense_year_min() != null && expenseSearchDTO.getExpense_year_min().length() > 0) {
				expenseSearchDTO.setExpense_date_min(expenseSearchDTO.getExpense_year_min()+expenseSearchDTO.getExpense_month_min());
			}
			if(expenseSearchDTO.getExpense_year_max() != null && expenseSearchDTO.getExpense_year_max().length() > 0) {
				expenseSearchDTO.setExpense_date_max(expenseSearchDTO.getExpense_year_max()+expenseSearchDTO.getExpense_month_max());
			}
			
			
			expenseSearchDTO.setEmp_no((String)session.getAttribute("emp_no"));
			System.out.println(expenseSearchDTO.getEmp_no());
			
			int expenseListAllCnt = this.expenseService.getExpenseListAllCnt(expenseSearchDTO);
			System.out.println(expenseListAllCnt);
			

			//--------------------------
			// [선택된 페이지 번호]에 [시작행 번호] 얻기
			//--------------------------
			int beginRowNo = Integer.parseInt(expenseSearchDTO.getSelectPageNo(),10) * Integer.parseInt(expenseSearchDTO.getRowCntPerPage(),10)
						     - Integer.parseInt(expenseSearchDTO.getRowCntPerPage(),10) + 1;
			//--------------------------
			// [선택된 페이지 번호]와 [총 검색 개수]와의 관계가 비합리적이면
			// [선택된 페이지 번호]를 1로 하고 검색 행의 [시작행 번호]를 1로 하기
			//--------------------------
			if(expenseListAllCnt<beginRowNo) {
				expenseSearchDTO.setSelectPageNo("1");
			}
			
			
			List<Map<String,String>> expenseList = this.expenseService.getExpenseList(expenseSearchDTO);
			for (int x = 0; x < expenseList.size(); x++) {
				Map<String, String> beforeSignMap = expenseList.get(x);
				if(beforeSignMap.get("SIGN_DATE2") != null) {
					SimpleDateFormat y = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
					Date y1 = y.parse(beforeSignMap.get("SYSDATE2").substring(0, 8));
					Date y2 = y.parse(beforeSignMap.get("SIGN_DATE2").substring(0, 8));
					long yiff = y1.getTime() - y2.getTime();
					long date = yiff / (24*60*60*1000);
					SimpleDateFormat f = new SimpleDateFormat("HH:mm", Locale.KOREA);
			        Date d1 = f.parse(beforeSignMap.get("SYSDATE2").substring(9, 14));
					Date d2 = f.parse(beforeSignMap.get("SIGN_DATE2").substring(9, 14));
					long diff = d1.getTime() - d2.getTime();
					long sec = diff / (1000*60);
					if(date == 0) {
						int hour = Integer.parseInt(beforeSignMap.get("SYSDATE2").substring(9, 11)) - Integer.parseInt(beforeSignMap.get("SIGN_DATE2").substring(9, 11));
						if (sec < 60) {
							hour = Integer.parseInt(beforeSignMap.get("SYSDATE2").substring(12, 14)) - Integer.parseInt(beforeSignMap.get("SIGN_DATE2").substring(12, 14));
							beforeSignMap.put("SIGN_DATE", sec + "분 전");
						} else {
							beforeSignMap.put("SIGN_DATE", hour + "시간 전");
						}
					}
				}
			}
			mav.addObject("expenseListAllCnt",expenseListAllCnt);
			mav.addObject("expenseList",expenseList);
			mav.addObject("scrollValue",expenseSearchDTO.getScrollValue());
			session.setAttribute("expenseList",expenseList);

		} catch(Exception e) {
			System.out.println(e);
			System.out.println("ExpenseController.getExpenseList(~)에서 에러발생");
		}
		return mav;
	}

	@RequestMapping(value = "/expenseRegForm.do")
	public ModelAndView goexpenseRegForm(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("expenseRegForm.jsp");
		try {
			String emp_no = (String) session.getAttribute("emp_no");
			List<Map<String, String>> superiorList = this.expenseService.getSuperiorList(emp_no);
			System.out.println("superiorList 성공");
			mav.addObject("superiorList", superiorList);
		} catch (Exception e) {
			System.out.println("ExpenseController.goexpenseRegForm(~)에서 에러발생");
		}
		return mav;
	}

	@RequestMapping(value = "/expenseRegProc.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public int insertExpenseReport(HttpSession session, ExpenseDTO expenseDTO) {
		int expenseReportRegCnt = 0;
		try {
			StringBuffer expense_date = new StringBuffer();
			expense_date.append(expenseDTO.getExpense_year());
			expense_date.append(expenseDTO.getExpense_month());
			expense_date.append(expenseDTO.getExpense_day());
			expenseDTO.setExpense_date(expense_date.toString());

			expenseReportRegCnt = this.expenseService.first_insertExpenseReport(expenseDTO);
		} catch (Exception e) {
			System.out.println("ExpenseController.insertExpenseReport(~) 에서 에러발생");
			expenseReportRegCnt = -1;
		}
		return expenseReportRegCnt;
	}
	
	@RequestMapping(value = "/expenseUpdelForm.do")
	public ModelAndView goexpenseUpdelForm(HttpSession session, @RequestParam Map<String, String> paramsMap){
		ModelAndView mav = new ModelAndView();
		mav.setViewName("expenseUpdelForm.jsp");
		try {
			ExpenseDTO expenseDTO = this.expenseService.getExpenseDTO(paramsMap);
			List<Map<String, String>> superiorList = this.expenseService.getSuperiorList(paramsMap.get("emp_no"));
			System.out.println("superiorList 성공");
			
			List<Map<String, String>> signList = this.expenseService.getSignList(paramsMap);
			
			int max_return_no = this.expenseService.getMax_return_no(paramsMap);
			
			Map<String,String> pickNextEmp = this.expenseService.pickNextEmployee(paramsMap);
			
			session.setAttribute("pickNextEmp", pickNextEmp);
			
			mav.addObject("superiorList", superiorList);
			mav.addObject("expenseDTO",expenseDTO);
			mav.addObject("signList",signList);
			mav.addObject("max_return_no", max_return_no);
			mav.addObject("pickNextEmp", pickNextEmp);
			
		} catch(Exception e) {
			System.out.println("ExpenseController.goexpenseUpdelForm(~)에서 에러발생");
		}
		return mav;
	}
	
	@RequestMapping(value = "/expenseUpdelProc.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public int signExpenseReport(HttpSession session, ExpenseDTO expenseDTO) {
		int signExpenseReportCnt = 0;
		try {
			expenseDTO.setLoginemp_no((String) session.getAttribute("emp_no"));
			expenseDTO.setPickNextEmp((Map<String, String>) session.getAttribute("pickNextEmp"));
			
			StringBuffer expense_date = new StringBuffer();
			expense_date.append(expenseDTO.getExpense_year());
			expense_date.append(expenseDTO.getExpense_month());
			expense_date.append(expenseDTO.getExpense_day());
			expenseDTO.setExpense_date(expense_date.toString());

			signExpenseReportCnt = this.expenseService.signExpenseReport(expenseDTO);
		} catch (Exception e) {
			System.out.println("DeveloperController.signExpenseReport(~) 에서 에러발생");
			signExpenseReportCnt = -1;
		}
		return signExpenseReportCnt;
	}
}
