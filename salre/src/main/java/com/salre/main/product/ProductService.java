package com.salre.main.product;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service
public class ProductService {

    @Autowired
    @Qualifier("Product")
    ProductInterface productDAO;

    // 1. 모두 조회
    public List<ProductDTO> selectAllProducts() {
        return productDAO.selectAllProducts();
    }

    // 2. 아이디로 보기
    public ProductDTO selectByIdService(int productId) {
        return productDAO.getProductById(productId);
    }

    // 3. 추가
    public int insertProduct(ProductDTO product) {
        return productDAO.InsertProduct(product);
    }

    // 4. 수정
    public int updateProduct(ProductDTO product) {
        return productDAO.updateProduct(product);
    }

    // 5. 삭제
    public int deleteProduct(int productid) {
        return productDAO.deleteProduct(productid);
    }
    // 6. 조건부 검색
    public List<ProductDTO> searchByConditions(ProductDTO productDTO) {
        return productDAO.searchByConditions(productDTO);
    }
    // 7. 총 매물 개수 확인
    public int countProduct() {
        return productDAO.countProduct();
    }
    // 8. 다음 product_id 확인
    public int nextId() {
        return productDAO.nextId();
    }
    // 9. 검색어로 매물 검색
    public List<ProductDTO> searchProducts(String searchQuery) {
        return productDAO.searchProductsByKeyword(searchQuery);
    }
    // 10. 검색어로
    public List<ProductDTO> searchProductsByKeyword(String keyword) {
        return productDAO.searchProductsByKeyword(keyword);
    }
    // 10. 조회수 증가
    public int incrementViewCount(int product_id) {
        return productDAO.incrementViewCount(product_id);
    }
    // 11. 계약 ID로 매물 검색
    public ProductDTO selectByContractId(int contract_id) {
        return productDAO.selectByContractId(contract_id);
    }
    // 12. 지역 코드별 매물 검색
    public List<ProductDTO> findProductsByRegionCode(int regionCode) {
        return productDAO.findProductsByRegionCode(regionCode);
    }
    // 13. 계약 진행 상황에 따라 매물 상태 업데이트
    public int updateProductStatusByContract(int product_id, int product_status) {
        return productDAO.updateProductStatusByContract(product_id, product_status);
    }
}
