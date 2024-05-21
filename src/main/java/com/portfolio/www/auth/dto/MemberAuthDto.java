package com.portfolio.www.auth.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MemberAuthDto {
	private int authSeq;
	private int memberSeq;
	private String authNum;
	private String authUri;
	private Long regDtm;
	private Long expireDtm;
	private String authYn;

}