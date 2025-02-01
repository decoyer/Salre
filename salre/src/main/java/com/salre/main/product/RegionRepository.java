package com.salre.main.product;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

public class RegionRepository {
	@Autowired
	SqlSession sqlSession;
	
	String namespace = "com.salre.main.product";
	
	public List<RegionDTO> selectAllRegions(){
		return sqlSession.selectList(namespace + "selectAllRegions");	
	}
	public RegionDTO getRegionById(int region_id) {
		return sqlSession.selectOne(namespace + "getRegionById", region_id);
	}
	public int InsertRegion(RegionDTO region){
		return sqlSession.insert(namespace + "InsertRegion", region);
	}
	public int updateRegion(RegionDTO region) {
		return sqlSession.update(namespace + "updateRegion" , region);
	}
	public int deleteRegion(int region_id) {
		return sqlSession.delete(namespace + "deleteRegion", region_id); 
	}
	public int countProduct() {
		return sqlSession.selectOne(namespace + "countProduct");
	}
	public int selectIdByRegion(String regionName) {
		return sqlSession.selectOne(namespace + "selectIdByRegion", regionName);
	}
}
