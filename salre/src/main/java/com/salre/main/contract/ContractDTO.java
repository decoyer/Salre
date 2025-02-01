package com.salre.main.contract;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Builder
@Setter@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class ContractDTO {
	int contract_id;
	private int user_id;
	private int product_id;
	private int price;
	private int contract_status;
	
	private Date contract_startdate;
	private Date contract_enddate;
	private Date contract_date;
	private String contract_rule;
	
	private	Integer middle_payment;
	private Integer balance_payment;
	private String balance_payment_day;
	private String middle_payment_day;
	private Integer rent_fee_day; //1일 ,,,2일...3등
	
	private String account; 
	private String bank_name;
	private String account_name;
	
	private String contract_epath;
	private String contract_imgpath;
	
}
