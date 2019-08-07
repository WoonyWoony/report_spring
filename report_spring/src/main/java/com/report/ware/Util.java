package com.report.ware;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

public class Util {
	// ==============================================================
	// 클라이언트에게 보낼 쿠키 생성하여 HttpServletResponse 객체에 저장하기
	// ==============================================================
	public static void addCookie(HttpServletResponse response, String cookieName, String cookieVal, int cookieLifeTime) throws Exception {
		// -----------------------------------------------
		// 쿠키명과 쿠키값을 관리하는 Cookie 객체 생성하기
		// Cookie 의 생명주기 정하기
		// HttpServletResponse 객체에 Cookie 객체 저장하기
		// -----------------------------------------------
		Cookie cookie1 = new Cookie(cookieName, cookieVal);
		cookie1.setMaxAge(cookieLifeTime);
		response.addCookie(cookie1);
	}
	
	// ==============================================================
	// 문자열이 null 이거나 길이가 없거나 공백으로 이루어져 있으면 true 리턴하는 메소드 선언
	// 주로 파라미터값을 검사할 때 사용한다.
	// ==============================================================
	public static boolean isEmpty(String str) {
		if (str == null) {
			return true;
		}
		str = str.replaceAll(" ", "");
		if (str.length() == 0) {
			return true;
		}
		return false;
	}
}