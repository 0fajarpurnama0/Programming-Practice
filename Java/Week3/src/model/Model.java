package model;
import java.util.ArrayList;
import java.util.Date;

/**
 * @author nakano@cc.kumamoto-u.ac.jp
 * @version 2015-04-23
 * 
 * MVC sample program : Model
 *
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
	
	public String getHistory() {
		StringBuffer h = new StringBuffer();
		for(Comment c : rec) {
			h.append("<div>sender:<b>"+c.getSender()+"</b> (date:"+c.getDate()+", from:"+c.getRemoteIp()+"<br />\n");
			h.append(c.getContent()+"</div>\n");
		}
		return h.toString();
	}
}
