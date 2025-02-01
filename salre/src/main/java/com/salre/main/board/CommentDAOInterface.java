package com.salre.main.board;

import java.util.List;

public interface CommentDAOInterface {
	
	// 댓글 등록
	public void register(CommentDTO commentDTO);
	
	// 해당 게시글에 작성된 댓글 리스트 가져오기
	public List<CommentDTO> selectAll(Integer board_id);
	
	// 해당 댓글 정보 조회
	public CommentDTO selectByCommentId(Integer comment_id);
	
	// 댓글 수정
	public int updateComment(CommentDTO commentDTO);
	
	// 댓글 삭제
	public void deleteComment(Integer comment_id);
	
	// 댓글 수
	public int selectCommentCnt(Integer board_id);

}
