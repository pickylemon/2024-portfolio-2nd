package com.portfolio.www.auth.dto;

import com.portfolio.www.auth.message.ResetPasswdAuthMessageEnum;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ResetPasswdAuthResponse {
	PasswdResetDto dto;
//	ResetPasswdAuthDto dto;
	ResetPasswdAuthMessageEnum msgObject;
	
	public ResetPasswdAuthResponse(PasswdResetDto dto) {
		this.dto = dto;
	}
	
	public ResetPasswdAuthResponse(ResetPasswdAuthMessageEnum msgObject) {
		this.msgObject = msgObject;
	}

}
