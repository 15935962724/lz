package tea.ui.node.type;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.ui.*;
import tea.db.*;
import tea.entity.*;
import tea.entity.node.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class Specimens extends HttpServlet
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
                out.print("<script>mt.show('对不起，您还没有登陆，请先登陆！',2,'/servlet/StartLogin?node=" + h.node + "');</script>");
                return;
            }
            String info = "操作执行成功！";
            Node n = Node.find(h.node);
            if("del".equals(act)) //删除
            {
                n.delete(h.language);
            } else if("hidden".equals(act)) //发布
            {
                n.setHidden(!n.isHidden());
            } else if("edit".equals(act)) //编辑
            {
                String subject = h.get("species1");
                String content = h.get("content");
                if(n.getType() == 1)
                {
                    int sequence = Node.getMaxSequence(h.node) + 10;
                    int options1 = n.getOptions1();
                    Category cat = Category.find(h.node); //105
                    h.node = Node.create(h.node,sequence,n.getCommunity(),new RV(h.username),cat.getCategory(),(options1 & 2) != 0,n.getOptions(),options1,h.language,null,null,new Date(),n.getStyle(),n.getRoot(),n.getKstyle(),n.getKroot(),null,h.language,subject,"","",content,null,"",0,null,"","","","",null,null);
                    n.finished(h.node);
                } else
                {
                    n.set(h.language,subject,content);
                }
                Specimen t = Specimen.find(h.node);
                //t.sid = h.getInt("sid");
                t.unit = h.get("unit");
                t.bbgdm = h.get("bbgdm");
                t.species[1] = h.get("species1");
                t.class1 = h.get("class1");
                t.order0 = h.get("order0");
                t.family = h.get("family");
                t.genus = h.get("genus");
                t.species[0] = h.get("species0");
                t.mutation = h.get("mutation");
                t.snumber = h.get("snumber");
                t.cperson = h.get("cperson");
                t.ctime = h.getDate("ctime");
                t.cnumber = h.get("cnumber");
                t.csite = h.get("csite");
                t.reserve = h.getInt("reserve");
                t.rname = h.get("rname");
                t.rcode = h.get("rcode");
                t.country = h.get("country");
                t.province = h.get("province");
				//未完成
                t.longitude = h.get("longitude");
                t.latitude = h.get("latitude");
                t.elevation = h.get("elevation");
                t.vegetation = h.get("vegetation");
                t.environment = h.get("environment");
                t.host = h.get("host");
                t.sexual = h.get("sexual");
                t.old = h.get("old");
                t.property = h.get("property");
                t.status = h.getInt("status");
                t.preserve = h.get("preserve");
                t.conlive = h.get("conlive");
                t.share = h.get("share");
                t.getway = h.get("getway");
                t.discribe = h.get("discribe");
                t.uuser = h.get("uuser");
                t.uid = h.getInt("uid");
                t.speciestype = h.getInt("speciestype");
                t.enterdbdate = h.getDate("enterdbdate");
                t.firstlevel = h.get("firstlevel");
                t.secondlevel = h.get("secondlevel");
                t.zyglm = h.get("zyglm");
                //t.picture = h.get("picture");
                t.set();

                if(nexturl.length() < 1)
                    nexturl = "/html/" + h.community + "/specimen/" + h.node + "-" + h.language + ".htm";
            } else if("iedit".equals(act)) //鉴定
            {
                int identify = h.getInt("identify");
                SIdentify t = SIdentify.find(identify);
                t.node = h.getInt("node");
                t.iperson = h.get("iperson");
                t.iyear = h.getDate("iyear");
                t.set();
            } else if("idel".equals(act)) //鉴定
            {
                int identify = h.getInt("identify");
                SIdentify t = SIdentify.find(identify);
                t.delete();
            } else if("pedit".equals(act)) //图片
            {
                int picture = h.getInt("picture");
                SPicture t = SPicture.find(picture);
                t.node = h.getInt("node");
                //t.sid = h.getInt("sid");
                //t.rname = h.get("rname");
                //t.species1 = h.get("species1");
                t.mulname = h.get("mulname");
                t.multype = h.get("multype");
                t.keyword = h.get("keyword");
                t.copyrightowner = h.get("copyrightowner");
                t.remark = h.get("remark");
                t.zyglm = h.get("zyglm");
                t.set();
            } else if("pdel".equals(act)) //图片
            {
                int picture = h.getInt("picture");
                SPicture t = SPicture.find(picture);
                t.delete();
            }
            TeaServlet.delete(n);

            out.print("<script>mt.show('" + info + "',1,'" + nexturl + "');</script>");
        } catch(Throwable ex)
        {
            out.print("<textarea id='ta'>" + ex.toString() + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }
}
