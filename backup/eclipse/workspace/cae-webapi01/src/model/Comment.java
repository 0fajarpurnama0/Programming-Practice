package model;
import java.util.Date;

/**
 * @author nakano@cc.kumamoto-u.ac.jp
 * @version 2015-04-23
 * 
 * MVC sample program : Data object for Model
 *
 */
public class Comment {
	private Date date;
	private String sender;
	private String content;
	private String remoteIp;
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public String getSender() {
		return sender;
	}
	public void setSender(String sender) {
		this.sender = sender;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRemoteIp() {
		return remoteIp;
	}
	public void setRemoteIp(String remoteIp) {
		this.remoteIp = remoteIp;
	}
	
}
