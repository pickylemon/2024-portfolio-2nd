package com.portfolio.www.auth.repository;

import org.springframework.dao.DataAccessException;
import org.springframework.dao.DataRetrievalFailureException;

import com.portfolio.www.auth.dto.MemberDto;
import com.portfolio.www.auth.dto.PasswdResetDto;

public interface MemberRepository {
	int save(MemberDto memberDto) throws DataAccessException;
	
	int getMemberSeq(String memberId) throws DataAccessException;
	
	int updateAuthValid(int memberSeq) throws DataAccessException;
	
	MemberDto findById(String memberId) throws DataRetrievalFailureException;
	//
	MemberDto findByIdNoAuth(String memberId) throws DataRetrievalFailureException;
	
	MemberDto findBySeq(int memberSeq) throws DataAccessException;
	
	int updatePasswd(PasswdResetDto resetDto) throws DataAccessException;
}