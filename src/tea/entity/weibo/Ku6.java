package tea.entity.weibo;

import java.io.*;
import org.json.*;
import tea.entity.*;

public class Ku6
{

    public static JSONObject open(String url) throws IOException, JSONException
    {
        String str = (String) Entity.open(url);
        System.out.println(str);
        return new JSONObject(str);
    }

    public static JSONObject getInfo(String[] code) throws IOException, JSONException
    {
        return open("http://v.ku6.com/video.htm?t=getVideosByIds&ids=" + Tudou.f(code));
    }

}
