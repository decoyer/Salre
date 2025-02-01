package com.salre.main.board;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
public class CommentDTO {
	Integer comment_id; // 댓글 번호
	Integer user_id; // 회원 번호
	Integer board_id; // 게시글 번호
	String comment_writer; // 댓글 작성자
	String comment_content; // 댓글 내용
	Timestamp created_at; // 댓글 작성일자
	Timestamp updated_at; // 댓글 수정일자
}
