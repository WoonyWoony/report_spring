package com.report.ware;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
//==============================================
// [DAO 클래스]인 [BoardDAOImpl 클래스] 선언
// @Repository 를 붙임으로서 [DAO 클래스] 임을 지정하게 되고 bean 태그로 자동 등록된다
//==============================================
@Repository
public class BoardDAOImpl implements BoardDAO {
	
	private String path = "com.report.ware.BoardDAO";
	@Autowired
	private SqlSessionTemplate sqlSession;

	// ==============================================
	// [1개 게시판 글 출력번호 수정하고 수정 행의 개수] 리턴하는 메소드 선언
	// ==============================================
	public int updatePrint_no(BoardDTO boardDTO) {
		int updatePrint_noCnt = sqlSession.update("path.updatePrint_no", boardDTO);
		return updatePrint_noCnt;
	}

	// ==============================================
	// [게시판 글 입력 후 입력 적용 행의 개수] 리턴하는 메소드 선언
	// ==============================================
	public int insertBoard(BoardDTO boardDTO) {
		int boardRegCnt = sqlSession.insert("com.report.ware.BoardDAO.insertBoard", boardDTO);
		return boardRegCnt;
	}

	// ==============================================
	// [검색한 게시판 목록] 리턴하는 메소드 선언
	// ==============================================
	public List<Map<String, String>> getBoardList(BoardSearchDTO boardSearchDTO) {
		List<Map<String, String>> boardList = sqlSession.selectList("com.report.ware.BoardDAO.getBoardList", boardSearchDTO);
		return boardList;
	}

	// ==============================================
	// [검색한 게시판 목록 개수] 리턴하는 메소드 선언
	// ==============================================
	public int getBoardListAllCnt(BoardSearchDTO boardSearchDTO) {
		int boardListAllCnt = sqlSession.selectOne("com.report.ware.BoardDAO.getBoardListAllCnt", boardSearchDTO);
		return boardListAllCnt;
	}

	// ==============================================
	// [1개 게시판 글] 리턴하는 메소드 선언
	// ==============================================
	@Override
	public BoardDTO getBoardDTO(int b_no) {
		BoardDTO boardDTO = sqlSession.selectOne("com.report.ware.BoardDAO.getBoardDTO", b_no);
		return boardDTO;
	}

	// ==============================================
	// [게시판 글 조회수 증가 하고 수정행의 개수] 리턴하는 메소드 선언
	// ==============================================
	@Override
	public int updateReadcount(int b_no) {
		int readcount = sqlSession.update("com.report.ware.BoardDAO.updateReadcount", b_no);
		return readcount;
	}
	
	
	//*******************************
	// 수정 삭제 관련 메소드
	//*******************************
	
	
	// ==============================================
	// [수정/삭제할 1개 게시판 글의 존재여부 개수] 리턴하는 메소드 선언
	// ==============================================
	@Override
	public int getBoardCnt(BoardDTO boardDTO) {
		int boardCnt = sqlSession.selectOne("com.report.ware.BoardDAO.getBoardCnt", boardDTO);
		return boardCnt;
	}

	// ==============================================
	// [삭제할 1개 게시판 암호 일치 개수] 리턴하는 메소드 선언
	// ==============================================
	@Override
	public int getPwdCnt(BoardDTO boardDTO) {
		int pwdCnt = sqlSession.selectOne("com.report.ware.BoardDAO.getPwdCnt", boardDTO);
		return pwdCnt;
	}

	// ==============================================
	// [1개 게시판 수정 후 수정 적용행의 개수]를 리턴하는 메소드 선언
	// ==============================================
	@Override
	public int updateBoard(BoardDTO boardDTO) {
		int updateCnt = sqlSession.update("com.report.ware.BoardDAO.updateBoard", boardDTO);
		return updateCnt;
	}

	
	// ==============================================
	// [1개 게시판 글 삭제 후 삭제 적용행의 개수]를 리턴하는 메소드 선언
	// ==============================================
	@Override
	public int deleteBoard(BoardDTO boardDTO) {
		int deleteBoardCnt = sqlSession.delete("com.report.ware.BoardDAO.deleteBoard", boardDTO);
		return deleteBoardCnt;
	}

}



