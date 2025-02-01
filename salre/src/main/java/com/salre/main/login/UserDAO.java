package com.salre.main.login;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.salre.main.myPage.LikeDTO;
import com.salre.main.myPage.PostDTO;
import com.salre.main.myPage.ReportDTO;
import com.salre.main.myPage.ReviewDTO;
import com.salre.main.product.ProductDTO;

@Repository("UserDAO")
public class UserDAO implements UserDAOInterface {

	@Autowired
	private SqlSession sqlSession;
	String namespace = "com.salre.main.login.UserDAOInterface.";

	public UserDTO selectById(int user_id) {
		UserDTO user = sqlSession.selectOne(namespace + "selectById", user_id);
		return user;

	}

	// 회원가입
	public int insertUser(UserDTO user) {
		int result = sqlSession.insert(namespace + "insertUser", user);
		return result;
	}

	// 로그인
	public UserDTO selectUserById(String id) {
		return sqlSession.selectOne(namespace + "selectUserById", id);
	}

	// ID찾기
	public String findIdByEmailAndName(String email, String name) {
		System.out.println("UserDAO/ email = " + email);
		System.out.println("UserDAO/ name = " + name);

		
		Map<String, String> params = new HashMap<>();
		params.put("email", email);
		params.put("name", name);

		String find_id = sqlSession.selectOne(namespace + "findIdByEmailAndName", params);
		System.out.println("UserDAO/ find Id @@@email = " + find_id);
		return find_id;
		// return userMapper.findIdByEmail(email);
	}

	// PW찾기
	public boolean checkUser(String id, String email) {
		Map<String, String> params = new HashMap<>();
		params.put("id", id);
		params.put("email", email);
		return sqlSession.selectOne(namespace + "checkUser", params) != null;
	}
	//회원정보수정
	public void updatePassword(String email, String encodedPassword) {
		Map<String, String> params = new HashMap<>();
		params.put("email", email);
		params.put("password", encodedPassword);
		sqlSession.update(namespace + "updatePassword", params);
	}

	// admin-handleBoardReport
	public List<ReportDTO> getBoardReportsByUserId(int user_id) {
		return sqlSession.selectList(namespace + "getBoardReportsByUserId", user_id);
	}

	// 회원탈퇴
	@Override
	public void deleteUser(String id) {
		sqlSession.delete(namespace + "deleteUser", id);
	}

	// ID중복체크/ 버튼
	public UserDTO selectUserById2(String id) {
		return sqlSession.selectOne(namespace + "selectUserById2", id);
	}

	// email 중복체크
	public int countByEmail(String email) {
		return sqlSession.selectOne(namespace + "countByEmail", email);
	}

	//마이페이지 - 나의 거래현황/ 거래목록 조회 (구매자)
    public List<ProductDTO> getBuyerTransactionByUserId(int user_id) {
  		return sqlSession.selectList(namespace + "getBuyerTransactionByUserId", user_id);
  	}
    
    // 마이페이지 - 나의거래현황 - 거래완료 - 리뷰작성
// 	public boolean checkReviewExists(int user_id, int product_id) {
// 	    Integer count = sqlSession.selectOne(namespace + "checkReviewExists", Map.of("user_id", user_id, "product_id", product_id));
// 	    return count != null && count > 0;
// 	}
 	public boolean checkReviewExists(ReviewDTO reviewDTO) {
 		Integer count = sqlSession.selectOne(namespace + "checkReviewExists", reviewDTO);
 		return count != null && count > 0;
 	}

    //마이페이지 - 나의 거래현황/ 거래목록 조회 
    public List<ProductDTO> getTransactionByUserId(int user_id) {
  		return sqlSession.selectList(namespace + "getTransactionByUserId", user_id);
  	}

    //마이페이지 - 나의 관심매물 
  	public List<ProductDTO> getFavoritesByUserId(int user_id){
  		return sqlSession.selectList(namespace + "getFavoritesByUserId", user_id);		
  	}
  	
	//마이페이지 - 나의 관심매물추가
	public void insertFavorite(LikeDTO userlike) {
		sqlSession.insert(namespace + "insertFavorite", userlike); 
	}
	  
	//마이페이지 - 나의 관심매물상태변경(1>0) 
	public void updateFavorite(LikeDTO userlike) { 
		System.out.println("userlike user_id : " + userlike.getUser_id());
		System.out.println("userlike product_id : " + userlike.getProduct_id());
		System.out.println("userlike is_liked before : " + userlike.is_liked());
		
		sqlSession.update(namespace + "updateFavorite",userlike);
		
		System.out.println("userlike is_liked after : " + userlike.is_liked());
	}
	
	//마이페이지 - 나의 관심매물삭제  
	public void deleteFavorite(LikeDTO userlike) {
		sqlSession.delete(namespace + "deleteFavorite", userlike); 
	}
	 

	// 마이페이지 - 나의 거래현황 - 후기작성
	public void insertReview(ReviewDTO review) {
		sqlSession.insert(namespace + "insertReview", review);

	}

	// 마이페이지 - 내가 작성한 글 목록 조회/ 특정 사용자의 게시글 목록 조회
	public List<PostDTO> selectPostsByUserId(int user_id) {
		return sqlSession.selectList(namespace + "selectPostsByUserId", user_id);
	}

	// 마이페이지 - 내가 작성한 후기
	public List<ReviewDTO> selectReviewsByUserId(int user_id) {
		return sqlSession.selectList(namespace + "selectReviewsByUserId", user_id);
	}

	// 마이페이지 - 내가 작성한 후기(수정)
	public void updateReview(int review_id, int review_rate, String review_content) {
		sqlSession.update(namespace + "updateReview",
				Map.of("review_id", review_id, "review_rate", review_rate, "review_content",
						review_content));
	}

	// 마이페이지 - 내가 작성한 후기(삭제)
	public void deleteReview(int review_id) {
		sqlSession.delete(namespace + "deleteReview", review_id);
	}

	// 마이페이지 - 내가 작성한 후기
	public List<ReportDTO> selectReportsByUserId(int user_id) {
		return sqlSession.selectList(namespace + "selectReportsByUserId", user_id);
	}

	//  마이페이지 - 회원정보수정/ updateUserInfo 
	public void updateUserInfo(UserDTO user) {
		// sqlSession.updateUserInfo(namespace+"updateUserInfo",user);
		sqlSession.update(namespace + "updateUserInfo", user);
	}
	
	//admin-게시물신고내역조회
		public List<ReportDTO> selectAdminReportsByReportClass(int report_class) {
			return sqlSession.selectList(namespace + "selectAdminReportsByReportClass", report_class);
		}
	//admin-매물신고내역조회
		public List<ReportDTO> selectAdminPropertiesReportsByReportClass(int report_class) {
			return sqlSession.selectList(namespace + "selectAdminReportsByReportClass", report_class);
		}
	//admin-신고처리무효화
		public void updateReportStatus(int report_id, String status) {
			System.out.println(status);
			sqlSession.update(namespace + "updateReportStatus", Map.of("report_id", report_id, "status", status));
		}
		
	//admin-매물삭제  
		public void deletePropertyById(int product_id) {
			sqlSession.delete(namespace + "deletePropertyById", product_id);
		}		
	
		

}
