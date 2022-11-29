package util;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;


public class YlUtil {
	/**
	 * 获取参数
	 * @param request
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	public static String getAllPar(HttpServletRequest request,tea.entity.Http h) throws UnsupportedEncodingException{
		Map<String, String[]> parameterMap=request.getParameterMap();  
        String parameterStr="";  
        //之后，所有变长参数都在这个名为parameterMap的Map里面了。  
        //只需要遍历一下这个Map就可以了。  
        for(String key : parameterMap.keySet()){  
            parameterStr+=key+"="+URLEncoder.encode(parameterMap.get(key)[0],"UTF-8")+"&";  
        } 
        return parameterStr;
	}
}
