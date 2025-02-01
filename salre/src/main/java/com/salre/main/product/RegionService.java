package com.salre.main.product;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RegionService {
	
	@Autowired
	RegionInterface RegionDAO;
	public List<RegionDTO> selectAllRegion(){
		return RegionDAO.selectAllRegion();
	}
	
	public RegionDTO selectRegionById(int region_id) {
		return RegionDAO.selectRegionById(region_id);
	}
	public int selectIdByRegion(String regionName) {
		return RegionDAO.selectIdByRegion(regionName);
	}
	public int insertRegion(RegionDTO region) {
		return RegionDAO.insertRegion(region);
	}
	
	public int updateRegion(RegionDTO region) {
		return RegionDAO.updateRegion(region);
	}
	public int deleteRegion(int region_id) {
		return RegionDAO.deleteRegion(region_id);
	}
	public int countRegion() {
		return RegionDAO.countRegion();
	}
 
}
