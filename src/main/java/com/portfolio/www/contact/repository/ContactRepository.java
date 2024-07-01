package com.portfolio.www.contact.repository;

import java.util.List;

import com.portfolio.www.contact.dto.ContactDto;

public interface ContactRepository {
	public int save(ContactDto contactDto);
	public List<ContactDto> getAll();
}
