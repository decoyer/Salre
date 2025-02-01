package com.salre.main.contract;

import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.salre.main.product.ProductContractDTO;
import com.salre.main.product.ProductDAO;
import com.salre.main.product.ProductDTO;
import com.salre.main.login.UserDTO;
import com.salre.main.login.UserDAO;


@Service
public class ContractService {

	@Autowired
	public ContractMybatis contractDAO;
	@Autowired
	@Qualifier("UserDAO")
	public UserDAO userDAO;
	@Autowired
	public ProductDAO productDAO;

	
	
	// 계약 ID로 조회
    public ContractDTO getContractById(int contract_id) {
        return contractDAO.selectById(contract_id);
    }
    //매물,회원정보 조회 화면
    public void beforeContract() {
    }
    //계약상태 업데이트
    public void updateContractStatus(int contract_id,int contract_status) {
    	contractDAO.updateContractStatus(contract_id, contract_status);
    }
    //판매자추가정보입력
    public int updateAdditionalInfo(Integer contract_id, String account, String account_name, String bank_name) {
    	return contractDAO.updateAddInfo(contract_id,account,account_name,bank_name);
    }
    // 계약 ID로 모든 매물, 판매자조회
    public ProductContractDTO getContractPById(int contract_id) {
    	return contractDAO.selectContractPById(contract_id);
    }
    public String processContract(Map<String, String> formData, int contract_id, String basePath,HttpSession session) throws Exception {
        Map<String, String> data = fetchContractData(contract_id, formData,session);

        // 1. 엑셀 작성
        String excelPath = basePath + "/excel/contractTmp_sample.xlsx";
      System.out.println("excelpath :"+ excelPath);
        excelPath = ExcelWriter.writeContractData(excelPath, data,basePath,contract_id);
        saveContractExcelPath(contract_id, excelPath); //엑셀경로 저장
        
        // 2. EXCEL TO PDF
        String pdfPath = AsposePdfConverter.convertExcelToPdf(excelPath,contract_id,basePath);
        // 3.PDF TO IMG
        String imageName = "/resources/paperImages/" + UUID.randomUUID() + "_contract.png";
        String imagePath = basePath + imageName;
        ImageConverter.convertPdfToImage(pdfPath, imagePath);
        
        return imageName; // 초안 계약서 이미지 경로 반환
    }
    
    //데이터 입력
    public Map<String, String> fetchContractData(int contract_id, Map<String, String> formData,HttpSession session) {
        // DAO 호출로 계약 데이터 조회
    	
        ProductContractDTO contract = contractDAO.selectContractPById(contract_id);
        ProductDTO product = productDAO.getProductById(contract.getProduct_id());
        UserDTO landlord = userDAO.selectById(product.getUser_id());
        System.out.println("landlord:"+landlord);
        UserDTO tenant = (UserDTO) session.getAttribute("loggedInUser");
        System.out.println("tenant:"+tenant);
        System.out.println("contract:"+contract);
        
        // 데이터 매핑 및 병합
        Map<String, String> data = new HashMap<>();

        // 부동산 정보
        data.put("payment_type", contract.getPayment_type()); // 거래 유형
        data.put("address", contract.getAddress()); // 주소
        data.put("land_type", contract.getLand_type()); // 토지 지목
        data.put("land_area", contract.getLand_area()); // 토지 면적
        data.put("building_structure", contract.getBuilding_structure()); // 건물 구조
        data.put("building_usage", contract.getBuilding_usage()); // 건물 용도
        data.put("building_area", "184.1분의12.483"); // 건물 면적
        data.put("rental_area",contract.getRental_area()); // 임대 부분
        data.put("area", String.valueOf(contract.getArea())); // 임대 부분 면적

        // 계약 내용
        data.put("deposit_INT", String.valueOf(contract.getDeposit())); // 보증금 숫자
        data.put("deposit_CHAR", NumberToKorean.convertToKorean(contract.getDeposit())); // 보증금 한글
        data.put("manage_fee", String.valueOf(contract.getManage_fee())); // 관리비 숫자
        data.put("rentfee_day", String.valueOf(contract.getRent_fee_day())); // 월세 입금일
        data.put("rentfee", String.valueOf(contract.getRentfee())); // 월세
        data.put("manage_feeCHAR", NumberToKorean.convertToKorean(contract.getManage_fee())); // 관리비 한글
        if (contract.getMiddle_payment() != 0) {
            data.put("middle_payment", NumberToKorean.convertToKorean(contract.getMiddle_payment()));}//중도금
        if(contract.getMiddle_payment_day() !=null) {
        	data.put("middle_payment_day", String.valueOf(contract.getMiddle_payment_day()));}// 중도금 입금일
        if (contract.getBalance_payment() != 0) {
            data.put("balance_payment", NumberToKorean.convertToKorean(contract.getBalance_payment()));} // 잔금
        if(contract.getBalance_payment_day() !=null) {
        	data.put("balance_payment_day", String.valueOf(contract.getBalance_payment_day()));}// 잔금일
        data.put("price", NumberToKorean.convertToKorean(contract.getPrice())); // 계약금
        data.put("taker",landlord.getUser_name());//영수자
        
        // 서명 정보
        data.put("landlord_address", landlord.getAddress()+landlord.getAddress_detail()); // 임대인 주소
        data.put("landlord_resident_num", landlord.getResident_num()); // 임대인 주민등록번호
        String userResidentNnum2 = landlord.getResident_num2();
        String userNewResidentNnum2 = "-"+userResidentNnum2;
        data.put("landlord_resident_num2", userNewResidentNnum2); // 임대인 주민등록번호
        data.put("landlord_phone_num", landlord.getPhone_num()); // 임대인 전화번호
        data.put("landlord_name",landlord.getUser_name()); // 임대인 이름
        data.put("tenant_address",tenant.getAddress()+tenant.getAddress_detail()); // 임차인 주소
        data.put("tenant_resident_num", tenant.getResident_num());// 임차인 주민등록번호
        String residentNnum2 = tenant.getResident_num2();
        String newResidentNnum2 = "-"+residentNnum2;
        data.put("tenant_resident_num2", newResidentNnum2);// 임차인 주민등록번호
        data.put("tenant_phone_num", tenant.getPhone_num());// 임차인 전화번호
        data.put("tenant_name", tenant.getUser_name());// 임차인 이름

        // 날짜 정보
        LocalDate today = LocalDate.now();
        Date sqlStartDate = contract.getContract_startdate();
        Date sqlEndDate = contract.getContract_enddate();
        LocalDate startDate = sqlStartDate.toLocalDate();
        LocalDate endDate = sqlEndDate.toLocalDate();

        data.put("contract_startdate(y)", String.valueOf(startDate.getYear())); // 임대 시작일 연도
        data.put("contract_startdate(m)", String.valueOf(startDate.getMonthValue())); // 임대 시작일 월
        data.put("contract_startdate(d)", String.valueOf(startDate.getDayOfMonth())); // 임대 시작일 일
        data.put("contract_enddate(y)", String.valueOf(endDate.getYear())); // 임대 종료일 연도
        data.put("contract_enddate(m)", String.valueOf(endDate.getMonthValue())); // 임대 종료일 월
        data.put("contract_enddate(d)", String.valueOf(endDate.getDayOfMonth())); // 임대 종료일 일
        data.put("contract_date2(y)", String.valueOf(today.getYear())); // 계약일 연도
        data.put("contract_date2(m)", String.valueOf(today.getMonthValue())); // 계약일 월
        data.put("contract_date2(d)", String.valueOf(today.getDayOfMonth())); // 계약일 일
        data.put("paper_exchange_day(y)", String.valueOf(today.getYear())); // 계약서 교부일 년
        data.put("paper_exchange_day(m)", String.valueOf(today.getMonthValue())); // 계약서 교부일 월
        data.put("paper_exchange_day(d)", String.valueOf(today.getDayOfMonth())); // 계약서 교부일 일
        data.put("contract_rule", contract.getContract_rule()); // 특약사항

        // 추가 데이터
        data.put("contract_id", String.valueOf(contract.getContract_id()));
        data.put("user_id", String.valueOf(contract.getUser_id()));
        data.put("product_id", String.valueOf(contract.getProduct_id()));
        data.put("account", String.valueOf(contract.getAccount()));

        // 사용자 입력 데이터 병합
        for (Map.Entry<String, String> entry : formData.entrySet()) {
            data.put(entry.getKey(), entry.getValue());
        }
        //System.out.println("데이터 삽입");
        return data;
    }
   

    // 계약 생성
    public int saveContract(ContractDTO contractDTO) {
        return contractDAO.saveContract(contractDTO);
    }
    //서명 저장
    public String saveSignature(String signatureData, String basePath) throws Exception {
        try {
            // 서명 이미지를 저장할 디렉토리 경로
            String savePath = basePath + "/resources/signatures/";
            File dir = new File(savePath);
            if (!dir.exists()) {
                dir.mkdirs();
            }

            // Base64 데이터를 디코딩하여 파일로 저장
            String base64Image = signatureData.split(",")[1];
            byte[] imageBytes = Base64.getDecoder().decode(base64Image);
            String fileName = "signature_" + System.currentTimeMillis() + ".png";
            String filePath = savePath + fileName;
            //System.out.println(savePath);
            try (FileOutputStream fos = new FileOutputStream(filePath)) {
                fos.write(imageBytes);
            }

            return filePath; // 저장된 파일 경로 반환
        } catch (Exception e) {
            throw new Exception("서명 저장 중 오류 발생: " + e.getMessage(), e);
        }
    }
    //서명 이미지로 저장
    private void saveSignatureImage(String signatureData, String filePath) throws IOException {
    	 // Base64 데이터를 디코딩
        String base64Image = signatureData.split(",")[1];
        byte[] imageBytes = Base64.getDecoder().decode(base64Image);

        // InputStream으로 변환
        ByteArrayInputStream bis = new ByteArrayInputStream(imageBytes);
        BufferedImage originalImage = ImageIO.read(bis);
        bis.close();

        // 이미지 크기 조정 
        int targetWidth = (int) (2 * 37.795275591); 
        int targetHeight = (int) (1 * 37.795275591); 
        BufferedImage resizedImage = new BufferedImage(targetWidth, targetHeight, BufferedImage.TYPE_INT_ARGB);
        Graphics2D g2d = resizedImage.createGraphics();

        // 고품질 리사이징 옵션 설정
        g2d.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BICUBIC);
        g2d.drawImage(originalImage, 0, 0, targetWidth, targetHeight, null);
        g2d.dispose();

        // 새로운 크기의 이미지를 파일로 저장
        File outputFile = new File(filePath);
        ImageIO.write(resizedImage, "png", outputFile);

        System.out.println("Resized signature image saved at: " + filePath);
    }
   
    //계약서 생성 및 샘플 조회
    public String generateSampleContract(Map<String, String> formData, int contract_id, String basePath,HttpSession session) throws Exception {
        // 1. 계약 정보 생성 및 데이터 매핑
        Map<String, String> data = fetchContractData(contract_id, formData,session); // 계약 데이터와 formData 병합
        String excelPath = basePath + "/excel/contractTmp_sample.xlsx";
        ExcelWriter.writeContractData(excelPath, data,basePath,contract_id);
        System.out.println("계약서 샘플 작성 완료");

        // 2. PDF 및 이미지 변환
        String pdfPath = basePath + "/pdf/contractTmp_sample.pdf";
        AsposePdfConverter.convertExcelToPdf(excelPath,contract_id,basePath);
        String imageName = "/resources/contractSamples/" + UUID.randomUUID() + "_sample.png";
        String imagePath = basePath + imageName;
        ImageConverter.convertPdfToImage(pdfPath, imagePath);
        System.out.println("계약서 샘플 이미지 생성 완료");
        
        return imageName; // 생성된 샘플 계약서 이미지 경로 반환
    }
    //임대인 서명
    public String addLandlordSignature(String signatureData, int contract_id, String basePath) throws Exception {
        // 1. 서명 이미지 저장
        String signaturePath = basePath + "/resources/signatures/landlord_" + contract_id + ".png";
        saveSignatureImage(signatureData, signaturePath);

        // 2. 엑셀에 서명 삽입
        String excelPath = basePath + "/resources/excel/contract_Sample_"+contract_id+".xlsx";
        String landlord_excelPath =   ExcelWriter.insertImageIntoExcel(excelPath, signaturePath, "V48"); // 임대인 서명 위치 V48

        // 3. PDF 및 이미지 변환 
        String pdfDirectory = basePath + "/resources/pdf/landlord/";
        String newPdfPath = AsposePdfConverter.convertExcelToOtherPdf(landlord_excelPath,pdfDirectory,contract_id);
        
        String imageDirectory = basePath+"/resources/paperImages";
        String newImagePath =ImageConverter.convertPdfToOtherImage(newPdfPath,imageDirectory,contract_id);
        
        return newImagePath; // 임대인 서명된 계약서 이미지 경로 반환
    }
   //임차인 서명
    public String addTenantSignature(String signatureData, int contract_id, String basePath) throws Exception {
        // 1. 서명 이미지 저장
        String signaturePath = basePath + "/resources/signatures/tenant_" + contract_id + ".png";
        saveSignatureImage(signatureData, signaturePath);

        // 2. 엑셀에 서명 삽입
        String excelPath = basePath + "/resources/excel/landlord/contract_Sample_" + contract_id + ".xlsx";
        String tenant_excelPath = ExcelWriter.insertImageIntoExcel(excelPath, signaturePath, "V51"); // 임차인 서명 위치 V51

        // 3. 최종 PDF 및 이미지 변환
        String pdfDirectory = basePath + "/resources/pdf/tenant";
        String newPdfPath = AsposePdfConverter.convertExcelToOtherPdf(tenant_excelPath,pdfDirectory,contract_id);
    
       // String imageName = "/resources/paperImages/" + UUID.randomUUID() + "_final_contract.png";
      //String imagePath = basePath + imageName;
        
        String imageDirectory = basePath+"/resources/paperImages";
        String newImagePath =ImageConverter.convertPdfToOtherImage(newPdfPath,imageDirectory,contract_id);
        
        return newImagePath;
    }
   
    //엑셀 경로 저장
    public void saveContractExcelPath(int contract_id, String contract_epath) {
        contractDAO.updateContractExcelPath(contract_id, contract_epath);
    }
    //엑셀 경로 저장
    public void saveContractPdfPath(int contract_id, String contract_pdfpath) {
    	contractDAO.updateContractpdfPath(contract_id, contract_pdfpath);
    }
    //이미지 경로 저장
    public void saveContractImgPath(int contract_id, String contract_imgpath) {
    	contractDAO.updateContractImgPath(contract_id, contract_imgpath);
    }
}