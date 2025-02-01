package com.salre.main.myPage;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PostDTO {
	private int board_id; 
	private int user_id; 
	private String board_class;
	private String board_title; 
	private String board_content; 
	private Timestamp created_at; 
	private Timestamp updated_at; 
	private int click_cnt; 
}
