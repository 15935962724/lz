package tea.ui.node.type.perform;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import tea.entity.node.*;
import tea.ui.*;
import java.util.Date;
import tea.htmlx.TimeSelection;

public class EditPerform extends TeaServlet
{
    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);
            Node node = Node.find(teasession._nNode);

			String nexturl = teasession.getParameter("nexturl");
			String act = teasession.getParameter("act");

			if("EditPerform".equals(act))
			{
                String subject = teasession.getParameter("Subject"); //演出名称
                String pftime = teasession.getParameter("pftime");//演出时间
                String price = teasession.getParameter("price");//演出价格

                String sort = teasession.getParameter("sort"); //主要演员
                String text = teasession.getParameter("content"); //简介
                String organise = teasession.getParameter("organise"); //组织人
                String linkman = teasession.getParameter("linkman"); //组织者联系方式
                String corp = teasession.getParameter("corp"); //组织者所属公司
                String intropicture = teasession.getParameter("intropicture"); //介绍图片路径
                String intropicturename = teasession.getParameter("intropictureName"); //介绍图片名称
                String direct = teasession.getParameter("direct"); //导演

                String ClearIntroPicture = teasession.getParameter("ClearIntroPicture");


                //把演出 添加到Node表中 可以使用列举
                if(node.getType() == 1)
                {
                    int sequence = Node.getMaxSequence(teasession._nNode) + 10;
                    long options = node.getOptions();
                    int options1 = node.getOptions1();
                    String community = node.getCommunity();
                    Category cat = Category.find(teasession._nNode); //55
                    teasession._nNode = Node.create(teasession._nNode,sequence,community,teasession._rv,cat.getCategory(),(options1 & 2) != 0,options,options1,node.getDefaultLanguage(),null,null,new java.util.Date(),0,0,0,0,null,teasession._nLanguage,subject,"","",text,null,"",0,null,"","","","",null,null);
                } else
                {
                    Date Issuedate = new Date();
                    node.set(teasession._nLanguage,subject,text);
                    node.setTime(Issuedate);
                }

                Perform pfobj = new Perform(teasession._nNode,teasession._nLanguage);
                if(ClearIntroPicture != null)
                {
                    intropicture = null;
                    intropicturename = null;
                } else if(intropicture != null)
                {
                } else
                {
                    intropicture = pfobj.getIntropicture();
                    intropicturename = pfobj.getIntropicturename();
                }

                if(pfobj.isExist())
                {
                    pfobj.set(sort,organise,linkman,corp,intropicture,intropicturename,direct,pftime,price);
                } else
                {
                    Perform.create(teasession._nNode,teasession._nLanguage,sort,organise,linkman,corp,intropicture,intropicturename,direct,pftime,price);
                }
                //点击在编辑页面中的场次设置按钮
                if(teasession.getParameter("GoBack")!=null)
                {
                	nexturl = "/jsp/type/perform/PerformStreak.jsp?community="+teasession._strCommunity+"&node="+teasession._nNode;
                }
			}		//删除
			else if("delete".equals(act))
			{
				int nid = Integer.parseInt(teasession.getParameter("node")); // teasession.getParameter("node");
				Node nobj = Node.find(nid);
				nobj.delete(teasession._nLanguage);
				Perform pfobj = Perform.find(nid,teasession._nLanguage);
				pfobj.delete();
				//删除场次
				PerformStreak.delete(nid);
			}

            super.delete(node);
            if(nexturl != null && nexturl.length()>0 && !"null".equals(nexturl))
            {
                response.sendRedirect(nexturl);
                return;
            }

            if (teasession.getParameter("GoBack") != null)
            {
                response.sendRedirect("EditNode?node=" + teasession._nNode);
            } else
            {
                node.finished(teasession._nNode);
                response.sendRedirect("Node?node=" + teasession._nNode + "&edit=ON");
            }
        } catch (Exception ex)
        {
            response.sendRedirect("/jsp/info/Error.jsp?info=" + ex.getMessage());
            ex.printStackTrace();
        }
    }
}
