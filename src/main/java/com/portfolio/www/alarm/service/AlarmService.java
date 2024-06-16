package com.portfolio.www.alarm.service;

import org.springframework.stereotype.Service;
import org.springframework.util.ObjectUtils;

import com.portfolio.www.auth.dto.MemberDto;
import com.portfolio.www.auth.repository.MemberRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AlarmService {
	private final MemberRepository memberRepository;
	
	public MemberDto getMember(int memberSeq) {
//		MemberDto member = null;
//		MemberDto member = memberRepository.findBySeq(memberSeq);
//		if(!ObjectUtils.isEmpty(member)) {
//			memberId = member.getMemberId();
//		}
//		return memberId;
		return memberRepository.findBySeq(memberSeq);
	}
}
