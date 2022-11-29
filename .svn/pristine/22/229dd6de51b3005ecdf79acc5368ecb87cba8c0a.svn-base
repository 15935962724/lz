package tea.ui.node.type.movie;


import java.io.*;
import java.util.Date;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.node.*;
import tea.htmlx.*;
import tea.http.MultipartRequest;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import javax.servlet.ServletContext;
import java.math.BigDecimal;
import tea.entity.node.Movie;


public class EditMovie extends TeaServlet
{
    public EditMovie()
    {
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);
            ServletContext application = getServletContext();
            if(teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            Node node = Node.find(teasession._nNode);
            if(!node.isCreator(teasession._rv) && AccessMember.find(node._nNode,teasession._rv._strV).getPurview() < 2)
            {
                response.sendError(403);
                return;
            }
            String subject = teasession.getParameter("subject");
            String performer=teasession.getParameter("performer"); //主要演员
            String direct=teasession.getParameter("direct"); //导演
            String country=teasession.getParameter("country"); //国家
            String mvtype=teasession.getParameter("mvtype"); //影片类型
            String mvmaking=teasession.getParameter("mvmaking"); //影片长度
            String mvgrade=teasession.getParameter("mvgrade"); //影片级别
            String publisher=teasession.getParameter("publisher"); //发行公司
            int mvyear=0;
            if(teasession.getParameter("mvyear")!=null && teasession.getParameter("mvyear").length()>0)
            {
                mvyear=Integer.parseInt(teasession.getParameter("mvyear"));
            }
            String mvaward=teasession.getParameter("mvaward"); //所获奖项
            String behindcontent=teasession.getParameter("behindcontent"); //幕后内容
            String feature=teasession.getParameter("feature"); //有趣花絮
            String languagetype=teasession.getParameter("languagetype"); //语言类型
            String mvpath=teasession.getParameter("mvpath");

            String content = teasession.getParameter("content");

            byte bypic[] = teasession.getBytesParameter("mvpic");

            String mvprice = teasession.getParameter("mvprice");
            if(mvprice != null && mvprice.length() > 0)
            {
                mvprice = teasession.getParameter("mvprice");
            }
            else
            {
                mvprice = "0";
            }
            BigDecimal price = new BigDecimal(mvprice);
            Date date4 = new Date();
            try
            {
                date4 = TimeSelection.makeTime(teasession.getParameter("IssueYear"),teasession.getParameter("IssueMonth"),teasession.getParameter("IssueDay"),teasession.getParameter("IssueHour"),teasession.getParameter("IssueMinute"));
            } catch(Exception ex2)
            {
            }
            if(node.getType() == 1)
            {
                int sequence = Node.getMaxSequence(teasession._nNode) + 10;
                long options = node.getOptions();
                int options1 = node.getOptions1();
                String community = node.getCommunity();
                int defautllangauge = node.getDefaultLanguage();
                Category cat = Category.find(teasession._nNode); //39
                teasession._nNode = Node.create(teasession._nNode,sequence,community,teasession._rv,cat.getCategory(),(options1 & 2) != 0,options,options1,defautllangauge,null,null,date4,node.getStyle(),node.getRoot(),node.getKstyle(),node.getKroot(),null,teasession._nLanguage,subject,"","",content,null,"",0,null,"","","","",null,null);
                node = Node.find(teasession._nNode);
            } else
            {
                node.set(teasession._nLanguage,subject,content);
                node.setTime(date4);
            }

            File fpic = new File(application.getRealPath("/res/" + node.getCommunity() + "/movie/" + teasession._nNode + ".jpg"));
            File dir = fpic.getParentFile();
            String path = "/res/" + node.getCommunity() + "/movie/" + teasession._nNode + ".jpg";

            if(!dir.exists())
            {
                dir.mkdirs();
            }
            if(teasession.getParameter("clearpicture") != null)
            {
                path=null;
                fpic.delete();
            } else if(bypic != null)
            {
                FileOutputStream fos = new FileOutputStream(fpic);
                fos.write(bypic);
                fos.close();
            }
            Movie.set(node._nNode,path,performer,direct,country,mvtype,mvmaking,mvgrade,publisher,mvyear,mvaward,behindcontent,feature,languagetype,price,mvpath);


            String nexturl = teasession.getParameter("nexturl");
            if(teasession.getParameter("GoBack") != null)
            {
                response.sendRedirect("EditNode?node=" + teasession._nNode);
            } else
            {
                if(nexturl != null)
                {
                    response.sendRedirect(nexturl);
                } else
                {
                    node.finished(teasession._nNode);
                    response.sendRedirect("Node?node=" + teasession._nNode + "&edit=ON");
                }
            }
        } catch(Exception exception)
        {
            response.sendError(400,exception.toString());
            exception.printStackTrace();
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
    }
}
