package holo.notice.service;

import java.util.List;

import holo.notice.HolonoticeDTO;

public interface HolonoticeService {
	 public void insertNotice(HolonoticeDTO dto) throws Exception ;
	 public List getnoticeList(String category_a, int pagenum, int pagesize) throws Exception;
	 public int getnoticeCount() throws Exception ;
	 public void updateCountviews(int articlenum) throws Exception ;
	 public HolonoticeDTO getNotice(int articlenum) throws Exception ;
	 public void updateNotice(HolonoticeDTO dto) throws Exception;
	 public int deleteNotice(int articlenum) throws Exception;
	 public void insertLikes(int articlenum) throws Exception;
	 public void insertDislikes(int articlenum) throws Exception;
}