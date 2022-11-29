package tea.ui.node.type;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.ui.*;
import tea.entity.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.node.*;
import tea.entity.util.*;

public class Outsides extends HttpServlet
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
            if("city".equals(act))
            {
                out.print("<root>");
                ArrayList ep = Card.find(" AND card<100 AND card IN(SELECT SUBSTRING(CAST(city AS CHAR(6)),1,2) FROM Outside)",0,200);
                for(int i = 0;i < ep.size();i++)
                {
                    Card c = (Card) ep.get(i);
                    int prov = c.getCard();
                    out.print("<prov code=\"" + prov + "\" name=\"" + c.getAddress() + "\">");
                    //
                    if(prov == 11 || prov == 12 || prov == 31 || prov == 50)
                        prov = Integer.parseInt(prov + "01");
                    ArrayList ec = Card.find(" AND card LIKE " + DbAdapter.cite(prov + "__") + " AND card IN(SELECT SUBSTRING(CAST(city AS CHAR(6)),1," + (String.valueOf(prov).length() + 2) + ") FROM Outside)",0,200);
                    for(int j = 0;j < ec.size();j++)
                    {
                        c = (Card) ec.get(j);
                        out.print("<city code=\"" + c.getCard() + "\" name=\"" + c.getAddress() + "\"/>");
                    }
                    out.print("</prov>");
                }
                out.print("</root>");
                return;
            }
            out.print("<script>var mt=parent.mt;</script>");
            TeaSession ts = new TeaSession(request);
            if(ts._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + h.node);
                return;
            }
            if("member".equals(act)) //权限
            {
                Outside t = Outside.find(h.node,h.language);
                t.set("member",t.member = h.get("member"));
            } else
            {
                Node n = Node.find(h.node);
                if("del".equals(act)) //删除
                {
                    n.delete(h.language);
                } else if("edit".equals(act)) //编辑
                {
                    String subject = h.get("subject");
                    String content = h.get("content");
                    if(n.getType() == 1)
                    {
                        int sequence = Node.getMaxSequence(h.node) + 10;
                        int options1 = n.getOptions1();
                        Category cat = Category.find(h.node); //100
                        h.node = Node.create(h.node,sequence,n.getCommunity(),ts._rv,cat.getCategory(),(options1 & 2) != 0,n.getOptions(),options1,h.language,null,null,new Date(),n.getStyle(),n.getRoot(),n.getKstyle(),n.getKroot(),null,h.language,subject,"","",content,null,"",0,null,"","","","",null,null);
                        n.finished(h.node);

                        //校外教育信息资源网
                        int newid = Node.create(h.node,sequence,n.getCommunity(),ts._rv,0,(options1 & 2) != 0,n.getOptions(),options1,h.language,null,null,new Date(),n.getStyle(),n.getRoot(),n.getKstyle(),n.getKroot(),null,h.language,"基本情况","","","<include src=\"/jsp/custom/ccc/OutsideContentInc.jsp\"/>",null,"",0,null,"","","","",null,null);
                        n.finished(newid);

                        newid = Node.create(h.node,sequence,n.getCommunity(),ts._rv,1,(options1 & 2) != 0,n.getOptions(),options1,h.language,null,null,new Date(),n.getStyle(),n.getRoot(),n.getKstyle(),n.getKroot(),null,h.language,"机构动态","","","",null,"",0,null,"","","","",null,null);
                        n.finished(newid);
                        cat = Category.find(newid);
                        cat.set(39,0,0);

                        newid = Node.create(h.node,sequence,n.getCommunity(),ts._rv,1,(options1 & 2) != 0,n.getOptions(),options1,h.language,null,null,new Date(),n.getStyle(),n.getRoot(),n.getKstyle(),n.getKroot(),null,h.language,"团队师资","","","",null,"",0,null,"","","","",null,null);
                        n.finished(newid);
                        cat = Category.find(newid);
                        cat.set(98,0,0);

                        newid = Node.create(h.node,sequence,n.getCommunity(),ts._rv,0,(options1 & 2) != 0,n.getOptions(),options1,h.language,null,null,new Date(),n.getStyle(),n.getRoot(),n.getKstyle(),n.getKroot(),null,h.language,"联系方式","","","<include src=\"/jsp/custom/ccc/OutsideContactInc.jsp\"/>",null,"",0,null,"","","","",null,null);
                        n.finished(newid);
                    } else
                    {
                        n.set(h.language,subject,content);

                        //基本情况
//                    Enumeration e = Node.find(" AND father=" + h.node,0,1);
//                    if(e.hasMoreElements())
//                    {
//                        int node = ((Integer) e.nextElement()).intValue();
//                        n = Node.find(node);
//                        n.setContent(h.language,content);
//                    }
                    }
                    Outside t = Outside.find(h.node,h.language);
                    t.city = h.getInt("city2");
                    if(t.city < 1)
                        t.city = h.getInt("city1");
                    if(t.city < 1)
                        t.city = h.getInt("city0");
                    t.website = h.get("website");
                    t.tel = h.get("tel");
                    t.qq = h.get("qq");
                    t.address = h.get("address");
                    t.bus = h.get("bus");
                    t.map = h.get("map");
                    t.set();

                    if(nexturl.length() < 1)
                        nexturl = "/servlet/Node?node=" + h.node + "&language=" + h.language;
                }
                TeaServlet.delete(n);
            }
            out.print("<script>mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
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
