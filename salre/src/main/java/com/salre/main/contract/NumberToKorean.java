package com.salre.main.contract;

public class NumberToKorean {
	  private static final String[] UNITS = {"", "만", "억", "조", "경"};
	    private static final String[] NUMBERS = {"", "일", "이", "삼", "사", "오", "육", "칠", "팔", "구"};

	    public static String convertToKorean(int amount) {
	        if (amount == 0) {
	            return "금영원";
	        }

	        StringBuilder result = new StringBuilder("금");
	        int unitIndex = 0;

	        while (amount > 0) {
	            int part = amount % 10000;
	            if (part > 0) {
	                result.insert(1, convertPart(part) + UNITS[unitIndex]);
	            }
	            amount /= 10000;
	            unitIndex++;
	        }

	        result.append("원정");
	        return result.toString();
	    }

	    private static String convertPart(int part) {
	        StringBuilder result = new StringBuilder();
	        int[] digits = {1000, 100, 10, 1};
	        String[] units = {"천", "백", "십", ""};

	        for (int i = 0; i < digits.length; i++) {
	            int digit = part / digits[i];
	            if (digit > 0) {
	                result.append(NUMBERS[digit]).append(units[i]);
	            }
	            part %= digits[i];
	        }

	        return result.toString();
	    }

}
