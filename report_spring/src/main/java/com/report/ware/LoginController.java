package com.report.ware;

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

// ===========================================================================
// 가상 URL 주소로 접속하면 호출되는 메소드를 소유한 [LoginController 컨트롤러 클래스] 선언.
// ===========================================================================
// @Controller 를 붙임으로써 [컨트롤러 클래스]임을 지정한다.
// ===========================================================================
@Controller
public class LoginController {
	// ===========================================================================
	// 속성변수 loginService 선언하고, LoginService 라는 인터페이스를 구현한 클래스를 객체화하여 저장
	// ===========================================================================
	// @Autowired 이 붙은 속성변수에는 인터페이스 자료형을 쓰고
	// 이 인터페이스를 구현한 클래스를 객체화하여 저장한다.
	// LoginService 라는 인터페이스를 구현한 클래스의 이름을 몰라도 관계없다. 1개 존재하기만 하면 된다.
	// ===========================================================================
	@Autowired
	private LoginService loginService;
	
	@RequestMapping(value = "/loginForm.do")
	public ModelAndView loginForm(HttpSession session) {
		session.removeAttribute("emp_no");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("loginForm.jsp");
		return mav;
	}
	
	@RequestMapping(value = "/loginProc.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public int loginProc(
			HttpSession session, HttpServletResponse response
			, @RequestParam Map<String, String> paramsMap) {
		int admin_idCnt = 0;
		String emp_name;
		String emp_no = paramsMap.get("admin_id");
		String pwd = paramsMap.get("pwd");
		String is_login = paramsMap.get("is_login");
		String emp_role;
		String emp_jikup;
		String emp_allow;
		try {
			admin_idCnt = this.loginService.getAdminCnt(paramsMap);
			emp_name = this.loginService.getAdminName(paramsMap);
			emp_role = this.loginService.getEmpRole(paramsMap);
			emp_jikup = this.loginService.getEmpJikup(paramsMap);
			
			emp_allow = this.loginService.getEmpAllow(paramsMap);
			if (admin_idCnt == 1) {
				if(emp_allow.equals("1")) {
					return 10; // 가입대기 상태
				}
				if(emp_allow.equals("3")) {
					return 30; // 가입거절 상태
				}
				session.setAttribute("emp_no", emp_no);
				session.setAttribute("emp_name", emp_name);
				session.setAttribute("emp_role", emp_role);
				session.setAttribute("emp_jikup", emp_jikup);
				session.setMaxInactiveInterval(7200);
				if (is_login == null) {
					Cookie cookie1 = new Cookie("admin_id", null);
					cookie1.setMaxAge(0);
					response.addCookie(cookie1);
					Cookie cookie2 = new Cookie("pwd", null);
					cookie2.setMaxAge(0);
					response.addCookie(cookie2);
				}
				else {
					Cookie cookie1 = new Cookie("admin_id", emp_no);
					cookie1.setMaxAge(60 * 60 * 24);
					response.addCookie(cookie1);
					Cookie cookie2 = new Cookie("pwd", pwd);
					cookie2.setMaxAge(60 * 60 * 24);
					response.addCookie(cookie2);
				}
			}
		} catch (Exception e) {
			System.out.println("LoginController.loginProc(~) 에서 에러발생");
			admin_idCnt = -1;
		}
		return admin_idCnt;
	}
	
	@RequestMapping(value = "/findloginForm.do")
	public ModelAndView findloginForm(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("findloginForm.jsp");
		return mav;
	}
}
