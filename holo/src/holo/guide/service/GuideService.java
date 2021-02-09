package holo.guide.service;

import holo.guide.AddressDTO;

public interface GuideService {
	public void insertAddr(AddressDTO addr) throws Exception;
	public void updateAddr(AddressDTO addr) throws Exception;
	public int checkAddr(String id) throws Exception;
}
