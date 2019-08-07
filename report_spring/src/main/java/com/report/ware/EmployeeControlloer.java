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

@Controller
public class EmployeeControlloer {
	@Autowired
	private EmployeeService employeeService;

	@RequestMapping(value = "/employeeListForm.do")
	public ModelAndView getEmployeeList(HttpSession session, EmployeeDTO employeeDTO, EmployeeSearchDTO employeeSearchDTO) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("employeeListForm.jsp");
		session.removeAttribute("employeeDTO");
		try {
			if (employeeSearchDTO.getSelectPageNo() == null || employeeSearchDTO.getSelectPageNo().length() == 0) {
				employeeSearchDTO.setSelectPageNo("1");
			}
			if (employeeSearchDTO.getRowCntPerPage() == null || employeeSearchDTO.getRowCntPerPage().length() == 0) {
				employeeSearchDTO.setRowCntPerPage("10");
			}

			int selectPageNo = Integer.parseInt(employeeSearchDTO.getSelectPageNo(), 10);
			int rowCntPerPage = Integer.parseInt(employeeSearchDTO.getRowCntPerPage(), 10);
			
			String uri = (String) session.getAttribute("uri");
			System.out.println(uri);
			if(uri == null || uri.equals("dashboard") || uri.equals("boardListForm") || uri.equals("dailyList") || uri.equals("expenseList") || uri.equals("salesList") || uri.equals("employeeListForm") || uri.equals("employeeRegForm") || uri.equals("employeeUpDelForm") || uri.equals("employeeListForm_beforeAllow") ) {
				session.setAttribute("employeeSearchDTO", employeeSearchDTO);
			}
			else {
				employeeSearchDTO = (EmployeeSearchDTO) session.getAttribute("employeeSearchDTO");
			}
			session.setAttribute("uri", "employeeListForm");
			session.setAttribute("empuri", "employeeListForm");
			int employeeListAllCnt = this.employeeService.getEmployeeListAllCnt(employeeSearchDTO);
			
			int lastPageNo = employeeListAllCnt / rowCntPerPage;
			if (employeeListAllCnt % rowCntPerPage > 0) {
				lastPageNo++;
			}
			if (lastPageNo < selectPageNo) {
				employeeSearchDTO.setSelectPageNo("1");
				session.setAttribute("selectPageNo", 1);
			}
			
			List<Map<String, String>> employeeList = this.employeeService.getEmployeeList(employeeSearchDTO);
			
			
			List<Map<String, String>> depList = this.employeeService.getDepList();
			List<Map<String, String>> jikupList = this.employeeService.getJikupList( );
			

			
			mav.addObject("employeeListAllCnt",employeeListAllCnt);
			mav.addObject("employeeList",employeeList);
			mav.addObject("jikupList", jikupList);
			mav.addObject("depList", depList);			
		}catch(Exception ex) {
			System.out.println("employeeController.getEmployeeList(~) 메소드 호출 시 에러발생");
		}
		return mav;
	}
	@RequestMapping(value = "/employeeListForm_beforeAllow.do")
	public ModelAndView getEmployeeList_beforeAllow(HttpSession session, EmployeeDTO employeeDTO, EmployeeSearchDTO employeeSearchDTO) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("employeeListForm_beforeAllow.jsp");
		session.removeAttribute("employeeDTO");
		try {
			if (employeeSearchDTO.getSelectPageNo() == null || employeeSearchDTO.getSelectPageNo().length() == 0) {
				employeeSearchDTO.setSelectPageNo("1");
			}
			if (employeeSearchDTO.getRowCntPerPage() == null || employeeSearchDTO.getRowCntPerPage().length() == 0) {
				employeeSearchDTO.setRowCntPerPage("10");
			}
			
			int selectPageNo = Integer.parseInt(employeeSearchDTO.getSelectPageNo(), 10);
			int rowCntPerPage = Integer.parseInt(employeeSearchDTO.getRowCntPerPage(), 10);
			
			String uri = (String) session.getAttribute("uri");
			System.out.println(uri);
			if(uri == null || uri.equals("dashboard") || uri.equals("boardListForm") || uri.equals("dailyList") || uri.equals("expenseList") || uri.equals("salesList") || uri.equals("employeeListForm") || uri.equals("employeeRegForm") || uri.equals("employeeUpDelForm") || uri.equals("employeeListForm_beforeAllow") ) {
				session.setAttribute("employeeSearchDTO", employeeSearchDTO);
			}
			else {
				employeeSearchDTO = (EmployeeSearchDTO) session.getAttribute("employeeSearchDTO");
			}
			session.setAttribute("uri", "employeeListForm_beforeAllow");
			session.setAttribute("empuri", "employeeListForm_beforeAllow");
			int employeeListAllCnt = this.employeeService.getEmployeeListAllCnt_beforeAllow(employeeSearchDTO);
			
			int lastPageNo = employeeListAllCnt / rowCntPerPage;
			if (employeeListAllCnt % rowCntPerPage > 0) {
				lastPageNo++;
			}
			if (lastPageNo < selectPageNo) {
				employeeSearchDTO.setSelectPageNo("1");
				session.setAttribute("selectPageNo", 1);
			}
			
			List<Map<String, String>> employeeList = this.employeeService.getEmployeeList_beforeAllow(employeeSearchDTO);
			
			
			List<Map<String, String>> depList = this.employeeService.getDepList();
			List<Map<String, String>> jikupList = this.employeeService.getJikupList( );
			
			
			
			mav.addObject("employeeListAllCnt",employeeListAllCnt);
			mav.addObject("employeeList",employeeList);
			mav.addObject("jikupList", jikupList);
			mav.addObject("depList", depList);			
		}catch(Exception ex) {
			System.out.println("employeeController.getEmployeeList(~) 메소드 호출 시 에러발생");
		}
		return mav;
	}

	
	
	
	@RequestMapping(value = "/employeeRegForm.do")
	public ModelAndView goEmployeeRegForm(HttpSession session, EmployeeDTO employeeDTO,@RequestParam Map<String,String> getParams) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("employeeRegForm.jsp");
		try {
		
			// employeeListForm에서 employeeRegForm으로 이동한경우 기존 흔적을 유지할 필요가 없다.
			// employeeRegForm에서 employeeRegForm으로 이동한경우 기존 흔적을 유지할 필요가 있다.
			
			String uri = (String) session.getAttribute("uri");
			// 만약에 바로 전에 employeeRegForm에서 신입사원의 직급과 부서를 선택하여 
			// RegProc.do에서 직속상관후보수를 체크한후 0보다 크다면 employeeRegForm의 파라미터값을 가지고 employeeRegForm.do로 이동한다. 
			// 이때 employeeRegForm양식에서 넘어온 파라미터를 담고 있는 DTO를 세션에 저장하여 
			// 다시 employeeRegForm.jsp를 호출할때 해당 jsp페이지에서 EL에서 호출한다. 
			System.out.println("employeeRegForm으로 넘어올때 uri==>");
			System.out.println(uri);
			
			String check = getParams.get("empRegCheck");
			// String mgrEmployeeCnt = (String)session.getAttribute("mgrEmployeeCnt");
			System.out.println("employeeRegProc에서 empRegCheck --"+check);
			
			if ( uri.equals("employeeRegForm") && check!=null && check.equals("no") ) {
				// session.setAttribute("employeeDTO", employeeDTO);
				mav.addObject("employeeDTO", employeeDTO);
		        List<Map<String, String>> mgrEmployeeList = this.employeeService.getMgrEmployeeList(employeeDTO);
		        mav.addObject("mgrEmployeeList", mgrEmployeeList);
			} 
			// 바로전에 employeeRegForm이 아닌 다른 페이지에서 넘어왔다면
			// 세션에 담긴 기존의 흔적으로 다시 employeeDTO 객체의 데이터를 갱신한다.
			// 한행을 클릭하였을때 바로 들어오는 경
			else {
				mav.addObject("empRegCheck",check);
				session.removeAttribute("employeeDTO");
			}
			// uri의 값을 다시 현재 페이지로 설정한다.
			session.setAttribute("uri", "employeeRegForm");			
	         List<Map<String, String>> depList = this.employeeService.getDepList();
	         List<Map<String, String>> jikupList = this.employeeService.getJikupList( );
	         //List<Map<String, String>> employeeAllList = this.employeeService.getEmployeeAllList();
	         

	         
	         mav.addObject("jikupList", jikupList);
	         mav.addObject("depList", depList);
	        // mav.addObject("employeeAllList", employeeAllList);
	        
	         
	         
		}catch(Exception ex) {
			System.out.println("employeeController.goEmployeeRegForm(~) 메소드 호출 시 에러발생");
		}
		return mav;
	}


	
	// ------------------------------------------------------------
	// 가상주소 /employeeRegProc.do 로 접근하면 호출되는 메소드 선언
	// ------------------------------------------------------------
	@RequestMapping(value = "/employeeRegProc.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public int insertEmployee(HttpSession session,EmployeeDTO employeeDTO,@RequestParam(value = "empRegCheck") String empRegCheck) {
		int employeeRegCnt = 0;
		System.out.println("employeeRegProc에서 empRegCheck --"+empRegCheck);
		try {

			if (empRegCheck.equals("yes")) {
				int alreadyCnt = this.employeeService.getAlreadyCnt(employeeDTO);
				if(alreadyCnt >0) {
					return -9;
				}
				// 사원정보가 등록이 적용된 행의 수를 리턴하는 메소드 호출
				employeeRegCnt = this.employeeService.insertemp(employeeDTO);
			}
			else if (empRegCheck.equals("no")) {
				// 직속상관후보정보가 담긴행의 개수를 리턴하는 메소드 호출
				employeeRegCnt = this.employeeService.getMgrEmployeeCnt(employeeDTO);
				//session.setAttribute("mgrEmployeeCnt", employeeRegCnt);
			}				
			
			
			
		} catch (Exception ex) {
			System.out.println("employeeController.insertEmployee(~) 메소드 호출 시 에러발생");
		}
		return employeeRegCnt;
	}
	// ------------------------------------------------------------
	// 가상주소 /employeeUpDelForm.do 로 접근하면 호출되는 메소드 선언
	// ------------------------------------------------------------
	@RequestMapping(value = "/employeeUpDelForm.do", method = RequestMethod.POST)
	public ModelAndView goEmployeeUpDelForm( HttpSession session , EmployeeDTO employeeDTO , @RequestParam Map<String,String> getParams) {			
		ModelAndView mav = new ModelAndView();
		mav.setViewName("employeeUpDelForm.jsp");
		try {
			String uri = (String) session.getAttribute("uri");
			String empCheck = getParams.get("empCheck");
			// employeeUpDelForm.jsp에서 직급,부서선택시 자동호출하는 경우
			if ( uri.equals("employeeUpDelForm") && empCheck!=null && empCheck.equals("no") ) {
				mav.addObject("employeeDTO", employeeDTO);
				List<Map<String, String>> mgrEmployeeList = this.employeeService.getMgrEmployeeList(employeeDTO);
				mav.addObject("mgrEmployeeList", mgrEmployeeList);
				mav.addObject("empCheck", String.valueOf(empCheck));
			} 
			// employeeListForm에서 한직원을 클릭하여 넘어온 경우
			else {
				Map<String, String> getEmployee = this.employeeService.getEmployee(Integer.parseInt(employeeDTO.getEmp_no(),10));
				employeeDTO.setDep_no(getEmployee.get("DEP_NO"));
				employeeDTO.setJikup_code(getEmployee.get("JIKUP_CODE"));
				session.setAttribute("beforeEmp_no", getEmployee.get("EMP_NO"));
				if(employeeDTO.getDep_no() != null && employeeDTO.getJikup_code() != null) {
					List<Map<String, String>> mgrEmployeeList = this.employeeService.getMgrEmployeeList(employeeDTO);
					mav.addObject("mgrEmployeeList", mgrEmployeeList);
				}
				mav.addObject("getEmployee", getEmployee);
				mav.addObject("empCheck", empCheck);
				
			}	
			session.setAttribute("uri", "employeeUpDelForm");
			
	        
	        
			List<Map<String, String>> depList = this.employeeService.getDepList();
			List<Map<String, String>> jikupList = this.employeeService.getJikupList();
			mav.addObject("jikupList", jikupList);
			mav.addObject("depList", depList);
			
		} catch (Exception ex) {
			System.out.println(ex);
			System.out.println("EmployeeController.goEmployeeUpDelForm(~) 메소드 호출 시 에러발생");
		}
		return mav;
	}	
	// ------------------------------------------------------------
	// 가상주소 /employeeUpDelProc.do 로 접근하면 호출되는 메소드 선언
	// ------------------------------------------------------------
	@RequestMapping(value = "/employeeUpDelProc.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public int employeeUpDelProc(EmployeeDTO employeeDTO, @RequestParam(value = "empCheck") String empCheck , HttpSession session) {
		int employeeUpDelCnt = 0;
		try {
			if (empCheck.equals("yes")) {
				if(!employeeDTO.getBeforeEmp_no().equals(employeeDTO.getEmp_no())){
					int alreadyCnt = this.employeeService.getAlreadyCnt(employeeDTO);
					if(alreadyCnt >0) {
						return -9;
					}				
				}
				employeeUpDelCnt = this.employeeService.updateEmployee(employeeDTO);
			}
			else if(empCheck.equals("no")) {
				employeeUpDelCnt = this.employeeService.getMgrEmployeeCnt(employeeDTO);
			}
		} catch (Exception ex) {
			employeeUpDelCnt = -10;
			System.out.println("EmployeeController.employeeUpDelProc(~) 메소드 호출 시 에러발생");
		}
		return employeeUpDelCnt;
	}	
}