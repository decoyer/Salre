package com.salre.main.board;

import java.util.List;
import java.util.Map;

public interface BoardDAOInterface {
	
	// 게시판 목록 조회
	public List<BoardDTO> selectAll();
	
	// 게시글 등록
	public int insert(BoardDTO boardDTO);
	
	// 게시글 상세보기
	public BoardDTO selectByBoardId(Integer board_id);
	
	// 게시글 상세보기 시 조회수 증가
	public void updateClickCnt(Integer board_id);
	
	// 게시글 삭제
	public void delete(Integer board_id);
	
	// 게시글 수정
	public int update(BoardDTO boardDTO);
	
	// 해당 페이지에서 보여줄 공지사항 게시글 목록
	public List<BoardDTO> selectByPage(Map<String, Object> pagingParams);
	
	// 전체 글 갯수 조회
	public int selectBoardCount(String type);

}
