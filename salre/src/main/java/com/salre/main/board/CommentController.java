package com.salre.main.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/comment")
public class CommentController {
	
	@Autowired
	CommentService commentService;
	
	// 댓글 등록
	@ResponseBody
	@PostMapping(value = "/register")
	public List<CommentDTO> commentRegister(@RequestBody CommentDTO commentDTO) {
		log.info("commentDTO : " + commentDTO);
		
		// 댓글 등록
		commentService.register(commentDTO);
		
		// 해당 게시글에 작성된 댓글 리스트 가져오기
		List<CommentDTO> commentDTOList = commentService.selectAllService(commentDTO.getBoard_id());
		log.info("commentDTOList : " + commentDTOList);
		
		return commentDTOList;
	}
	
	// 댓글 수정 화면
	@ResponseBody
	@GetMapping(value = "/update")
	public CommentDTO commentUpdatePage(Integer comment_id) {
		// 해당 댓글 정보 조회
		CommentDTO commentDTO = commentService.selectByCommentIdService(comment_id);
		
		return commentDTO;
	}
	
	// 댓글 수정
	@ResponseBody
	@PostMapping(value = "/update", consumes = MediaType.APPLICATION_JSON_VALUE,
			produces = "application/json;charset=utf-8")
	public Map<String, Object> commentUpdate(@RequestBody CommentDTO commentDTO) {
		// 댓글 수정
		int result = commentService.updateCommentService(commentDTO);
		
		// 댓글 수정 후 댓글 리스트 가져오기
		List<CommentDTO> commentDTOList = commentService.selectAllService(commentDTO.getBoard_id());
		
		Map<String, Object> response = new HashMap<>();
	    response.put("resultMessage", result > 0 ? "게시글이 수정되었습니다." : "게시글 수정을 실패했습니다.");
	    response.put("commentDTOList", commentDTOList);
	    
	    return response;
	}
	
	// 댓글 수정 취소
	@ResponseBody
	@GetMapping(value = "/updateCancel")
	public List<CommentDTO> commentUpdateCancel(Integer board_id) {
		// 해당 게시글에 작성된 댓글 리스트 가져오기
		List<CommentDTO> commentDTOList = commentService.selectAllService(board_id);
		log.info("commentDTOList : " + commentDTOList);
		
		return commentDTOList;
	}
	
	// 댓글 삭제
	@ResponseBody
	@GetMapping(value = "/deleteComment")
	public List<CommentDTO> commentDelete(@RequestParam Integer comment_id, @RequestParam Integer board_id) {
		// 댓글 삭제
		commentService.deleteService(comment_id);
		
		// 댓글 삭제 후 댓글 리스트 가져오기
		List<CommentDTO> commentDTOList = commentService.selectAllService(board_id);
		log.info("commentDTOList : " + commentDTOList);
		
		return commentDTOList;
	}

}
