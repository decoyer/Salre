package com.salre.main.product;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
@Setter
@ToString
public class ProductDTO {

	int product_id;
	int user_id;
	Integer region_id;
	String product_name;
	String payment_type;
	Integer product_status;
	int view_count;
	String address;
	String address_detail;
	int deposit;
	int rentfee;
	double area;
	String product_type;
	Integer floor;
	Date enter_day;
	Integer room_count;
	int bath_count;
	Date approve_day;
	int park_count;
	int manage_fee;
	String direction;
	String description;
	String land_type;
	String land_area;
	String building_structure;
	String building_usage;
	String rental_area;
	int loan1;
	int loan2;
	int loan3;
}
