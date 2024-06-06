package com.portfolio.www.forum.notice.dto;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Data;

@Data
public class PageHandler {
	
	private SearchCondition sc;
	private Integer startPage;
	//현재 페이지
	private final Integer page;
	private Integer endPage;
	private final Integer naviSize = 10;
	//한 페이지의 사이즈
	private final Integer size;
	private final Integer offset;
	private Integer totalPage;
	
	public PageHandler(Integer currPage, Integer pageSize, SearchCondition sc) {
		this.page = currPage;
		this.size = pageSize;
		this.offset = (currPage - 1) * pageSize;
		this.sc = sc;
	}
	
	public void calculatePage(Integer totalPost) {
		this.startPage = ((page-1)/10)*10 + 1;
		this.totalPage = (totalPost-1) / size + 1;
		this.endPage = Math.min(startPage + naviSize - 1, totalPage);
	}
	
	public String makeQueryString() {
		return UriComponentsBuilder.newInstance()
								   .queryParam("page", getPage())
								   .queryParam("size", getSize())
								   .queryParam("keyword", getSc().getKeyword())
								   .queryParam("value", getSc().getValue())
								   .build().toString();
	}
	
//	public String getQueryString() {
//		
//	}
	
//	public PageHandler(Integer currPage, Integer pageSize, Integer totalPost) {
//		this.currPage = currPage;
//		this.pageSize = pageSize;
//		this.offset = (currPage - 1) * pageSize;
//		this.startPage = ((currPage-1)/10)*10 + 1;
//		this.totalPage = (totalPost-1) / pageSize + 1;
//		this.endPage = Math.min(startPage + naviSize - 1, totalPage);
//	}

	public void print() {
		System.out.println("currPage = " + this.page);
		if(this.startPage != 1) {
			System.out.print("<< ");
		}
		for(int i=startPage; i<=endPage; i++) {
			System.out.print(i+" ");
		}
		if(this.endPage!=this.totalPage) {
			System.out.println(">>");
		}
		System.out.println();
		
	}

}
