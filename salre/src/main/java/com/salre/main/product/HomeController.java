package com.salre.main.product;
 
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;
 
@Slf4j
@Controller
public class HomeController {
    @Autowired
    private ProductService productService;
    @Autowired
    private RegionService regionService;
    @Autowired
    private ApplicationContext applicationContext;

    private static String appkey;

    @PostConstruct
    public void init() {
        Properties props = (Properties) applicationContext.getBean("apikey");
        appkey = props.getProperty("appkey");
    }
    
    @GetMapping("/")
    public String home(Model model) {
        // 기존 데이터
        model.addAttribute("productCount", productService.countProduct());
        model.addAttribute("regionCount", regionService.countRegion());
        model.addAttribute("appkey", appkey);

        try {
            model.addAttribute("regions", new ObjectMapper().writeValueAsString(regionService.selectAllRegion()));
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
 
        return "home"; // home.jsp로 이동
    }
    
    @PostMapping("/nearby-products")
    @ResponseBody
    public List<ProductDTO> getNearbyProducts(@RequestBody Map<String, String> regionData) {
        String regionName = regionData.get("region"); // ex: 강남구
        System.out.println("Region DATA : " + regionData);
 
        int regionCode = regionService.selectIdByRegion(regionName); 
        System.out.println(regionCode);
        System.out.println(productService.findProductsByRegionCode(regionCode));
        return productService.findProductsByRegionCode(regionCode);
    }
}
