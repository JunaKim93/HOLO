package holo.holouser.service;

import java.util.List;

import holo.holouser.MessageDTO;

public interface MessageService {
	public void sendMessage(MessageDTO dto) throws Exception;
	public int countMsgR(String receiver) throws Exception;
	public int countMsgS(String sender) throws Exception;
	public List msgR_list(int start, int end, String receiver) throws Exception;
	public List msgS_list(int start, int end, String sender) throws Exception;
	public MessageDTO getMsg(int msgnum) throws Exception;
	public void updateReadcount(int msgnum) throws Exception;
	public void deleteSendMsg(int msgnum) throws Exception;
	public void deleteReceiveMsg(int msgnum) throws Exception;
	public void deleteMsg(int msgnum) throws Exception;
	public int countUnreadMsg(String receiver) throws Exception;
}
