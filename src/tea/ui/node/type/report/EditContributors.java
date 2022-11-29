package tea.ui.node.type.report;


import java.io.*;
import java.sql.SQLException;
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

import tea.entity.integral.CommunityPoints;
import tea.entity.member.*;
import tea.entity.util.*;
import tea.entity.westrac.WestracIntegralLog;

import java.util.*;
import javax.imageio.*;
import java.awt.image.*;
import tea.entity.site.*;
import tea.entity.Http;

public class EditContributors extends TeaServlet
{
    public void init(javax.servlet.ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html;charset=UTF-8");
        Http h = new Http(request,response);
        java.io.PrintWriter out = response.getWriter();
        try
        {
            //out.println("<script>var mt=parent.mt;</script>");
            TeaSession teasession = new TeaSession(request);
            int membertype = 0;
            if(h.get("membertype") != null)
            {

                membertype = Integer.parseInt(h.get("membertype"));

            }

            //如果是会员  必须登录
            if(membertype == 0 && teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + h.node + "&nexturl=" + java.net.URLEncoder.encode(request.getRequestURI() + "?" + request.getQueryString(),"UTF-8"));
                return;
            }
            // RV rv = new RV(h.get("member"));
            // teasession._rv = rv;


            String act = h.get("act");

            String nexturl = h.get("nexturl");

            int nid = 0;
            if(h.get("nid") != null && h.get("nid").length() > 0)
            {
                nid = Integer.parseInt(h.get("nid"));
            }

            Node nobj = Node.find(nid);

//			Category category = Category.find(father);
//			int type = node.getType();
//
//			if(type == 1)
//			{
//				type = category.getCategory();
//			}
//			if((node.getOptions1() & 1) == 0)
//			{
//				if(teasession._rv == null)
//				{
//					response.sendRedirect("/servlet/StartLogin?node=" + h.node);
//					return;
//				}
//
//			} else if(teasession._rv == null)
//			{
//				teasession._rv = RV.ANONYMITY;
//			}

            if(request.getMethod().equals("GET") && !"audit".equals(act) && !"Rejection".equals(act) && !"ContributorsNodeLists".equals(act) && !"ContributorsListAudit".equals(act) && !"AdminNodeLists".equals(act))
            {
                response.sendRedirect("/jsp/type/report/EditReport.jsp?" + request.getQueryString());
            } else
            {
                String info = "操作执行成功！";
                CommunityPoints cp = CommunityPoints.find(CommunityPoints.getIgid(h.community));
                if("EditContributors".equals(act))
                {
                    int father = Integer.parseInt(h.get("father"));
                    String subject = h.get("subject");
                    if(subject == null || subject.length() < 1)
                    {
                        outText(teasession,response,r.getString(h.language,"InvalidSubject"));
                        return;
                    }
                    String content = "";
                    if(h.get("content2") != null)
                    {
                        content = h.get("content2");
                    } else
                    {
                        content = h.get("content");
                    }
                    //关键词
                    String keywords = h.get("keywords");
                    String filepath = h.get("filepath"); //附件地址
                    String filename = h.get("filepathName");
                    if(h.get("clearpicture2") != null && h.get("clearpicture2").length() > 0)
                    {
                        filename = filepath = "|";
                    } else if(filepath != null && filepath.length() > 0)
                    {
                        filepath = "|" + filepath + "|";
                        filename = "|" + filename + "|";
                    } else
                    {
                        Node n = Node.find(h.node);
                        filepath = n.getFile(h.language);
                        filename = n.getFileName(h.language);
                    }

                    boolean mostly = false;
                    boolean mostly1 = true;
                    boolean mostly2 = true;
                    boolean textorhtml = "1".equals(h.get("TextOrHtml"));
                    String logograph = (h.get("logograph")); //导语
                    if(nid > 0)
                    {
                        nobj.set(h.language,subject,content);
                        long options = nobj.getOptions();
                        if(textorhtml)
                        {
                            options |= 0x40;
                        }
                        nobj.setOptions(options);
                        nobj.setKeywords(keywords,h.language);
                        nobj.setFile(filepath,h.language);
                        nobj.setFileName(filename,h.language);
                        nobj.set("description",h.language,logograph);
                        Logs.create(h.community,teasession._rv,2,nid,subject);
                    } else
                    {
                        int sequence = Node.getMaxSequence(father) + 10;
                        Node node = Node.find(father);
                        long options = node.getOptions();
                        int options1 = node.getOptions1();
                        String community = h.community;
                        if(textorhtml)
                        {
                            options |= 0x40;
                        }
                        int defautllangauge = node.getDefaultLanguage();
                        Category cat = Category.find(father); //39

                        nid = Node.create(father,sequence,community,teasession._rv,cat.getCategory(),true,options,options1,defautllangauge,null,
                                          null,new java.util.Date(),node.getStyle(),node.getRoot(),node.getKstyle(),node.getKroot(),null,h.language,subject,keywords,logograph,content,
                                          null,"",0,null,"","","",filename,filepath,null);

                        nobj = Node.find(nid);
                        nobj.finished(nid);
                        nobj.setSource(5); //前台投稿
                    }
                    StringBuilder ids = new StringBuilder("/");
                    String ms[] = h.getValues("mark");
                    if(ms != null)
                    {
                        for(int i = 0;i < ms.length;i++)
                        {
                            ids.append(ms[i]).append("/");
                        }
                    }
                    nobj.set(mostly,mostly1,mostly2,ids.toString());

                    //图片
                    String np = nobj.getPicture(h.language);
                    if(np == null || np.length() < 1 || np.endsWith("#auto"))
                    {
                        Pattern P_PIC = Pattern.compile("<img[^<>]+src=[\"']?([^\"']+)[\"']?[^<>]+>",Pattern.CASE_INSENSITIVE);
                        Matcher m = P_PIC.matcher(content);
                        String newv = m.find() ? m.group(1) + "#auto" : "";
                        if(!newv.equals(np))
                        {
                            nobj.setPicture(newv,h.language);
                        }
                    }

                    //媒体
//
                    int media = 0,class_id = 0,classc_id = 0;

                    if(Community.find(h.community).getMedia() > 0)
                    {
                        media = Community.find(h.community).getMedia();
                    }

                    //地点
                    String locus = h.get("locus");
                    //副标题
                    String subhead = h.get("subhead");
                    //作者
                    String author = h.get("member");

                    String picture = h.get("picture");

                    if(h.get("clearpicture") != null)
                    {
                        picture = "";
                    }

                    String kicker = h.get("kicker"); //肩题
                    Date date4 = new Date(); //发生时间

                    //投稿人的基本信息
                    String name = h.get("name"); //姓名
                    String units = h.get("units"); //工作单位
                    String email = h.get("email"); //邮箱
                    String mobile = h.get("mobile"); //手机
                    String address = h.get("address"); //地址

                    String telephone = h.get("telephone"); //办公电话

                    String signature = h.get("signature"); //本文署名

                    // author = name; //姓名就是作者

                    author = signature;
                    Report obj = Report.find(nid);
					obj.media=media;
					obj.classes=class_id;
					obj.classes2=classc_id;
					obj.issuetime=date4;
					obj.set();
					obj.setLayer(h.language,picture,locus,subhead,author,kicker,null,null,null,null,null,null,null,null,signature);
					obj.set(name,units,email,mobile,address,1,telephone);

                    //判断是否投稿和保存
                    String act2 = h.get("act2");

                    if("YEScon".equals(act2)) //投稿并保存
                    {
                        nobj.set("audits",String.valueOf(nobj.audits = 1));
                        //添加积分
                        Profile p = Profile.find(teasession._rv._strR);
                        p.setIntegral(p.getIntegral() + cp.getTgjf());
                        p.setContributeintegral(p.getContributeintegral() + cp.getTgjf());
                        info = "你已经投稿成功，谢谢！";
                    } else if("NOcon".equals(act2)) //不投稿保存
                    {
                        nobj.set("audits",String.valueOf(nobj.audits = 0));
                        info = "稿件保存成功！";
                    }
                    delete(nobj);

                    // out.print("<script  language='javascript'>alert('投稿操作完成');window.close();</script> ");
                    out.println("<script>alert('" + info + "');window.location.href='" + nexturl + "';</script> ");
                    return;

                } else if("delete".equals(act)) //彻底删除
                {
                    nobj.delete(h.language);
                    Report obj = Report.find(nid);
                    obj.delete();
                    out.println("<script  language='javascript'>alert('删除操作完成');window.location.href='" + nexturl + "';</script> ");
                    delete(nobj);
                    return;
                    //nexturl = "/jsp/type/report/contributors/Contributors_js.jsp?type=2&node="+h.node+"&membertype="+membertype;
                } else if("ContributorsMember".equals(act))
                {
                    //投稿人的基本信息
                    String name = h.get("name"); //姓名
                    String units = h.get("units"); //工作单位
                    String email = h.get("email"); //邮箱
                    String mobile = h.get("mobile"); //手机
                    String address = h.get("address"); //地址

                    String telephone = h.get("telephone"); //办公电话
                    Report obj = Report.find(nid);
                    obj.set(name,units,email,mobile,address,1,telephone);
                    //修改作者
                    //  obj.setAuthor(signature);
                    delete(Node.find(nid));

                    out.print("<script  language='javascript'>alert('投稿人信息修改成功');window.close();</script> ");

                    return;

                } else if("audit".equals(act)) //稿子审核
                {
                    Node n = Node.find(h.node);
                    if(n.getAudit()==1)
                    {
                    Report r = Report.find(h.node);
                    n.set("audits",String.valueOf(nobj.audits = 2));
                    r.set("editmember",teasession._rv._strR,h.language);

                    n.setHidden(false);
                    //修改发生时间
                    //  r.setIssuetime(new Date());
                    n.set("auditmember",String.valueOf(n.auditmember = teasession._rv._strR));
                    n.set("audittime",n.audittime = new Date());
                    n.set("starttime", n.getTime());

                    //添加积分
                    Profile p = Profile.find(n.getCreator()._strR);

                    p.setIntegral(p.getIntegral() + cp.getCyjf());
                    p.setContributeintegral(p.getContributeintegral() + cp.getCyjf());
                    //如果是履友



                    //如果是您的论坛工分已经达到2000/5000/10000分，特为您增加10/30/50履友积分，希望您更多地参与联盟活动中来！

                    out.print("审核成功");
                    delete(Node.find(h.node));
                    }

                    return;
                } else if("state".equals(act)) //隐藏
                {
                    Node n = Node.find(h.node);
                    n.setHidden("1".equals(h.get("state")));
                    //修改处理人员
                    n.set("auditmember",String.valueOf(n.auditmember = teasession._rv._strR));
                    n.set("audittime",n.audittime = new Date());
                    delete(n);
                    out.print("<script>parent.mt.show('数据操作成功！',1,'" + nexturl + "')</script>");
                    return;
                } else if("Rejection".equals(act)) //退稿
                {

                    int nodeid = 0;
                    if(h.get("nodeid") != null && h.get("nodeid").indexOf("/") == -1)
                    {
                        nodeid = Integer.parseInt(h.get("nodeid"));

                        Node n = Node.find(nodeid);
                        Report r = Report.find(nodeid);
                        String rejection = h.get("rejection");
                        n.set("audits",String.valueOf(nobj.audits = 3));
                        n.setHidden(true);
                        r.set("editmember",teasession._rv._strR,h.language);
                        r.setRejection(rejection);
                        //投稿加分
                        Profile p = Profile.find(n.getCreator()._strR);

                        p.setIntegral(p.getIntegral() - cp.getTgjianf());
                        p.setContributeintegral(p.getContributeintegral() - cp.getTgjianf());
                        //修改处理人员
                        n.set("auditmember",String.valueOf(n.auditmember = teasession._rv._strR));
                        n.set("audittime",n.audittime = new Date());

                        out.print("退稿成功 ");

                    } else
                    {
                        String ns = h.get("nodeid");
                        String s = "退稿成功";
                        for(int i = 1;i < ns.split("/").length;i++)
                        {
                            int nsid = Integer.parseInt(ns.split("/")[i]);
                            Node n = Node.find(nsid);
                            Report r = Report.find(nsid);

                            if(n.getAudit() == 1)
                            {
                                String rejection = h.get("rejection");
                                n.set("audits",String.valueOf(nobj.audits = 3));
                                n.setHidden(true);
                                r.set("editmember",teasession._rv._strR,h.language);
                                r.setRejection(rejection);
                                //投稿加分
                                Profile p = Profile.find(n.getCreator()._strR);

                                p.setIntegral(p.getIntegral() - cp.getTgjianf());
                                p.setContributeintegral(p.getContributeintegral() - cp.getTgjianf());
                            } else
                            {
                                s = "审核文章中有已审核或退稿的，系统只针对未审核文章";
                                break;
                            }
                            //修改处理人员
                            n.set("auditmember",String.valueOf(n.auditmember = teasession._rv._strR));
                            n.set("audittime",n.audittime = new Date());

                        }
                        out.print(s);
                    }

                    delete(Node.find(h.node));

                    return;
                } else if("ContributorsNodeLists".equals(act)) //删除 -- 软删除 归档到回收站
                {

                    Node n = Node.find(h.node);
                    Report r = Report.find(h.node);
                    n.set("audits",String.valueOf(nobj.audits = 4));
                    r.set("editmember",teasession._rv._strR,h.language);
                    n.setHidden(true);
                    //修改处理人员
                    n.set("auditmember",String.valueOf(n.auditmember = teasession._rv._strR));
                    n.set("audittime",n.audittime = new Date());

                    out.print("删除成功 ");
                    delete(n);

                    return;
                } else if("ContributorsListAudit".equals(act)) //个人投稿按钮
                {
                    nobj.set("audits",String.valueOf(nobj.audits = 1));
                    out.print("投稿成功,请等待审核... ");

                    return;
                } else if("AdminNodeLists".equals(act)) //新闻操作判断是否有权限
                {
                    out.print("您里面有没有权限的id");
                    return;
                }
                delete(Node.find(h.node));
                response.sendRedirect(nexturl);

            }
        } catch(Exception exception)
        {
            // response.sendError(400,"新闻添加错误,请检查您的网络是否正常");//exception.toString()
            //response.sendRedirect("/jsp/admin");
            response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("您添加的投稿出错了,请重新上传&nbsp;","UTF-8"));
            System.out.println("投稿添加错误,请检查您的网络是否正常");
            exception.printStackTrace();
        } finally
        {
            out.flush();
            out.close();
        }
    }
}
