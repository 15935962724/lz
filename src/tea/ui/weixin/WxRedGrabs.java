package tea.ui.weixin;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.weixin.*;
import tea.entity.util.*;
import tea.entity.stat.*;

public class WxRedGrabs extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request,response);
        String act = h.get("act"),nexturl = h.get("nexturl",""),info = "操作执行成功！";
        PrintWriter out = response.getWriter();
        try
        {
            out.println("<script>var mt=parent.mt;</script>");
            int wxredgrab = h.getInt("wxredgrab");
            WxRedGrab t = wxredgrab < 1 ? new WxRedGrab(0) : WxRedGrab.find(wxredgrab);
            if("add".equals(act)) //抢红包
            {
                String tmp = h.getCook("wxuser",null);
                if(tmp == null)
                {
                    out.print("Err");
                    return;
                }
                t.ip = request.getHeader("x-forwarded-for");
                if(t.ip == null)
                    t.ip = request.getRemoteAddr();
                //t.ip += "/" + h.get("ip");
                t.wxred = h.getInt("wxred");
                t.wxuser = Integer.parseInt(tmp);
                info = add(t,out);
                if(info.startsWith("/jsp/"))
                {
                    out.print("<script>parent.location.replace('" + info + "');</script>");
                    return;
                }
                if(t.money == 0)
                {
                    out.print("<script>mt.toast('" + info + "');</script>");
                    if(t.time != null)
                        out.print("<script>parent.sorry();</script>");
                    return;
                }
                nexturl = "window.parent.wx.closeWindow()";
            } else
            {
                if(h.member < 1)
                {
                    out.print("<script>top.location.replace('/servlet/StartLogin?community=" + h.community + "');</script>");
                    return;
                }
                if("del".equals(act)) //删除
                {
                    t.delete();
                }
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

    public synchronized static String add(WxRedGrab t,Writer out) throws Exception
    {
        WxUser wu = WxUser.find(t.wxuser);
        if(wu.score < 100)
            return "必须满分才可以抢红包！";

        if(wu.wxgroup == 80)
            return "抱歉，请先关注我们，才能参加抢红包活动！";

        int hits = WxRedGrab.count(" AND wxuser=" + wu.wxuser);
        if(wu.hits < 3 && hits > 0)
            return "抱歉，您已抢过红包了！"; //"请先分享给3个好友后，方可再次抢红包！";

        if(hits > 5)
            return "你的6次抢红包次数已经全部用完，感谢你的参与！<br>欢迎邀请更多的人参与工伤保险微信竞答活动！";

        String day = DbAdapter.cite(new Date(),true);
        if(WxRedGrab.count(" AND wxuser=" + wu.wxuser + " AND time>" + day) > 2) //每天3次
            return "今天抢红包次数过多，请明天再来...";
        //地区
        if(wu.wxuser == 15041235L)
            t.ip = wu.ip;
        StringBuilder sql = new StringBuilder();
        sql.append(" AND city IN(0");
        Ip ip = Ip.find(t.ip);
        if(ip.card > 0)
        {
            sql.append("," + String.valueOf(ip.card).substring(0,2));
            sql.append("," + ip.card);
        }
        sql.append(")");
        sql.append(" AND hidden=0 AND community=" + DbAdapter.cite(wu.community));
        if(t.wxred < 1)
        {
            sql.append(" ORDER BY city DESC");
            //if(wu.location!=null)
            //{
            //  tmp=wu.location;
            //  if(tmp.startsWith("中国 "))tmp=tmp.substring(3);
            //  ArrayList al=Card.find(" AND card<100 AND name="+DbAdapter.cite(tmp.substring(0,tmp.indexOf(' '))),0,1);
            //  if(al.size()>0)city=((Card)al.get(0)).card;
            //}
            if(wu.card != ip.card)
                wu.set("card",String.valueOf(wu.card = ip.card));
            ArrayList al = WxRed.find(sql.toString(),0,Integer.MAX_VALUE);
            if(al.size() > 1)
                return "/jsp/custom/clssn/WxRedGrabAdd2.jsp?community=" + wu.community;
            t.wxred = ((WxRed) al.get(0)).wxred;
        } else if(WxRed.count(" AND wxred=" + t.wxred + sql.toString()) < 1)
        {
            Filex.logs("WxRedGrabs_err.txt","“wxred”不正确！　" + sql.toString() + "　json:" + t.toString());
            return "很遗憾，你没有抢到红包！";
        }
        WxRed wr = WxRed.find(t.wxred);
        boolean isDay = wr.limit > WxRedGrab.sum(" AND wxred=" + t.wxred + " AND time>" + day);
        //if(!isDay)
        //    return "抱歉！本红包池红包已经抢完！欢迎明天再来。";
        Calendar cal = Calendar.getInstance();
        t.ran = cal.get(Calendar.HOUR_OF_DAY) > 7 //8点之后
                && wr.total > WxRedGrab.sum(" AND wxred=" + t.wxred) //总上限
                && isDay //天上限
                ? (int) (tea.entity.util.SCA.random() * 100) : Integer.MAX_VALUE;
        int pro = 0;
        for(int i = WxRed.PROBABILITY.length - 1;i > 0;i--)
        {
            pro += wr.probability[i];
            if(t.ran < pro)
            {
                t.money = WxRed.PROBABILITY[i];
                break;
            }
        }
        t.time = new Date();
        //发红包
        String info;
        if(t.money == 0)
            info = "很遗憾，你没有抢到红包！";
        else
        {
            XMLObject jo = wu.sendRedPack("知识竞答","恭喜你，获得“工伤保险知识网上问答”红包！",t.money);
            t.code = jo.getString("mch_billno");
            //jo.getString("send_listid")//微信的订单号,不正确
            String err = jo.getString("err_code");
            if("SUCCESS".equals(jo.getString("result_code")))
                info = "恭喜你，已抢到" + t.money + "元红包！";
            else if("SYSTEMERROR_DEL".equals(err)) //请求已受理，请稍后使用原单号查询发放结果
            {
                t.status = 2;
                info = "恭喜你，已抢到" + t.money + "元红包！　红包稍候发放！";
            } else
            {
                if("NOTENOUGH".equals(err)) //帐号余额不足，请到商户平台充值后再重试
                {
                    Err.send(err,"错误：帐号余额不足\r\n");
                } else if("TIME_LIMITED".equals(err)) //请勿在0点到8点间发红包
                {
                } else if("NO_AUTH".equals(err)) //发放失败，此请求可能存在风险，已被微信拦截
                {
                } else if("FREQ_LIMIT".equals(err)) //发放给同一用户的红包过于频繁,请稍候重试.
                {
                } else if("CA_ERROR".equals(err)) //CA证书出错，请登录微信支付商户平台下载证书
                {
                }
                t.json = jo.toString();
                t.money = 0;
                info = "很遗憾，你没有抢到红包！";
            }
        }
        t.set();
        wu.set("hits",String.valueOf(wu.hits = 0));
        out.write("<script>parent._czc.push(['_trackEvent','红包','" + (wr.city < 1 ? "全国" : Card.find(wr.city).name) + "'," + day + "," + t.money + "]);</script>");
        return info;
    }
}

//劳动报
//公众号：zggsbx@qq.com/zggsbx123
//支付：1239832102/485195

//高尔夫
//weixin6@redcome.com/aa1122
//1230542802/904084

//TATA
//商户号：1218814901    登陆密码：tatamumen520
