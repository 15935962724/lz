package tea.entity.weibo;

import java.net.*;
import java.text.*;
import java.util.*;
import java.io.*;
import java.util.zip.*;
import javax.crypto.*;
import javax.crypto.spec.*;
import sun.misc.*;
import tea.entity.*;
import org.json.*;
import java.sql.SQLException;
import tea.entity.member.*;
import java.util.regex.*;

public class OAuth
{
    public static final String[] OAUTH_TYPE =
            {"","[新浪]","[腾讯]"};
    /*
       public static String oauth(String url) throws SQLException
       {
           //"2761202927","2761182323","2762280771"
           Profile p = Profile.find("[新浪]piccweibo");
           p.getTime();

           return oauth(url, false, null, new String[]{p.sinakey, p.sinasecret}, false);
           //iwlk
           //p.sinakey="f12e652b1157d3d1398b62db49c3ca63";
           //p.sinasecret="2e3901bdd1f56bb39466ec7ed4e6b9be";
           //return oauth(url, true, null, new String[]{p.sinakey, p.sinasecret}, false);
       }

       //isQQ: false:心愿行动  true:发现行动
       public static String oauth(String url, boolean isPost, byte[] pic, boolean isQQ) throws SQLException
       {
           String member = "[新浪]piccweibo";
           if ("LIU".equals(System.getenv("COMPUTERNAME")))
           {
               member = "[新浪]iwlk";
           }
           //"weibo"
           Profile p = Profile.find(member);
           p.getTime();

           return oauth(url, isPost, pic, isQQ ? new String[]{p.qqkey, p.qqsecret}: new String[]{p.sinakey, p.sinasecret}, isQQ);
       }
     */
    public static String oauth(String community,String url,boolean isPost,byte[] pic,String[] token) throws SQLException
    {
        boolean isToast = false;

        WConfig s = WConfig.find(community);
        boolean isQQ = url.startsWith("http://open.t.qq.com/");

        //System.out.println("请求_OAUTH：" + url);
        //
        final long timestamp = System.currentTimeMillis() / 1000; // 1316672567; //
        final long nonce = timestamp + new Random().nextInt(); // 1169216974; //

        ArrayList<String> al = new ArrayList();

        al.add("oauth_consumer_key=" + (isQQ ? s.qqkey : s.sinakey));
        al.add("oauth_nonce=" + nonce);
        al.add("oauth_signature_method=HMAC-SHA1");
        al.add("oauth_timestamp=" + timestamp);
        if(token != null)
            al.add("oauth_token=" + token[0]);
        al.add("oauth_version=1.0");
        //2.0
        //al.add("client_id=" + (isQQ ? s.qqkey : s.sinakey));
        //
        int j = url.indexOf('?');
        if(j != -1)
        {
            String[] arr = url.substring(j + 1).split("&");
            for(int i = 0;i < arr.length;i++)
                al.add(arr[i]);
            url = url.substring(0,j);
        }
        Collections.sort(al);
        StringBuilder par = new StringBuilder();
        for(int i = 0;i < al.size();i++)
        {
            if(i > 0)
                par.append("&");
            par.append(al.get(i));
        }

        StringBuilder sb = new StringBuilder();
        sb.append(isPost ? "POST" : "GET").append("&").append(enc(url)).append("&").append(enc(par.toString()));
        //
        String sign = (isQQ ? s.qqsecret : s.sinasecret) + "&" + (token == null ? "" : token[1]);
        try
        {
            Mac mac = Mac.getInstance("HmacSHA1");
            mac.init(new SecretKeySpec(sign.getBytes(),"HmacSHA1"));
            sign = String.valueOf(new BASE64Encoder().encode(mac.doFinal(sb.toString().getBytes())));
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
        par.append("&oauth_signature=" + enc(sign));
        try
        {
            // 腾讯接口，采用的不是OAuth
            if(!isPost || (isQQ && pic != null))
                url += "?" + par.toString();

            HttpURLConnection conn = (HttpURLConnection)new URL(url).openConnection();
            // conn.addRequestProperty("Authorization", "OAuth " + par.toString().replaceAll("=", "=\"").replaceAll("&", "\",") + "\"");
            conn.addRequestProperty("Accept-Encoding","gzip");
            if(isPost)
            {
                if(pic != null)
                    conn.addRequestProperty("Content-Type","multipart/form-data; boundary=Jf4mVY1mx_eLBt5GRmSe9hz6i_u6bW");
                conn.setDoOutput(true);
                OutputStream os = conn.getOutputStream();
                if(pic == null)
                {
                    os.write(par.toString().getBytes());
                } else
                {
                    String[] arr = par.toString().split("&");
                    for(int i = 0;i < arr.length;i++)
                    {
                        j = arr[i].indexOf('=');
                        os.write(("--Jf4mVY1mx_eLBt5GRmSe9hz6i_u6bW\r\nContent-Disposition: form-data; name=\"" + arr[i].substring(0,j) + "\"\r\n\r\n" + URLDecoder.decode(arr[i].substring(j + 1),"UTF-8") + "\r\n").getBytes("UTF-8"));
                    }
                    os.write("--Jf4mVY1mx_eLBt5GRmSe9hz6i_u6bW\r\nContent-Disposition: form-data; name=\"pic\"; filename=\"pic.jpg\"\r\n\r\n".getBytes());
                    os.write(pic);
                    os.write("\r\n--Jf4mVY1mx_eLBt5GRmSe9hz6i_u6bW--\r\n".getBytes());
                }
                os.close();
            }
            // InputStream is;
            // try
            // {
            // is = conn.getInputStream();
            // } catch (Exception ex)
            // {
            // is = conn.getErrorStream();
            // }
            int code = conn.getResponseCode();
            InputStream is = code == 200 ? conn.getInputStream() : conn.getErrorStream();
            //System.out.println("CODE " + code);
            if("gzip".equals(conn.getHeaderField("Content-Encoding")))
                is = new GZIPInputStream(is);
            String str = new String(Filex.read(is),"UTF-8");
            conn.disconnect();
            //System.out.println("返回_OAUTH：" + str.replaceAll("\\},\\{", "},\n{"));
            if(isToast && str.charAt(0) == '{')
            {
                JSONObject o = new JSONObject(str);
                String error = null;
                if(isQQ)
                {
                    int ret = o.getInt("ret");
                    if(ret > 0)
                    {
                        error = o.getString("msg");
                        //Resources res = Common.c.getResources();
                        //error = res.getStringArray(res("errcode","array"))[o.getInt("errcode")];
                    }
                } else if(code != 200)
                {
                    error = o.getString("error");
                    //String tmp = res("code_" + error.substring(0,error.indexOf(':')));
                    //if(tmp != null)
                    //    error = tmp;
                }
                if(error != null)
                {
                    System.out.println(error);
                    return null;
                }
            }
            if(!isQQ)
            {
                if(code == 200 && !url.startsWith("http://api.t.sina.com.cn/oauth/"))
                    str = "{\"request\":\"\",\"error_code\":0,\"error\":\"\",data:" + str + "}";
            }
            return str;
        } catch(Exception ex)
        {
            if(isToast)
                System.out.println("没有发现网络");
            ex.printStackTrace();
            return null;
        }
    }

    public static String enc(String str)
    {
        try
        {
            str = URLEncoder.encode(str,"UTF-8");
        } catch(UnsupportedEncodingException e)
        {
        }
        str = str.replaceAll("[+]","%20").replaceAll("[*]","%2A").replaceAll("%7E","~");
        return str;
    }

    public static HashMap parse(String param)
    {
        String[] arr = param.split("&");
        HashMap hm = new HashMap();
        for(int i = 0;i < arr.length;i++)
        {
            int j = arr[i].indexOf('=');
            if(j == -1)
                continue;
            System.out.println(arr[i].substring(0,j) + "_" + arr[i].substring(j + 1));
            hm.put(arr[i].substring(0,j),arr[i].substring(j + 1));
        }
        return hm;
    }


    private static final String[] DIGITS =
            {
            "0","1","2","3","4","5","6","7","8","9",
            "a","b","c","d","e","f","g","h","i","j",
            "k","l","m","n","o","p","q","r","s","t",
            "u","v","w","x","y","z",
            "A","B","C","D","E","F","G","H","I","J",
            "K","L","M","N","O","P","Q","R","S","T",
            "U","V","W","X","Y","Z"};


    //radix： 这里是你想转换为多少进制 2-62之间）
    public static String toString(long value,int radix)
    {
        if(value < 0)
            return "-" + toString( -value,radix);
        if(value < radix)
            return DIGITS[(int) value];
        else
            return toString(value / radix,radix) + DIGITS[(int) (value % radix)];
    }

    //新浪微博id 转为 mid
    //http://open.weibo.com/wiki/Querymid
    public static String mid(long id)
    {
        StringBuilder sb = new StringBuilder();
        String str = String.valueOf(id);
        int len = str.length(),i = len % 7;
        if(i != 0)
            sb.append(toString(Long.parseLong(str.substring(0,i)),62));
        for(;i < len;i += 7)
        {
            String tmp = toString(Long.parseLong(str.substring(i,i + 7)),62);
            //不足4位补0
            for(int j = 4 - tmp.length();j > 0;j--)
                sb.append("0");
            sb.append(tmp);
        }
        return sb.toString();
    }

    //最大长度140
    public static String f(String str,int len) throws IOException
    {
        byte[] by = str.getBytes("GBK");
        if(by.length > len)
        {
            if(by[len] < 0)
                len--;
            str = new String(by,0,len);
            len = str.length() - 1;
            if(str.charAt(len) == 65533)
                str = str.substring(0,len);
        }
        return str;
    }

    public static String f(Date t)
    {
        long j = (System.currentTimeMillis() - t.getTime()) / 1000;
        if(j < 60)
            return j + "秒钟前";
        j /= 60;
        if(j < 60)
            return j + "分钟前";
        j /= 60;
        if(j < 24)
            return j + "小时前";
        return new SimpleDateFormat("MM-dd HH:mm").format(t);
    }


    // 表情
    static Pattern FACE_P;
    static HashMap FACE_H;

    public static String face(String str)
    {
        if(FACE_P == null)
        {
            String[][] FACE_NAME =
                    {
                    {"织","41/zz2_org"},
                    {"神马","60/horse2_org"},
                    {"浮云","bc/fuyun_org"},
                    {"给力","c9/geili_org"},
                    {"围观","f2/wg_org"},
                    {"威武","70/vw_org"},
                    {"熊猫","6e/panda_org"},
                    {"兔子","81/rabbit_org"},
                    {"奥特曼","bc/otm_org"},
                    {"囧","15/j_org"},
                    {"互粉","89/hufen_org"},
                    {"礼物","c4/liwu_org"},
                    {"呵呵","ac/smilea_org"},
                    {"嘻嘻","0b/tootha_org"},
                    {"哈哈","6a/laugh"},
                    {"可爱","14/tza_org"},
                    {"可怜","af/kl_org"},
                    {"挖鼻屎","a0/kbsa_org"},
                    {"吃惊","f4/cj_org"},
                    {"害羞","6e/shamea_org"},
                    {"挤眼","c3/zy_org"},
                    {"闭嘴","29/bz_org"},
                    {"鄙视","71/bs2_org"},
                    {"爱你","6d/lovea_org"},
                    {"泪","9d/sada_org"},
                    {"偷笑","19/heia_org"},
                    {"亲亲","8f/qq_org"},
                    {"生病","b6/sb_org"},
                    {"太开心","58/mb_org"},
                    {"懒得理你","17/ldln_org"},
                    {"右哼哼","98/yhh_org"},
                    {"左哼哼","6d/zhh_org"},
                    {"嘘","a6/x_org"},
                    {"衰","af/cry"},
                    {"委屈","73/wq_org"},
                    {"吐","9e/t_org"},
                    {"打哈气","f3/k_org"},
                    {"抱抱","27/bba_org"},
                    {"怒","7c/angrya_org"},
                    {"疑问","5c/yw_org"},
                    {"馋嘴","a5/cza_org"},
                    {"拜拜","70/88_org"},
                    {"思考","e9/sk_org"},
                    {"汗","24/sweata_org"},
                    {"困","7f/sleepya_org"},
                    {"睡觉","6b/sleepa_org"},
                    {"钱","90/money_org"},
                    {"失望","0c/sw_org"},
                    {"酷","40/cool_org"},
                    {"花心","8c/hsa_org"},
                    {"哼","49/hatea_org"},
                    {"鼓掌","36/gza_org"},
                    {"晕","d9/dizzya_org"},
                    {"悲伤","1a/bs_org"},
                    {"抓狂","62/crazya_org"},
                    {"黑线","91/h_org"},
                    {"阴险","6d/yx_org"},
                    {"怒骂","89/nm_org"},
                    {"心","40/hearta_org"},
                    {"伤心","ea/unheart"},
                    {"猪头","58/pig"},
                    {"ok","d6/ok_org"},
                    {"耶","d9/ye_org"},
                    {"good","d8/good_org"},
                    {"不要","c7/no_org"},
                    {"赞","d0/z2_org"},
                    {"来","40/come_org"},
                    {"弱","d8/sad_org"},
                    {"蜡烛","91/lazu_org"},
                    {"钟","d3/clock_org"},
                    {"蛋糕","6a/cake"},
                    {"话筒","1b/m_org"},
                    {"伦敦奥火","5a/lundunaohuo_org"},
                    {"lt母亲节","9c/ltmuqinjie_org"},
                    {"din推撞","dd/dintuizhuang_org"},
                    {"转发","02/lxhzhuanfa_org"},
                    {"笑哈哈","32/lxhwahaha_org"},
                    {"不好意思","b4/lxhbuhaoyisi_org"},
                    {"给劲","a5/lxhgeili_org"},
                    {"路过这儿","ac/lxhluguo_org"},
                    {"lb味","d1/lbwei_org"},
                    {"bobo纠结","f0/bobojiujie_org"},
                    {"c甩舌头","a4/xcjshuaishetou_org"},
                    {"ppb卖萌","06/ppbmaimeng_org"},
                    {"ala嘿嘿嘿","94/altheiheihei_org"},
                    {"飞机","6d/travel_org"},
                    {"lxhx滚过","43/lxhxgunguo_org"},
                    {"阳光","1a/sunny_org"},
                    {"微风","a5/wind_org"},
                    {"cc撞墙","4d/cczhuangqiang_org"},
                    {"bed凌乱","fa/brdlingluan_org"},
                    {"爱你哦","02/chn_aini_org"},
            };
            FACE_H = new HashMap();
            StringBuilder sb = new StringBuilder();
            for(int i = 0;i < FACE_NAME.length;i++)
            {
                if(i > 0)
                    sb.append("|");
                sb.append("\\[").append(FACE_NAME[i][0]).append("\\]");

                FACE_H.put(FACE_NAME[i][0],FACE_NAME[i][1]);
            }
            FACE_P = Pattern.compile(sb.toString());
        }
        StringBuilder sb = new StringBuilder();
        int last = 0;
        Matcher m = FACE_P.matcher(str);
        while(m.find())
        {
            String n = m.group();
            n = n.substring(1,n.length() - 1);
            sb.append(str.substring(last,m.start())).append("<img src='http://img.t.sinajs.cn/t35/style/images/common/face/ext/normal/").append(FACE_H.get(n)).append(".gif' alt='").append(n).append("' />");
            last = m.end();
        }
        sb.append(str.substring(last));
        return sb.toString();
    }

    public static String a(String str,String a)
    {
        StringBuilder sb = new StringBuilder();
        int last = 0;
        Matcher m = Pattern.compile("@[^ @，<]+|#[^#]+#|http://t.cn/\\w+").matcher(str);
        while(m.find())
        {
            String n = m.group();
            String url = n;
            switch(n.charAt(0))
            {
            case '@':
                url = "http://weibo.com/n/" + n.substring(1) + "' wb_screen_name='" + n.substring(1);
                break;
            case '#':
                url = "http://huati.weibo.com/k/" + n.substring(1,n.length() - 1) + "?order=time";

                //url = "http://s.weibo.com/weibo/" + n.substring(1, n.length() - 1);
                break;
            }
            sb.append("<a href='" + a + "' target='_blank'>" + str.substring(last,m.start()) + "</a>").append("<a href='" + url + "' target='_blank'>").append(n).append("</a>");
            last = m.end();
        }
        sb.append("<a href='" + a + "' target='_blank'>" + str.substring(last) + "</a>");
        return sb.toString();
    }


}
