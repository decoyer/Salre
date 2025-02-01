package com.salre.main.login;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController // 반환값을 JSP와 같은 View가 아니라 JSON이나 XML 형식의 데이터로 반환
public class RestLoginController {

	@Autowired
	private UserService userService;

	// ID 중복체크
	@GetMapping("/checkId")
	public ResponseEntity<String> checkId(@RequestParam("id") String id) {
		boolean isAvailable = userService.isIdAvailable(id);
		System.out.println("@@@id = " + id);
		return isAvailable ? ResponseEntity.ok("available") : ResponseEntity.ok("unavailable");
	}

	// email 중복체크
	@GetMapping("/checkEmail")
	@ResponseBody
	public String checkEmail(@RequestParam("email") String email) {
		boolean isAvailable = userService.isEmailAvailable(email);
		return isAvailable ? "available" : "unavailable";
	}

}