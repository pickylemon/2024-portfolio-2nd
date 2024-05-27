package com.portfolio.www.auth.dto;

import java.util.HashMap;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class EmailDto {
	private String receiver;
	private String subject;
	private String text;
	private boolean isHtml;
	
	public static EmailDto createEmailDto(String receiver, HashMap<String, String> mailContent, boolean isHtml) {
		return new EmailDto(receiver, mailContent.get("subject"), mailContent.get("text"), isHtml);
	}
	
	public boolean isHtml() {
		return this.isHtml;
	}
}
