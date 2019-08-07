package com.report.ware;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class MypageControlloer {
	@Autowired
	private MypageService mypageService;

	@RequestMapping(value = "/myPageForm.do")
	public ModelAndView goMypage(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("myPageForm.jsp");
		try {
			String emp_no = (String) session.getAttribute("emp_no");
			EmployeeDTO employeeDTO = this.mypageService.getEmployeeDTO(emp_no);
			mav.addObject("employeeDTO",employeeDTO);
		} catch (Exception ex) {
			System.out.println("MypageControlloer.goMypage(~)에서 에러발생");
		}
		return mav;
	}
	
		// ------------------------------------------------------------
		// 가상주소 /myPageProc.do 로 접근하면 호출되는 메소드 선언
		// ------------------------------------------------------------
		@RequestMapping(value = "/myPageProc.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
		@ResponseBody
		public int myPageProc(EmployeeDTO employeeDTO) {
			ModelAndView mav = new ModelAndView();
			mav.setViewName("myPageProc.jsp");
			int myPageCnt = 0;
			try {
				myPageCnt = this.mypageService.updatePage(employeeDTO);
			} catch (Exception ex) {
				System.out.println("MypageController.getmyPageProc(~) 메소드 호출 시 에러발생");
			}
			return myPageCnt;
		}

}