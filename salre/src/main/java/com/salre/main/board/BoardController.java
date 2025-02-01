package com.salre.main.board;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.salre.main.login.UserDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	CommentService commentService;

	// 게시판 목록 조회(게시글 페이징; 처음 페이지 요청은 1페이지를 보여줌)
	@GetMapping(value = "/list")
	public String boardList(@RequestParam(value = "type", required = false, defaultValue = "공지사항") String type,
			@RequestParam(value = "page", required = false, defaultValue = "1") int page,
			HttpServletRequest request, Model model) {
		// 해당 페이지에서 보여줄 게시글(공지사항 or 자유게시판) 목록
		List<BoardDTO> boardList = boardService.selectByPageService(type, page);
		// 게시글이 없을 경우
		if (boardList == null || boardList.isEmpty()) {
			BoardDTO defaultBoardDTO = new BoardDTO();
			
			defaultBoardDTO.setBoard_id(0);
			defaultBoardDTO.setBoard_class(type);
			
			boardList.add(defaultBoardDTO);
		}
		log.info("boardList : " + boardList);
		
		// /board/list/page=2 이런 식으로 요청하게 됨
		PageDTO pageDTO = boardService.pagingParam(type, page);
		log.info("pageDTO : " + pageDTO);
		
		// 로그인 정보(세션) 가져오기
		HttpSession session = request.getSession();
		UserDTO userDTO = (UserDTO) session.getAttribute("loggedInUser");
		
		model.addAttribute("boardList", boardList);
		model.addAttribute("pageDTO", pageDTO);
		model.addAttribute("userDTO", userDTO);
		model.addAttribute("type", type);
		
		return "board/boardList";
	}
	
	// 게시글 등록 화면
	@GetMapping(value = "/insert.do")
	public String boardInsertPage(@RequestParam(value = "type", required = false, defaultValue = "공지사항") String type,
			HttpServletRequest request, Model model) {
		String board_class = type; // 공지사항 or 자유게시판
		
		// 게시글 등록 시 user_id, writer(아이디) 필요
		HttpSession session = request.getSession();
		UserDTO userDTO = (UserDTO) session.getAttribute("loggedInUser");
		
		model.addAttribute("type", board_class);
		model.addAttribute("userDTO", userDTO);
		
		return "board/boardInsert";
	}
	
	// 게시글 등록
	@ResponseBody
	@PostMapping(value = "/insert", consumes = MediaType.APPLICATION_JSON_VALUE,
			produces = "text/plain;charset=utf-8")
	public String boardInsert(@RequestBody BoardDTO boardDTO) {
		// 공지사항 : 관리자만 등록 가능, 자유게시판 : 누구나 가능
		int result = boardService.insertService(boardDTO);
		
		return result > 0 ? "게시글이 등록되었습니다." : "게시글 등록에 실패했습니다.";
	}
	
	// 게시글 상세보기
	@GetMapping(value = "/detail")
	public String boardDetail(Integer board_id, HttpServletRequest request, Model model) {
		// 게시글 상세보기 시 조회수 증가
		boardService.updateClickCnt(board_id);
		
		// 해당 게시글 정보
		BoardDTO boardDTO = boardService.selectByBoardIdService(board_id);
		
		// 해당 게시글에 작성된 댓글 리스트 가져오기
		List<CommentDTO> commentDTOList = commentService.selectAllService(board_id);
		
		// 댓글 수
		int commentCnt = commentService.selectCommentCnt(board_id);
		
		// 댓글 등록 시 content_writer(아이디) 필요
		HttpSession session = request.getSession();
		UserDTO userDTO = (UserDTO) session.getAttribute("loggedInUser");
		log.info("userDTO : " + userDTO);
		
		model.addAttribute("boardDTO", boardDTO);
		model.addAttribute("commentDTOList", commentDTOList);
		model.addAttribute("commentCnt", commentCnt);
		model.addAttribute("userDTO", userDTO);
		
		return "board/boardDetail";
	}
	
	// 게시글 삭제
	@GetMapping(value = "/delete")
	public String boardDelete(Integer board_id) throws UnsupportedEncodingException {
		// 게시글 삭제 후 공지사항 or 자유게시판 페이지로 돌아가기 위해 type = board_class 설정
		BoardDTO boardDTO = boardService.selectByBoardIdService(board_id);
		String type = boardDTO.getBoard_class();
		String encodedType = URLEncoder.encode(type, StandardCharsets.UTF_8.toString());
		
		boardService.deleteService(board_id);
		
		return "redirect:list?type=" + encodedType;
	}
	
	// 게시글 수정 화면
	@GetMapping(value = "/update")
	public String boardUpdate(Integer board_id, Model model) {
		BoardDTO boardDTO = boardService.selectByBoardIdService(board_id);
		
		model.addAttribute("boardDTO", boardDTO);
		
		return "board/boardUpdate";
	}
	
	// 게시글 수정
	@ResponseBody
	@PostMapping(value = "/update", consumes = MediaType.APPLICATION_JSON_VALUE,
			produces = "text/plain;charset=utf-8")
	public String boardUpdate(@RequestBody BoardDTO boardDTO) {
		int result = boardService.updateService(boardDTO);
		
		String type = boardDTO.getBoard_class();
		
		return result > 0 ? type + "이 수정되었습니다." : type + " 수정을 실패했습니다.";
	}
	
}
