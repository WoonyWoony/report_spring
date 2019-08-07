package com.report.ware;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
public class CalendarController {

	@Autowired
	CalendarService calendarService;

	@RequestMapping(value = "/calendarForm.do")
	public ModelAndView calenderTest(HttpSession session, @RequestParam(value="scrollValue", required = false, defaultValue = "0.0") Double scrollValue ) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("calendarForm.jsp");
		String emp_no = (String) session.getAttribute("emp_no");
		JSONArray jsonArray = new JSONArray();
		String calendarJson = null;
		try {
			List<Map<String, String>> calendarList = this.calendarService.getCalendarList(emp_no);

			for (int i = 0; i < calendarList.size(); i++) {
				JSONObject data = new JSONObject();
				data.put("id", calendarList.get(i).get("id"));
				data.put("title", calendarList.get(i).get("title"));
				data.put("start", calendarList.get(i).get("start"));
				data.put("end", calendarList.get(i).get("end"));
				jsonArray.add(i, data);
			}
			calendarJson = jsonArray.toString();
			calendarJson = calendarJson.replaceAll("\"id\"", "id");
			calendarJson = calendarJson.replaceAll("\"title\"", "title");
			calendarJson = calendarJson.replaceAll("\"start\"", "start");
			calendarJson = calendarJson.replaceAll("\"end\"", "end");
			System.out.println("calendarJson : "+ calendarJson);
			mav.addObject("calendarJson", calendarJson);
			
			System.out.println(scrollValue);
			mav.addObject("scrollValue", scrollValue);
		} catch (Exception e) {
			System.out.println(e);
			System.out.println("CalendarController.calenderTest(~) 에서 에러발생");
		}
		return mav;
	}

	@RequestMapping(value = "/calendarProc.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public int insertCalendar(HttpSession session, @RequestParam Map<String, String> paramsMap) {
		int insertCalendar = 0;
		try {
			insertCalendar = this.calendarService.insertCalendar(paramsMap);
		} catch (Exception e) {
			System.out.println(e);
			System.out.println("CalendarController.insertCalendar(~) 에서 에러발생");
			insertCalendar = -1;
		}
		return insertCalendar;
	}

	@RequestMapping(value = "/calendarList.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public ModelAndView getCalendarList(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("calendarProc.jsp");
		String emp_no = (String) session.getAttribute("emp_no");
		JSONArray jsonArray = new JSONArray();
		String calendarJson = null;
		try {
			List<Map<String, String>> calendarList = this.calendarService.getCalendarList(emp_no);
			System.out.println(calendarList.toArray());

			for (int i = 0; i < calendarList.size(); i++) {
				JSONObject data = new JSONObject();
				data.put("id", calendarList.get(i).get("id"));
				data.put("title", calendarList.get(i).get("title"));
				data.put("start", calendarList.get(i).get("start"));
				data.put("end", calendarList.get(i).get("end"));
				jsonArray.add(i, data);
			}
			System.out.println(jsonArray.toString());
			calendarJson = jsonArray.toString();
			System.out.println("calendarJson : "+ calendarJson);
			mav.addObject("calendarJson", calendarJson);
			session.setAttribute("calendarJson", calendarJson);
		} catch (Exception e) {
			System.out.println(e);
			System.out.println("CalendarController.getCalendarList(~) 에서 에러발생");
		}
		return mav;
	}
	
//	@RequestMapping(value = "/calendarList2.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
//	@ResponseBody
//	public String getCalendarList2(HttpSession session) {
//		ModelAndView mav = new ModelAndView();
//		mav.setViewName("calendarProc.jsp");
//		String emp_no = (String) session.getAttribute("emp_no");
//		JSONArray jsonArray = new JSONArray();
//		String calendarJson = null;
//		try {
//			List<Map<String, String>> calendarList = this.calendarService.getCalendarList(emp_no);
//			System.out.println(calendarList.toArray());
//			
//			for (int i = 0; i < calendarList.size(); i++) {
//				JSONObject data = new JSONObject();
//				data.put("id", calendarList.get(i).get("id"));
//				data.put("title", calendarList.get(i).get("title"));
//				data.put("start", calendarList.get(i).get("start"));
//				data.put("end", calendarList.get(i).get("end"));
//				jsonArray.add(i, data);
//			}
//			System.out.println(jsonArray.toString());
//			calendarJson = jsonArray.toString();
//			System.out.println("calendarJson : "+ calendarJson);
//			mav.addObject("calendarJson", calendarJson);
//			session.setAttribute("calendarJson", calendarJson);
//		} catch (Exception e) {
//			System.out.println(e);
//			System.out.println("CalendarController.getCalendarList(~) 에서 에러발생");
//		}
//		return calendarJson;
//	}
	
	@RequestMapping(value = "/deleteCalendar.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public int deleteCalendar(HttpSession session, @RequestParam Map<String,String> paramsMap) {
		String emp_no = (String) session.getAttribute("emp_no");
		int deleteCalendar = 0;
		String calendar_id = paramsMap.get("calendar_id");
		try {
			if(calendar_id.length() > 15) {
				return -10;
			}
			deleteCalendar = this.calendarService.deleteCalendar(paramsMap);
		} catch (Exception e) {
			System.out.println(e);
			System.out.println("CalendarController.deleteCalendar(~) 에서 에러발생");
		}
		return deleteCalendar;
	}
	
	@RequestMapping(value = "/updateCalendar.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public int updateCalendar(HttpSession session, @RequestParam Map<String,String> paramsMap) {
		System.out.println(paramsMap.toString());
		String emp_no = (String) session.getAttribute("emp_no");
		String calendar_id = paramsMap.get("calendar_id");
		int updateCalendar = 0;
		try {
			if(calendar_id.length() > 15) {
				return -10;
			}
			updateCalendar = this.calendarService.updateCalendar(paramsMap);
		} catch (Exception e) {
			System.out.println(e);
			System.out.println("CalendarController.updateCalendar(~) 에서 에러발생");
		}
		return updateCalendar;
	}
}
