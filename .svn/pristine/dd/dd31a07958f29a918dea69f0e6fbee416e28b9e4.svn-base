package tea.ui.node.type.company;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.site.*;
import tea.entity.node.*;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import tea.entity.*;
import java.util.*;

public class EditCompanyWindows extends TeaServlet
{

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);
        if (teasession._rv == null)
        {
            response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
            return;
        }
        String act = teasession.getParameter("act");
        String nu = teasession.getParameter("nexturl");
        try
        {
            Community community = Community.find(teasession._strCommunity);
            int root = community.getNode();
            Company c = Company.find(root);
            if ("logo".equals(act) || "banner".equals(act) || act.startsWith("ad"))
            {
                String link = teasession.getParameter("link");
                String pic = null;
                byte by[] = teasession.getBytesParameter("file");
                if (by != null)
                {
                    pic = write(teasession._strCommunity, by, ".gif");
                }
                if (act.startsWith("logo"))
                {
                    if (by != null)
                    {
                        c.setLogo(pic, teasession._nLanguage);
                    }
                    Node n = Node.find(root);
                    n.setSubject(link, teasession._nLanguage);
                } else if (act.startsWith("ad"))
                {
                    c.setAd(teasession._nLanguage, Integer.parseInt(act.substring(2)), pic, link);
                } else if (pic != null)
                {
                    c.setBanner(teasession._nLanguage, pic);
                }
                PrintWriter out = response.getWriter();
                out.print("<script>opener.location.reload(); window.close();</script>");
                out.close();
            } else if (act.startsWith("category"))
            {
                String subject = request.getParameter("subject");
                Node n = Node.find(teasession._nNode);
                if (n.getType() == 0)
                {
                    int type = Integer.parseInt(act.substring(8));
                    int nid = Node.create(teasession._nNode, 0, teasession._strCommunity, teasession._rv, 1, false, 0, 0, 1, null, null, new Date(), 0, 0, 0, 0, null, 1, subject, "","", "", null, null, 0, null, null, null, null, null, null, null);
                    Category.find(nid).set(type, 0, 0, "", 0);
                } else
                {
                    n.setSubject(subject, teasession._nLanguage);
                }
            } else if (act.startsWith("hidden"))
            {
                int code = Integer.parseInt(act.substring(6));
                WindowsBox wb = WindowsBox.find(root, code);
                wb.setHidden(!wb.isHidden());
            } else if (act.equals("windowsbox"))
            {
                for (int i = 0; i < 30; i++)
                {
                    boolean hidden = request.getParameter("hidden" + i) == null;
                    String name = request.getParameter("name" + i);
                    WindowsBox wb = WindowsBox.find(root, i);
                    wb.set(hidden, teasession._nLanguage, name);
                }
            } else if (act.equals("node"))
            {
                String subject = teasession.getParameter("subject");
                String content = teasession.getParameter("content");
                Node n = Node.find(teasession._nNode);
                if (n.getType() == 1)
                {
                    int o1 = n.getOptions1();
                    Category cat = Category.find(teasession._nNode);
                    teasession._nNode = Node.create(teasession._nNode, 0, n.getCommunity(), teasession._rv, cat.getCategory(), (o1 & 2) != 0, n.getOptions(), o1, n.getDefaultLanguage(), null, null, new java.util.Date(), 0, 0, 0, 0, null, teasession._nLanguage, subject, "","", content, null, "", 0, null, "", "", "", "", null, "");
                    n.finished(teasession._nNode);
                } else
                {
                    n.setSubject(subject, teasession._nLanguage);
                }
                String url = teasession.getParameter("url");
                String logo = null;
                byte by[] = teasession.getBytesParameter("logo");
                if (by != null)
                {
                    logo = write(teasession._strCommunity, by, ".gif");
					n.setPicture(logo,teasession._nLanguage);
                }
				n.set("clickurl",teasession._nLanguage,url);
                Link al = Link.find(teasession._nNode, teasession._nLanguage);
				al.ip=request.getRemoteAddr();
				al.set();
            } else if (act.equals("template"))
            {
                String radio = request.getParameter("radio");
                CommunityOption co = CommunityOption.find(teasession._strCommunity);
                co.set("eyptemplate", radio);
            } else if (act.equals("style"))
            {
                String radio = request.getParameter("radio");
                CommunityOption co = CommunityOption.find(teasession._strCommunity);
                co.set("eypstyle", radio);
            } else
            //////////////////////////////////////////////////////////////////////////////////////////////
            if ("0".equals(act)) //公司概况
            {
                int category = Integer.parseInt(request.getParameter("category1"));
                int city = Integer.parseInt(request.getParameter("city1"));
                String product = request.getParameter("product");
                int enrol = Integer.parseInt(request.getParameter("enrol"));
                int scale = Integer.parseInt(request.getParameter("scale"));
                String principal = request.getParameter("principal");
                int property = Integer.parseInt(request.getParameter("property"));
                String birth = request.getParameter("birth");
                String brand = request.getParameter("brand");
                c.set(category, city, enrol, scale, property, teasession._nLanguage, product, principal, birth, brand);
            } else if ("1".equals(act)) //公司概况
            {
                String content = teasession.getParameter("content");
                byte by[] = teasession.getBytesParameter("picture");
                if (by != null)
                {
                    String picture = write(teasession._strCommunity, by, ".gif");
                    c.setPicture(picture, teasession._nLanguage);
                }
                Node n = Node.find(root);
                n.set(teasession._nLanguage, n.getSubject(teasession._nLanguage), content);
            } else if ("2".equals(act)) //公司资质
            {
                String qualification[] = c.getQualification();
                for (int i = 0; i < 4; i++)
                {
                    byte by[] = teasession.getBytesParameter("qualification" + i);
                    if (by != null)
                    {
                        qualification[i] = write(teasession._strCommunity, by, ".gif");
                    } else if (teasession.getParameter("clear" + i) != null)
                    {
                        qualification[i] = "";
                    }
                }
                c.setQualification(qualification);
            } else if ("3".equals(act)) //企业文化
            {
                String title = teasession.getParameter("culturetitle");
                String picture = null;
                byte by[] = teasession.getBytesParameter("culturepicture");
                if (by != null)
                {
                    picture = write(teasession._strCommunity, by, ".gif");
                } else if (teasession.getBytesParameter("clear") != null)
                {
                    picture = "";
                }
                String content = teasession.getParameter("culturecontent");
                c.setCulture(teasession._nLanguage, title, picture, content);
            } else if ("4".equals(act)) //联系我们///
            {
                String name = teasession.getParameter("name");
                String contact = teasession.getParameter("contact");
                String email = teasession.getParameter("email");
                String telephone = teasession.getParameter("telephone");
                String fax = teasession.getParameter("fax");
                String address = teasession.getParameter("address");
                String zip = teasession.getParameter("zip");
                String webpage = teasession.getParameter("webpage");
                String map = null;
                byte by[] = teasession.getBytesParameter("map");
                if (by != null)
                {
                    map = write(teasession._strCommunity, by, ".gif");
                }
                int companydetail = Integer.parseInt(teasession.getParameter("companydetail"));
                if (companydetail == -1)
                {
                    Node n = Node.find(root);
                    n.setSubject(name, teasession._nLanguage);
                    c.set(teasession._nLanguage, contact, email, null, address, 0, null, zip, null, telephone, fax, webpage, map, null);
                } else
                if (companydetail == 0)
                {
                    CompanyDetail.create(root, teasession._nLanguage, name, contact, email, telephone, fax, address, zip, webpage, map);
                } else
                {
                    CompanyDetail cd = CompanyDetail.find(companydetail);
                    cd.set(teasession._nLanguage, name, contact, email, telephone, fax, address, zip, webpage, map);
                }
            } else if ("delcd".equals(act)) //删除分支机构///
            {
                int companydetail = Integer.parseInt(teasession.getParameter("companydetail"));
                CompanyDetail cd = CompanyDetail.find(companydetail);
                cd.delete();
            } else if ("dns".equals(act)) //基本信息设置///
            {
                String domain = teasession.getParameter("domain");
                if (teasession.getParameter("add") != null) //绑定域名
                {
                    DNS.find(domain).set(teasession._strCommunity, teasession._nStatus, "/jsp/type/company/windows/", root, false,"");
                } else if (teasession.getParameter("del") != null) //绑定域名
                {
                    DNS.find(domain).delete();
                } else //社区续费
                {
                    int year = Integer.parseInt(teasession.getParameter("year"));
                    Calendar cal = Calendar.getInstance();
                    cal.setTime(community.getStopTime());
                    cal.add(Calendar.YEAR, year);
                    community.setStopTime(cal.getTime());
                }
            }
        } catch (Exception ex)
        {
            ex.printStackTrace();
        }
        if (nu == null)
        {
            nu = request.getHeader("referer");
        }
        response.sendRedirect(nu);
    }
}
