package holo.holouser.service;

import java.util.List;

import holo.holouser.ScrapDTO;

public interface ScrapServiceInterface {

	 public void doScrap(ScrapDTO scrapDTO) throws Exception;
	 public List scrapList(String id, int pagenum) throws Exception;
	 public int countScrap(String id)throws Exception;
}
