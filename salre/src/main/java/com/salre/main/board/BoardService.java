package com.salre.main.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class BoardService {
	
	@Autowired
	BoardDAOMybatis boardDAOMybatis;
	
	// 게시판 목록 조회
	public List<BoardDTO> selectAllService() {
		return boardDAOMybatis.selectAll();
	}

	// 게시글 등록
	public int insertService(BoardDTO boardDTO) {
		return boardDAOMybatis.insert(boardDTO);
	}

	// 게시글 상세보기
	public BoardDTO selectByBoardIdService(Integer board_id) {
		return boardDAOMybatis.selectByBoardId(board_id);
	}

	// 게시글 상세보기 시 조회수 증가
	@Transactional
	public void updateClickCnt(Integer boardId) {
		boardDAOMybatis.updateClickCnt(boardId);
	}

	// 게시글 삭제
	public void deleteService(Integer board_id) {
		boardDAOMybatis.delete(board_id);
	}

	// 게시글 수정
	public int updateService(BoardDTO boardDTO) {
		return boardDAOMybatis.update(boardDTO);
	}

	int pageLimit = 10; // 한 페이지 당 보여지는 글 갯수
	int blockLimit = 5; // 하단에 보여줄 페이지 번호 갯수
	// 해당 페이지에서 보여줄 게시글(공지사항, 자유게시판) 목록
	public List<BoardDTO> selectByPageService(String type, int page) {
		/*
		 * 한 페이지 당 보여지는 글 갯수 10
		 * 1페이지 => 0(index)
		 * 2페이지 => 10(index)
		 * 3페이지 => 20(index)
		 */
		int pageStart = (page - 1) * pageLimit;
		Map<String, Object> pagingParams = new HashMap<>();
		pagingParams.put("start", pageStart);
		pagingParams.put("limit", pageLimit);
		pagingParams.put("type", type);
		
		List<BoardDTO> pagingList = boardDAOMybatis.selectByPage(pagingParams);
		
		return pagingList;
	}

	public PageDTO pagingParam(String type, int page) {
		// 전체 글 갯수 조회
		int boardCount = boardDAOMybatis.selectBoardCount(type);
		
		// 전체 페이지 갯수 계산*(10 / 3 = 3.333 => 4)
		int maxPage = (int) (Math.ceil((double) boardCount / pageLimit));
		
		// 시작 페이지 값 계산(1, 6, 11, 16, ...)
		int startPage = (((int) (Math.ceil((double) page / blockLimit))) - 1) * blockLimit + 1;
		
		// 끝 페이지 값 계산(5, 10, 15, 20, ...)
		int endPage = startPage + blockLimit - 1;
		
		// 끝 페이지 값이 마지막 페이지
		if (endPage > maxPage) {
			endPage = maxPage;
		}
		
		PageDTO pageDTO = PageDTO.builder().page(page)
										   .maxPage(maxPage)
										   .startPage(startPage)
										   .endPage(endPage).build();
		
		return pageDTO;
	}

}
