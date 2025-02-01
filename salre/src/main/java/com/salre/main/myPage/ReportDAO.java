package com.salre.main.myPage;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("ReportDAO")
public class ReportDAO {
	@Autowired
	private SqlSession sqlSession;
	String namespace = "com.salre.main.myPage.ReportDAO";

	
	public int addReport(int user_id,int product_id,
			String report_content,int report_class, String status) {
		Map<String, Object> params = new HashMap<>();
		params.put("user_id", user_id);
		params.put("product_id", product_id);
		params.put("report_content", report_content);
		params.put("report_class", report_class);
		params.put("status", status);
		int result = sqlSession.insert(namespace + ".insertReport",params);
	 return result;
	}
	
}
