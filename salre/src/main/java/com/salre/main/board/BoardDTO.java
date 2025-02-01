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
public class BoardDTO {
	Integer board_id; // 게시글 번호
	Integer user_id; // 회원 번호
	String writer; // 작성자
	String board_class; // 게시판 분류(공지사항, 자유게시판)
	String board_title; // 게시글 제목
	String board_content; // 게시글 내용
	Timestamp created_at; // 생성일시(작성일자)
	Timestamp updated_at; // 수정일시
	Integer click_cnt; // 조회수
}
