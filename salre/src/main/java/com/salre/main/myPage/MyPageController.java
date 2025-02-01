package com.salre.main.myPage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.salre.main.login.UserDTO;
import com.salre.main.login.UserService;
import com.salre.main.product.ProductDTO;
import com.salre.main.product.ProductService;
@Controller
public class MyPageController {

	@Autowired
	private UserService userService;
	@Autowired
	private ProductService productService;
	
	//마이페이지
	@GetMapping("/myPage")
	public String userInfo(HttpSession session, Model model) {	    
		return "myPage/myPage";
	}
	
 
	//마이페이지 - 나의 관심매물
	@GetMapping("/favorites")
	public String getFavoriteItems(Model model, HttpSession session) {
		   UserDTO user = (UserDTO) session.getAttribute("loggedInUser");
		   if (user == null) {
			   return "redirect:/login"; // 로그인 페이지로 리다이렉트
		   }

		   int user_id = user.getUser_id();
		   List<ProductDTO> favoritesList = userService.getFavoritesByUserId(user_id);
		   model.addAttribute("favoritesList", favoritesList);
		   return "myPage/favorites"; // JSP 파일 경로
	   }


	
	//01.10테스트코드
	//마이페이지-나의관심매물-좋아요해제(매물카드삭제)
	  @PostMapping("/toggleLike")
	  @ResponseBody
	  public Map<String, Object> toggleLike(@RequestBody LikeDTO userlike) {
	      Map<String, Object> response = new HashMap<>();
	      System.out.println("##5 userlike = "+userlike);
	      System.out.println("##4 userlike.is_liked = "+userlike.is_liked());
	   
	      try {
	          if (userlike.is_liked()) {
	        	  System.out.println("##1 userlike.is_liked = "+userlike.is_liked());
	              userService.updateFavorite(userlike);
	              System.out.println("##2 userlike.is_liked = "+userlike.is_liked());
	              response.put("success", true);
	              response.put("message", "좋아요가 취소되었습니다.");
	              
	          } else {
	        	  userService.insertFavorite(userlike);
	        	  System.out.println("##3 userlike.is_liked = "+userlike.is_liked());
	              response.put("success", true);
	              response.put("message", "좋아요가 등록되었습니다.");
	          }
	      } catch (Exception e) {
	          response.put("success", false);
	          response.put("message", "처리 중 오류가 발생했습니다.");
	      }
	      return response;
	  }

	 
	


   //나의 거래현황
   /*
	* @GetMapping("/transactions") public String transactions() { return
	* "myPage/transactions"; }
	*/
   @GetMapping("/transactions") 
   public String transactions(HttpSession session, Model model) {
	  Object userObj = session.getAttribute("loggedInUser");

	   if (userObj instanceof UserDTO) {
		   UserDTO user = (UserDTO) userObj;
		   int user_id = user.getUser_id(); // user_id �뜝�룞�삕�뜝�룞�삕
		   System.out.println("Extracted user_id: " + user_id);

		   // 구매자 거래 매물 목록 가져오기
		   List<ProductDTO> buyerProductList = userService.getBuyerTransactionByUserId(user_id);
		   System.out.println("@#$buyerProductList: " + buyerProductList);
		   model.addAttribute("buyerProductList", buyerProductList);
		  
		   // 판매자 거래 매물 목록 가져오기
		   List<ProductDTO> productList = userService.getTransactionByUserId(user_id);
//	        System.out.println("productList: " + productList);
		   model.addAttribute("productList", productList);

		   return "myPage/transactions"; 
	   } else {
		 
		   System.out.println("로그인 후 이용해주세요.");
		   return "redirect:/login";  // 로그인 페이지로 리다이렉트
	   }
   }

	@PostMapping("/transactions/registerReview")
	@ResponseBody
	public Map<String, Object> updateReview(@RequestBody ReviewDTO review, 
	                                        @RequestParam int product_id, 
	                                        HttpSession session) {
	    Map<String, Object> response = new HashMap<>();

	    try {
	        // 세션에서 UserDTO 객체 가져오기
	        Object userObj = session.getAttribute("loggedInUser");
	        if (userObj == null) {
	            throw new IllegalArgumentException("로그인 정보가 없습니다.");
	        }

	        UserDTO user = (UserDTO) userObj;
	        int user_id = user.getUser_id(); // user_id 추출
	        System.out.println("### user_id: " + user_id);
	        //System.out.println("### product_id: " + product_id);
	        

	        // ProductDTO를 통해 seller_id 가져오기
	        ProductDTO product = productService.selectByIdService(product_id);
	        if (product == null) {
	            throw new IllegalArgumentException("유효하지 않은 product_id입니다.");
	        }
	        System.out.println(product_id);
	        int seller_id = product.getUser_id();
	        	
	        // ReviewDTO에 user_id와 seller_id 설정
	        review.setUser_id(user_id);
	        review.setSeller_id(seller_id);
	        review.setProduct_id(product_id);
	        
	        // 리뷰 중복 작성 확인
	        boolean is_review = userService.isReviewWritten(review);
	        if (is_review) {
	            throw new IllegalArgumentException("이미 작성된 리뷰입니다.");
	        }

	        // 후기를 등록
	        userService.registerReview(review);

	        response.put("success", true);
	    } catch (IllegalArgumentException e) {
	        response.put("success", false);
	        response.put("message", e.getMessage());
	    } catch (Exception e) {
	        response.put("success", false);
	        response.put("message", "후기 등록 중 알 수 없는 오류가 발생했습니다.");
	        e.printStackTrace();
	    }

	    return response;
	}

			
			
	//마이페이지  - 내가 작성한 글
	@GetMapping("/posts")
	public String getMyPosts(HttpSession session, Model model) {
	   
	    Object userObj = session.getAttribute("loggedInUser");
	    
	    if (userObj instanceof UserDTO) {
	        UserDTO user = (UserDTO) userObj;
	        int user_id = user.getUser_id(); // user_id 추출
	        System.out.println("Extracted user_id: " + user_id);

	        // 작성 글 목록 가져오기
	        List<PostDTO> postList = userService.getPostsByUserId(user_id);
	        
	        // 게시글별 댓글 수 추가
			/*
			 * Map<Integer, Integer> commentCountMap = new HashMap<>(); for (PostDTO post :
			 * postList) { int commentCount =
			 * commentService.selectCommentCnt(post.getBoard_id());
			 * //System.out.println("@@Board ID: " + post.getBoard_id());
			 * //System.out.println("@@Comment Count: " + commentCount);
			 * commentCountMap.put(post.getBoard_id(), commentCount);
			 }*/
			 
	        System.out.println("postList: " + postList);
	        //System.out.println("commentCountMap: " + commentCountMap);
	        model.addAttribute("postList", postList);
	        //model.addAttribute("commentCountMap", commentCountMap);
	        return "myPage/posts"; // post.jsp 占쏙옙환
	    } else {
	        
	        System.out.println("로그인 후 이용해주세요.");
	        return "redirect:/login"; 
	    }
	}
	
	
	
 
	
	//마이페이지  - 나의 거래후기
	@GetMapping("/reviews") 
	public String getMyreviews(HttpSession session, Model model) {		  
	    Object userObj = session.getAttribute("loggedInUser");
	    
	    if (userObj instanceof UserDTO) {
	        UserDTO user = (UserDTO) userObj;
	        int user_id = user.getUser_id(); // user_id 추출
	        System.out.println("Extracted user_id: " + user_id);

	        List<ReviewDTO> reviewList = userService.getMyreviewsByUserId(user_id);
	        System.out.println("reviewList: " + reviewList);
	        model.addAttribute("reviewList", reviewList);
	        return "myPage/reviews"; // reviews.jsp 반환
	    } else {
	        System.out.println("로그인 후 이용해주세요.");
	        return "redirect:/login"; 
	    }
	
	}

	
	//마이페이지  - 나의 거래후기(수정)
	@PostMapping("/reviews/update")
	@ResponseBody
	public Map<String, Object> updateReview(@RequestParam int review_id,
	                                        @RequestParam int review_rate,
	                                        @RequestParam String review_content) {
	    Map<String, Object> response = new HashMap<>();

	    try {
	        userService.updateReview(review_id, review_rate, review_content);
	        response.put("success", true);
	    } catch (Exception e) {
	        response.put("success", false);
	        response.put("message", "후기 수정에 실패했습니다.");
	    }

	    return response;
	}

	//마이페이지  - 나의 거래후기(삭제)
		@PostMapping("/reviews/delete")
		@ResponseBody
		public Map<String, Object> deleteReview(@RequestParam int review_id){
			Map<String, Object> response = new HashMap<>();
			
			try {
				userService.deleteReview(review_id);
				response.put("success", true);
				response.put("message", "후기가 성공적으로 삭제되었습니다.");
				
			}catch(Exception e) {
				response.put("success", false);
				response.put("message", "후기 삭제에 실패했습니다.");
			}
			return response;
		}


	//마이페이지 - 나의 신고내역
		@GetMapping("/reports") 
		public String getMyreports(HttpSession session, Model model) {
			 
		    Object userObj = session.getAttribute("loggedInUser");
		    
		    if (userObj instanceof UserDTO) {
		        UserDTO user = (UserDTO) userObj;
		        int user_id = user.getUser_id(); // user_id 추출
		        System.out.println("Extracted user_id: " + user_id);
		        // Service 
		        List<ReportDTO> reportList = userService.getMyreportsByUserId(user_id);
		        System.out.println("reportList: " + reportList);
		        model.addAttribute("reportList", reportList);
		        return "myPage/reports"; // reports.jsp 占쏙옙환
		    } else {
		        
		        System.out.println("로그인 후 이용해주세요.");
		        return "redirect:/login"; 
		    }
		
		}
		@PostMapping("/addreports")
		public ResponseEntity<String> addReports(@RequestParam("reportType") int reportType,
		                       @RequestParam("reportContent") String reportContent,
		                       @RequestParam("product_id") int productId,
		                       @RequestParam("status") String status,
		                       HttpSession session) {
		    // 현재 로그인한 사용자 정보 가져오기
		    UserDTO user = (UserDTO) session.getAttribute("loggedInUser");
		    int userId = user.getUser_id();
		    System.out.println(status);
		    // 신고 내용 저장 처리
		    userService.addReport(userId, productId, reportContent, reportType, status);

		    // 로깅 (디버깅 용도로 사용)
		    System.out.println("신고 저장 완료 - 유저 ID: " + userId + ", 상품 ID: " + productId + 
		                       ", 신고 유형: " + reportType + ", 내용: " + reportContent);
		    return ResponseEntity.ok("신고가 성공적으로 접수되었습니다.");
		}
}
