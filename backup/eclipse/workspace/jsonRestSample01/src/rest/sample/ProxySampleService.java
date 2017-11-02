package rest.sample;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.*;

import net.arnx.jsonic.JSON;
/**
 *  Simple REST with JSON sample using JSONIC GET, version 2015-06-11
 *  Copyright 2015 Hiroshi Nakano nakano@cc.kumamoto-u.ac.jp
 */
public class ProxySampleService {
	/**
	 * Default method for GET (find) / GETのデフォルトメソッド (find)
	 * @param params : hash array / 連想配列(項目名と値)
	 * @return : JSON string
	 */
	public LinkedHashMap<String,Object> find(Map<String,Object> params) {
		LinkedHashMap<String,Object> ret
			= (LinkedHashMap<String,Object>)JSON.decode(getJSON((String)params.get("uri")));
		for(String key : params.keySet()) {
			ret.put( key, params.get(key).toString());
			System.out.println(String.format("%1$tF %1$tT : ", new Date()) + this.getClass().getName()
					+ " : key=" + key + ", param=" + ret.get(key));
		}
		return ret;
	}
	/**
	 * get JSON data from external JSON Rest service / 外部のJSON RESTサービスから、JSONデータを取得
	 * @param uri : full uri for getting data / 外部のRESTサービスのフルURI
	 * @return : JSON string
	 */
	private String getJSON(String uri) {
		String ret = "";
		try {
			ret = "";
			URL url = new URL(uri);
			Object content = url.getContent();
			if (content instanceof InputStream) {
				BufferedReader bf = new BufferedReader(new InputStreamReader((InputStream) content));
				String line;
				while ((line = bf.readLine()) != null) {
					ret += line;
				}
			} else {
				System.out.println("????? " + content.toString());
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		System.out.println(String.format("%1$tF %1$tT : ", new Date()) + this.getClass().getName()
				+ " : ret=" + ret);
		return ret;
	}
}