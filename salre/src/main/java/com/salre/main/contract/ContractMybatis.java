package com.salre.main.contract;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.salre.main.product.ProductContractDTO;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@Repository("contractMybatis")
public class ContractMybatis implements ContractDAOInterface{

		@Autowired
		SqlSessionTemplate sqlSession;
		
		
		String namespace = "com.salre.main.contract.";
		
		
		public ContractUserDTO selectAllById(int contract_id) {
			ContractUserDTO contractAll = sqlSession.selectOne(namespace+"selectAllById",contract_id);
			return contractAll;
		}
		//contract_id로 매물 조회
		public ProductContractDTO selectContractPById(int contract_id) {
			ProductContractDTO productContract = sqlSession.selectOne(namespace +"selectContractPById",contract_id);
			//log.info("productById 1건:" + productContract);
			return productContract;
			
		}
		//계좌관련 추가 정보 입력
		public int updateAddInfo(int contract_id, String account, String name, String bankName) {
			Map<String, Object> params = new HashMap<>();
		    params.put("contract_id", contract_id);
		    params.put("account", account);
		    params.put("account_name", name);
		    params.put("bank_name", bankName);

		    int rowsAffected = sqlSession.update(namespace + "updateAddInfo", params);
		    //log.info("updateAddInfo 업데이트된 행 수: " + rowsAffected);
		    return rowsAffected;
			
		}
		
		public ContractDTO selectById(int contract_id) {
			ContractDTO contract = sqlSession.selectOne(namespace +"selectById",contract_id);
			log.info("contract건:" + contract);
			return contract;
		}

		public int saveContract(ContractDTO contractDTO) {
			sqlSession.insert(namespace + "updateContract",contractDTO);
			//log.info("쿼리" + contractDTO);
			//log.info("수정건수: " + result);
			int contractId= contractDTO.getContract_id();
			return contractId;
		}
		//계약서 엑셀 경로 저장
		public int updateContractExcelPath(@Param("contract_id") int contract_id,
				@Param("contract_epath") String contract_epath) {
			
			Map<String,Object> params = new HashMap<>();
			params.put("contract_id", contract_id);
			params.put("contract_epath", contract_epath);
			int result = sqlSession.update(namespace + "updateContractExcelPath",params);
			//log.info("엑셀경로 저장 완료 건수 :" + result);
			//log.info("contract_epath : "+contract_epath);
			return result; 
		}
		//계약서 pdf 경로 저장
		public int updateContractpdfPath(@Param("contract_id") int contract_id,
				@Param("contract_pdfpath") String contract_pdfpath) {
			
			Map<String,Object> params = new HashMap<>();
			params.put("contract_id", contract_id);
			params.put("contract_pdfpath", contract_pdfpath);
			int result = sqlSession.update(namespace + "updateContractpdfPath",params);
			return result; 
		}
		//계약서 이미지 경로 저장
		public int updateContractImgPath(@Param("contract_id") int contract_id,
				@Param("contract_imgpath") String contract_imgpath) {
		
			Map<String,Object> params = new HashMap<>();
			params.put("contract_id", contract_id);
			params.put("contract_imgpath", contract_imgpath);
			
			int result = sqlSession.update(namespace + "updateContractImgPath",params);
			//log.info("이미지경로 저장 완료 건수 :" + result);
			//log.info("contract_imgpath : "+contract_imgpath);
			return result; 
		}
		
		public void updateContractStatus(int contract_id,int contract_status) {
			Map<String,Object> params = new HashMap<>();
			params.put("contract_id", contract_id);
			params.put("contract_status", contract_status);
			sqlSession.update(namespace + "updateContractStatus",params);
		}

	}