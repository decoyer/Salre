package com.salre.main.contract;

import com.salre.main.product.ProductContractDTO;

public interface ContractDAOInterface {
	
	public ContractUserDTO selectAllById(int  contract_id);
	public ProductContractDTO selectContractPById(int  contract_id);
	public int updateAddInfo(int contract_id,String account,String bank_name,String account_name);
	public ContractDTO selectById(int  contract_id);
	public int saveContract(ContractDTO contractDTO);
	public int updateContractExcelPath(int contract_id, String contract_ePath);
	public int updateContractImgPath(int contract_id, String contract_imgPath);
	public void updateContractStatus(int contract_id,int contract_status);
}
