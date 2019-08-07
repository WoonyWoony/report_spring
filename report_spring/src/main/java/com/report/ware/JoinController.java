package com.report.ware;

import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class JoinController {

	@Autowired
	JoinService joinSeivce;
	
	@Autowired
	EmployeeService employeeService;
	
	@RequestMapping(value = "/joinForm.do")
	public ModelAndView getJoinForm(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("joinForm.jsp");
		List<Map<String, String>> depList = this.employeeService.getDepList();
		mav.addObject("depList", depList);		
		return mav;
	}
	
	@RequestMapping(value = "/joinProc.do")
	public ModelAndView joinProc(
			// HttpSession, HttpServletResponse 객체를 받아오는 매개변수 선언
			HttpSession session, HttpServletResponse response
			// 파리미터명, 파라미터값이 저장된 HashMap 객체를 받아오는 매개변수 선언
			// 파라미터명은 키값으로, 파라미터값은 키값에 대응하는 저장 문자열로 HashMap 객체가 저장된다.
			, EmployeeDTO employeeDTO) {
		int insertEmpCnt=0;
		ModelAndView mav = new ModelAndView();
		mav.setViewName("joinProc.jsp");
		try {
			insertEmpCnt = this.joinSeivce.insertEmp(employeeDTO);
			String loginEmp_no = this.joinSeivce.getLginEmp_no(employeeDTO);
			mav.addObject("insertEmpCnt", insertEmpCnt);		
			mav.addObject("loginEmp_no", loginEmp_no);		
		} catch (Exception e) {
			System.out.println("JoinController.joinProc(~) 에서 에러발생");
			mav.addObject("insertEmpCnt",-1);
		}
		return mav;
	}
}
