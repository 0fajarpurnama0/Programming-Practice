/** Commented by Fajar Purnama 152-D8713 */

package model; /** This creates a package named "model" */
import java.util.Date; /** Reads a file "java.util.Date" and uses the information */

/** Comments */
/**
 * @author nakano@cc.kumamoto-u.ac.jp
 * @version 2015-04-23
 * 
 * MVC sample program : Data object for Model
 *
 */

public class Comment { /** Creates a class named "Comment" accessable by any class, package, subclass, and world (public) (different from protected and private class). A class is a set of instructions that describe how a data structure should behave. */
	private Date date; /** Declares "date" variable as "Date" type and makes it "private" (only accessable to class) */
	private String sender; /** Creates a private "sender" variable as "String" type */
	private String content; /** Creates a "content" variable (same as previous line) */
	private String remoteIp; /** Creates a "remoteIP" variable (same as previous line) */
	public Date getDate() { /** creates a "getDate()" function type "Date" as "public" */
		return date; /** returns "date" value after function is called */
	}
	public void setDate(Date date) { /** Creates a public void function "setDate(Date date)", note that Date = type and date = variable */
		this.date = date; /** Assigns value "date" (on getDate() function) to the instance variable "date" (this.date) */
	}

/** The void keyword (which means "completely empty") indicates to the method that no value is returned after calling that method. Alternatively, we can use data type keywords (such as int, char, etc.) to specify that a method should return a value of that type.*/

	public String getSender() { /** creates a "getSender()" function type "String" as "public" */
		return sender; /** returns "sender" value after function is called */
	}
	public void setSender(String sender) { /** Creates a public void function "setSender(String sender)" */
		this.sender = sender; /** Assigns value "sender" (on getSender() function) to the instance variable "sender" (this.sender) */
	}
	public String getContent() { /** creates a "getContent()" function type "String" as "public" */
		return content; /** returns "content" value after function is called */
	}
	public void setContent(String content) { /** Creates a public void function "setContent(String content)" */
		this.content = content; /** Assigns value "content" (on getContent() function) to the instance variable "content" (this.content) */
	}
	public String getRemoteIp() { /** creates a "getRemoteIp()" function type "String" as "public" */
		return remoteIp;
	}
	public void setRemoteIp(String remoteIp) { /** Creates a public void function "setRemoteIp(String remoteIp)" */
		this.remoteIp = remoteIp; /** Assigns value "remoteIp" (on getRemoteIp() function) to the instance variable "remoteIp" (this.remoteIp) */
	}
	
} /** Ends a class, within the comment class there are date, sender, content, and remoteIP */
