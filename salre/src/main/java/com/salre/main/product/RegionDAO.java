package com.salre.main.product;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository("RegionInterface")
@Primary
public class RegionDAO implements RegionInterface {

	@Autowired
	SqlSession sqlSession;

	String namespace = "com.salre.main.product.";

	public List<RegionDTO> selectAllRegion() {
		List<RegionDTO> regionlist = sqlSession.selectList(namespace + "selectAllRegion");
		return regionlist;
	}

	public RegionDTO selectRegionById(int region_id) {
		return sqlSession.selectOne(namespace + "selectRegionById", region_id);
	}

	public int insertRegion(RegionDTO region) {
		int result = sqlSession.insert(namespace + "insert");
		return result;
	}

	public int updateRegion(RegionDTO region) {
		int result = sqlSession.update(namespace + "updateRegion", region);
		return result;
	}

	public int deleteRegion(int region_id) {
		int result = sqlSession.delete(namespace + "deleteRegion", region_id);
		return result;
	}

	public int countRegion() {
		return sqlSession.selectOne(namespace + "countRegion");
	}

	@Override
	public int selectIdByRegion(String regionName) {
		return sqlSession.selectOne(namespace + "selectIdByRegion", regionName);
	}

}
