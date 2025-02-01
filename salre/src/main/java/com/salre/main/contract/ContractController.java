package com.salre.main.contract;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.salre.main.login.UserDTO;
import com.salre.main.login.UserService;
import com.salre.main.product.ProductContractDTO;
import com.salre.main.product.ProductDTO;
import com.salre.main.product.ProductService;

@Controller
@RequestMapping("/contract")
public class ContractController {
	@Autowired
	public ContractService contractService;
	@Autowired
	public UserService userService;
	@Autowired
	public ProductService productService;

	
	
	@GetMapping("/input")
	public String showContractInputPage(@RequestParam(value = "contract_id",required=false,defaultValue="0") Integer contract_id,
	        Model model) {
		if (contract_id == 0) {
	        model.addAttribute("errorMessage", "계약번호가 제공되지 않았습니다.");
	        return "errorPage"; // 에러 페이지로 이동
	    }
		ProductContractDTO contract = contractService.getContractPById(contract_id);
	    // 데이터를 모델에 추가
	    model.addAttribute("contract", contract);
	    return "contract/contractInput"; // contractInput.jsp로 이동
	}
	@PostMapping("/input")
	public ResponseEntity<String> handleInputData(@RequestParam("contract_id") Integer contract_id, Model model) {
	    // 데이터 처리 (필요시 contractId를 기반으로 데이터 조회/저장)
	    // 요청 성공 응답
	    return ResponseEntity.ok("Success");
	}

	// 1.거래 시작 누리고 첫화면  "정보확인"(매물,회원정보 조회)
	//구매자 - 정보확인 페이지
	@GetMapping("/dealstart")
	public String tenantContract(HttpServletRequest request,int product_id,Model model) {
		
		HttpSession session = request.getSession();
		
	
		UserDTO user = (UserDTO) session.getAttribute("loggedInUser");//구매자 user_id
		System.out.println("user_id"+user.getUser_id());
 
		ProductDTO product = productService.selectByIdService(product_id);
		System.out.println(product);
		System.out.println(product.getUser_id());
		UserDTO P_user = userService.getUserById(product.getUser_id());//판매자 user_id
		System.out.println(P_user);
		model.addAttribute("product", product);
		model.addAttribute("P_user", P_user);
		model.addAttribute("user", user);
		
		return "contract/contractDetailTenant";
	}
	// 판매자  - 계약 사항 확인
		@GetMapping("/dealcheck/{contract_id}")
		public String landlordContract(@PathVariable(required = true) int contract_id, HttpServletRequest request,Model model) {
			HttpSession session = request.getSession();
			UserDTO user = (UserDTO) session.getAttribute("loggedInUser");//판매자
			session.setAttribute("landlord_id",user.getUser_id());//판매자 id
			ContractDTO contract = contractService.getContractById(contract_id);
			session.setAttribute("contract", contract);
			ProductDTO product = productService.selectByContractId(contract_id);
			
			model.addAttribute("contract", contract);
			model.addAttribute("product", product);
			model.addAttribute("user", user);//판매자
			return "contract/contractDetailLandlord";
		}
	
	// 계약정보 입력
		@PostMapping("/inputContract") 
		public String selectAllContractById(
				@RequestParam(required = false, defaultValue = "0") int product_id,
				@RequestParam(required = false, defaultValue = "0") int user_id,
				Model model) {
			ProductDTO product = productService.selectByIdService(product_id);
			UserDTO user = userService.getUserById(user_id);
			
	
			model.addAttribute("product", product);
			model.addAttribute("user", user);
			
			return "contract/contractInput";
		}

		// 계약서 저장 
	     @PostMapping("/save") //입력받은 계약내용, 특약내용 저장
	     public String saveContract(HttpSession session, ContractDTO contractDTO,
	    		 @RequestParam int product_id,
	    		 @RequestParam int user_id,
	    		 Model model) {
	    	 //공백인 경우 null로 처리
	    	 if (contractDTO.getBalance_payment_day() != null && contractDTO.getBalance_payment_day().trim().isEmpty()) {
	    		    contractDTO.setBalance_payment_day(null);
	    		}
	    		if (contractDTO.getMiddle_payment_day() != null && contractDTO.getMiddle_payment_day().trim().isEmpty()) {
	    		    contractDTO.setMiddle_payment_day(null);
	    		}
	    	 // 계약 저장후 계약번호 반환
	    
	    	  int contract_id = contractService.saveContract(contractDTO);
	    	  ProductDTO product = productService.selectByContractId(contract_id);
	    	  session.setAttribute("contract", contractDTO);
	    	  session.setAttribute("product",product);
	    	UserDTO p_user = userService.getUserById(product.getUser_id());
	         ContractDTO contract =contractService.getContractById(contract_id);
	         contractService.updateContractStatus(contract_id,2);//계약 상태 업데이트 2 : 계약서 작성
	       
	       model.addAttribute("p_user",p_user);
	         model.addAttribute("contract",contract);
	         // 저장된 계약 정보를 조회하는 페이지로 리다이렉트
	         return "redirect:/contract/contractTotal?contract_id=" + contract_id +
	         "&product_id=" + product_id +
	         "&user_id=" + user_id;
	         
	     }
	     // 계약서 확인
	     @GetMapping("/contractTotal")
	     public String showContractTotal(@RequestParam("contract_id") int contract_id, Model model,HttpSession session) {
			ContractDTO contract = contractService.getContractById(contract_id);
			UserDTO user = userService.getUserById(contract.getUser_id());//임대인
			ProductDTO product = productService.selectByIdService(contract.getProduct_id());
			UserDTO p_user = userService.getUserById(product.getUser_id());
			UserDTO tenant = (UserDTO) session.getAttribute("loggedInUser");
			UserDTO tenant_user = userService.getUserById(tenant.getUser_id());
			
			model.addAttribute("p_user",p_user);
			  model.addAttribute("tenant_user",tenant_user);
			    model.addAttribute("contract", contract);
			    model.addAttribute("user", user);//임대인
			    model.addAttribute("product", product);
			    System.out.println("contract_id 받음: " + contract_id);
	    	 return "contract/contractTotal";
	     }
	     // 서명하기
	     @PostMapping("/saveSignature")
	     public ResponseEntity<?> saveSignature(@RequestBody Map<String, String> requestData, HttpSession session) {
	         try {
	             String signatureData = requestData.get("signature");

	             // 서명 이미지를 저장할 경로
	             String basePath = session.getServletContext().getRealPath(".");
	             String filePath = contractService.saveSignature(signatureData, basePath);
	             System.out.println(filePath);
	             return ResponseEntity.ok(Map.of("success", true, "message", "서명이 저장되었습니다.", "path", filePath));
	           
	         } catch (Exception e) {
	             e.printStackTrace();
	             return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
	                                  .body(Map.of("success", false, "message", e.getMessage()));
	         }
	     }
	     
	     
	     //초안생성
	     @GetMapping("/sample/{contract_id}")
	     public String generateContractSample(
	    		 @PathVariable int contract_id,
	    		 @RequestParam Map<String, String> formData,
	    		 HttpServletRequest request,
	    		 HttpSession session,
	    		 Model model) {
	         System.out.println("초안생성 시작 : generateContractSample");
	    	 try {
	             String basePath = request.getSession().getServletContext().getRealPath(".");
	             String imagePath = contractService.processContract(formData, contract_id, basePath,session);
	         
	             //생성된 경로르 DB에 저장
	             contractService.saveContractImgPath(contract_id, imagePath);
	             ProductDTO product = (ProductDTO) session.getAttribute("product");
	         
	             // 모델에 데이터 추가
	             model.addAttribute("product", product);
	             model.addAttribute("imagePath", imagePath);
	             model.addAttribute("contract_id", contract_id);
	           
	             // JSP로 이동
	             return "contract/viewContractSample";
	            
	         } catch (Exception e) {
	             e.printStackTrace();
	             model.addAttribute("errorMessage", "초안 생성 중 오류 발생: " + e.getMessage());
	             return "error";
	             }
	     }

			@GetMapping("/additionalInfo")
			public String showAdditionalInfoPage(HttpSession session, Model model) {
				// 계약 정보 가져오기
				ContractDTO contract = (ContractDTO)session.getAttribute("contract"); // 세션에 contract_id넣어야함
				model.addAttribute("contract", contract);
				
				
				// 추가 정보 입력 페이지로 이동
				return "contract/additionalInfo"; // additionalInfo.jsp 파일
			}
	     
		@PostMapping("/saveAdditionalInfo")
		public String saveAdditionalInfo(@RequestParam Map<String, String> formData, Model model,
				HttpSession session) {
				
			// 세션에서 contract_id 가져오기
			ContractDTO contract = (ContractDTO) session.getAttribute("contract");
				
			// Map에서 값 추출
			String account = formData.get("account");
			String account_name = formData.get("account_name");
			String bank_name = formData.get("bank_name");
				
			// 추가 정보 저장
			contractService.updateAdditionalInfo(contract.contract_id, account, account_name, bank_name);
			// 다음 단계로 리다이렉트
			return "redirect:/contract/viewContract/"+contract.contract_id; // 다음 단계 JSP
			}
		
		
			//계약서 보기
			@GetMapping("/viewContract/{contract_id}")
			public String viewContract(@PathVariable(required = true) Integer contract_id, Model model, HttpSession session) {
				   
		         // 계약서 경로를 모델에 전달
					ContractDTO contract = contractService.getContractById(contract_id);
		            model.addAttribute("contract", contract);
					return "contract/viewContract"; // 계약서 이미지를 보여주는 JSP
				

			}
	     //임대인 서명
	     @PostMapping("/landlord-sign/{contract_id}")
	     public ResponseEntity<?> addLandlordSignature(@PathVariable int contract_id, @RequestBody Map<String, String> requestData, HttpServletRequest request) {
	         try {
	             String signatureData = requestData.get("signature");
	             String basePath = request.getSession().getServletContext().getRealPath(".");
	             
	             
	            String imagePath = contractService.addLandlordSignature(signatureData, contract_id, basePath);
	            //경로 파싱
	            String delimiter = "/resources/";
	            int index = imagePath.indexOf(delimiter);
	            String relativePath="";
	            if (index != -1) {
	                relativePath = imagePath.substring(index).replace("\\", "/");
	                
	            } else {
	                  }
	            System.out.println("Landlord imagePath :"+relativePath); 
	            contractService.saveContractImgPath(contract_id, relativePath);
	            contractService.updateContractStatus(contract_id, 3); //계약상태 변경 3:임대인 서명완료
	             return ResponseEntity.ok(Map.of("imagePath", relativePath));
	             
	         } catch (Exception e) {
	             e.printStackTrace();
	             return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("임대인 서명 추가 중 오류 발생");
	         }
	     }
	   //계약서만 보기
	    @GetMapping("/onlyView/{contract_id}")
	    	public String onlyViewContract(@PathVariable(required = true) Integer contract_id, Model model) {
	    	ContractDTO contract = contractService.getContractById(contract_id);	
			model.addAttribute("contract",contract);
	    	return "contract/onlyViewContract";
	    }
	     
	     //임대인 서명 후 계약서
			@GetMapping("/viewSignContract2/{contract_id}")
			public String viewSignContract2(@PathVariable(required = true) Integer contract_id, Model model) {
				ContractDTO contract = contractService.getContractById(contract_id);
				ProductDTO product = productService.selectByContractId(contract_id);
				model.addAttribute("product",product);
				model.addAttribute("contract",contract);
				return "contract/viewSignContract2"; // 계약서 이미지를 보여주는 JSP
			}
			//임차인 서명 후 계약서
			@GetMapping("/viewSignContract/{contract_id}")
			public String viewSignContract(@PathVariable(required = true) Integer contract_id, Model model) {
				ContractDTO contract = contractService.getContractById(contract_id);
				ProductDTO product = productService.selectByContractId(contract_id);
				model.addAttribute("product",product);
				model.addAttribute("contract",contract);
				return "contract/viewSignContract"; // 계약서 이미지를 보여주는 JSP
			}
			//임차인 계약서 서명
			@GetMapping("/signTenantContract/{contract_id}")
			public String signTenantContract(@PathVariable(required = true) Integer contract_id, Model model) {
				ContractDTO contract = contractService.getContractById(contract_id);	
				model.addAttribute("contract",contract);
				return "contract/signTenantContract"; // 계약서 이미지를 보여주는 JSP
			}
			
	     //임차인 서명
	     @PostMapping("/tenant-sign/{contract_id}")
	     public ResponseEntity<?> addTenantSignature(@PathVariable int contract_id, @RequestBody Map<String, String> requestData, HttpServletRequest request) {
	         
	    	 try {
	             String signatureData = requestData.get("signature");
	             String basePath = request.getSession().getServletContext().getRealPath(".");
	             String imagePath = contractService.addTenantSignature(signatureData, contract_id, basePath);
	             
	             	//경로 파싱
		            String delimiter = "/resources/";
		            int index = imagePath.indexOf(delimiter);
		            String relativePath="";
		            if (index != -1) {
		                relativePath = imagePath.substring(index).replace("\\", "/");
		                
		            } else {
		                  }
		            System.out.println("Tenant imagePath :"+relativePath); 
		            contractService.saveContractImgPath(contract_id, relativePath);
	             
	             contractService.updateContractStatus(contract_id, 4); //계약상태 변경 4:임차인 서명완료
	             return ResponseEntity.ok(Map.of("imagePath", imagePath));
	         } catch (Exception e) {
	             e.printStackTrace();
	             return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("임차인 서명 추가 중 오류 발생");
	         }
	     }
	     @GetMapping("/payCheck/{contract_id}")
	     public String checkPaymentResult(@PathVariable("contract_id") int contract_id,Model model) {
	    	ContractDTO contract = contractService.getContractById(contract_id);
	    //알림 보낸 시간도 보내고싶음
	    	model.addAttribute("contract",contract);
	    	return "contract/payCheck";
	     }
	     
	     //판매자가 송금완료 눌렀을때
	     @PostMapping("/updateStatus")
	     @ResponseBody
	     public ResponseEntity<String> updateContractStatus(@RequestBody  Map<String, Integer> data) {
	    	 int contractId = (Integer) data.get("contract_id");
	    	 int contractStatus = (Integer) data.get("contract_status");
	    	 contractService.updateContractStatus(contractId,contractStatus);//계약상태값 변경 5 : 송금완료
	    	 return ResponseEntity.ok("상태 업데이트 성공");
	     }
	     
	     
	     

}
