package com.salre.main.contract;

import java.awt.image.BufferedImage;
import java.io.File;

import javax.imageio.ImageIO;

import org.apache.pdfbox.Loader;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.rendering.PDFRenderer;

public class ImageConverter {
	public static void convertPdfToImage(String pdfPath, String imagePath) throws Exception {
       
		System.out.println("ImageConverter pdfPath:" +pdfPath );
		System.out.println("ImageConverter imagePath:" +imagePath );
		try (PDDocument pdfDocument =Loader.loadPDF(new File(pdfPath))) {
            PDFRenderer renderer = new PDFRenderer(pdfDocument);
            BufferedImage image = renderer.renderImageWithDPI(0, 300);
            ImageIO.write(image, "png", new File(imagePath));
        }
    }
	public static String convertPdfToOtherImage(String pdfPath, String outputDirectory, int contract_id) throws Exception {
		System.out.println("ImageConverter OtherpdfPath:" +pdfPath );
		String imageFileName;
		//이미지 파일 생성 경로
		 // 이미지 파일 이름 결정
	    if (pdfPath.contains("tenant")) {
	        imageFileName = "contract_tenant_" + contract_id + ".png";
	    } else if (pdfPath.contains("landlord")) {
	        imageFileName = "contract_landlord_" + contract_id + ".png"; // landlord로 수정
	    } else {
	        throw new IllegalArgumentException("pdfPath에 tenant나 landlord가 포함되어 있지 않습니다."); // 예외 처리
	    }
		// 이미지 파일 경로 생성
	    String imagePath = outputDirectory + File.separator + imageFileName;
	    
	    // 출력 디렉토리 생성
	    File directory = new File(outputDirectory);
	    if (!directory.exists()) {
	        directory.mkdirs();
	    }
		
		try (PDDocument pdfDocument =Loader.loadPDF(new File(pdfPath))) {
            PDFRenderer renderer = new PDFRenderer(pdfDocument);
            BufferedImage image = renderer.renderImageWithDPI(0, 300);
            ImageIO.write(image, "png", new File(imagePath));
        }
		
		System.out.println("Image 생성 완료 :"+imagePath);
		return imagePath;
    }
}
