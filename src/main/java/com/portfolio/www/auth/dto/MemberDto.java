package com.portfolio.www.auth.dto;

import org.apache.ibatis.type.Alias;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Alias("MemberDto")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemberDto {
	private int memberSeq;
	@NotNull(message = "아이디는 필수값입니다.")
	@Pattern(regexp = "^[a-zA-Z][0-9a-zA-Z]{5,8}$") //영문으로 시작, 영어 대소문자 숫자 조합으로 5~8자리
	private String memberId;
	@NotNull
	@Pattern(regexp = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,15}$")
	//영어대소문자, 특수문자 8~15자리
	private String passwd;
	@NotNull @NotBlank
	private String memberNm;
	@NotNull @NotBlank @Email
	private String email;
	private String authYn;
	private String pwdChngDtm;
	private String joinDtm;
	
	public MemberDto(MemberDto memberDto) {
		this(memberDto.getMemberSeq(), memberDto.getMemberId(), memberDto.getPasswd()
				, memberDto.getMemberNm(), memberDto.getEmail(), memberDto.getAuthYn()
				, memberDto.getPwdChngDtm(), memberDto.getJoinDtm());
	}
	
}