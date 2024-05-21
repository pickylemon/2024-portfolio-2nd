package com.portfolio.www.auth.dto;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Alias("MemberDto")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemberDto {
	private int memberSeq;
	private String memberId;
	private String passwd;
	private String memberNm;
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