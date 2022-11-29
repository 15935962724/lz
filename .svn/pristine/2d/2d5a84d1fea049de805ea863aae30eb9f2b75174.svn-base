package tea.ui.node.type.house;


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
import tea.entity.netdisk.FileCenterAttach;

public class EditHouse extends TeaServlet
{
    public EditHouse()
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

            String subject = teasession.getParameter("_nName");

            String content = teasession.getParameter("content");

            byte bypic[] = teasession.getBytesParameter("picture");

            String price = teasession.getParameter("price");
            if(price != null && price.length() > 0)
            {
                price = teasession.getParameter("price");
            } else
            {
                price = "0";
            }
            BigDecimal prices = new BigDecimal(price);

            String average = teasession.getParameter("average");
            if(average != null && average.length() > 0)
            {
                average = teasession.getParameter("average");
            } else
            {
                average = "0";
            }
            BigDecimal averages = new BigDecimal(average);

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

            File fpic = new File(application.getRealPath("/res/" + node.getCommunity() + "/house/" + teasession._nNode + ".jpg"));
            File dir = fpic.getParentFile();
            String path = "/res/" + node.getCommunity() + "/house/" + teasession._nNode + ".jpg";

            if(!dir.exists())
            {
                dir.mkdirs();
            }
            if(teasession.getParameter("clearpicture") != null)
            {
                path = null;
                fpic.delete();
            } else if(bypic != null)
            {
                FileOutputStream fos = new FileOutputStream(fpic);
                fos.write(bypic);
                fos.close();
            }

            String[] list =teasession.getParameterValues("file");
            StringBuffer pathstr=new StringBuffer(",");
            if(list != null)
            {
                for(int i = 0;i < list.length;i++)
                {
//                    System.out.println(list[i] + "  ");

                    File srcold = new File(request.getSession().getServletContext().getRealPath(list[i]));
                    File f = new File(request.getSession().getServletContext().getRealPath("/res/"+teasession._strCommunity + "/house/" + teasession._nNode + "/" + list[i].subSequence(list[i].lastIndexOf("/"),list[i].length())));
                    File dirold = f.getParentFile();
                    if(!dirold.exists())
                    {
                        dirold.mkdirs();
                    }
                    srcold.renameTo(f);
                    String path1 = "/res/" + teasession._strCommunity + "/house/" + teasession._nNode  + list[i].subSequence(list[i].lastIndexOf("/"),list[i].length());
                    pathstr.append(path1).append(",");
                }
            }

            String old = teasession.getParameter("old");
            old=pathstr.append(old).append(",").toString().replaceAll(",,",",");
            String impactpic=old;
            String huxing = teasession.getParameter("huxing"); //户型
            String sizes = teasession.getParameter("sizes"); //大小
            String parcel = teasession.getParameter("parcel"); //小区名称
            String zhuangxiu = teasession.getParameter("zhuangxiu"); //装修情况
            String toward = teasession.getParameter("toward"); ///朝向
            String floor = teasession.getParameter("floor"); //楼层
            String address = teasession.getParameter("address"); //地址
            String huxingpic = path; //户型图
            String facilities = teasession.getParameter("facilities"); //配套设施
            String xiaoqu = teasession.getParameter("xiaoqu"); //小区介绍

            House.set(node._nNode,huxing,sizes,parcel,zhuangxiu,toward,floor,address,prices,averages,huxingpic,impactpic,facilities,xiaoqu);

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
        //  super.r.add("tea/ui/node/type/dish/EditDish");
    }
}
