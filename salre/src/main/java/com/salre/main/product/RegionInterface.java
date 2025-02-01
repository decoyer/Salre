package com.salre.main.product;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface RegionInterface {
	public List<RegionDTO> selectAllRegion();

	public RegionDTO selectRegionById(int region_id);

	public int insertRegion(RegionDTO region);

	public int updateRegion(RegionDTO region);

	public int deleteRegion(int region_id);

	public int countRegion();

	public int selectIdByRegion(String regionName);
}
