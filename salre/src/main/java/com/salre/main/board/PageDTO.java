package com.salre.main.board;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
public class PageDTO {
	int page; // 현재 페이지
	int maxPage; // 전체 필요한 페이지 갯수
	int startPage; // 현재 페이지 기준 시작 페이지 값
	int endPage; // 현재 페이지 기준 마지막 페이지 값
}
