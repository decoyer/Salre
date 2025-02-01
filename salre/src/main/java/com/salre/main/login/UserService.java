package com.salre.main.login;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.salre.main.myPage.LikeDTO;
import com.salre.main.myPage.PostDTO;
import com.salre.main.myPage.ReportDAO;
import com.salre.main.myPage.ReportDTO;
import com.salre.main.myPage.ReviewDTO;
import com.salre.main.product.ProductDTO;

import at.favre.lib.crypto.bcrypt.BCrypt;

@Service
public class UserService {

	@Autowired
	@Qualifier("UserDAO")
	public UserDAO userDAO;
	@Autowired
	public ReportDAO reportDAO;
	// 회원 등록
	public int registerUser(UserDTO user) {
		// 비밀번호 암호화
		String hashedPassword = BCrypt.withDefaults().hashToString(12, user.getPassword().toCharArray());
		user.setPassword(hashedPassword); // ��ȣȭ�� ��й�ȣ�� ����

		// DB에 저장
		return userDAO.insertUser(user);
	}

	// admin-handleBoardReport
	public List<ReportDTO> getBoardReportsByUserId(int user_id) {
		return userDAO.getBoardReportsByUserId(user_id);
	}

	// 로그인
	public UserDTO loginUser(String id, String password) {
		// 1. ID로 사용자 조회
		UserDTO user = userDAO.selectUserById(id);
		if (user == null) {
			return null; // 사용자가 없으면 로그인 실패
		}

		// 2. 비밀번호 확인
		boolean isPasswordMatch = at.favre.lib.crypto.bcrypt.BCrypt.verifyer()
				.verify(password.toCharArray(), user.getPassword()).verified;

		if (isPasswordMatch) {
			// 비밀번호 확인 성공: 비밀번호를 null로 설정하고 반환
			user.setPassword(null);
			return user;
		}

		// 비밀번호 확인 실패
		return null;
	}

	// 아이디 찾기
	public String findIdByEmailAndName(String email, String name) {
		String find_id = userDAO.findIdByEmailAndName(email, name);
		System.out.println("UserService/ find Id @@@email = " + find_id);
		return find_id;

	}

	// 비밀번호 찾기
	@Autowired
	private JavaMailSender mailSender;

	private final Map<String, String> verificationCodes = new HashMap<>();

	public boolean validateUser(String id, String email) {
		return userDAO.checkUser(id, email);
	}

	public void generateVerificationCode(String email) {// 인증코드 생성 및 전송
		String verificationCode = String.valueOf(new Random().nextInt(900000) + 100000);
		verificationCodes.put(email, verificationCode);
		sendEmail(email, "[살래?]비밀번호 찾기 인증코드", "인증코드: " + verificationCode);
	}

	public boolean verifyCode(String email, String verificationCode) {// 인증코드 확인
		return verificationCode.equals(verificationCodes.get(email));
	}

	public void updatePassword(String email, String newPassword) {// 비밀번호 암호화 후 업데이트
		String encodedPassword = new BCryptPasswordEncoder().encode(newPassword);
		userDAO.updatePassword(email, encodedPassword);
	}

	private void sendEmail(String to, String subject, String body) {// 이메일 전송
		SimpleMailMessage message = new SimpleMailMessage(); // 이메일 메시지 객체 생성
		message.setTo(to);// 이메일 수신자 주소 설정
		message.setSubject(subject);// 이메일 제목 설정
		message.setText(body);// 이메일 본문 설정
		mailSender.send(message);// 이메일 메시지 전송
									
	}

	// 회원 탈퇴
	public void deleteUser(String id) {
		userDAO.deleteUser(id);
	}

	// ID 중복 체크
	public boolean isIdAvailable(String id) {
		// userDAO.selectUserById2(id): null - 데이터베이스에 해당 ID가 존재하지 않음
		// 중복되지 않은 ID./중복 존재 - 데이터베이스에 해당 ID가 존재하면 중복된 ID.
		return userDAO.selectUserById2(id) == null;
	}

	public boolean isEmailAvailable(String email) {
		int count = userDAO.countByEmail(email);
		return count == 0;
	}

	// 마이페이지 - 나의 거래현황 목록 조회(구매자)
	public List<ProductDTO> getBuyerTransactionByUserId(int user_id) {
		return userDAO.getBuyerTransactionByUserId(user_id);
	}

	// 마이페이지 - 나의 거래현황 목록 조회
	public List<ProductDTO> getTransactionByUserId(int user_id) {
		return userDAO.getTransactionByUserId(user_id);
	}

	// 사용자 작성글 - 리뷰 작성
	public void registerReview(ReviewDTO review) {
		userDAO.insertReview(review);
	}

	// 마이페이지 - 나의 관심매물
	public List<ProductDTO> getFavoritesByUserId(int user_id) {
		return userDAO.getFavoritesByUserId(user_id);
	}
	
	//testcode
	//마이페이지 - 나의 관심매물추가  
	/*
	 * public ResponseEntity<String> toggleLike(@RequestBody LikeDTO likeDTO) {
	 * boolean updatedStatus = userService.toggleLike(likeDTO); return
	 * ResponseEntity.ok(updatedStatus ? "Liked" : "Unliked"); }
	 */
	
	//마이페이지 - 나의 관심매물추가
	public void insertFavorite(LikeDTO userlike) {
		userDAO.insertFavorite(userlike); 
	  }
	
	//마이페이지 - 나의 관심매물상태변경(1>0) 
	public void updateFavorite(LikeDTO userlike) {
		//System.out.println("userlike user_id : " + userlike.getUser_id());
		//System.out.println("userlike product_id : " + userlike.getProduct_id());
		
		 userDAO.updateFavorite(userlike);
	}
	
	
	//마이페이지 - 나의 관심매물삭제  
	public void deleteFavorite(LikeDTO userlike) {
		userDAO.deleteFavorite(userlike); 
	  }
	 

	// 사용자 작성글 - 게시글 작성한 글 목록 조회(특정 사용자의 게시글 목록 조회)
	public List<PostDTO> getPostsByUserId(int user_id) {
		return userDAO.selectPostsByUserId(user_id);
	}

	// 사용자 작성글 - 리뷰 작성 목록 조회
	public List<ReviewDTO> getMyreviewsByUserId(int user_id) {
		return userDAO.selectReviewsByUserId(user_id);
	}

	// 마이페이지 - 나의거래현황 - 거래완료 - 리뷰작성
//	public boolean isReviewWritten(int user_id, int product_id) {
//	    return userDAO.checkReviewExists(user_id, product_id);
//	}
	public boolean isReviewWritten(ReviewDTO reviewDTO) {
		return userDAO.checkReviewExists(reviewDTO);
	}

	
	// 사용자 작성글 - 리뷰 수정
	public void updateReview(int review_id, int review_rate, String review_content) {
		userDAO.updateReview(review_id, review_rate, review_content);
	}


	// 사용자 작성글 - 리뷰 삭제
	public void deleteReview(int review_id) {
		userDAO.deleteReview(review_id);
	}

	// 사용자 작성글 - 신고내역 조회
	public List<ReportDTO> getMyreportsByUserId(int user_id) {
		return userDAO.selectReportsByUserId(user_id);
	}
	public  void addReport(int user_id,int product_id,String report_content,int report_class,String status)  {
		 reportDAO.addReport(user_id, product_id, report_content, report_class, status);
	}
	
	// 사용자 정보 수정
	public void updateUserInfo(UserDTO user) {
		userDAO.updateUserInfo(user);
	};

	// 추가
	public UserDTO getUserById(int user_id) {
		return userDAO.selectById(user_id);
	}
	

	//admin-매물신고내역조회
	public List<ReportDTO> getAdminPropertiesReportsByReportClass(int report_class) {
		return userDAO.selectAdminPropertiesReportsByReportClass(report_class);
	}
	//admin-신고처리무효화
	public void updateReportStatus(int report_id, String status) {
		userDAO.updateReportStatus(report_id, status);
	}
	//admin-매물삭제  
	public void deletePropertyById(int product_id) {
		userDAO.deletePropertyById(product_id);
	}

}
