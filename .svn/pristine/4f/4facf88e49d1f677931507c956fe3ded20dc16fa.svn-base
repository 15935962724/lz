package tea.entity.weibo;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import org.json.*;
import java.net.*;
import sun.misc.BASE64Encoder;

//http://www.tudou.com/programs/view/KrsYt6ABLi4/
public class Tudou
{
    //private static final String appkey = "45cc4aa9f7b0fff5" //"45cc4aa9f7b0fff5","ebe56c978c39857a"
    //                                     , user = "xinyuanxingdong{0}@163.com", pwd = "xinyuan518";
    String community;
    public Tudou(String community)
    {
        this.community = community;
    }

    public JSONObject open(String url) throws IOException, JSONException, SQLException
    {
        WConfig wc = WConfig.find(community);
        HttpURLConnection conn = (HttpURLConnection)new URL(url + "&appKey=" + wc.tudoukey).openConnection();
//        String[] SEQ =
//                {"", "0", "1"};
//        Random ran = new Random();
//        String tmp = user.replaceFirst("\\{0\\}", SEQ[ran.nextInt(SEQ.length)]);
//        System.out.println("用户：" + tmp);


        conn.setRequestProperty("Authorization", "Basic " + new BASE64Encoder().encode((wc.tudouuser + ":" + wc.tudoupassword).getBytes()));
        String str = new String(Filex.read(conn.getInputStream()), "UTF-8");
        System.out.println(str);
        return new JSONObject(str);
    }

    //视频上传接口
    //{"itemUploadInfo":{"token":"75511587_142106070_2783904077","itemCode":"30-LHbT07Oo","uploadUrl":"http://122.141.224.139/?token=75511587_142106070_2783904077&appKey=45cc4aa9f7b0fff5&sn=1338189248445","serverIp":"122.141.224.139"}}
    public JSONObject upload(String title, String content, String tags) throws IOException, JSONException, SQLException
    {
        return open("http://api.tudou.com/v3/gw?method=item.upload&title=" + Http.enc(title) + "&content=" + Http.enc(content) + "&tags=" + Http.enc(tags) + "&channelId=1&ipAddr=127.0.0.1");
    }

    public static String[] STATE_TYPE =
            {"--", "正常播放", "审核中", "转码中", "不存在", "重复上传", "审核不通过"};
    //视频重复：审核不通过

    //视频状态查询
    //{"multiResult":{"results":[{"state":6,"desc":"审核不通过","itemCode":"1leKHoWFaoI"}]}}
    public JSONObject getState(String[] code) throws IOException, JSONException, SQLException
    {
        return open("http://api.tudou.com/v3/gw?method=item.state.get&itemCodes=" + f(code));
    }

    //视频信息查询
    //{"multiResult":{"results":[{"description":"11","tags":"心愿行动","alias":"","definition":0,"itemId":142112653,"itemCode":"l3Nu9NrJah0","title":"11","picUrl":"http://i4.tdimg.com/142/112/653/p.jpg","totalTime":561870,"channelId":99,"outerPlayerUrl":"http://www.tudou.com/v/l3Nu9NrJah0/v.swf","itemUrl":"http://www.tudou.com/programs/view/l3Nu9NrJah0/","mediaType":"视频","playTimes":1,"downEnable":true,"pubDate":"2012-05-28","favorall":0,"bigPicUrl":"http://i4.tdimg.com/142/112/653/w.jpg","ownerId":112415998,"ownerNickname":"心愿行动小天使","commentCount":0,"ownerName":"_112415998","picChoiceUrl":["http://i4.tdimg.com/142/112/653/m15.jpg","http://i4.tdimg.com/142/112/653/m30.jpg"],"secret":false,"addPlaylistTime":""}]}}
    public JSONObject getInfo(String[] code) throws IOException, JSONException, SQLException
    {
        return open("http://api.tudou.com/v3/gw?method=item.info.get&itemCodes=" + f(code));
    }

    //豆单信息查询
    //{"multiResult":{"results":[{"description":"","tags":"","title":"《黑衣人3》预告合辑","channelId":22,"outerPlayerUrl":"http://www.tudou.com/l/aLrAelXu-_g/v.swf","playTimes":218696,"playlistId":15570487,"ownerId":88587884,"ownerNickname":"","subTimes":1,"ownerName":"","playlistCode":"aLrAelXu-_g","createDate":"2012-05-25T12:22:56","modifiedDate":"2012-05-25T13:01:28","descriptionUrl":"http://www.tudou.com/playlist/id/15570487/","playlistUrl":"http://www.tudou.com/playlist/p/l15570487.html","itemCount":7,"playlistPicUrl":"http://i4.tdimg.com/127/920/933/p.jpg","currentItemId":0}]}}
    public JSONObject getPlaylist(String[] code) throws IOException, JSONException, SQLException
    {
        return open("http://api.tudou.com/v3/gw?method=playlist.info.get&playlistCodes=" + f(code));
    }

    //剧集节目查询  pos:默认1  size:默认10
    //{"multiResult":{"results":[{"description":"","tags":"心战","alias":"","definition":3,"itemId":141644233,"title":"心战01 (粤语)","totalTime":2565730,"bigPicUrl":"http://i4.tdimg.com/141/644/233/w.jpg","picUrl":"http://i4.tdimg.com/141/644/233/p.jpg","channelId":30,"pubDate":"2012-05-24","playTimes":234066,"downEnable":true,"favorall":19,"ownerName":"_81082741","ownerNickname":"高清TVB剧场","outerPlayerUrl":"http://www.tudou.com/a/X8Ir7OkT7Hk/&iid=141644233/v.swf","itemUrl":"http://www.tudou.com/programs/view/_CX7MvoyWfU/","ownerId":81082741,"mediaType":"视频","commentCount":77,"itemCode":"_CX7MvoyWfU","picChoiceUrl":["http://i4.tdimg.com/141/644/233/m15.jpg","http://i4.tdimg.com/141/644/233/m30.jpg"],"secret":false,"addPlaylistTime":""}],"page":{"pageSize":1,"pageCount":6,"pageNo":1,"totalCount":6}}}
    public JSONObject getItem(int albumId, int pos, int size) throws IOException, JSONException, SQLException
    {
        //用 appkey 报：4031 : 验证异常,访问次数超出限制,请减少每分钟请求次数
        return open("http://api.tudou.com/v3/gw?method=album.item.get&appKey=" + "myKey" + "&albumId=" + albumId + "&pagegNo=" + pos + "&pageSize=" + size);
    }

    static String f(String[] code)
    {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < code.length; i++)
        {
            if (i > 0)
                sb.append(",");
            sb.append(code[i]);
        }
        return sb.toString();
    }

}
