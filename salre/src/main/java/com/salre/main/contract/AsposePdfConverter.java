package com.salre.main.contract;

import java.io.File;

import com.aspose.cells.PdfSaveOptions;
import com.aspose.cells.Workbook;

public class AsposePdfConverter {
	 public static String convertExcelToPdf(String excelPath,int contract_id,String basePath) {
	        try {
	        	 // Excel 파일 로드
	        	System.out.println("pdf변환전 excel 파일로드"+excelPath);
	            Workbook workbook = new Workbook(excelPath);

	         // PDF 저장 옵션 설정
	            PdfSaveOptions saveOptions = new PdfSaveOptions();
	            saveOptions.setOnePagePerSheet(false); // 시트 크기에 따라 페이지 나누기
	            String pdfPath = basePath + "/resources/pdf/contract_sample_"+contract_id +".pdf";
	            	
	         // PDF로 저장
	            workbook.save(pdfPath, saveOptions);

	            System.out.println("PDF 변환 완료: " + pdfPath);
	            return pdfPath;
	        } catch (Exception e) {
	            e.printStackTrace();
	           return null;
	        }
	    }
	 public static String convertExcelToOtherPdf(String excelPath,String outputDirectory,int contract_id ) {
	        try {
	        	 // Excel 파일 로드
	        	System.out.println("pdf변환전 excel 파일로드"+excelPath);
	            Workbook workbook = new Workbook(excelPath);

	         // PDF 저장 옵션 설정
	            PdfSaveOptions saveOptions = new PdfSaveOptions();
	            saveOptions.setOnePagePerSheet(false); // 시트 크기에 따라 페이지 나누기

	            String newPdfPath="";
	            File newDirectory=null;
	            
	            // 새로운 경로 생성
	            if(outputDirectory.contains("landlord")) {
	            	newPdfPath = outputDirectory + "/contract_landlord_" + contract_id + ".pdf";
	            	newDirectory = new File(outputDirectory).getParentFile();
	            } else if (outputDirectory.contains("tenant")) {
	            	newPdfPath = outputDirectory + "/contract_tenant_" + contract_id + ".pdf";
	            	newDirectory = new File(outputDirectory).getParentFile();
	            }      // 디렉토리 생성
	            
	            if (!newDirectory.exists()) {
	                newDirectory.mkdirs();
	            }
	         // PDF로 저장
	            workbook.save(newPdfPath, saveOptions);

	            System.out.println("PDF 변환 완료: " + newPdfPath);
	            return newPdfPath;
	        } catch (Exception e) {
	            e.printStackTrace();
	           return null;
	        }
	    }
}
