package holo.holouser.service;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import holo.holouser.MessageDTO;

@Service("msg")
public class MessageServiceMybatis implements MessageService{

	@Autowired
	private SqlSessionTemplate dao = null;
	
	@Autowired
	private HashMap hashmap = null;

	@Override
	public void sendMessage(MessageDTO dto) throws Exception {
		dao.insert("msg.sendMessage", dto);
		
	}

	@Override
	public int countMsgR(String receiver) throws Exception {
		
		return dao.selectOne("msg.countMsgR", receiver);
	}

	@Override
	public int countMsgS(String sender) throws Exception {
		
		return dao.selectOne("msg.countMsgS", sender);
	}

	@Override
	public List msgR_list(int start, int end, String receiver) throws Exception {
		hashmap.put("start", start);
		hashmap.put("end", end);
		hashmap.put("receiver", receiver);
		
		
		return dao.selectList("msg.getMsgListR", hashmap);
	}

	@Override
	public List msgS_list(int start, int end, String sender) throws Exception {
		hashmap.put("start", start);
		hashmap.put("end", end);
		hashmap.put("sender", sender);
		
		
		return dao.selectList("msg.getMsgListS", hashmap);
	}

	@Override
	public MessageDTO getMsg(int msgnum) throws Exception {
		
		return dao.selectOne("msg.getMsg", msgnum);
	}

	@Override
	public void updateReadcount(int msgnum) throws Exception {
		dao.update("msg.updateReadcount",msgnum);
		
	}

	@Override
	public void deleteSendMsg(int msgnum) throws Exception {
		dao.update("msg.delSendMsg", msgnum);
		
	}

	@Override
	public void deleteReceiveMsg(int msgnum) throws Exception {
		dao.update("msg.delReceiveMsg",msgnum);
		
	}

	@Override
	public void deleteMsg(int msgnum) throws Exception {
		dao.update("msg.delMsg",msgnum);
		
	}



}
