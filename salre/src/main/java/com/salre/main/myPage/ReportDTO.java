package com.salre.main.myPage;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReportDTO {
	private int report_id;
	private int user_id;
	private int product_id;
	private int report_class;
	private String report_content;
	private Timestamp report_time;
	private String status;
	
	
}
