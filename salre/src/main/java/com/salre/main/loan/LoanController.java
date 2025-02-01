package com.salre.main.loan;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/loan")
public class LoanController {
    @Autowired
    LoanService loanService;

    // 메인 페이지
    @GetMapping("/main")
    public ModelAndView viewMain() {
        return new ModelAndView("loan/main");
    }

    // 대출상품 조회
    @PostMapping("/result")
    public String getResult(@RequestParam("age") int age, @RequestParam("income") String income,
            @RequestParam("product_type") String productType, Model model) {
        // 입력받은 소득 값 구분
        int incomeValue = getIncome(income);

        // 조건에 따라 대출상품 조회
        List<LoanDTO> loanList = select(age, incomeValue);

        // 조회된 대출상품을 JSP로 전달
        model.addAttribute("loanList", loanList);

        // 결과 페이지 이동
        return "loan/result";
    }

    // 조건에 따라 대출상품 조회
    @GetMapping("/select")
    @ResponseBody
    public List<LoanDTO> select(@RequestParam("age") int age, @RequestParam("income") int incomeValue) {
        return loanService.select(age, incomeValue);
    }

    // 대출상품 상세 조회
    @PostMapping("/detail")
    public String getDetail(@RequestParam("id") int id, Model model) {
        // 대출상품 번호를 통해 상세 정보를 조회
        LoanDTO loan = loanService.selectById(id);

        // 대출상품 상세 정보를 JSP로 전달
        model.addAttribute("loan", loan);

        // 상세 페이지 이동
        return "loan/detail";
    }

    // 입력받은 소득 값 구분
    private int getIncome(String income) {
        switch (income) {
            case "3500l":
                return 35000000;
            case "5000l":
                return 50000000;
            default:
                return Integer.MAX_VALUE;
        }
    }
}
