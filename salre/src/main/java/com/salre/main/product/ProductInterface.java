package com.salre.main.product;

import java.util.List;

public interface ProductInterface {
    public int InsertProduct(ProductDTO product);
    public ProductDTO getProductById(int productId);
    public ProductDTO selectByContractId(int contract_id);
    public List<ProductDTO> selectAllProducts();
    public int updateProduct(ProductDTO product);
    public int deleteProduct(int productId);
	public List<ProductDTO> searchProductsByKeyword(String keyword);
	public List<ProductDTO> searchByConditions(ProductDTO productDTO);
    public int countProduct();
    public int nextId();
	public int incrementViewCount(int product_id);
	public List<ProductDTO> findProductsByRegionCode(int regionCode);
	int updateProductStatusByContract(int product_id, int product_status); 
}
