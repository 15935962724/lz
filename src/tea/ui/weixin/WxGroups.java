package tea.ui.weixin;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.weixin.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.weibo.WConfig;
import org.json.*;

public class WxGroups extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        response.addHeader("Content-Encoding","nogzip");
        Http h = new Http(request,response);
        String act = h.get("act"),nexturl = h.get("nexturl","");
        ServletContext application = this.getServletContext();
        PrintWriter out = response.getWriter();
        try
        {
            out.println("<script>var mt=parent.mt;</script>");
            if(h.member<1)
            {
                out.print("<script>top.location.replace('/servlet/StartLogin?community=" + h.community + "');</script>");
                return;
            }
            String info = "操作执行成功！";
            WxGroup t = WxGroup.find(h.community,h.getInt("wxgroup"));
            if("del".equals(act)) //删除
            {
                t.delete();
            } else if("edit".equals(act)) //编辑
            {
                t.name = h.get("name");
                JSONObject js = WeiXin.find(h.community).api(1,"groups/" + (t.wxgroup < 1 ? "create" : "update"),"{\"group\":{\"id\":" + t.wxgroup + ",\"name\":" + Attch.cite(t.name) + "}}");
                int err = js.isNull("errcode") ? 0 : js.getInt("errcode");
                if(err != 0)
                {
                    info = "错误：" + err + "<br>描述：" + js.getString("errmsg");
                } else
                {
                    if(t.wxgroup < 1)
                    {
                        js = js.getJSONObject("group");
                        t.wxgroup = js.getInt("id");
                    }
                    t.set();
                }
            } else if("sync".equals(act))
            {
                StringBuilder ids = new StringBuilder();
                JSONObject js = WeiXin.find(h.community).api(1,"groups/get",null);
                JSONArray ja = js.getJSONArray("groups");
                for(int i = 1;i < ja.length();i++)
                {
                    js = ja.getJSONObject(i);
                    WxGroup wg = WxGroup.find(h.community,js.getInt("id"));
                    wg.name = js.getString("name");
                    wg.cnt = js.getInt("count");
                    wg.set();
                    ids.append(wg.wxgroup + ",");
                }
                ArrayList al = WxGroup.find(" AND community=" + DbAdapter.cite(h.community) + " AND wxgroup NOT IN(" + ids.toString() + "0)",0,200);
                for(int i = 0;i < al.size();i++)
                {
                    WxGroup wg = (WxGroup) al.get(i);
                    wg.delete();
                }
            }
            out.print("<script>mt.show(\"" + info + "\",1,'" + nexturl + "');</script>");
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
