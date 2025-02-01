package com.salre.main.login;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString

public class UserDTO {

	private int user_id;//auto inc
	private String id; 
    private String password; 
    private String user_name; 
    private String phone_num;
    private String email; 
    private String resident_num; 
    private String address; 
    private String address_detail; 
    private String resident_num2; 
	
}
