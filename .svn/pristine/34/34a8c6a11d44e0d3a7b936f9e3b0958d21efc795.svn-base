package tea.ui.node.type.photography;
import java.io.*;
import java.util.Date;
import javax.servlet.*;
import javax.servlet.http.*;

import tea.entity.node.*;
import tea.entity.photography.Photography;
import tea.entity.photography.PhotographyPoll;
import tea.htmlx.*;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import tea.ui.member.profile.newcaller;
import tea.db.DbAdapter;
import tea.entity.Entity;
import tea.entity.RV;
import java.util.regex.*;

import tea.entity.admin.orthonline.NodePoints;
import tea.entity.integral.IntegralRecord;
import tea.entity.member.*;
import tea.entity.util.*;

import java.util.*;
import javax.imageio.*;

import java.awt.image.*;

import tea.entity.site.*;
import tea.resource.Resource;



public class EditPhotography extends TeaServlet
{
	public void init(javax.servlet.ServletConfig servletconfig) throws ServletException
	{
		super.init(servletconfig);
	}

	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		request.setCharacterEncoding("UTF-8");
		  response.setContentType("text/html;charset=UTF-8");

		try
		{



			TeaSession teasession = new TeaSession(request);


			Resource r=new Resource("/tea/resource/Photography");
			String nexturl = teasession.getParameter("nexturl");
			String act = teasession.getParameter("act");

			Node node = Node.find(teasession._nNode);
			int categories = 0;//类型
			if(teasession.getParameter("categories")!=null && teasession.getParameter("categories").length()>0)
			{
				categories = Integer.parseInt(teasession.getParameter("categories"));
			}

			if(node.getType()==1 || node.getType()==0)// 如果是类别 是添加
			{
				teasession._nNode = categories;
				node = Node.find(teasession._nNode);
			}




			Category category = Category.find(teasession._nNode);
			int type = node.getType();
			boolean isnew = false;
			if (type == 1)
			{
				type = category.getCategory();
			}

			if ((node.getOptions1() & 1) == 0)
			{
				if (teasession._rv == null && !"edivote".equals(act))
				{
					response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
					return;
				}
			} else if (teasession._rv == null)
			{
				teasession._rv = RV.ANONYMITY;
			}

			if (request.getMethod().equals("GET"))
			{
				//response.sendRedirect("/jsp/type/photography/EditPhotography.jsp?" + request.getQueryString());
				if("edivote".equals(act))//投票
				{
					java.io.PrintWriter out = response.getWriter();
					String ip = request.getRemoteAddr();
					StringBuffer sql = new StringBuffer();

					sql.append(" AND node = ").append(teasession._nNode);
					sql.append(" AND ip = ").append(DbAdapter.cite(ip));
					sql.append(" AND times>=").append(DbAdapter.cite(Entity.sdf.format(new Date())+" 00:00:00.000"));
					sql.append(" AND times<=").append(DbAdapter.cite(Entity.sdf.format(new Date())+" 23:59:59.000"));

					int count = PhotographyPoll.count(teasession._strCommunity, sql.toString());
					if(count>=10)
					{
						out.print(r.getString(teasession._nLanguage,"9946908074"));
						out.close();
						return;
					}
					String member =null;
					if(teasession._rv==null)
					{

					}else {
						member = teasession._rv.toString();
					}

					PhotographyPoll.create(teasession._nNode,member , ip, teasession._strCommunity);
					Photography pobj = Photography.find(teasession._nNode);
					pobj.setVotenumber(pobj.getVotenumber()+1);


					out.print(r.getString(teasession._nLanguage,"2129497929")+"："+pobj.getVotenumber());
					out.close();
					return;
				}

			} else
			{
				 if("Photography".equals(teasession.getParameter("Photographyact")))
				{
					  String value[] = request.getParameterValues("nid");

			            if(value != null)
			            {
			            	String next_str ="操作成功";
			            	//boolean f = false;
			                for(int index = 0;index < value.length;index++)
			                {
			                    int i = Integer.parseInt(value[index]);
			                   Photography pobj = Photography.find(i);

			                    Node nobj = Node.find(i);
			                   /* AccessMember obj_am = AccessMember.find(node._nNode,teasession._rv.toString());
			                    if( !teasession._rv.isOrganizer(node.getCommunity()) && !teasession._rv.isWebMaster() && obj_am.getPurview() < 2)
			                    {
			                        response.sendError(403);
			                        return;
			                    }
			                    */
			                    if("delete".equals(act))
			                    {

			                    	nobj.delete(teasession._nLanguage);
			                    	pobj.delete(teasession._nLanguage);
			                    	PhotographyPoll.delete(i);
			                    	Talkback.delete(i);//删除评论

			                    }else if("audit".equals(act))//审核 显示
			                    {
			                    	if(nobj.getAudit()==0)
			                    	{
			                    		// next_str ="审核操作成功";
										nobj.set("audits",String.valueOf(nobj.audits=1));
			                    		nobj.setHidden(false);
			                    		pobj.set(teasession._rv.toString(),new Date(),teasession._nLanguage);
			                    	}else
			                    	{
			                    		next_str ="抱歉!您审核的作品里面有【已审核】的作品.\\n系统只能审核【未审核】的作品!";
			                    	}
			                    }else if("cancel_audit".equals(act))//还原
			                    {
			                    	if(nobj.getAudit()==0)
			                    	{
			                    		next_str ="抱歉!您还原的作品里面有【未审核】的作品.\\n系统只能还原【已审核或已拒绝】的作品!";
			                    	}else
			                    	{
			                    		nobj.set("audits",String.valueOf(nobj.audits=0));
			                    		nobj.setHidden(true);
			                    		pobj.set(null,null,teasession._nLanguage);
			                    		pobj.setVotenumber(0);
			                    		PhotographyPoll.delete(i);

			                    	}
			                    }else if("refusal".equals(act))//拒绝作品
			                    {
			                    	if(nobj.getAudit()==2)
			                    	{
			                    		next_str ="抱歉!您拒绝的作品里面有【已拒绝】的作品.\\n系统只能拒绝【已审核或未审核】的作品!";
			                    	}else
			                    	{
			                    		nobj.set("audits",String.valueOf(nobj.audits=2));
			                    		nobj.setHidden(true);
			                    		pobj.set(null,null,teasession._nLanguage);
			                    		pobj.setVotenumber(0);
			                    		PhotographyPoll.delete(i);

			                    	}
			                    }
			                }
							java.io.PrintWriter out = response.getWriter();
							out.print("<script  language='javascript'>alert('" + next_str + "');window.location.href='" + nexturl + "&id="+teasession.getParameter("id")+"';</script> ");
							out.close();
							return;
			            }


				}
			    else if ("EditPhotography".equals(act))//用户添加
				{



					if((node.getOptions1()& 1) == 0)
					{
					  if(teasession._rv==null)
					  {
					    response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
					    return;
					  }
					  /*
					  if (!node.isCreator(teasession._rv)&&!AccessMember.find(node._nNode, teasession._rv._strV).isProvider(type))
					  {
					    response.sendError(403);
					    return;
					  }
					  */
					}

					String subject = teasession.getParameter("subject");
					if (subject == null || subject.length() < 1)
					{
						outText(teasession, response, r.getString(teasession._nLanguage, "InvalidSubject"));
						return;
					}
					String byname = teasession.getParameter("byname");
					String camerabrand = teasession.getParameter("camerabrand");//相机品牌名称
					int camerabrandtype = -1;//相机品牌类型
					if(teasession.getParameter("camerabrandtype")!=null && teasession.getParameter("camerabrandtype").length()>0)
					{
						camerabrandtype = Integer.parseInt(teasession.getParameter("camerabrandtype"));
					}



					String content = teasession.getParameter("caption");//描述



					int audit=0;
					if(teasession.getParameter("audit")!=null && teasession.getParameter("audit").length()>0)
					{
						audit = Integer.parseInt(teasession.getParameter("audit"));
					}



					boolean mostly = teasession.getParameter("mostly") != null;
					boolean mostly1 = teasession.getParameter("mostly1") != null;
					boolean mostly2 = teasession.getParameter("mostly2") != null;

					if (node.getType() == 1)
					{
						int sequence = Node.getMaxSequence(teasession._nNode) + 10;
						long options = node.getOptions();
						int options1 = node.getOptions1();
						String community = node.getCommunity();

						int defautllangauge = node.getDefaultLanguage();
						Category cat = Category.find(teasession._nNode); // 39
						teasession._nNode = Node.create(teasession._nNode, sequence, community, teasession._rv, cat.getCategory(), (options1 & 2) != 0, options, options1, defautllangauge, null, null, new java.util.Date(), node.getStyle(), node.getRoot(), node.getKstyle(), node.getKroot(), null, teasession._nLanguage, subject, null, "",content, null, "", 0, null, "", "", "", "", null, null);
						node = Node.find(teasession._nNode);

						if("EditPhotography".equals(teasession.getParameter("act2")))//如果是管理员后台添加 不用审核
						{
							audit = 1;
						}
						node.set("audits",String.valueOf(node.audits=audit));
						if(audit!=1)
						{
							node.setHidden(true);
						}else
						{
							node.setHidden(false);
						}
						isnew = true;

						//判断信息来源
						if (nexturl != null && nexturl.length() > 0)
						{
							node.setSource(2);
						} else
						{
							// 前台创建
							node.setSource(1);
						}
						node.finished(teasession._nNode);

					} else
					{
						node.set(teasession._nLanguage, subject, content);
						long options = node.getOptions();

						node.setOptions(options);
						Logs.create(node.getCommunity(), teasession._rv, 2, teasession._nNode, subject);

						node.set("audits",String.valueOf(node.audits=audit));
						if(audit!=1)
						{
							node.setHidden(true);
						}else
						{
							node.setHidden(false);
						}

						Photography.find(teasession._nNode).set(null,null,teasession._nLanguage);
						Photography.find(teasession._nNode).setVotenumber(0);
                		PhotographyPoll.delete(teasession._nLanguage);
					}
					StringBuilder h = new StringBuilder("/");
					String ms[] = teasession.getParameterValues("mark");
					if (ms != null)
					{
						for (int i = 0; i < ms.length; i++)
						{
							h.append(ms[i]).append("/");
						}
					}
					node.set(mostly, mostly1, mostly2, h.toString());

					Photography obj =Photography.find(teasession._nNode);

					String locus = teasession.getParameter("locus");
					String subhead = teasession.getParameter("subhead");
					String author = teasession.getParameter("author");



					String picname=teasession.getParameter("picnameName");
					String picpath=teasession.getParameter("picname");




					String abbpicname = null;//teasession.getParameter("abbpicnameName");
					String abbpicpath = null;//teasession.getParameter("abbpicname");

					if(teasession.getParameter("clear_picname")!=null)
					{
						 picname = "";
						 picpath = "";
						 abbpicname="";
						 abbpicpath="";
					}else if(picpath==null)
					{
						picname=obj.getPicname(teasession._nLanguage);
						picpath=obj.getPicpath(teasession._nLanguage);
						abbpicname=obj.getAbbpicname(teasession._nLanguage);
						abbpicpath=obj.getAbbpicpath(teasession._nLanguage);


					}else {


						//按比例压缩文件

						BufferedImage ybi = ImageIO.read( new File(getServletContext().getRealPath(picpath))); //获取原来图片的大小
						int ww = ybi.getWidth();
						System.out.println(ww);
						if(ww>1000)
						{
							if (ybi != null)
							{
								ZoomOut zo = new ZoomOut();
								ybi = zo.imageZoomOut(ybi, 1000, 575);
								ImageIO.write(ybi, "JPEG", new File(getServletContext().getRealPath(picpath)));
							}
						}




						String newFilename = picname.substring(0,picname.lastIndexOf("."))+"_shrink"+picname.substring(picname.lastIndexOf("."),picname.length());
						String newFile =picpath.substring(0,picpath.lastIndexOf("/"))+"/"+newFilename;
						//复制文件
						obj.copyFile(getServletContext().getRealPath(picpath),getServletContext().getRealPath(newFile));


						abbpicname =newFilename;
						abbpicpath =newFile;
					}



					/*
					if (picture != null && teasession.getParameter("tbn") != null)
					{
						File f = new File(getServletContext().getRealPath(picture));
						BufferedImage bi = ImageIO.read(f);
						if (bi != null)
						{
							ZoomOut zo = new ZoomOut();
							bi = zo.imageZoomOut(bi, 300, 300);
							ImageIO.write(bi, "JPEG", f);
						}

					} else if (teasession.getParameter("clearpicture") != null)
					{
						picture = "";
					}
					*/

					if (obj.isExists())
					{
						obj.set(teasession._nLanguage, categories,0, byname, camerabrand, picname, picpath, abbpicname, abbpicpath);
						obj.setCamerabrandType(camerabrandtype);

						//清空投票表数据
						if(audit!=0)//说明是审核
						{
							obj.set(teasession._rv.toString(),new Date(),teasession._nLanguage);


						}else {
							obj.set(null,null,teasession._nLanguage);
							obj.setVotenumber(0);
	                		PhotographyPoll.delete(teasession._nNode);
						}


					} else
					{
						Photography.create(teasession._nNode, teasession._nLanguage, categories, 0, byname, camerabrand, picname, picpath, abbpicname, abbpicpath);
						Photography.find(teasession._nNode).setCamerabrandType(camerabrandtype);
					}



					// 手动列举
					String listingname = teasession.getParameter("listingname");
					String listact = teasession.getParameter("listact");
					if (listact != null && listact.length() > 0)
					{
						StringBuffer sb = new StringBuffer();
						sb.append("0");
						String ls[] = teasession.getParameter("listing").split("/");
						for (int i = 1; i < ls.length; i++)
						{
							sb.append(",").append(ls[i]);
							DbAdapter db = new DbAdapter();
							try
							{
								db.executeQuery("SELECT listed FROM Listed WHERE node=" + teasession._nNode + " AND listing =" + ls[i]);

								if (db.next())
								{
								} else
								{

									Listed.create(teasession._nNode, Integer.parseInt(ls[i]), null);
								}
							} finally
							{
								db.close();
							}

						}
						DbAdapter db = new DbAdapter();
						try
						{
							db.executeUpdate("DELETE FROM Listed WHERE node=" + teasession._nNode + " AND listing NOT IN(" + sb.toString() + ")");
						} finally
						{
							db.close();
						}
					}


					delete(node);

					//如果是前台用户添加提示功能 String myact = teasession.getParameter("MyPHO");//前台用户添加的作品 要提示用户
					if("MyPHO".equals(teasession.getParameter("myact")))
					{
						java.io.PrintWriter out = response.getWriter();
						//out.println("<script>f_close('newDiv');</script>");
						out.print("<script>parent.mt.show('/jsp/type/photography/PhotograpAlert.jsp?editnode="+teasession.getParameter("editnode")+"&phonode="+teasession.getParameter("phonode")+"&nexturl="+nexturl+"','','"+r.getString(teasession._nLanguage,"7187599648")+"',300,140);</script>");


//						int count =  Node.countPhotography(teasession._strCommunity,"  and n.type = 94  and n.rcreator ="+DbAdapter.cite(teasession._rv.toString()));
//						out.print("<script  language='javascript'>");
//
//						out.print("alert('您的作品已经上传成功,感谢您的参与。\\n\\n您还可以上传"+(20-count)+"幅作品。');");
//						out.print("history.go(-2);");
//
//						out.print("</script>");
						out.close();
						return;
					}


					if(nexturl!=null && nexturl.length()>0&&!"null".equals(nexturl))
					{
						response.sendRedirect(nexturl);
						return;
					}else {
						response.sendRedirect("Node?node=" + teasession._nNode);
						return;
					}
				}
			}
		} catch (Exception exception)
		{
			// response.sendError(400,"新闻添加错误,请检查您的网络是否正常");//exception.toString()
			// response.sendRedirect("/jsp/admin");
			response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("您添加的摄影出错了,请重新上传&nbsp;", "UTF-8"));
			System.out.println("摄影添加错误,请检查您的网络是否正常");
			exception.printStackTrace();
		}


	}
}
