package com.report.ware;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class BoardController {
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private MypageService mypageService;

	@RequestMapping(value = "/boardListForm.do")
	public ModelAndView getBoardList(HttpSession session, BoardSearchDTO boardSearchDTO) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("boardListForm.jsp");
		try {
			if (boardSearchDTO.getSelectPageNo() == null || boardSearchDTO.getSelectPageNo().length() == 0) {
				boardSearchDTO.setSelectPageNo("1");
			}
			if (boardSearchDTO.getRowCntPerPage() == null || boardSearchDTO.getRowCntPerPage().length() == 0) {
				boardSearchDTO.setRowCntPerPage("10");
			}

			int selectPageNo = Integer.parseInt(boardSearchDTO.getSelectPageNo(), 10);
			int rowCntPerPage = Integer.parseInt(boardSearchDTO.getRowCntPerPage(), 10);

			String uri = (String) session.getAttribute("uri");
			if (uri == null || uri.equals("dashboard") || uri.equals("boardListForm") || uri.equals("dailyList") || uri.equals("expenseList") || uri.equals("salesList") || uri.equals("employeeListForm") || uri.equals("employeeRegForm") || uri.equals("employeeUpDelForm") || uri.equals("employeeListForm_beforeAllow")) {
				session.setAttribute("boardSearchDTO", boardSearchDTO);
			} else {
				boardSearchDTO = (BoardSearchDTO) session.getAttribute("boardSearchDTO");
			}
			session.setAttribute("uri", "boardListForm");

			int boardListAllCnt = this.boardService.getBoardListAllCnt(boardSearchDTO);
			
			int lastPageNo = boardListAllCnt / rowCntPerPage;
			if (boardListAllCnt % rowCntPerPage > 0) {
				lastPageNo++;
			}
			if (lastPageNo < selectPageNo) {
				boardSearchDTO.setSelectPageNo("1");
				session.setAttribute("selectPageNo", 1);
			}
			
			List<Map<String, String>> boardList = this.boardService.getBoardList(boardSearchDTO);

			
			// ------------------------------------------------------------
			// 게시글 작성 시간 구현하기
			// ------------------------------------------------------------
			for (int x = 0; x < boardList.size(); x++) {
				Map<String, String> beforeSignMap = boardList.get(x);
				int date = Integer.parseInt(beforeSignMap.get("sysdate2").substring(0, 8)) - Integer.parseInt(beforeSignMap.get("reg_date2").substring(0, 8));
				SimpleDateFormat f = new SimpleDateFormat("HH:mm", Locale.KOREA);
		        Date d1 = f.parse(beforeSignMap.get("sysdate2").substring(9, 14));
				Date d2 = f.parse(beforeSignMap.get("reg_date2").substring(9, 14));
				long diff = d1.getTime() - d2.getTime();
				long sec = diff / (1000*60);
				if(date == 0) {
					int hour = Integer.parseInt(beforeSignMap.get("sysdate2").substring(9, 11)) - Integer.parseInt(beforeSignMap.get("reg_date2").substring(9, 11));
					if (sec < 60) {
						hour = Integer.parseInt(beforeSignMap.get("sysdate2").substring(12, 14)) - Integer.parseInt(beforeSignMap.get("reg_date2").substring(12, 14));
						beforeSignMap.put("reg_date", sec + "분 전");
					} else {
						beforeSignMap.put("reg_date", hour + "시간 전");
					}
				}
			}
			
			mav.addObject("boardList", boardList);
			mav.addObject("boardListAllCnt", boardListAllCnt);

		} catch (Exception ex) {
			System.out.println("ContactController.getBoardList(~) 메소드 호출 시 에러발생");
			System.out.println(ex.toString());
		}
		return mav;
	}

	// ------------------------------------------------------------
	// 가상주소 /boardRegForm.do 로 접근하면 호출되는 메소드 선언
	// ------------------------------------------------------------
	@RequestMapping(value = "/boardRegForm.do")
	public ModelAndView goBoardRegForm(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("boardRegForm.jsp");
		String emp_no = (String) session.getAttribute("emp_no");
		try {
			EmployeeDTO employeeDTO = this.mypageService.getEmployeeDTO(emp_no);
			mav.addObject("employeeDTO", employeeDTO);
		} catch(Exception e) {
			System.out.println("ContactController.goBoardRegForm(~) 메소드 호출 시 에러발생");
			System.out.println(e.toString());
		}
		return mav;
	}

	// ------------------------------------------------------------
	// /erp/boardRegProc.do 로 접근하여 호출되는 메소드 선언
	// ------------------------------------------------------------
	@RequestMapping(value = "/boardRegProc.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public int inserBoard(BoardDTO boardDTO) {
		System.out.println("InsertBoard 메소드 시작!");
		int boardRegCnt = 0;
		try {
			boardRegCnt = this.boardService.insertBoard(boardDTO);
		} catch (Exception ex) {
			boardRegCnt = -1;
			System.out.println("BoardController.insertBoard(~) 메소드 호출 시 에러발생");
		}
		return boardRegCnt;
	}

	// ------------------------------------------------------------
	// 가상주소 /boardContentForm.do 로 접근하면 호출되는 메소드 선언
	// ------------------------------------------------------------
	@RequestMapping(value = "/boardContentForm.do", method = RequestMethod.POST)
	public ModelAndView getBoardContentForm(@RequestParam(value = "b_no") int b_no, HttpSession session) {
		session.setAttribute("uri", "");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("boardContentForm.jsp");
		try {
			BoardDTO boardDTO = this.boardService.getBoardDTO(b_no);
			mav.addObject("board", boardDTO);
		} catch (Exception ex) {
			System.out.println("BoardController.getBoardContentForm(~) 메소드 호출 시 에러발생");
		}
		return mav;
	}

	// ------------------------------------------------------------
	// 가상주소 /boardUpDelForm.do 로 접근하면 호출되는 메소드 선언
	// ------------------------------------------------------------
	@RequestMapping(value = "/boardUpDelForm.do", method = RequestMethod.POST)
	public ModelAndView getBoardUpDelForm(@RequestParam(value = "b_no") int b_no, HttpSession session) {
		session.setAttribute("uri", "");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("boardUpDelForm.jsp");
		try {
			BoardDTO boardDTO = this.boardService.getBoardDTO_without_upReadcount(b_no);
			mav.addObject("boardDTO", boardDTO);
		} catch (Exception ex) {
			System.out.println("BoardController.getBoardUpDelForm(~) 메소드 호출 시 에러발생");
		}
		return mav;
	}

	// ------------------------------------------------------------
	// 가상주소 /boardUpDelProc.do 로 접근하면 호출되는 메소드 선언
	// ------------------------------------------------------------
	@RequestMapping(value = "/boardUpDelProc.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public int boardUpDelProc(BoardDTO boardDTO, @RequestParam(value = "upDel") String upDel) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("boardUpDelProc.jsp");
		int boardUpDelCnt = 0;
		try {
			if (upDel.equals("up")) {
				boardUpDelCnt = this.boardService.updateBoard(boardDTO);
			}
			else {
				boardUpDelCnt = this.boardService.deleteBoard(boardDTO);
			}
		} catch (Exception ex) {
			boardUpDelCnt = -10;
			System.out.println("BoardController.boardUpDelProc(~) 메소드 호출 시 에러발생");
		}
		return boardUpDelCnt;
	}

	// ------------------------------------------------------------
	// 현재 이 [컨트롤러 클래스] 내의 @RequestMapping 이 붙은 메소드 호출 시
	// 예외 발생하면 호출되는 메소드 선언
	// ------------------------------------------------------------
	@ExceptionHandler(Exception.class)
	public String handlerException(HttpServletRequest request) {
		request.setAttribute("msg", request.getRequestURL() + " 접속 시 에러가 발생 했음.");
		return "/WEB-INF/views/error.jsp";
	}

}