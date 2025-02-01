package com.salre.main.login;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.salre.main.myPage.LikeDTO;
import com.salre.main.myPage.PostDTO;
import com.salre.main.myPage.ReportDTO;
import com.salre.main.myPage.ReviewDTO;
import com.salre.main.product.ProductDTO;

// Interface(�԰ݼ�): ���Ǵ� �ְ� ������ ����.
@Mapper
public interface UserDAOInterface {

			// 회원가입
			public int insertUser(UserDTO user);
			
			public UserDTO selectById(int  user_id);
			
			// 로그인
			//public UserDTO selectUserById(String id,String password);
			public UserDTO selectUserById(String id);
			
			// ID찾기
			/* public String findIdByEmail(String email); */
			public String findIdByEmailAndName(String email, String name);
			
			// PW찾기
		    public boolean checkUser(String id, String email) ;
		    public void updatePassword(String email, String newPassword) ;
			
		    // 회원탈퇴
			public void deleteUser(String id);
			
			// ID 중복체크
		    public UserDTO selectUserById2(String id);

			//admin-handleBoardReport
		    public  List<ReportDTO> getBoardReportsByUserId(int user_id);

		    //마이페이지 - 나의 거래현황 목록 조회(구매자)
		    public List<ProductDTO> getBuyerTransactionByUserId(int user_id);
		    
		    //마이페이지 - 나의거래현황 - 거래완료 - 리뷰작성
//		    public boolean checkReviewExists(int user_id, int product_id);
		    public boolean checkReviewExists(ReviewDTO reviewDTO);

		    //마이페이지 - 나의 거래현황 목록 조회
		    public List<ProductDTO> getTransactionByUserId(int user_id);

		    //마이페이지 - 나의 관심매물
		  	public List<ProductDTO> getFavoritesByUserId(int user_id);
		  	
		    //마이페이지 - 나의 관심매물추가
			public void insertFavorite(LikeDTO userlike);
			
			//마이페이지 - 나의 관심매물상태변경(1>0) 
			public void updateFavorite(LikeDTO userlike);
			  
			//마이페이지 - 나의 관심매물삭제  
			public void deleteFavorite(LikeDTO userlike);
		  
			// 사용자작성글 - 게시글 작성한 글 목록 조회(특정 사용자의 게시글 목록 조회)
		    public List<PostDTO> selectPostsByUserId(int user_id);
		    
		    // 사용자작성글 - 리뷰 작성 목록
			public List<ReviewDTO> selectReviewsByUserId(int user_id);
			
			// 사용자작성글 - 리뷰 작성 수정
			public void updateReview(int review_id, int review_rate, String review_content);
			
			// 사용자작성글 - 리뷰 작성 삭제
			public void deleteReview(int review_id);
			  
			// 사용자작성글 - 신고내역
			public List<ReportDTO> selectReportsByUserId(int user_id);
			  
			// 사용자정보수정 - 회원정보수정
		    public void updateUserInfo(UserDTO user);
		    
			//admin-매물신고내역조회
			public List<ReportDTO> selectAdminPropertiesReportsByReportClass(int report_class);
				
			//admin-신고처리무효화
			public void updateReportStatus(int report_id, String status);
			
			//admin-매물삭제  
			public void deletePropertyById(int product_id);

}