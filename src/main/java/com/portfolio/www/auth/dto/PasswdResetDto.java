package com.portfolio.www.auth.dto;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PasswdResetDto {
	@NotNull
	private int resetPasswdAuthSeq;
	@NotNull
	private int memberSeq;
	@NotNull
	@Pattern(regexp = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,15}$",
	message = "비밀번호는 특수문자와 영어대소문자, 숫자를 조합해 8~15자리 내로 입력해주세요.")
	private String passwd;

}
