package com.salre.main.loan;

import lombok.Data;

@Data
public class LoanableDTO {
    private int product_id;
    private boolean loan;
    private boolean work;
    private boolean youth;
}
