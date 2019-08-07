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
public class DailyBusinessController {

	@Autowired
	private DailyService dailyService;
	@Autowired
	private ExpenseService expenseService;

	@RequestMapping(value = "/dailyListForm.do")
	public ModelAndView godailyListForm(HttpSession session, DailyBusiSearchDTO dailyBusiSearchDTO) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("dailyBusinessListForm.jsp");
		try {

			String uri = (String) session.getAttribute("uri");
			if (uri == null || uri.equals("dashboard") || uri.equals("boardListForm") || uri.equals("dailyList")
					|| uri.equals("expenseList") || uri.equals("salesList") || uri.equals("employeeListForm")
					|| uri.equals("employeeRegForm") || uri.equals("employeeUpDelForm")
					|| uri.equals("employeeListForm_beforeAllow")) {
				session.setAttribute("dailyBusiSearchDTO", dailyBusiSearchDTO);
			} else {
				dailyBusiSearchDTO = (DailyBusiSearchDTO) session.getAttribute("dailyBusiSearchDTO");
			}
			session.setAttribute("uri", "dailyList");

			// =========================================================================

			// <1> 만약 매개변수의 BoardSearchDTO 객체의 속성변수 selectPageNo 에 0 이
			// 저장되어 있으면 1로 대체 저장하기
			// <2> 만약 매개변수의 BoardSearchDTO 객체의 속성변수 rowCntPerPage 에 0 이
			// 저장되어 있으면 10로 대체 저장하기
			// ------------------------
			// 속성변수 selectPageNo, rowCntPerPage 는 select 구문으로 DB 연동시 가져올 행의
			// 범위에 사용되는 중요한 데이터이므로 기본값으로 1과 10을 세팅한다.
			if (dailyBusiSearchDTO.getSelectPageNo() == null || dailyBusiSearchDTO.getSelectPageNo().length() == 0) { // <1>
				dailyBusiSearchDTO.setSelectPageNo("1");
			}
			if (dailyBusiSearchDTO.getRowCntPerPage() == null || dailyBusiSearchDTO.getRowCntPerPage().length() == 0) { // <2>
				dailyBusiSearchDTO.setRowCntPerPage("10");
			}

			// =========================================================================

			if (dailyBusiSearchDTO.getBusi_year_min() != null && dailyBusiSearchDTO.getBusi_year_min().length() > 0) {
				dailyBusiSearchDTO.setBusi_date_min(
						dailyBusiSearchDTO.getBusi_year_min() + dailyBusiSearchDTO.getBusi_month_min());
			}

			if (dailyBusiSearchDTO.getBusi_year_max() != null && dailyBusiSearchDTO.getBusi_year_max().length() > 0) {
				dailyBusiSearchDTO.setBusi_date_max(
						dailyBusiSearchDTO.getBusi_year_max() + dailyBusiSearchDTO.getBusi_month_max());
			}

			if (dailyBusiSearchDTO.getBusi_hours_min() != null && dailyBusiSearchDTO.getBusi_hours_min().length() > 0) {
				dailyBusiSearchDTO.setBusi_time_min(
						dailyBusiSearchDTO.getBusi_hours_min() + dailyBusiSearchDTO.getBusi_minutes_min());
			}
			if (dailyBusiSearchDTO.getBusi_hours_max() != null && dailyBusiSearchDTO.getBusi_hours_max().length() > 0) {
				dailyBusiSearchDTO.setBusi_time_max(
						dailyBusiSearchDTO.getBusi_hours_max() + dailyBusiSearchDTO.getBusi_minutes_max());
			}

			dailyBusiSearchDTO.setEmp_no((String) session.getAttribute("emp_no"));
			System.out.println(dailyBusiSearchDTO.getEmp_no());

			int dailyListAllCnt = this.dailyService.getDailyListAllCnt(dailyBusiSearchDTO);

			// --------------------------
			// [선택된 페이지 번호]에 [시작행 번호] 얻기
			// --------------------------
			int beginRowNo = Integer.parseInt(dailyBusiSearchDTO.getSelectPageNo(), 10)
					* Integer.parseInt(dailyBusiSearchDTO.getRowCntPerPage(), 10)
					- Integer.parseInt(dailyBusiSearchDTO.getRowCntPerPage(), 10) + 1;
			// --------------------------
			// [선택된 페이지 번호]와 [총 검색 개수]와의 관계가 비합리적이면
			// [선택된 페이지 번호]를 1로 하고 검색 행의 [시작행 번호]를 1로 하기
			// --------------------------
			if (dailyListAllCnt < beginRowNo) {
				dailyBusiSearchDTO.setSelectPageNo("1");
			}

			List<Map<String, String>> dailyList = this.dailyService.getDailyList(dailyBusiSearchDTO);
			for (int x = 0; x < dailyList.size(); x++) {
				Map<String, String> beforeSignMap = dailyList.get(x);
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
			mav.addObject("dailyListAllCnt", dailyListAllCnt);
			mav.addObject("dailyList", dailyList);
			mav.addObject("scrollValue", dailyBusiSearchDTO.getScrollValue());
			session.setAttribute("dailyList", dailyList);

		} catch (Exception e) {
			System.out.println(e);
			System.out.println("DailyBusinessController.godailyListForm(~)에서 에러발생");
		}
		return mav;
	}

	@RequestMapping(value = "/dailyBusiRegForm.do")
	public ModelAndView godailyRegForm(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("dailyBusinessRegForm.jsp");
		try {
			String emp_no = (String) session.getAttribute("emp_no");
			List<Map<String, String>> superiorList = this.expenseService.getSuperiorList(emp_no);
			System.out.println("superiorList 성공");
			mav.addObject("superiorList", superiorList);
		} catch (Exception e) {
			System.out.println("DailyBusinessController.godailyRegForm(~)에서 에러발생");
		}
		return mav;
	}

	@RequestMapping(value = "/dailyBusiRegProc.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public int insertDailBusiReport(HttpSession session, DailyBusiDTO dailyBusiDTO) {
		int dailyReportRegCnt = 0;
		try {
			StringBuffer busi_start_date = new StringBuffer();
			busi_start_date.append(dailyBusiDTO.getBusi_year_min());
			busi_start_date.append(dailyBusiDTO.getBusi_month_min());
			busi_start_date.append(dailyBusiDTO.getBusi_day_min());
			busi_start_date.append(dailyBusiDTO.getBusi_hours_min());
			busi_start_date.append(dailyBusiDTO.getBusi_minutes_min());
			dailyBusiDTO.setBusi_start_date(busi_start_date.toString());

			StringBuffer busi_end_date = new StringBuffer();
			busi_end_date.append(dailyBusiDTO.getBusi_year_max());
			busi_end_date.append(dailyBusiDTO.getBusi_month_max());
			busi_end_date.append(dailyBusiDTO.getBusi_day_max());
			busi_end_date.append(dailyBusiDTO.getBusi_hours_max());
			busi_end_date.append(dailyBusiDTO.getBusi_minutes_max());
			dailyBusiDTO.setBusi_end_date(busi_end_date.toString());

			System.out.println(busi_start_date);
			System.out.println(busi_end_date);

			dailyReportRegCnt = this.dailyService.first_insertDailyReport(dailyBusiDTO);
		} catch (Exception e) {
			System.out.println(e);
			System.out.println("DailyBusinessController.insertDailBusiReport(~) 에서 에러발생");
			dailyReportRegCnt = -1;
		}
		return dailyReportRegCnt;
	}

	@RequestMapping(value = "/dailyUpdelForm.do")
	public ModelAndView goexpenseUpdelForm(HttpSession session, @RequestParam Map<String, String> paramsMap) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("dailyBusinessUpdelForm.jsp");
		try {
			DailyBusiDTO dailyBusiDTO = this.dailyService.getDailyDTO(paramsMap);
			List<Map<String, String>> superiorList = this.expenseService.getSuperiorList(paramsMap.get("emp_no"));
			System.out.println("superiorList 성공");

			List<Map<String, String>> signList = this.dailyService.getSignList(paramsMap);

			int max_return_no = this.dailyService.getMax_return_no(paramsMap);

			Map<String, String> pickNextEmp = this.dailyService.pickNextEmployee(paramsMap);

			session.setAttribute("pickNextEmp", pickNextEmp);

			mav.addObject("superiorList", superiorList);
			mav.addObject("dailyBusiDTO", dailyBusiDTO);
			mav.addObject("signList", signList);
			mav.addObject("max_return_no", max_return_no);
			mav.addObject("pickNextEmp", pickNextEmp);

			System.out.println(dailyBusiDTO.getBusi_day_min());
			System.out.println(dailyBusiDTO.getBusi_day_max());

		} catch (Exception e) {
			System.out.println("DailyBusinessController.goexpenseUpdelForm(~)에서 에러발생");
		}
		return mav;
	}

	@RequestMapping(value = "/dailyUpdelProc.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public int signDailBusiReport(HttpSession session, DailyBusiDTO dailyBusiDTO) {
		int signDailyBusiReportCnt = 0;
		try {
			dailyBusiDTO.setLoginemp_no((String) session.getAttribute("emp_no"));
			dailyBusiDTO.setPickNextEmp((Map<String, String>) session.getAttribute("pickNextEmp"));

			StringBuffer busi_start_date = new StringBuffer();
			busi_start_date.append(dailyBusiDTO.getBusi_year_min());
			busi_start_date.append(dailyBusiDTO.getBusi_month_min());
			busi_start_date.append(dailyBusiDTO.getBusi_day_min());
			busi_start_date.append(dailyBusiDTO.getBusi_hours_min());
			busi_start_date.append(dailyBusiDTO.getBusi_minutes_min());
			dailyBusiDTO.setBusi_start_date(busi_start_date.toString());

			StringBuffer busi_end_date = new StringBuffer();
			busi_end_date.append(dailyBusiDTO.getBusi_year_max());
			busi_end_date.append(dailyBusiDTO.getBusi_month_max());
			busi_end_date.append(dailyBusiDTO.getBusi_day_max());
			busi_end_date.append(dailyBusiDTO.getBusi_hours_max());
			busi_end_date.append(dailyBusiDTO.getBusi_minutes_max());
			dailyBusiDTO.setBusi_end_date(busi_end_date.toString());

			signDailyBusiReportCnt = this.dailyService.signDailyBusiReport(dailyBusiDTO);
		} catch (Exception e) {
			System.out.println("DeveloperController.signExpenseReport(~) 에서 에러발생");
			signDailyBusiReportCnt = -1;
		}
		return signDailyBusiReportCnt;
	}
}
