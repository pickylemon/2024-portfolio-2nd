package com.portfolio.www.auth.dto;

import java.util.Calendar;
import java.util.UUID;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class ResetPasswdAuthDto {
	private int resetPasswdAuthSeq;
	private String authUri;
	private int memberSeq;
	private long regDtm;
	private long expireDtm;
	private String resetPwdYn;
	
	
	public static ResetPasswdAuthDto createResetPasswdAuthDto(int memberSeq) {
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.MINUTE, 3);
		
		String authUri = UUID.randomUUID().toString().replaceAll("-","");
		Long regDtm = Calendar.getInstance().getTimeInMillis();
		Long expireDtm = cal.getTimeInMillis();
		
		return new ResetPasswdAuthDto(authUri, memberSeq, regDtm, expireDtm);
	}


	public ResetPasswdAuthDto(String authUri, int memberSeq, long regDtm, long expireDtm) {
		this.authUri = authUri;
		this.memberSeq = memberSeq;
		this.regDtm = regDtm;
		this.expireDtm = expireDtm;
	}
	
	
	

}
