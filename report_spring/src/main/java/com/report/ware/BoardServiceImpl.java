package com.report.ware;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class BoardServiceImpl implements BoardService {
	@Autowired
	private BoardDAO boardDAO;

	// ==============================================
	// [1개 게시판 글 입력 후 입력 적용 행의 개수] 리턴하는 메소드 선언
	// ==============================================
	public int insertBoard(BoardDTO boardDTO) {
		String b_no = boardDTO.getB_no();
		if (b_no != null && b_no.length() > 0) {
			int updatePrint_noCnt = this.boardDAO.updatePrint_no(boardDTO);
		}
		int boardRegCnt = this.boardDAO.insertBoard(boardDTO);
		return boardRegCnt;
	}

	// ==============================================
	// [검색한 게시판 목록] 리턴하는 메소드 선언
	// ==============================================
	public List<Map<String, String>> getBoardList(BoardSearchDTO boardSearchDTO) {
		List<Map<String, String>> boardList = this.boardDAO.getBoardList(boardSearchDTO);
		return boardList;
	}

	// ==============================================
	// [검색한 게시판 목록 개수] 리턴하는 메소드 선언
	// ==============================================
	@Override
	public int getBoardListAllCnt(BoardSearchDTO boardSearchDTO) {
		int boardListAllCnt = this.boardDAO.getBoardListAllCnt(boardSearchDTO);
		return boardListAllCnt;
	}

	// ==============================================
	// [1개 게시판 글] 리턴하는 메소드 선언
	// ==============================================
	@Override
	public BoardDTO getBoardDTO(int b_no) {
		BoardDTO boardDTO = this.boardDAO.getBoardDTO(b_no);
		if (boardDTO != null) {
			int readcount = this.boardDAO.updateReadcount(b_no);
			boardDTO.setReadcount(boardDTO.getReadcount() + 1);
		}
		return boardDTO;
	}

	// ==============================================
	// 조회수 증가 없이 [수정/삭제 할 1개의 게시판 글 정보] 리턴하는 메소드 선언
	// 수정/삭제 할 때에는 조회수 증가하면 안됨
	// ==============================================
	@Override
	public BoardDTO getBoardDTO_without_upReadcount(int b_no) {
		BoardDTO boardDTO = this.boardDAO.getBoardDTO(b_no);
		return boardDTO;
	}

	// ==============================================
	// [1개 게시판] 수정 후 수정 적용행의 개수를 리턴하는 메소드 선언
	// ==============================================
	@Override
	public int updateBoard(BoardDTO boardDTO) {
		int boardCnt = this.boardDAO.getBoardCnt(boardDTO);
		if (boardCnt == 0) {
			return -1;
		}
		int pwdCnt = this.boardDAO.getPwdCnt(boardDTO);
		if (pwdCnt == 0) {
			return 0;
		}
		int updateCnt = this.boardDAO.updateBoard(boardDTO);
		return updateCnt;
	}

	// ==============================================
	// [1개 게시판] 삭제 후 삭제 적용행의 개수를 리턴하는 메소드 선언
	// ==============================================
	@Override
	public int deleteBoard(BoardDTO boardDTO) {
		int boardCnt = this.boardDAO.getBoardCnt(boardDTO);
		if (boardCnt == 0) {
			return -1;
		}
		int pwdCnt = this.boardDAO.getPwdCnt(boardDTO);
		if (pwdCnt == 0) {
			return -2;
		}
		int deleteCnt = this.boardDAO.deleteBoard(boardDTO);
		return deleteCnt;
	}
}
