package com.salre.main.myPage;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReviewDTO {
	private int review_id;
	private int user_id;
	private int seller_id;
	private int review_rate;
	private String review_content;
	private String seller_name; 
	private String product_name; 
	private boolean reviewWritten;// 추가된 필드
	private boolean is_review;// 추가된 필드
	private int product_id;      // 추가된 필드 상품 ID
	private int product_status;      // 추가된 필드 상품 ID
	
}
