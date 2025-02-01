package com.salre.main.product;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository("Product") 
public class ProductDAO implements ProductInterface {
	@Autowired
	SqlSession sqlSession;
	
	String namespace = "com.salre.main.product.";
	public ProductDTO selectByContractId(int contract_id) {
			return sqlSession.selectOne(namespace + "selectByContractId",contract_id);	
	}
    public List<ProductDTO> selectAllProducts() {
        // SQL 쿼리 호출
        List<ProductDTO> productlist = sqlSession.selectList(namespace + "selectAllProducts");
        return productlist;
    }
	public int InsertProduct(ProductDTO product) { 
		System.out.println("DAO : InsertProduct : " + product);
		int result = sqlSession.insert(namespace + "insert", product);
		return result;
	}
	public ProductDTO getProductById(int productId) {
	    return sqlSession.selectOne(namespace + "getProductById", productId);

	}
	public int updateProduct(ProductDTO product) {
		int result = sqlSession.update(namespace + "updateProduct", product);
		return result;
	}
	public int deleteProduct(int productId) {
		int result = sqlSession.delete(namespace + "deleteProduct", productId);
		return result;
	}

    public List<ProductDTO> searchProductsByKeyword(String keyword) {
        log.info("검색어로 DB에서 검색: ", keyword);  // 로그로 검색어 확인
        return sqlSession.selectList(namespace + "searchProductsByKeyword", keyword);
    }
	@Override
	public List<ProductDTO> searchByConditions(ProductDTO productDTO) {
		 log.info("ProductDTO로 DB에서 검색 : ", productDTO);
		return sqlSession.selectList(namespace + "searchByConditions", productDTO);
	}

	public int countProduct() {
		return sqlSession.selectOne(namespace + "countProduct");
	}
	@Override
	public int nextId() {
		return sqlSession.selectOne(namespace + "nextId");
	}
	@Override
	public int incrementViewCount(int product_id) {
		  return sqlSession.update(namespace + "incrementViewCount", product_id);	
	}
	@Override
	public List<ProductDTO> findProductsByRegionCode(int region_id) {
			return sqlSession.selectList(namespace + "findProductsByRegionCode", region_id);
	}
	@Override
	public int updateProductStatusByContract(int product_id, int product_status) {
	    // 파라미터로 전달할 Map 생성
	    Map<String, Object> params = new HashMap<>();
	    params.put("product_id", product_id);
	    params.put("product_status", product_status);

	    // update 쿼리 실행
	    return sqlSession.update(namespace + "updateProductStatusByContract", params);
	}


}
