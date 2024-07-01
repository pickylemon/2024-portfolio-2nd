package com.portfolio.www.contact.dto;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import lombok.Data;

@Data
public class ContactDto {
	@NotBlank(message = "연락받으실 분의 이름을 입력해주세요.")
	private String contactNm;
	@NotBlank @Email(message = "이메일 양식에 맞추어 입력해주세요.")
	private String contactEmail;
	@Size(min=1, max=1000, message = "1~1000자 사이로 메시지를 남겨주세요.")
	private String contactMsg;

}
