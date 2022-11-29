package util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashSet;
import java.util.Map;
import java.util.Properties;
import java.util.ResourceBundle;
import java.util.Set;

public class Config{
	
	private static ResourceBundle r = null;
	private static Properties p = null;
	static{
		if (Config.class.getResource("/config.properties") == null) {
			r = ResourceBundle.getBundle("config");
		} else {
			r = ResourceBundle.getBundle("config");
		}
		File config = new File("/config.properties");
		if(config.exists()){
			p = new Properties();
			FileInputStream is = null;
			try{
				is = new FileInputStream(config);
				p.load(is);
			}catch(Exception e){
				//
			}finally{
				if(is!=null)
					try {
						is.close();
					} catch (IOException e) {
					}
			}
			
		}
	}

	public static String getString(String key){
		if(p!=null){
			String r = null;
			if((r=p.getProperty(key))!=null){
				return r;
			}
		}
		return r.getString(key);
	}
	public static Integer getInt(String key){
		try{
			if(p!=null){
				String r = null;
				if((r=p.getProperty(key))!=null)
				return Integer.parseInt(r);
			}
		}catch(Exception e){
		}
		try{
			String v = r.getString(key);
			if(v!=null){
				return Integer.parseInt(v);
			}
		}catch(Exception e){
		}
		return null;
	}
	public static Integer getInt(String key, int defaultVal) {
		Integer val = getInt(key);
		if(val!=null){
			return val;
		}
		return defaultVal;
	}
	/**
	 * 璇诲彇閰嶇疆鏂囦欢涓殑鍙傛暟鍊�
	 * @param key 鍙傛暟鍚�
	 * @param defVal 榛樿鍊�
	 * @return
	 */
	public static String getString(String key, String defVal) {
		String rs = getString(key);
		if(rs==null){
			return defVal;
		}
		return rs;
	}
	public static void main(String[] args) {
		System.out.println(getString("junan"));
	}
}
