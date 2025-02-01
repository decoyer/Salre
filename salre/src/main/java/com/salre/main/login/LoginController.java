package com.salre.main.login;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.salre.main.myPage.ReportDTO;

@Controller
public class LoginController {
	@Autowired
	private UserService userService;

	@Autowired
    private ApplicationContext applicationContext;
    
	private static String impKey;
    private static String impKey2;
    private static String impSecret;
	private static String channelKey;
    
    @PostConstruct
    public void init() {
        Properties props = (Properties) applicationContext.getBean("apikey");
		impKey = props.getProperty("impKey");
        impKey2 = props.getProperty("impKey2");
        impSecret = props.getProperty("impSecret");
        channelKey = props.getProperty("channelKey");
    }
	
	// 본인인증 페이지
	@GetMapping("/signup")
	public String signupPage(Model model) {
		model.addAttribute("impKey", impKey);
		model.addAttribute("channelKey", channelKey);
		return "logIn/signUpAuth"; // signup.jsp 반환
	}
	
	
	  // 본인인증 처리
	  @PostMapping("/certify")
	//메서드의 반환값을 JSON 또는 문자열과 같은 HTTP 응답 본문에 직접 포함
	  public ResponseEntity<String> processCertification(@RequestParam("certificationResult") boolean certificationResult, HttpSession session){ 
	  if(certificationResult) {
	  session.setAttribute("isCertified", true); // 인증 성공 상태 저장 return
	  return ResponseEntity.ok("Certification Successful"); 
	  }else {
	  session.setAttribute("isCertified", false); // 인등 실패 상태 저장 return
	  return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Certification Failed"); 
	  	}
	  }
	  
		@GetMapping("/logout")
		public String logout() {
			return "common/logout";
		}
	
		// 회원가입 처리
	@PostMapping("/signup")
	public String registerUser(UserDTO user, Model model) {
		int result = userService.registerUser(user);
		model.addAttribute("message", result > 0 ? "회원가입 성공" : "회원가입 실패");
		
		return "redirect:login"; // 회원가입 후 로그인 페이지로 이동 //salre/ 추가했음
	}

	
	// 회원정보입력 페이지
	@GetMapping("/signUpInfo")
	public String signupInfoPage() {
		return "logIn/signUpInfo"; // signup.jsp 반환
	}

	@GetMapping("/login")
	public String loginPage(@RequestParam(value = "redirectUri", required = false) String redirectUri, HttpSession session) {
		// 리다이렉트할 URI를 세션에 저장
		if (redirectUri != null && !redirectUri.contains("/login")) { // 로그인 페이지는 제외
			session.setAttribute("redirectUri", redirectUri);
		}
		return "logIn/login"; // 로그인 페이지 반환
	}

	@GetMapping("/admin/myPage")
	public void admin() {
	}

	// 로그인 처리
	@PostMapping("/login")
	public String loginUser(@RequestParam String id, @RequestParam String password, HttpSession session, Model model) {
		UserDTO user = userService.loginUser(id, password);
		// System.out.println("user : " + user);
		if (user != null) {
			session.setAttribute("loggedInUser", user);
			if (id.equals("admin")) {
				session.setAttribute("contractStatusPending", 10); // 계약대기
				session.setAttribute("contractStatusNegotiating", 5); // 계약협의 중
				session.setAttribute("contractStatusOngoing", 15); // 계약진행 중 
				session.setAttribute("contractStatusCompleted", 20); // 계약완료
				session.setAttribute("propertyReportCount", 30); // 매물신고건수
				session.setAttribute("boardReportCount", 12); // 게시판 신고 건수
				session.setAttribute("userReportCount", 8); // 유저 신고 건수
				session.setAttribute("board1PostCount", 150); // 게시판 1 게시물 수
				session.setAttribute("board2PostCount", 120); // 게시판 2 게시물 수
				session.setAttribute("board3PostCount", 130); // 게시판 3 게시물 수
				session.setAttribute("contractCount", 50); // 전체 계약 건수
				return "redirect:admin/productreport";
			}
			model.addAttribute("user", user);
			return "redirect:/"; // 홈으로 이동

			// return "redirect:/home"; 
		}

		else {
			model.addAttribute("error", "ID 또는 PW가 잘못되었습니다.");
			return "logIn/login"; 
		}
	}

	// ID 찾기 페이지
	@GetMapping("/findId")
	public String findIdPage() {
		return "/logIn/findId";
	}

	// ID 찾기 처리
	@PostMapping("/findId")
	public String processFindId(@RequestParam("email") String email,@RequestParam("user_name") String name, Model model) {
		
		String userId = userService.findIdByEmailAndName(email,name);
		System.out.println("userID###### : " + userId);

		if (userId != null) {
			model.addAttribute("message", "Your ID is : " + userId);
		} else {
			model.addAttribute("error", "등록된 회원을 찾을 수 없습니다.");
		}

		return "/logIn/findId";
	}
	

	// PW 찾기 페이지
	@GetMapping("/findPassword")
	public String findPasswordPage() {
		return "/logIn/findPassword";
	}
	
	
	// PW 찾기 처리_20250105
	 @PostMapping("/sendVerificationCode")
	    @ResponseBody
	    public Map<String, Object> sendVerificationCode(@RequestParam String id, @RequestParam String email) {
	        Map<String, Object> response = new HashMap<>();
	        boolean isValidUser = userService.validateUser(id, email);
	        System.out.println("@@ id email = " + id + email);

	        if (!isValidUser) {
	            response.put("success", false);
	            response.put("message", "ID와 이메일이 등록된 정보와 일치하지 않습니다.");
	            return response;
	        }

	        userService.generateVerificationCode(email);
	        response.put("success", true);
	        response.put("message", "인증번호가 이메일로 발송되었습니다.");
	        return response;
	    }

	    @PostMapping("/verifyCode")
	    @ResponseBody
	    public Map<String, Object> verifyCode(@RequestParam String verificationCode, @RequestParam String email) {
	        Map<String, Object> response = new HashMap<>();
	        boolean isCodeValid = userService.verifyCode(email, verificationCode);

	        if (isCodeValid) {
	            response.put("success", true);
	            response.put("message", "인증번호가 확인되었습니다. 새 비밀번호를 입력하세요.");
	        } else {
	            response.put("success", false);
	            response.put("message", "인증번호가 유효하지 않습니다.");
	        }
	        return response;
	    }

	    @PostMapping("/resetPassword")
	    @ResponseBody
	    public Map<String, Object> resetPassword(@RequestParam String email, @RequestParam String newPassword) {
	        Map<String, Object> response = new HashMap<>();

	        userService.updatePassword(email, newPassword);
	        response.put("success", true);
	        response.put("message", "비밀번호가 성공적으로 변경되었습니다..");
	        return response;
	    }

		/*
		 * @GetMapping("/admin/boardreport"){ return "admin/boardreport"; }
		 */

		@GetMapping("/admin/productreport")
		public String productReport(Model model) {
			int report_class=0;  
	        List<ReportDTO> reportedProperties = userService.getAdminPropertiesReportsByReportClass(report_class);
	        System.out.println("reportedProperties: " + reportedProperties);
	        model.addAttribute("reportedProperties", reportedProperties);
			return "admin/productreport";
		}

		
		@PostMapping("/admin/handlePropertyReport") 
		public String handlePropertyReport(  int report_id , String action ,  RedirectAttributes redirectAttributes) {
			System.out.println("report_id : " + report_id + ":"+ action);
	 

		    if ("resolve".equals(action)) {
		        userService.updateReportStatus(report_id, "resolved"); // 신고 무효화 상태 업데이트
		        redirectAttributes.addFlashAttribute("message", "신고가 반려되었습니다.");
		    } else if ("delete".equals(action)  ) {
		    	//userService.deletePropertyById(product_id); // 매물 삭제
		    	userService.updateReportStatus(report_id, "deleted"); // 매물 삭제 상태 업데이트
		        redirectAttributes.addFlashAttribute("message", "매물이 삭제되었습니다.");
		    } else {
		        redirectAttributes.addFlashAttribute("error", "잘못된 요청입니다.");
		    }
		    return "redirect:/admin/productreport";
		}

		@GetMapping("/admin/userreport")
		public String userreport() {

			return "admin/userreport";
		}

		@PostMapping("/admin/myPage")
		public String handleAdminPost(HttpSession session) {
			UserDTO user = (UserDTO) session.getAttribute("loggedInUser");
			if (user == null) {
				return "redirect:/login"; 
			}

			
			return "redirect:/admin/myPage"; 
		}

		
		//회원정보수정
		  @GetMapping("/updatemyPage") 
		  public String updateUser() {
			  return "myPage/updateMyPage";
		  }
		  
		//회원정보수정(인증 후 data)
		  @GetMapping("/getSessionData")
		  @ResponseBody
		  public Map<String, String> getSessionData(HttpSession session) {
		      Map<String, String> response = new HashMap<>();
		      response.put("name", (String) session.getAttribute("certifiedName"));
		      response.put("phone", (String) session.getAttribute("certifiedPhone"));
		      response.put("birthday", (String) session.getAttribute("certifiedBirthday"));
		      return response;
		  }

	
		  
		//회원정보수정버튼 누르면 update
		  @PostMapping("/updateUserInfo")
		  @ResponseBody
		  public Map<String, Object> updateUserInfo(@RequestBody UserDTO user, HttpSession session) {
		      Map<String, Object> response = new HashMap<>();
		      try {
		    	// 세션에서 기존 데이터를 가져옴
		          UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");

		       // 기존 값 유지 로직
		          if (loggedInUser != null) {  //유저 로그인상태 확인
		              if (user.getPassword() == null || user.getPassword().isEmpty()) {
		                  user.setPassword(loggedInUser.getPassword()); // 기존 암호 유지
		              }
		             
		          }

		          // 업데이트 호출
		          userService.updateUserInfo(user);

		          // 세션 업데이트
		          session.setAttribute("loggedInUser", user);

		          response.put("success", true);
		      } catch (Exception e) {
		          response.put("success", false);
		          e.printStackTrace();
		      }
		      return response;
		  }


		  
		 
	
		 // 회원탈퇴 처리
	@PostMapping("/deleteUser")
	public String deleteUser(@RequestParam("id") String id, RedirectAttributes redirectAttributes) { // RedirectAttributes

		try {
			userService.deleteUser(id);
			redirectAttributes.addFlashAttribute("message", "회원탈퇴가 완료되었습니다.");																
			return "redirect:/login";
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "회원탈퇴 중 오류가 발생했습니다.");
			return "redirect:/myPage";
		}
	}

	
	
	//회원가입-본인인증
	@ResponseBody
	@PostMapping(value = "/rspTest2")
	public String rspTest(String imp_uid, HttpSession session, Model model) {
	    String jsonBody = "{\"imp_key\":\"" + impKey2 + "\", \"imp_secret\":\"" + impSecret + "\"}";
	    HttpRequest request = HttpRequest.newBuilder()
	            .uri(URI.create("https://api.iamport.kr/users/getToken"))
	            .header("Content-Type", "application/json")
	            .method("POST", HttpRequest.BodyPublishers.ofString(jsonBody))
	            .build();
	    HttpResponse<String> response = null;
	    try {
	        response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
	    } catch (IOException | InterruptedException e) {
	        e.printStackTrace();
	    }
	    String jsonResponse = response.body();
	    ObjectMapper objectMapper = new ObjectMapper();
	    JsonNode rootNode = null;
	    try {
	        rootNode = objectMapper.readTree(jsonResponse);
	    } catch (JsonProcessingException e) {
	        e.printStackTrace();
	    }
	    String token = rootNode.path("response").path("access_token").asText();
	    HttpRequest request2 = HttpRequest.newBuilder()
	            .uri(URI.create("https://api.iamport.kr/certifications/" + imp_uid))
	            .header("Content-Type", "application/json")
	            .header("Authorization", "Bearer " + token)
	            .method("GET", HttpRequest.BodyPublishers.ofString(""))
	            .build();
	    HttpResponse<String> response2 = null;
	    try {
	        response2 = HttpClient.newHttpClient().send(request2, HttpResponse.BodyHandlers.ofString());
	    } catch (IOException | InterruptedException e) {
	        e.printStackTrace();
	    }
	    String jsonResponse2 = response2.body();
	    System.out.println("########JSON Response from API: " + jsonResponse2);
	    try {
	        // JSON 데이터 파싱 및 세션 저장
	        JsonNode userNode = objectMapper.readTree(jsonResponse2).path("response");
	        if (userNode != null) {
	            String name = userNode.path("name").asText(null);
	            String phone = userNode.path("phone").asText(null);
	            String birthday = userNode.path("birthday").asText(null);
	            // 생년월일 포맷 변환 (yyyy-MM-dd -> yyMMdd)
	            if (birthday != null) {
	                LocalDate date = LocalDate.parse(birthday, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
	                birthday = date.format(DateTimeFormatter.ofPattern("yyMMdd"));
	            }
	            
	            // 세션에 저장
	            session.setAttribute("certifiedName", name);
	            session.setAttribute("certifiedPhone", phone);
	            session.setAttribute("certifiedBirthday", birthday);
	           
	            System.out.println("Session Data Saved:");
	            System.out.println("Name: " + session.getAttribute("certifiedName"));
	            System.out.println("Phone: " + session.getAttribute("certifiedPhone"));
	            System.out.println("Birthday: " + session.getAttribute("certifiedBirthday"));
	        }
	    } catch (JsonProcessingException e) {
	        e.printStackTrace();
	    }
	    return jsonResponse2; // JSON 데이터를 그대로 반환
	}
	// 회원정보수정 - 본인인증버튼
		@ResponseBody
		@PostMapping(value = "/rspTest3")
		public String rspTest3(String imp_uid, HttpSession session) {
		    String jsonBody = "{\"imp_key\":\"" + impKey2 + "\", \"imp_secret\":\"" + impSecret + "\"}";

		    HttpRequest request = HttpRequest.newBuilder()
		            .uri(URI.create("https://api.iamport.kr/users/getToken"))
		            .header("Content-Type", "application/json")
		            .method("POST", HttpRequest.BodyPublishers.ofString(jsonBody))
		            .build();

		    HttpResponse<String> response = null;
		    try {
		        response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
		    } catch (IOException | InterruptedException e) {
		        e.printStackTrace();
		    }
		    String jsonResponse = response.body();
		    ObjectMapper objectMapper = new ObjectMapper();

		    JsonNode rootNode = null;
		    try {
		        rootNode = objectMapper.readTree(jsonResponse);
		    } catch (JsonProcessingException e) {
		        e.printStackTrace();
		    }

		    String token = rootNode.path("response").path("access_token").asText();

		    HttpRequest request2 = HttpRequest.newBuilder()
		            .uri(URI.create("https://api.iamport.kr/certifications/" + imp_uid))
		            .header("Content-Type", "application/json")
		            .header("Authorization", "Bearer " + token)
		            .method("GET", HttpRequest.BodyPublishers.ofString(""))
		            .build();

		    HttpResponse<String> response2 = null;
		    try {
		        response2 = HttpClient.newHttpClient().send(request2, HttpResponse.BodyHandlers.ofString());
		    } catch (IOException | InterruptedException e) {
		        e.printStackTrace();
		    }

		    String jsonResponse2 = response2.body();
		    System.out.println("########JSON Response from API: " + jsonResponse2);

		    try {
		    	// JSON 데이터 파싱 및 세션 저장
		        JsonNode userNode = objectMapper.readTree(jsonResponse2).path("response");
		        if (userNode != null) {
		            String name = userNode.path("name").asText(null);
		            String phone = userNode.path("phone").asText(null);
		            String birthday = userNode.path("birthday").asText(null);

		            // 생년월일 포맷 변환 (yyyy-MM-dd -> yyMMdd)
		            if (birthday != null) {
		                LocalDate date = LocalDate.parse(birthday, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		                birthday = date.format(DateTimeFormatter.ofPattern("yyMMdd"));
		            }
		         // 세션에 저장된 기존 데이터와 병합
		            UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
		            if (loggedInUser != null) {
		                if (name != null) loggedInUser.setUser_name(name);
		                if (phone != null) loggedInUser.setPhone_num(phone);
		                if (birthday != null) loggedInUser.setResident_num(birthday);
		                session.setAttribute("loggedInUser", loggedInUser);
		            }

		         // 세션에 저장
		            session.setAttribute("certifiedName", name);
		            session.setAttribute("certifiedPhone", phone);
		            session.setAttribute("certifiedBirthday", birthday);

		            System.out.println("Session Data Saved:");
		            System.out.println("Name: " + session.getAttribute("certifiedName"));
		            System.out.println("Phone: " + session.getAttribute("certifiedPhone"));
		            System.out.println("Birthday: " + session.getAttribute("certifiedBirthday"));
		        }
		    } catch (JsonProcessingException e) {
		        e.printStackTrace();
		    }

		    return jsonResponse2; // JSON 데이터를 그대로 반환
		}
	
	
	
	
}
