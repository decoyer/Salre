package com.salre.main.contract;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.util.IOUtils;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Map;

public class ExcelWriter {

	

    public static  String writeContractData(String inputfilePath,Map<String, String> data,String basePath,int contract_id) throws IOException {
        // 엑셀 파일 읽기
        FileInputStream fis = new FileInputStream(inputfilePath);
        System.out.println(fis+"문서로드 완료");
        Workbook workbook = new XSSFWorkbook(fis);
        Sheet sheet = workbook.getSheetAt(0); // 첫 번째 시트 사용

        // 데이터 매핑: 데이터명과 셀 위치를 설정
        Map<String, String> cellMappings = Map.ofEntries(
        		  Map.entry("payment_type", "C2"),
                  Map.entry("address", "C5"),
                  Map.entry("land_type", "E6"),
                  Map.entry("land_area", "Q6"),
                  Map.entry("building_structure", "E7"),
                  Map.entry("building_usage", "H7"),
                  Map.entry("building_area", "Q7"),
                  Map.entry("rental_area", "C8"),
                  Map.entry("area", "Q8"),
                  Map.entry("deposit_CHAR", "D11"),
                  Map.entry("deposit_INT", "N11"),
                  Map.entry("rentfee", "D15"),
                  Map.entry("rentfee_day", "O15"),
                  Map.entry("manage_feeCHAR", "D16"),
                  Map.entry("manage_fee", "N16"),
                  Map.entry("landlord_address", "D47"),
                  Map.entry("landlord_resident_num", "D48"),
                  Map.entry("landlord_resident_num2", "G48"),
                  Map.entry("landlord_phone_num", "K48"),
                  Map.entry("landlord_name", "R48"),
                  Map.entry("tenant_address", "D50"),
                  Map.entry("tenant_resident_num", "D51"),
                  Map.entry("tenant_resident_num2", "G51"),
                  Map.entry("tenant_phone_num", "K51"),
                  Map.entry("tenant_name", "R51"),
                  Map.entry("taker", "U12"),
                  
                  Map.entry("price", "D12"), //INPUT
                  Map.entry("middle_payment", "D13"),//INPUT
                  Map.entry("middle_payment_day", "M13"),//INPUT
                  Map.entry("balance_payment", "D14"),//INPUT
                  Map.entry("balance_payment_day", "M14"),//INPUT
                  Map.entry("landlord_sign2", "X12"),//INPUT
                  Map.entry("landlord_sign", "V48"),//INPUT
                  Map.entry("contract_startdate(y)", "O18"),//INPUT
                  Map.entry("contract_startdate(m)", "S18"),//INPUT
                  Map.entry("contract_startdate(d)", "V18"),//INPUT
                  Map.entry("contract_enddate(y)", "H19"),//INPUT
                  Map.entry("contract_enddate(m)", "J19"),//INPUT
                  Map.entry("contract_enddate(d)", "L19"),//INPUT
                  Map.entry("contract_date(y)", "C35"),//INPUT
                  Map.entry("contract_date(m)", "E35"),//INPUT
                  Map.entry("contract_date(d)", "G35"),//INPUT
                  Map.entry("contract_date2(y)", "H46"),//INPUT
                  Map.entry("contract_date2(m)", "K46"),//INPUT
                  Map.entry("contract_date2(d)", "M46"),//INPUT
                  Map.entry("contract_rule", "C37"),//INPUT
                  Map.entry("tenant_sign", "V51"),//INPUT
                  Map.entry("paper_exchange_day(y)", "C35"),//INPUT
                  Map.entry("paper_exchange_day(m)", "E35"),//INPUT
                  Map.entry("paper_exchange_day(d)", "G35")//INPUT
        );

        // 데이터를 엑셀 셀에 입력
        for (Map.Entry<String, String> entry : data.entrySet()) {
            String dataKey = entry.getKey(); // 데이터 이름
            String value = entry.getValue(); // 입력값
            String cellRef = cellMappings.get(dataKey); // 셀 위치
            
            if (cellRef != null) {
                // 셀 위치를 해석 (예: "C2" → 1행 2열)
                int rowIndex = Integer.parseInt(cellRef.replaceAll("[^0-9]", "")) - 1; // 행 번호
                int colIndex = cellRef.charAt(0) - 'A'; // 열 번호
                Row row = sheet.getRow(rowIndex);
                if (row == null) {
                    row = sheet.createRow(rowIndex);
                }
                Cell cell = row.getCell(colIndex);
                if (cell == null) {
                    cell = row.createCell(colIndex);
                }
                cell.setCellValue(value); // 셀에 값 설정
            }
        }

        // 엑셀 파일 저장
        String outputDirectory = basePath + "/resources/excel/";
        String outputPath = outputDirectory + "contract_Sample_" + contract_id + ".xlsx";
        File directory = new File(outputDirectory);
        if (!directory.exists()) {
            directory.mkdirs(); // 디렉토리 생성
        }
        FileOutputStream fos = new FileOutputStream(outputPath);
       
        workbook.write(fos);

        // 자원 정리
        fos.close();
        workbook.close();
        fis.close();
        return outputPath;
    }
    public static String insertImageIntoExcel(String excelPath, String imagePath, String cellRef) throws Exception {
	    FileInputStream fis = new FileInputStream(excelPath);
	    Workbook workbook = new XSSFWorkbook(fis);
	    Sheet sheet = workbook.getSheetAt(0);

	    // 셀 위치 해석
	    int rowIndex = Integer.parseInt(cellRef.replaceAll("[^0-9]", "")) - 1;
	    int colIndex = cellRef.charAt(0) - 'A';

	    // 이미지 삽입
	    InputStream imageStream = new FileInputStream(imagePath);
	    byte[] imageBytes = IOUtils.toByteArray(imageStream);
	    int pictureIdx = workbook.addPicture(imageBytes, Workbook.PICTURE_TYPE_PNG);
	    
	    Drawing<?> drawing = sheet.createDrawingPatriarch();
	    CreationHelper helper = workbook.getCreationHelper();
	    ClientAnchor anchor = helper.createClientAnchor();
	    anchor.setCol1(colIndex);
	    anchor.setRow1(rowIndex);
//	    anchor.setCol2(colIndex + (int)(2.22 * 7.5)); // 너비 2.22cm에 해당
//	    anchor.setRow2(rowIndex + (int)(1.18 * 0.75)); // 높이 1.18cm에 해당
	    Picture picture = drawing.createPicture(anchor, pictureIdx);
	    picture.resize();

	    // 새로운 경로 설정
	    String newExcelPath = excelPath.replace("/excel/", "/excel/landlord/");
	    File newDirectory = new File(newExcelPath).getParentFile();
	    // 디렉토리 생성
	    if (!newDirectory.exists()) {
	        newDirectory.mkdirs();
	    }
	    // 엑셀 저장
	    FileOutputStream fos = new FileOutputStream(newExcelPath);
	    workbook.write(fos);

	    fos.close();
	    workbook.close();
	    fis.close();
	    return newExcelPath;
	}
}