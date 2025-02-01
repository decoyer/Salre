package com.salre.main.product;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/region")
public class RegionController {
    private final RegionService regionService;

    public RegionController(RegionService regionService) {
        this.regionService = regionService;
    }

    // 지역 등록 폼
    @GetMapping("/insert")
    public String showCreateForm(Model model) {
        model.addAttribute("regionDTO", new RegionDTO());
        return "region/insert";
    }

    // 지역 등록 처리
    @PostMapping("/insert")
    public String createRegion(@ModelAttribute RegionDTO regionDTO) {
        regionService.insertRegion(regionDTO);
        return "redirect:/region/list";
    }

    // 지역 목록 조회
    @GetMapping("/list")
    public String listRegions(Model model) {
        List<RegionDTO> regions = regionService.selectAllRegion();
        model.addAttribute("regions", regions);
        return "region/list";
    }
    // 지역 수정 폼
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable("id") int regionId, Model model) {
        RegionDTO regionDTO = regionService.selectRegionById(regionId);
        model.addAttribute("regionDTO", regionDTO);
        return "region/edit";
    }

    // 지역 수정 처리
    @PostMapping("/edit/{id}")
    public String updateRegion(@PathVariable("id") int regionId, @ModelAttribute RegionDTO regionDTO) {
        regionDTO.setRegion_id(regionId);
        regionService.updateRegion(regionDTO);
        return "redirect:/region/list";
    }

    // 지역 삭제
    @GetMapping("/delete/{id}")
    public String deleteRegion(@PathVariable("id") int regionId) {
        regionService.deleteRegion(regionId);
        return "redirect:/region/list";
    }

}
