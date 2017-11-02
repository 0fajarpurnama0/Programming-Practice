package model;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;

/**
 * @author nakano@cc.kumamoto-u.ac.jp
 * @version 2015-05-07
 * 
 * modified for WebAPI version from (MVC sample program : Model)
 */
public class Model {
	private static ArrayList<Comment> rec = new ArrayList<Comment>();
	
	public void setComment(String sender, String content, String remoteIp) {
		Comment c = new Comment();
		c.setDate(new Date());
		if(sender.equals("") || sender == null) sender = "no name";
		c.setSender(sender);
		if(content.equals("") || content == null) content = "no comment";
		c.setContent(content);
		c.setRemoteIp(remoteIp);
		rec.add(0, c);
	}
	
	// for WebAPI (JSON)
	public ArrayList<LinkedHashMap<String,Object>> getHistoryJSON() {
		ArrayList<LinkedHashMap<String,Object>> ret = new ArrayList<LinkedHashMap<String,Object>>();
		for(Comment c : rec) {
			LinkedHashMap<String,Object> line = new LinkedHashMap<String,Object>();
			line.put("sender", c.getSender());
			line.put("date", c.getDate());
			line.put("from", c.getRemoteIp());
			line.put("content", c.getContent());
			ret.add(line);
		}
		return ret;
	}
}