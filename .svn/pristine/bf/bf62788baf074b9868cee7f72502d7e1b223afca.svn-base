package tea.ui.weixin;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

import org.json.*;
import tea.entity.*;
import tea.entity.util.*;
import tea.entity.stat.*;
import tea.entity.weixin.*;
import java.awt.Graphics2D;
import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;

public class WeiXins extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request,response);
        String act = h.get("act"),nexturl = h.get("nexturl","");
        ServletContext application = this.getServletContext();
        PrintWriter out = response.getWriter();
        try
        {
            if("qrcode".equals(act))
            {
                int id = h.getInt("id"); //永久: 1--100000
                if(id < 1)
                    id = h.member;
                String type = h.get("type");
                if("login".equals(type))
                {
                    id = Integer.parseInt("1111" + (int) (tea.entity.util.SCA.random() * 100000));
                }
                int expire = 1800; //最大不超过1800(30分)
                //
                JSONObject jo = WeiXin.find(h.community).api(1,"qrcode/create","{\"expire_seconds\":" + expire + ",\"action_name\":\"" + (id < 100000 ? "QR_LIMIT_SCENE" : "QR_SCENE") + "\",\"action_info\":{\"scene\":{\"scene_id\":" + id + "}}}");
                nexturl = "https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=" + jo.get("ticket");
                //背影图
                int bg = h.getInt("bg");
                if(bg > 0)
                {
                    String str = "/res/" + h.community + "/qrcode/";
                    BufferedImage bi = ImageIO.read(new File(Http.REAL_PATH + str + bg + ".png"));
                    Graphics2D g = bi.createGraphics();
                    g.drawImage(ImageIO.read(new java.net.URL(nexturl)),28,14,258,258,null);
                    g.dispose();
                    nexturl = str + id + ".png";
                    ImageIO.write(bi,"PNG",new File(Http.REAL_PATH + nexturl));
                }
                if("js".equals(h.get("format")))
                {
                    out.print("document.write('<img src=" + nexturl + " class=" + act + ">');setInterval(function(){mt.send('/Member'+'s.do?act=weixin&key=" + MT.enc(id + "|0") + "',function(d){if(d)location=foLogin.nexturl.value})},2000);");
                } else
                    response.sendRedirect(nexturl);
                return;
            }if("lzcode".equals(act)){		//粒子签收二维码
            	String orderid = h.get("orderid");
                String id = "lz" +orderid;
//                int expire = 1800; //最大不超过1800(30分)
                //
//                Filex.logs("qdr.txt", h.community);
                JSONObject jo = WeiXin.find(h.community).api(1,"qrcode/create","{\"action_name\":\"QR_LIMIT_STR_SCENE\",\"action_info\":{\"scene\":{\"scene_str\":\"" + id + "\"}}}");
                nexturl = "https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=" + jo.get("ticket");
                
                out.print(nexturl);
                return;
            }else if("invoice".equals(act)){	//发票签收二维码
            	String orderid = h.get("orderid");
                String id = "invoice" +orderid;
//                int expire = 1800; //最大不超过1800(30分)
                //
//                Filex.logs("qdr.txt", h.community);
                JSONObject jo = WeiXin.find(h.community).api(1,"qrcode/create","{\"action_name\":\"QR_LIMIT_STR_SCENE\",\"action_info\":{\"scene\":{\"scene_str\":\"" + id + "\"}}}");
                nexturl = "https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=" + jo.get("ticket");
                
                out.print(nexturl);
                return;
            } else if("openid".equals(act))
            {
            	Filex.logs("qdr.txt","返回：" +h.get("code")+h.get("token")+h.get("openid"));
                String code = h.get("code"),openid = h.get("openid"),token = h.get("token");
                if(code != null)
                {
                    int retry = h.getInt("retry");
                    WeiXin wx = WeiXin.find(h.community);
                    Object obj = Http.open("https://api.weixin.qq.com/sns/oauth2/access_token?appid=" + wx.appid[1] + "&secret=" + wx.appsecret[1] + "&code=" + code + "&grant_type=authorization_code",null);
                    if(obj instanceof String)
                    {
                        Filex.logs("openid2_err.txt","返回：" + (String) obj);
                    }
                    byte[] by = (byte[]) obj;
                    String str = new String(by);
                    Filex.logs("openid_code.txt",str);
                    JSONObject jo = new JSONObject(str);
                    if(!jo.isNull("errcode"))
                    {
                        Filex.logs("code_err.txt","OPENID:" + str + "　retry:" + retry + "　URI:" + request.getRequestURI() + "?" + SCA.qs(request) + "　UA:" + request.getHeader("user-agent"));
                        if(retry++ < 3)
                        {
                            response.sendRedirect(request.getRequestURI() + "?retry=" + retry + "&" + SCA.qs(request).replace("&code=","&"));
                            return;
                        }
                        out.print(jo.getString("errmsg"));
                        return;
                    } else
                    {
                        Filex.logs("code_ok.txt","OPENID:" + str + "　retry:" + retry + "　URI:" + request.getRequestURI() + "?" + SCA.qs(request) + "　UA:" + request.getHeader("user-agent"));
                        openid = jo.getString("openid");
                        token = jo.getString("access_token");
                        int aa = jo.getInt("expires_in"); //2小时
                    }
                }
                WeiXin wx = WeiXin.find(h.community);
                if(openid != null)
                {
                    h.setCook("community",h.community,Integer.MAX_VALUE);
                    h.setCook("openid",openid, -1);
                    h.setCook("token",token,token == null ? 0 : 7200);
                    WxUser wu = WxUser.find(openid);
                    if(wu.time == null)
                    {
                        wu.community = h.community;
                        wu.userid = wx.userid[1];
                        wu.info();
                    }
                    wu.set(request);
                    h.setCook("wxuser",String.valueOf(wu.wxuser),(24 - Calendar.getInstance().get(Calendar.HOUR_OF_DAY)) * 3600);
                } else
                {
                    nexturl = request.getRequestURI() + "?" + SCA.qs(request);
                    if("LIU1".equals(System.getenv("COMPUTERNAME")))
                    {
                        nexturl += "&openid=okBcCt714jRx1fjUI-OjRdZbeoe4&token=okBcCt714jRx1fjUI-OjRdZbeoe4";
                    } else
                    {
                        nexturl = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + wx.appid[1] + "&redirect_uri=" + Http.enc("http://" + request.getServerName() + nexturl) + "&response_type=code&scope=" + h.get("scope","snsapi_base") + "&state=STATE#wechat_redirect";
                    }
                }
                response.sendRedirect(nexturl);
                return;
            } else if("logs".equals(act))
            {
                String info = h.get("info");
                if("config:invalid signature".equals(info)) //config:fail
                {
                    WeiXin wx = WeiXin.find(h.community);
                    wx.appticket[1] = null;
                }
                Filex.logs("WeiXins_logs.txt",info);
                return;
            }
            out.println("<script>var mt=parent.mt;</script>");
            if(h.member < 1)
            {
                out.print("<script>top.location.replace('/servlet/StartLogin?community=" + h.community + "');</script>");
                return;
            }
            String info = "操作执行成功！";
            WeiXin t = WeiXin.find(h.community);
            if("del".equals(act)) //删除
            {
                t.delete();
            } else if("edit".equals(act)) //编辑
            {
                t.user[0] = h.get("user0");
                t.password[0] = h.get("password0");
                t.cookie[0] = h.get("cookie0");
                t.appid[0] = h.get("appid0");
                t.appsecret[0] = h.get("appsecret0");
                //
                t.user[1] = h.get("user1");
                t.password[1] = h.get("password1");
                t.cookie[1] = h.get("cookie1");
                t.appid[1] = h.get("appid1");
                t.appsecret[1] = h.get("appsecret1");
                t.partnerid = h.get("partnerid");
                t.partnerkey = h.get("partnerkey");
                t.paysignkey = h.get("paysignkey");
                //
                t.user[2] = h.get("user2");
                t.password[2] = h.get("password2");
                t.cookie[2] = h.get("cookie2");
                t.userid[2] = t.appid[2] = h.get("appid2");
                t.appsecret[2] = h.get("appsecret2");
                t.set();
            } else if("login".equals(act))
            {
                int i = h.getInt("index");
                String str = t.login(i,h.get("verify"));
                if("-8".equals(str))
                {
                    out.print("<script>mt.show('<input id=_verify size=6><img src=/res/" + h.community + "/verify.jpg?r=" + tea.entity.util.SCA.random() + ">',2,\"window.mt.act('login'," + i + ");return false\");</script>");
                    return;
                }
                if(str != null)
                    info = str;
            } else if("welcome".equals(act))
            {
                int wxtype = h.getInt("wxtype");
                //t.wtype[wxtype] = h.getInt("wtype");
                t.welcome[wxtype] = h.get("welcome");
                //t.welcome[1] = h.get("welcome1");
                t.notfound = h.get("notfound");
                t.set();
            }
            out.print("<script>mt.show('" + info + "',1,'" + nexturl + "');</script>");
        } catch(Throwable ex)
        {
            out.print("<textarea id=ta>" + Err.get(h,ex) + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }
}
