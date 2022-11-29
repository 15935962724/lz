/**
 * 
 */
package tea.ui.util;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import java.lang.reflect.Type;
import java.util.*;

/**
 * json串转换类。
 * 
 * @author 
 * 
 */
public class JsonUtil {

	private static Gson gson = new GsonBuilder().serializeNulls().create();

	/**
	 * 将对象转换为json字符串。
	 * 
	 * @param src
	 *            要被转换的对象
	 * @return json字符串
	 */
	public static String toJson(Object src) {
		return gson.toJson(src);
	}

	/**
	 * 将指定类型的对象转换为json字符串。
	 * 
	 * @param src
	 *            要转换的对象
	 * @param typeOfSrc
	 *            要转换的对象的类型
	 * @return json字符串
	 */
	public static String toJson(Object src, Type typeOfSrc) {
		return gson.toJson(src, typeOfSrc);
	}

	/**
	 * 将json字符串转换为Map对象。
	 * 
	 * @param json
	 *            json字符串
	 * @return Map对象。
	 */
	public static Map<String, String> fromJsonStr(String json) {
		return gson.fromJson(json, new TypeToken<Map<String, String>>() {
		}.getType());
	}

	/**
	 * 将json字符串转换为Map对象。
	 * 
	 * @param json
	 *            json字符串
	 * @return Map对象。
	 */
	public static Map<String, Object> fromJsonObj(String json) {
		return gson.fromJson(json, new TypeToken<Map<String, Object>>() {
		}.getType());
	}

	/**
	 * 将json字符串转换为指定的类型。
	 * 
	 * @param json
	 *            json字符串
	 * @param typeOfT
	 *            要被转换的类型
	 * @return 通过json字符串构建的指定的对象。
	 */
	public static <T> T fromJson(String json, Type typeOfT) {
		return gson.fromJson(json, typeOfT);
	}

	/**
	 * 将json字符串转换为指定的类型。
	 * 
	 * @param json
	 *            json字符串
	 * @param classOfT
	 *            要被转换的类型
	 * @return 通过json字符串构建的指定的对象。
	 */
	public static <T> T fromJson(String json, Class<T> classOfT) {
		return gson.fromJson(json, classOfT);
	}

	/***
	 * json 转map
	 * @param jsonString
	 * @return Map
	 */
	@SuppressWarnings("rawtypes")
	public static Map<String, Object> josnToMap(String jsonString) {
		JSONObject jsonObject = JSONObject.fromObject(jsonString);
		Iterator keyIter = jsonObject.keys();
		String key;
		Object value;
		Map<String, Object> valueMap = new HashMap<String, Object>();
		while (keyIter.hasNext()) {
			key = (String) keyIter.next();
			value = jsonObject.get(key);
			valueMap.put(key, value);
		}
		return valueMap;
	}
	
	/**
	 * 取出json字符串中的list
	 * @param jsonString
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public static List josnToList(String jsonString){
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> listMap = JsonUtil.josnToMap(jsonString);
		if(listMap.containsKey("list"))
		{
			String listStr = (String) listMap.get("list").toString();
			JSONArray data = JSONArray.fromObject(listStr);
			for(int i=0;i<data.size();i++){
				JSONObject jobj =  (JSONObject) data.get(i);
				Iterator keyIter = jobj.keys();
				String key;
				Object value;
				Map<String, Object> valueMap = new HashMap<String, Object>();
				while (keyIter.hasNext()) {
					key = (String) keyIter.next();
					value = jobj.get(key);
					valueMap.put(key, value);
				}
				list.add(valueMap);
			}
		}
		return list;
	}	
}
