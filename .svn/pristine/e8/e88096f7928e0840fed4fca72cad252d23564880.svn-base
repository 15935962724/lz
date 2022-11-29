package tea.ui.weixin;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.weixin.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.weibo.*;
import org.json.*;

public class WxMenus extends HttpServlet
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
            out.println("<script>var mt=parent.mt;</script>");
            if(h.member < 1)
            {
                out.print("<script>top.location.replace('/servlet/StartLogin?community=" + h.community + "');</script>");
                return;
            }
            if("sequence".equals(act))
            {
                int sequence = h.getInt("sequence");
                if(sequence > 0)
                {
                    WxMenu m = WxMenu.find(h.getInt("menu"));
                    m.set("sequence",String.valueOf(m.sequence = sequence));
                } else
                {
                    int pos = h.getInt("pos");
                    String[] arr = h.get("menus").split("[|]");
                    for(int i = 1;i < arr.length;i++)
                    {
                        WxMenu m = WxMenu.find(Integer.parseInt(arr[i]));
                        m.set("sequence",String.valueOf(m.sequence = i + pos));
                    }
                    return;
                }
            }
            String info = "操作执行成功！";
            int menu = h.getInt("menu");
            WxMenu t = WxMenu.find(menu);
            if("del".equals(act)) //删除
            {
                String[] arr = menu < 1 ? h.getValues("menus") : new String[]
                               {String.valueOf(menu)};
                for(int i = 0;i < arr.length;i++)
                {
                    t = WxMenu.find(Integer.parseInt(arr[i]));
                    t.delete();
                }
            } else if("edit".equals(act)) //编辑
            {
                t.community = h.community;
                t.father = h.getInt("father");
                t.name = h.get("name");
                t.type = h.getInt("type");
                t.eventkey = h.get("eventkey" + t.type);
                t.url = h.get("url");
                t.hidden = h.getBool("hidden");
                t.sequence = h.getInt("sequence");
                t.set();
            } else if("sync".equals(act))
            {
                int ftype = h.getInt("ftype");
                WeiXin wx = WeiXin.find(h.community);
                if(MT.f(wx.appid[ftype]).length() < 1)
                {
                    out.print("<script>mt.show('请先配置“App key”！');</script>");
                    return;
                }
                String str = WxMenu.getRoot(h.community,ftype).toString();
                JSONObject js = wx.api(ftype,"menu/" + (str.length() < 14 ? "delete" : "create") + "?agentid=1",str);
                int err = js.getInt("errcode");
                if(err != 0)
                {
                    info = js.getString("errmsg");
                    if(err == 43010)
                        info = "请先开启“回调模式”！";
                    info = "错误：" + err + "<br/>描述：" + info;
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
}
