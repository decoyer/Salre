package com.salre.main.contract;

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
public class ContractUserDTO {
	int contract_id;
	int user_id;
	int product_id;
	int price;
	String account;
	int contract_status;
	
	
	
	String id;
	String password;
	String user_name;
	String phone_num;
	String email;
	String resident_num;
	String address;
	String address_detail;
	String resident_num2;
}
