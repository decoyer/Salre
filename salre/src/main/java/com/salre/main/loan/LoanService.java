package com.salre.main.loan;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LoanService {
    @Autowired
    private LoanRepository loanRepository;

    // 대출 조회
    public List<LoanDTO> select(int age, int income) {
        return loanRepository.select(age, income);
    }

    // 대출 상세 조회
    public LoanDTO selectById(int id) {
        return loanRepository.selectById(id);
    }
}