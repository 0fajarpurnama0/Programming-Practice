package rest.sample;
import java.util.*;
/**
 *  Simple REST with JSON/JSONP sample using JSONIC GET, version 2015-06-11
 *  Copyright 2015 Hiroshi Nakano nakano@cc.kumamoto-u.ac.jp
 */
public class SampleService {
	/**
	 * Default method for GET (find) / GETのデフォルトメソッド (find)
	 * @param params : hash array / 連想配列(項目名と値)
	 * @return : JSON string
	 */
	public LinkedHashMap<String,Object> find(Map<String,Object> params) {
		LinkedHashMap<String,Object> ret = new LinkedHashMap<String,Object>();
		ret.put("message", "Hello, I am " + this.getClass().getName() + "!!!");
		for(String key : params.keySet()) {
			ret.put( key, params.get(key).toString());
			System.out.println(String.format("%1$tF %1$tT : ", new Date()) + this.getClass().getName()
					+ " : key=" + key + ", param=" + ret.get(key));
		}
		return ret;
	}
}