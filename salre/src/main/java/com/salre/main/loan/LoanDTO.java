package com.salre.main.loan;

import lombok.Data;

@Data
public class LoanDTO {
    private int loan_id;
    private String loan_name;
    private String bank_name;
    private String interest_type;
    private String repayment_type;
    private double loan_rate;
    private int loan_limit;
    private int max_age;
    private int max_income;
}