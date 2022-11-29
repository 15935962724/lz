package tea.ui.node.type.venues;

import java.io.*;
import java.util.Date;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.node.*;
import tea.htmlx.*;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import tea.db.DbAdapter;
import tea.entity.RV;
import java.util.regex.*;

import tea.entity.admin.map.GMap;
import tea.entity.member.*;
import tea.entity.util.*;
import java.util.*;
import javax.imageio.*;
import java.awt.image.*;

public class EditVenues extends TeaServlet
{
	public void init(javax.servlet.ServletConfig servletconfig) throws ServletException
	{
		super.init(servletconfig);
	}

	public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
	{
		request.setCharacterEncoding("UTF-8");
		try
		{
			TeaSession teasession = new TeaSession(request);

            Node node = Node.find(teasession._nNode);
            Category category = Category.find(teasession._nNode);
            String nexturl = teasession.getParameter("nexturl");
            String act = teasession.getParameter("act");
			//删除
            if("delete".equals(act))
            {
                int nid = Integer.parseInt(teasession.getParameter("node")); // teasession.getParameter("node");
                Node nobj = Node.find(nid);
                nobj.delete(teasession._nLanguage);
                Venues vobj = Venues.find(nid);
                vobj.delete();
                //删除场馆座位图
                SeatEditor.delete(nid);
                //删除地图标点
                GMap gmobj = GMap.find(nid);
                gmobj.delete();
                response.sendRedirect(nexturl);
                return;
            }

			int type = node.getType();
			if(type == 1)
			{
				type = category.getCategory();
			}
			if((node.getOptions1() & 1) == 0)
			{
				if(teasession._rv == null)
				{
					response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
					return;
				}
				if(!node.isCreator(teasession._rv) && !AccessMember.find(node._nNode,teasession._rv._strV).isProvider(type))
				{
					response.sendError(403);
					return;
				}
			} else if(teasession._rv == null)
			{
				teasession._rv = RV.ANONYMITY;
			}
			if(request.getMethod().equals("GET"))
			{
				response.sendRedirect("/jsp/type/report/EditVenues.jsp?" + request.getQueryString());
				return;
			} else
			{
				if("EditVenues".equals(act))
				{
					String subject = teasession.getParameter("subject");//场馆名称
					if(subject == null || subject.length() < 1)
					{
						outText(teasession,response,r.getString(teasession._nLanguage,"InvalidSubject"));
						return;
					}
					String content = teasession.getParameter("content");//简介
					boolean srccopy = teasession.getParameter("srccopy") != null;//源网站的图片贴入本地
					if(srccopy)
					{
						content = copy(teasession._strCommunity,content);
					}
					boolean textorhtml = "1".equals(teasession.getParameter("TextOrHtml"));//使用HTML
					if(node.getType() == 1)
					{
						int sequence = Node.getMaxSequence(teasession._nNode) + 10;
						long options = node.getOptions();
						int options1 = node.getOptions1();
						String community = node.getCommunity();
						if(textorhtml)
						{
							options |= 0x40;
						}
						int defautllangauge = node.getDefaultLanguage();
						Category cat = Category.find(teasession._nNode); //39
						teasession._nNode = Node.create(teasession._nNode,sequence,community,teasession._rv,cat.getCategory(),(options1 & 2) != 0,options,options1,defautllangauge,null,null,new java.util.Date(),node.getStyle(),node.getRoot(),node.getKstyle(),node.getKroot(),null,teasession._nLanguage,subject,null,"",content,null,"",0,null,"","","","",null,null);
						node = Node.find(teasession._nNode);
					} else
					{
						node.set(teasession._nLanguage,subject,content);
						long options = node.getOptions();
						if(textorhtml)
						{
							options |= 0x40;
						}
						node.setOptions(options);
						Logs.create(node.getCommunity(),teasession._rv,2,teasession._nNode,subject);
					}

					//图片
					String np = node.getPicture(teasession._nLanguage);
					if(np == null || np.length() < 1 || np.endsWith("#auto"))
					{
						Pattern P_PIC = Pattern.compile("<img[^<>]+src=[\"']?([^\"']+)[\"']?[^<>]+>",Pattern.CASE_INSENSITIVE);
						Matcher m = P_PIC.matcher(content);
						String newv = m.find() ? m.group(1) + "#auto" : "";
						if(!newv.equals(np))
						{
							node.setPicture(newv,teasession._nLanguage);
						}
					}

                    String address = teasession.getParameter("address");
                    String linkman = teasession.getParameter("linkman");
                    String contactway = teasession.getParameter("contactway");
                    String aunit = teasession.getParameter("aunit");
                    int seating = 0;
					if(teasession.getParameter("seating")!=null && teasession.getParameter("seating").length()>0)
					{
						seating = Integer.parseInt(teasession.getParameter("seating"));
					}


						Venues obj = Venues.find(teasession._nNode);

					String intropic = teasession.getParameter("intropic");
					String intropicname = teasession.getParameter("intropicName");
					if(intropic != null && teasession.getParameter("tbn") != null)
					{
						File f = new File(getServletContext().getRealPath(intropic));
						BufferedImage bi = ImageIO.read(f);
						if(bi != null)
						{
							ZoomOut zo = new ZoomOut();
							bi = zo.imageZoomOut(bi,300,300);
							ImageIO.write(bi,"JPEG",f);
						}
					} else
					if(teasession.getParameter("clearpicture") != null)
					{
						intropic = "";
						intropicname="";
					}else
					{
						intropic=obj.getIntropicpath();
						intropicname=obj.getIntropicpath();

					}


					if(obj.isExists())
					{
						obj.set(address,linkman,contactway,aunit,intropicname,intropic,seating);
					} else
					{
						Venues.create(teasession._nNode,address,linkman,contactway,aunit,intropicname,intropic,seating);
					}


                    delete(node);

                    node.finished(teasession._nNode);
					//如果修改的时候点击的是 座位设置 跳转
					if("座位设置".equals(teasession.getParameter("GoFinish")))
					{
						nexturl = "/jsp/type/venues/Seatindex.jsp?node="+teasession._nNode+"&top=top&community="+teasession._strCommunity;
					}
                    if(nexturl != null)
                    {
                        response.sendRedirect(nexturl);
						return;
                    }

                    if(category.getClewtype() != 0)
                    {
                        response.setContentType("text/html;charset=UTF-8");
                        java.io.PrintWriter out = response.getWriter();
                        out.print("<script>parent.showDialog('" + category.getClewcontent() + "','<a href=/servlet/Node?node=" + teasession._nNode + " class=bag>确定</a>　<a href=javascript:dialog_close(); class=trade>取消</a>');</script>");
                        out.close();
                    } else
                    {
                        response.sendRedirect("Node?node=" + teasession._nNode);
                    }
						//

				}

			}
		} catch(Exception exception)
		{
		   // response.sendError(400,"新闻添加错误,请检查您的网络是否正常");//exception.toString()
			//response.sendRedirect("/jsp/admin");
			 response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("您添加的【场馆】出错了,请重新上传&nbsp;<a href=# onClick=\"javascript:history.back()\">返回</a>.","UTF-8"));
			System.out.println("场馆添加错误,请检查您的网络是否正常");
			exception.printStackTrace();
		}
	}
}
