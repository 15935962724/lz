package tea.ui.weixin;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.ui.admin.*;
import tea.entity.*;
import tea.entity.util.*;
import tea.entity.weixin.*;
import tea.entity.node.*;
import javax.servlet.*;
import javax.servlet.http.*;
import org.json.*;

public class WxUsers extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        response.addHeader("Content-Encoding","nogzip");
        Http h = new Http(request,response);
        String act = h.get("act"),nexturl = h.get("nexturl",""),format = h.get("format");
        PrintWriter out = response.getWriter();
        try
        {
            if(format == null)
                out.println("<script>var mt=parent.mt;</script>");
            if("steering".equals(act)) //邮政:投票
            {
                String openid = h.getCook("openid",null);
                if(openid == null)
                    return;
                WxUser t = WxUser.find(openid);
                if(t.nodes.contains("|" + h.node + "|"))
                {
                    out.print("<script>mt.show('抱歉，您已投过票了。');</script>");
                    return;
                }
                Filex.logs("steering.txt","OpenId:" + openid + "　Node:" + h.node);
                DbAdapter db = new DbAdapter();
                try
                {
                    db.executeUpdate(h.node,"UPDATE Node SET hot=hot+1 WHERE node=" + h.node);
                } finally
                {
                    db.close();
                }
                t.nodes += h.node + "|";
                if(t.time == null)
                {
                    t.userid = "gh_488675187ff5";
                    t.community = h.community;
                    t.set();
                } else
                    t.set("nodes",t.nodes);
                out.print("<script>parent.location='" + nexturl + "?node=" + h.node + "';</script>");
                return;
            } else if("hits".equals(act) || "score".equals(act))
            {
                String tmp = h.getCook("wxuser",null);
                Filex.logs("WxUsers_hits.txt","wxuser:" + tmp + "　qs:" + SCA.qs(request));
                if(tmp == null)
                {
                    out.print("{err:'Err'}");
                    return;
                }
                WxUser wu = WxUser.find(Long.parseLong(tmp));
                if("hits".equals(act))
                {
                    wu.set("hits",String.valueOf(++wu.hits));
                    if(wu.hits > 2)
                        wu.set("score",String.valueOf(wu.score = 0));
                } else
                {   /*
                    if(wu.wxuser == 15041235L || WxRedGrab.count(" AND wxuser=" + wu.wxuser + " AND time>" + DbAdapter.cite(new Date(System.currentTimeMillis() - 120000))) > 0)
                    //if(wu.wxuser == 15041235L)
                    {
                        String verify = h.get("verify","");
                        Filex.logs("WxUsers_verify.txt",wu.toString() + "　verify:" + verify);
                        if(Imgs.verify(h) > 0)
                        {
                            out.print("<script>");
                            if(verify.length() > 0)
                                verify = "<font style=color:red>验证码输入错误，请重新输入！</font><br>";
                            out.print("mt.show('" + verify + "验证码：<input id=_verify size=5 style=outline:auto;font-size:18px;text-transform:uppercase;><img src=/Imgs.do?act=verify&t='+new Date().getTime()+' style=vertical-align:middle>',2,'verify=window._verify.value;f_score()');</script>");
                            return;
                        }
                    }*/
                    wu.set("ip",wu.ip = request.getRemoteAddr());
                    wu.nodes += MT.f(new Date(),1) + "|";
                    wu.set("nodes",wu.nodes);
                    wu.set("score",String.valueOf(wu.score = h.getInt("score")));
                    out.print("<script>parent.f_result(); mt.toast('close');mt.close();</script>");
                    return;
                }
                if("json".equals(format))
                    out.print("{hits:" + wu.hits + "}");
                //out.print("<script>mt.toast('分享成功，还差" + (3 - wu.hits) + "次就可再次抢红包！');</script>");
                return;
            }
            String tmp = h.get("wxuser");
            if(h.member < 1 && !"15030036".equals(tmp))
            {
                out.print("<script>top.location.replace('/servlet/StartLogin?community=" + h.community + "');</script>");
                return;
            }
            String info = "操作执行成功！";
            WeiXin wx = WeiXin.find(h.community);
            WxUser t = WxUser.find(Long.parseLong(tmp));
            if("del".equals(act)) //删除
            {
                t.delete();
            } else if("edit".equals(act)) //编辑
            {
                t.openid = h.get("openid");
                t.nickname = h.get("nickname");
                t.remarkname = h.get("remarkname");
                t.location = h.get("location");
                t.signature = h.get("signature");
                t.time = h.getDate("time");
                t.set();
            } else if("send".equals(act))
            {
                JSONObject js;
                String type = h.get("type");
                String file = h.get("file");
                if(file != null)
                    js = t.send("file",file);
                else
                    js = t.send(type,h.get("content"));
                int err = js.getInt("errcode");
                if(err == 43004)
                    info = "不能发送，对方不是你的粉丝！";
                else if(err == 45015)
                    info = "由于该用户48小时未与你互动，你不能再主动发消息给他。直到用户下次主动发消息给你才可以对其进行回复。";
                else if(err != 0)
                    info = "编号：" + err + "<br/>错误：" + js.getString("errmsg");
//                info = t.send(h.get("content"));
//                if(info == null)
//                {
//                    t.refresh();
//                    info = "发送成功！";
//                } else
//                    nexturl = "";
            } else if("red".equals(act)) //发红包
            {
                XMLObject jo = t.sendRedPack(h.get("name"),h.get("remark"),h.getFloat("price"));
                if("FAIL".equals(jo.getString("result_code")))
                    info = jo.getString("err_code") + "：" + jo.getString("return_msg");
            } else if("group".equals(act)) //移动用户分组
            {
                int wxgroup = h.getInt("wxgroup");
                JSONObject js = wx.api(1,"groups/members/update","{\"openid\":\"" + t.openid + "\",\"to_groupid\":" + wxgroup + "}");
                int err = js.getInt("errcode");
                if(err != 0)
                {
                    info = WeiXin.f(js);
                } else
                {
                    //旧组-1
                    WxGroup wg = WxGroup.find(h.community,t.wxgroup);
                    if(wg.time != null)
                        wg.set("cnt",String.valueOf(--wg.cnt));
                    //新组+1
                    wg = WxGroup.find(h.community,wxgroup);
                    if(wg.time != null)
                        wg.set("cnt",String.valueOf(++wg.cnt));
                    t.set("wxgroup",String.valueOf(t.wxgroup = wxgroup));
                }
            } else if("sync".equals(act))
            {
                for(int j = 0;j < 20;j++)
                    out.write("// 显示进度条  \n");
                String next = "";
                int count = 0,total = 0;
                int ftype = h.getInt("ftype");
                if(ftype == 2) //企业号
                {
                    JSONObject jo = wx.api(ftype,"user/list?department_id=1&fetch_child=1&status=0",null);
                    int err = jo.getInt("errcode");
                    if(err != 0)
                    {
                        info = WeiXin.f(jo);
                    } else
                    {
                        JSONArray ja = jo.getJSONArray("userlist");
                        for(int i = 0;i < ja.length();i++)
                        {
                            jo = ja.getJSONObject(i);
                            WxUser wu = WxUser.find(jo.getString("userid"));
                            wu.community = h.community;
                            wu.userid = wx.userid[ftype];
                            wu.nickname = jo.getString("name");
                            wu.weixinid = jo.getString("weixinid");
                            wu.mobile = jo.getString("mobile");
                            wu.email = jo.getString("email");
                            wu.avatar = jo.getString("avatar");
                            wu.avatar = MT.f(wu.avatar).length() < 1 ? null : wu.avatar + "64";
                            wu.signature = jo.getString("position");
                            wu.status = jo.getInt("status");
                            wu.set();
                        }
                    }
                } else
                    do
                    {
                        JSONObject jo = wx.api(ftype,"user/get?next_openid=" + next,null);
                        int err = jo.getInt("errcode");
                        if(err != 0)
                        {
                            info = WeiXin.f(jo);
                            break;
                        }
                        total = jo.getInt("total");
                        count = jo.getInt("count");
                        next = jo.getString("next_openid");
                        if(jo.isNull("data"))
                            break;
                        jo = jo.getJSONObject("data");
                        JSONArray ja = jo.getJSONArray("openid");
                        for(int i = 0;i < ja.length();i++)
                        {
                            WxUser wu = WxUser.find(ja.getString(i));
                            wu.community = h.community;
                            wu.userid = wx.userid[ftype];
                            //查询用户所在分组
                            jo = wx.api(1,"groups/getid","{\"openid\":\"" + wu.openid + "\"}");
                            wu.wxgroup = jo.getInt("groupid");
                            //获取用户基本信息
                            wu.info();
                            if(out != null)
                            {
                                out.write("<script>mt.progress(" + i + "," + total + ");</script>");
                                out.flush();
                            }
                        }
                    } while(count > 0);
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
