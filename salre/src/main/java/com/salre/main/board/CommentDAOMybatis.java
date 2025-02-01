package com.salre.main.board;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class CommentDAOMybatis implements CommentDAOInterface {
	
	@Autowired
	SqlSession sqlSession;
	
	// commentMapper.xml
	String namespace = "com.salre.main.board.comment.";

	// 댓글 등록
	public void register(CommentDTO commentDTO) {
		sqlSession.insert(namespace + "register", commentDTO);
	}

	// 해당 게시글에 작성된 댓글 리스트 가져오기
	public List<CommentDTO> selectAll(Integer board_id) {
		return sqlSession.selectList(namespace + "selectAll", board_id);
	}

	// 해당 댓글 정보 조회
	public CommentDTO selectByCommentId(Integer comment_id) {
		return sqlSession.selectOne(namespace + "selectByCommentId", comment_id);
	}

	// 댓글 수정
	public int updateComment(CommentDTO commentDTO) {
		int result = sqlSession.update(namespace + "updateComment", commentDTO);
		log.info("[updateComment] 수정 건수 : " + result);
		
		return result;
	}

	// 댓글 삭제
	public void deleteComment(Integer comment_id) {
		sqlSession.delete(namespace + "deleteComment", comment_id);
	}

	// 댓글 수
	public int selectCommentCnt(Integer board_id) {
		return sqlSession.selectOne(namespace + "selectCommentCnt", board_id);
	}

}
