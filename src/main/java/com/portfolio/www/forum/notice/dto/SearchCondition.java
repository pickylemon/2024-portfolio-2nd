package com.portfolio.www.forum.notice.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SearchCondition {
	String keyword;
	String value;

	public boolean isEmpty() {
		return keyword == null & value == null;
	}
}
