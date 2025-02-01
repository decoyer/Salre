package com.salre.main.myPage;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LikeDTO {
	private int like_id;
	private int product_id;
	private int user_id;
	@JsonProperty("is_liked") // JSON 키와 매핑 강제 지정
	private boolean is_liked; 
}
