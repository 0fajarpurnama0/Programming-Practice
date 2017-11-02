package rest.open;

import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest; //+ for using variable request

import model.Model;


/**
 *  Sample program for REST service vs. cae-mvc01
 *  REST service using JSONIC, version 2015-05-07 (since 2015-05-07)
 *  Copyright 2015 Hiroshi Nakano nakano@cc.kumamoto-u.ac.jp
 */
public class ApiService {
	public HttpServletRequest request;
	private static Model model = new Model();

	/**
	 * GET process (add comment and get history)
	 * @param params : sender, content
	 * @return : ArrayList<LinkedHashMap<String,Object>>
	 */
  public ArrayList<LinkedHashMap<String,Object>> find(Map<String,Object> params) {
		String sender = params.get("sender").toString();
		String content = params.get("content").toString();
		String remoteIp = request.getRemoteAddr();
		model.setComment(sender, content, remoteIp);
		System.out.println((new Date())+ ": " + sender+","+content+","+remoteIp);
		return model.getHistoryJSON();
	}

}
