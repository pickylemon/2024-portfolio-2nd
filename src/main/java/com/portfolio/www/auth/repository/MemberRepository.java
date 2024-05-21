package com.portfolio.www.auth.repository;

import org.springframework.dao.DataAccessException;
import org.springframework.dao.DataRetrievalFailureException;

import com.portfolio.www.auth.dto.MemberDto;

public interface MemberRepository {
	int save(MemberDto memberDto) throws DataAccessException;
	
	int getMemberSeq(String memberId) throws DataAccessException;
	
	int authValidation(int memberSeq) throws DataAccessException;
	
	MemberDto find(String memberId) throws DataRetrievalFailureException;
	
}