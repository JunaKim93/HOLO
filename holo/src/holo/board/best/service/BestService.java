package holo.board.best.service;

import java.util.List;

public interface BestService {
	public int getInfoBestCount() throws Exception;
	public List getInfoBestList(int start, int end) throws Exception;
	public int getDiyBestCount() throws Exception;
	public List getDiyBestList(int start, int end) throws Exception;
	public int getComBestCount() throws Exception;
	public List getComBestList(int start, int end) throws Exception;
}
