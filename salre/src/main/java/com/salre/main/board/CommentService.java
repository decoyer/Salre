package com.salre.main.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CommentService {
	
	@Autowired
	CommentDAOMybatis commentDAOMybatis;

	// 댓글 등록
	public void register(CommentDTO commentDTO) {
		commentDAOMybatis.register(commentDTO);
	}

	// 해당 게시글에 작성된 댓글 리스트 가져오기
	public List<CommentDTO> selectAllService(Integer board_id) {
		return commentDAOMybatis.selectAll(board_id);
	}

	// 해당 댓글 정보 조회
	public CommentDTO selectByCommentIdService(Integer comment_id) {
		return commentDAOMybatis.selectByCommentId(comment_id);
	}

	// 댓글 수정
	public int updateCommentService(CommentDTO commentDTO) {
		return commentDAOMybatis.updateComment(commentDTO);
	}

	// 댓글 삭제
	public void deleteService(Integer comment_id) {
		commentDAOMybatis.deleteComment(comment_id);
	}

	// 댓글 수
	public int selectCommentCnt(Integer board_id) {
		return commentDAOMybatis.selectCommentCnt(board_id);
	}

}
