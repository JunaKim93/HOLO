package holo.board.search.service;

import java.util.List;

import holo.board.search.dto.SearchDTO;

public interface SearchService {

	public List<SearchDTO> test(String choice, String search) throws Exception;
	public List<SearchDTO> getSearchList(String choice, String search, int start, int end) throws Exception;
	public int searchCount(String choice, String search) throws Exception;
}