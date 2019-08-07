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
import org.springframework.web.servlet.ModelAndView;

import net.sf.json.JSONArray;

@Controller
public class DashboardController {
	
	@Autowired
	DashboardService dashboardService;
	
	@RequestMapping(value = "/dashboard.do")
	public ModelAndView goDashboard(HttpSession session, DashboardDTO dashboardDTO) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("dashboard.jsp");
		
		JSONArray dailyStatJson = new JSONArray();
		JSONArray saleStatJson = new JSONArray();
		JSONArray expenseStatJson = new JSONArray();
		
		JSONArray roundStatNameJson = new JSONArray();
		JSONArray roundStatCountJson = new JSONArray();
		//--------------------------------------------
		
		JSONArray SignCntJson = new JSONArray();
		
		//--------------------------------------------
		
		try {
			String uri = (String)session.getAttribute("uri");
			if(uri == null || uri.equals("dashboard") || uri.equals("boardListForm") || uri.equals("dailyList") || uri.equals("expenseList") || uri.equals("salesList") || uri.equals("employeeListForm") || uri.equals("employeeRegForm") || uri.equals("employeeUpDelForm") || uri.equals("employeeListForm_beforeAllow")) {					
				session.setAttribute("dashboardDTO", dashboardDTO);
			}else {															
				dashboardDTO = (DashboardDTO)session.getAttribute("dashboardDTO");
			}
			session.setAttribute("uri", "dashboard");
			
			dashboardDTO.setLoginemp_no((String) session.getAttribute("emp_no"));
			
			// 첫번째 통계에 뽑을 3개의 리스트
			List<Map<String,String>> dailyStatList = this.dashboardService.getDailyStatList(dashboardDTO);
			List<Map<String,String>> saleStatList = this.dashboardService.getSaleStatList(dashboardDTO);
			List<Map<String,String>> expenseStatList = this.dashboardService.getExpenseStatList(dashboardDTO);
			for (int i = 0; i < dailyStatList.size(); i++) {
				dailyStatJson.add(dailyStatList.get(i).get("COUNT"));
			}
			for (int i = 0; i < saleStatList.size(); i++) {
				saleStatJson.add(saleStatList.get(i).get("COUNT"));
			}
			for (int i = 0; i < expenseStatList.size(); i++) {
				expenseStatJson.add(expenseStatList.get(i).get("COUNT"));
			}
			
			mav.addObject("dailyStatJson", dailyStatJson.toString());
			mav.addObject("saleStatJson", saleStatJson.toString());
			mav.addObject("expenseStatJson", expenseStatJson.toString());
			
			List<Map<String,String>> roundStatList = null;
			// 원형 통계에 뽑을 리스트
			if(dashboardDTO.getRoundStat_kinds().equals("일일")) {
				roundStatList = this.dashboardService.getRoundDailyStatList(dashboardDTO);
			} else if(dashboardDTO.getRoundStat_kinds().equals("영업")) {
				roundStatList = this.dashboardService.getRoundSalesStatList(dashboardDTO);
			} else if(dashboardDTO.getRoundStat_kinds().equals("지출")) {
				roundStatList = this.dashboardService.getRoundExpenseStatList(dashboardDTO);
			}
			
			for (int i = 0; i < roundStatList.size(); i++) {
				roundStatNameJson.add(roundStatList.get(i).get("NAME"));
				roundStatCountJson.add(roundStatList.get(i).get("COUNT"));
			}
			mav.addObject("roundStatNameJson", roundStatNameJson.toString());
			mav.addObject("roundStatCountJson", roundStatCountJson.toString());
			mav.addObject("scrollValue",dashboardDTO.getScrollValue());

			
			//--------------------------------------------
			
			// 두번째 통계에 뽑을 3개의 리스트
			String reportCode = dashboardDTO.getReportCode();
			List<Map<String,String>> signList = null;
			if(reportCode.equals("1")) {
				signList = this.dashboardService.getDailySignList(dashboardDTO);
			}
			if(reportCode.equals("2")) {
				signList = this.dashboardService.getSaleSignList(dashboardDTO);
			}
			if(reportCode.equals("3")) {
				signList = this.dashboardService.getExpenseSignList(dashboardDTO);
			}
			
			for (int i = 0; i < signList.size(); i++) {
				SignCntJson.add(signList.get(i).get("COUNT"));
			}
			String bc = SignCntJson.toString();
			String[] abc = bc.split(",");
			abc[0] = abc[0] + "]";
			abc[1] = "[" + abc[1] + "]";
			abc[2] = "[" + abc[2] + "]";
			abc[3] = "[" + abc[3];
			mav.addObject("SignCntJson", SignCntJson.toString());
			mav.addObject("abc0", abc[0]);
			mav.addObject("abc1", abc[1]);
			mav.addObject("abc2", abc[2]);
			mav.addObject("abc3", abc[3]);

			
			//--------------------------------------------
			// Notification List
			List<Map<String,String>> beforeSignList = this.dashboardService.getBeforSignList(dashboardDTO);
			// ------------------------------------------------------------
			// 게시글 작성 시간 구현하기
			// ------------------------------------------------------------
			for (int x = 0; x < beforeSignList.size(); x++) {
				Map<String, String> beforeSignMap = beforeSignList.get(x);
				SimpleDateFormat y = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
				Date y1 = y.parse(beforeSignMap.get("PREV_SYSDATE2").substring(0, 8));
				Date y2 = y.parse(beforeSignMap.get("PREV_SIGN_DATE2").substring(0, 8));
				long yiff = y1.getTime() - y2.getTime();
				long date = yiff / (24*60*60*1000);
				SimpleDateFormat f = new SimpleDateFormat("HH:mm", Locale.KOREA);
		        Date d1 = f.parse(beforeSignMap.get("PREV_SYSDATE2").substring(9, 14));
				Date d2 = f.parse(beforeSignMap.get("PREV_SIGN_DATE2").substring(9, 14));
				long diff = d1.getTime() - d2.getTime();
				long sec = diff / (1000*60);
				if(date == 0) {
					int hour = Integer.parseInt(beforeSignMap.get("PREV_SYSDATE2").substring(9, 11)) - Integer.parseInt(beforeSignMap.get("PREV_SIGN_DATE2").substring(9, 11));
					if (sec < 60) {
						hour = Integer.parseInt(beforeSignMap.get("PREV_SYSDATE2").substring(12, 14)) - Integer.parseInt(beforeSignMap.get("PREV_SIGN_DATE2").substring(12, 14));
						beforeSignMap.put("PREV_SIGN_DATE", sec + "분 전");
					} else {
						beforeSignMap.put("PREV_SIGN_DATE", hour + "시간 전");
					}
				} else {
					beforeSignMap.put("PREV_SIGN_DATE", date + "일 전");
				}
			}
			mav.addObject("beforeSignList",beforeSignList);
		} catch(Exception e) {
			System.out.println(e);
			System.out.println("DashboardController.goDashboard(~) 에서 에러발생");
		}
		return mav;
	}

}
