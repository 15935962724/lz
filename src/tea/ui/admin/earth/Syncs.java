package tea.ui.admin.earth;

import tea.entity.member.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import java.math.*;
import tea.entity.node.*;
import tea.entity.*;
import tea.entity.admin.Supply;

public class Syncs extends HttpServlet
{
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        int len = request.getContentLength();
        if (len == -1) //if ("synctype".equals(request.getHeader("act")))
        {
            PrintWriter out = response.getWriter();
            out.print("/21/32/34/39/");
            out.close();
            return;
        }
        try
        {
            ObjectInputStream ois = new ObjectInputStream(request.getInputStream());
            Map m = (Map) ois.readObject();
            ois.close();
            //添加
            ArrayList al = (ArrayList) m.get("addnode");
            if (al != null)
            {
                for (int i = 0; i < al.size(); i++)
                {
                    Map d = (Map) al.get(i);
                    String domain = "http://" + (String) d.get("domain");
                    String syncid = (String) d.get("syncid"); //"营业执照序列号.节点号"
                    int father = ((Integer) d.get("father")).intValue();
                    Date time = (Date) d.get("time");
                    String creator = (String) d.get("creator");
                    RV rv = new RV(creator);
                    Date updatetime = (Date) d.get("updatetime");
                    int type = ((Integer) d.get("type")).intValue();
                    String subject = (String) d.get("subject");
                    String content = (String) d.get("content");
                    content = content.replaceAll("<img[^<]+src=\"(/[^\"]+)\"[^<]*>", "<img src=\"" + domain + "$1\" />");
                    int node = Node.findBySyncId(syncid);
                    System.out.println("同步: add:" + node + "/" + syncid);
                    boolean _bNew = node == 0;
                    Node n;
                    if (_bNew)
                    {
                        switch (type)
                        {
                        case 34:
                            father = 2196666;
                            break;
                        case 39:
                            father = 2196817;
                            break;
                        }
                        Node f = Node.find(father);
                        node = Node.create(father, 0, f.getCommunity(), rv, type, false, f.getOptions(), f.getOptions1(), 1, null, null, time, 0, 0, 0, 0,  syncid, 1, subject, null,"", content, null, null, 0, null, null,  null, null, null, null, null);
                        n = Node.find(node);
                        n.finished(node);
                    } else
                    {
                        n = Node.find(node);
                        n.set(1, subject, content);
                    }
                    n.setUpdatetime(updatetime);
                    switch (type)
                    {
                    case 21: //企业
                    {
                        String contact = (String) d.get("contact");
                        String email = (String) d.get("email");
                        String organization = (String) d.get("organization");
                        String address = (String) d.get("address");
                        int city = ((Integer) d.get("city")).intValue();
                        String state = (String) d.get("state");
                        String zip = (String) d.get("zip");
                        String country = (String) d.get("country");
                        String telephone = (String) d.get("telephone");
                        String fax = (String) d.get("fax");
                        String webpage = (String) d.get("webpage");
                        String map = (String) d.get("map");
                        String eyp = (String) d.get("eyp");
                        Company.find(node).set(1, contact, email, organization, address, city, state, zip, country, telephone, fax, webpage, map, eyp);
                        break;
                    }
                    case 32: //供求
                    {
                        int company = ((Integer) d.get("company")).intValue();
                        int newstype = ((Integer) d.get("newstype")).intValue();
                        int city = ((Integer) d.get("city")).intValue();
                        int city1 = ((Integer) d.get("city1")).intValue();
                        int term = ((Integer) d.get("term")).intValue();
                        int industrytype1 = ((Integer) d.get("industrytype1")).intValue();
                        int industrytype2 = ((Integer) d.get("industrytype2")).intValue();
                        String picname = (String) d.get("picname");
                        String picpath = domain + (String) d.get("picpath");
                        String website = (String) d.get("website");
                        Supply.create(subject, newstype, industrytype1, industrytype2, city, term, picname, picpath, website, content, 0, company, rv._strV, null, city1, node, 1);
                        break;
                    }
                    case 34: //产品
                    {
                        String goodstype = (String) d.get("goodstype");
                        int brand = ((Integer) d.get("brand")).intValue();
                        String no = (String) d.get("no");
                        String measure = (String) d.get("measure");
                        String spec = (String) d.get("spec");
                        String capability = (String) d.get("capability");
                        String smallpicture = domain + (String) d.get("smallpicture");
                        String bigpicture = domain + (String) d.get("bigpicture");
                        String commendpicture = domain + (String) d.get("commendpicture");
                        boolean status = true;
                        int company = ((Integer) d.get("company")).intValue();
                        BigDecimal price = (BigDecimal) d.get("price");
                      //  Goods.find(node).set(goodstype, brand, no, status, company, price, 0, false, (float)0, 0, 0, 0, 1, measure, spec, capability, smallpicture, bigpicture, commendpicture);
                       //   Goods.find(node).set(goodstype, brand, no, status, company, price, 0, 0, 0, 0 correspond2, correspond3, correspond4, correspond5, correspond6, language, measure, spec, capability, smallpicture, bigpicture, commendpicture)
                        break;
                    }
                    case 39: //新闻
                    {
                        int media = ((Integer) d.get("media")).intValue();
                        int classes = ((Integer) d.get("classes")).intValue();
                        Date issuetime = (Date) d.get("issuetime");
                        String picture = domain + (String) d.get("picture");
                        String locus = (String) d.get("locus");
                        String subhead = (String) d.get("subhead");
                        String author = (String) d.get("author");
                        String logograph = (String) d.get("logograph");
                        if (_bNew)
                        {
                         //   Report.create(node, media, classes, issuetime, 1, picture, locus, subhead, author, logograph);
                        } else
                        {
                           // Report.find(node).set(media, classes, issuetime, 1, picture, locus, subhead, author, logograph);
                        }
                        break;
                    }
                    }
                }
            }
            //删除
            al = (ArrayList) m.get("delnode");
            if (al != null)
            {
                for (int i = 0; i < al.size(); i++)
                {
                    String syncid = (String) al.get(i);
                    int node = Node.findBySyncId(syncid);
                    System.out.println("同步: del:" + node);
                    Node.find(node).delete(1);
                }
            }
        } catch (Exception ex)
        {
            ex.printStackTrace();
            throw new ServletException(ex);
        }
    }
}
