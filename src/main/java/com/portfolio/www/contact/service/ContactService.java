package com.portfolio.www.contact.service;

import org.springframework.stereotype.Service;

import com.portfolio.www.contact.dto.ContactDto;
import com.portfolio.www.contact.repository.ContactRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ContactService {
	private final ContactRepository contactRepository;
	
	public int save(ContactDto contactDto) {
		return contactRepository.save(contactDto);
	}

}
