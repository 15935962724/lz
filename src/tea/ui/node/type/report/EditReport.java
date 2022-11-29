package tea.ui.node.type.report;

import java.io.*;
import java.util.Date;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.*;
import tea.entity.node.*;
import tea.htmlx.*;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import tea.db.DbAdapter;
import tea.entity.RV;
import java.util.regex.*;

import tea.entity.admin.orthonline.NodePoints;
import tea.entity.integral.CommunityPoints;
import tea.entity.integral.IntegralRecord;
import tea.entity.member.*;
import tea.entity.util.*;
import java.util.*;
import javax.imageio.*;
import java.awt.image.*;
import tea.entity.site.*;
import tea.newer.*;

public class EditReport extends TeaServlet
{
    public void init(javax.servlet.ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request,response);
        PrintWriter out = response.getWriter();
        try
        {
            out.println("<script>var mt=parent.mt;</script>");
            TeaSession teasession = new TeaSession(request);
            String nexturl = h.get("nexturl");
            Node node = Node.find(h.node);
            Category category = Category.find(h.node);
            int type = node.getType();
            boolean isnew = false;
            if(type == 1)
            {
                type = category.getCategory();
            }
            String act = h.get("act");
            if("sug".equals(act))
            {
                String medianame = h.get("medianame");
                if(medianame != null) //新闻来源
                {
                    out.print("<table cellspacing='0' style='width:100%'>");
                    ArrayList al = Media.find(" AND m.community=" + DbAdapter.cite(h.community) + " AND m.type=39 AND ml.name LIKE " + DbAdapter.cite("%" + medianame + "%"),0,10);
                    for(int i = 0;i < al.size();i++)
                    {
                        Media ss = (Media) al.get(i);
                        String name = ss.getName(h.language);
                        out.print("<tr onmousedown='mt.sug_sel(this,true)' onmouseover='mt.sug_sel(this)' data='" + ss.toString() + "'><td>" + MT.red(name,medianame));
                    }
                    out.print("</table>");
                }
                String experts = h.get("experts");
                if(experts != null) //专家
                {
                    out.print("<table cellspacing='0' style='width:100%'>");
                    List al = Newexperts.findList(" AND ename LIKE " + DbAdapter.cite("%" + experts + "%"),0,10);
                    for(int i = 0;i < al.size();i++)
                    {
                        Newexperts np = (Newexperts) al.get(i);
                        out.print("<tr onmousedown='mt.sug_sel(this,true)' onmouseover='mt.sug_sel(this)' data='" + np.toString() + "'><td>" + MT.red(np.getEname(),experts));
                    }
                    out.print("</table>");
                }
                String providemember = teasession.getParameter("providemember");
                if(providemember != null) //新闻提供者
                {
                    out.print("<table cellspacing='0' style='width:100%'>");
                    List al = Newproviders.findList(" AND nname LIKE " + DbAdapter.cite("%" + providemember + "%"),0,10);
                    for(int i = 0;i < al.size();i++)
                    {
                        Newproviders np = (Newproviders) al.get(i);
                        out.print("<tr onmousedown='mt.sug_sel(this,true)' onmouseover='mt.sug_sel(this)' data='" + np.toString() + "'><td>" + MT.red(np.getNname(),providemember));
                    }
                    out.print("</table>");
                }
                return;
            }
            if("upload".equals(act))
            {
                int battch = h.getInt("file.attch");
                if(battch > 0)
                {
                    Attch a = Attch.find(battch);
                    a.set("content",a.content = h.get("content"));
                    out.print(a.toString3());
                }
                return;
            }

            if((node.getOptions1() & 1) == 0)
            {
                if(teasession._rv == null)
                {
                    response.sendRedirect("/servlet/StartLogin?node=" + h.node);
                    return;
                }
                // if(!node.isCreator(teasession._rv) &&
                // !AccessMember.find(node._nNode,teasession._rv._strV).isProvider(type))
                // {
                // response.sendError(403);
                // return;
                // }
            } else if(teasession._rv == null)
            {
                teasession._rv = RV.ANONYMITY;
            }
            if(request.getMethod().equals("GET"))
            {
                response.sendRedirect("/jsp/type/report/EditReport.jsp?" + request.getQueryString());
            } else
            {
                if(h.get("EditReportKeywords") == null)
                {
                    String subject = h.get("subject");
                    if(subject == null || subject.length() < 1)
                    {
                        outText(teasession,response,r.getString(h.language,"InvalidSubject"));
                        return;
                    }
                    Node n = node.getType() == 1 ? new Node(0) : Node.find(h.node);
                    if(n._nNode == 0)
                    {
                        long options = node.getOptions();
                        int options1 = node.getOptions1();
                        Category cat = Category.find(h.node);
                        n.father = h.node;
                        n.sequence = Node.getMaxSequence(h.node) + 10;
                        n.community = node.getCommunity();
                        n.member = h.member;
                        n.creator = teasession._rv;
                        n.type = cat.getCategory(); //39
                        n.hidden = (options1 & 2) != 0;
                        n.options = options;
                        n.options1 = options1;
                        n.defaultLanguage = h.language; //node.getDefaultLanguage();
                        n.time = new Date();
                        n.style = node.getStyle();
                        n.root = node.getRoot();
                        n.kstyle = node.getKstyle();
                        n.kroot = node.kroot;
                        if(nexturl != null && nexturl.length() > 0)
                        {
                            n.source = 2;
                        } else
                        {
                            //前台创建
                            n.source = 1;
                        }
                        //添加审核
                        n.audits = 4; //默认是审核通过
                        if((cat.getPermissions() & 1) != 0)
                        {
                            n.audits = 0;
                        } else if((cat.getPermissions() & 2) != 0)
                        {
                            n.audits = 1;
                        } else if((cat.getPermissions() & 4) != 0)
                        {
                            n.audits = 2;
                        } else if((cat.getPermissions() & 8) != 0)
                        {
                            n.audits = 3;
                        }
                        n.hidden = n.audits != 4;
                        n.accessmembersnode = node.getAccessmembersnode();
                        
                        //判断是否传过来 “隐藏” 的值  --医疗粒子
                        String isHidden = h.get("isHidden","");
                        if(isHidden!=null&&isHidden.length()>0)
                        	n.hidden = Integer.parseInt(isHidden)==1?true:false;
                        
                        //h.node = Node.create(h.node,sequence,community,teasession._rv,cat.getCategory(),(options1 & 2) != 0,options,options1,defautllangauge,start,null,new java.util.Date(),node.getStyle(),node.getRoot(),node.getKstyle(),node.getKroot(),null,h.language,subject,keywords,description,content,null,"",0,null,"","","","",file,null);
                        isnew = true;
                    } else if(node.getType() == 0)
                    {
                        out.print("<script>mt.show('抱歉，参数不正确！')</script>");
                        return;
                    } else
                    {
                        n.getSequence(); //加载
                        Logs.create(node.getCommunity(),teasession._rv,2,h.node,subject);
                    }
                    n.starttime = h.getDate("start");
                    n.mostly = h.get("mostly") != null;
                    n.mostly1 = h.get("mostly1") != null;
                    n.mostly2 = h.get("mostly2") != null;
                    n.mark = h.get("mark","|").replace('|','/');
                    //修改处理人员
                    n.auditmember = teasession._rv.toString();
                    n.audittime = new Date();
                    n.set();
                    h.node = n._nNode;
                    //
                    String description = h.get("description");
                    String content = h.get("content");
                    boolean srccopy = h.get("srccopy") != null;
                    if(srccopy)
                    {
                        content = Caiji.img(h,content);
                    }
                    //附件
                    String file = h.get("file");
                    String keywords = h.get("keywords");
                    //图片
                    String pic = n._nNode == 0 ? null : n.getPicture(h.language);
                    if(pic == null || pic.length() < 1 || pic.endsWith("#auto"))
                    {
                        Matcher m = Pattern.compile("<img[^<>]+src=[\"']?([^\"']+)[\"']?[^<>]+>",Pattern.CASE_INSENSITIVE).matcher(content);
                        pic = m.find() ? m.group(1) + "#auto" : "";
                        if(pic.startsWith("file:/"))
                            pic = "";
                    }
                    n.setLayer(h.language,subject,keywords,description,content,pic,null,0,null,null,null,null,null,file,null);

                    if(isnew && (n.options1 & 2) != 0)
                    {
                        NodePoints np = NodePoints.get(h.node);
                        Profile profile = Profile.find(n.getCreator()._strV);
                        profile.addIntegral(np.getScwz(),profile.getProfile());

                        // 加分记录:上传资源加积分
                        IntegralRecord.create(h.community,profile.getMember(),np.getScwz(),4,n._nNode,profile.getMember());
                    }
                    //修改投稿积分
                    // 判断是否是透过新闻
                    String[] ms = h.getValues("mark");
                    if(ms != null && (n.getOptions1() & 4) != 0)
                    {
                        int igid = CommunityPoints.getIgid(h.community);
                        if(igid > 0)
                        {
                            CommunityPoints cp = CommunityPoints.find(igid);
                            Profile p = Profile.find(n.getCreator()._strR);
                            for(int i = 0;i < ms.length;i++)
                            {
                                int m = Integer.parseInt(ms[i]);
                                if(cp.getJjjf() == m && cp.getJjjf() > 0) //聚焦判断
                                {
                                    //聚焦加分
                                    p.setIntegral(p.getIntegral() + cp.getJjjf());
                                    p.setContributeintegral(p.getContributeintegral() + cp.getJjjf());
                                } else if(cp.getTtjf1() == m && cp.getTtjf1() > 0) //头条1
                                {
                                    p.setIntegral(p.getIntegral() + cp.getTtjf1());
                                    p.setContributeintegral(p.getContributeintegral() + cp.getTtjf1());
                                } else if(cp.getTtjf2() == m && cp.getTtjf2() > 0) //头条2
                                {
                                    p.setIntegral(p.getIntegral() + cp.getTtjf2());
                                    p.setContributeintegral(p.getContributeintegral() + cp.getTtjf2());
                                } else if(cp.getTtjf3() == m && cp.getTtjf3() > 0) //头条3
                                {
                                    p.setIntegral(p.getIntegral() + cp.getTtjf3());
                                    p.setContributeintegral(p.getContributeintegral() + cp.getTtjf3());
                                }
                            }
                        }
                    }

                    Report obj = Report.find(h.node);
                    obj.media = h.getInt("media");
                    String mn = h.get("medianame","");
                    if(mn.length() > 0)
                    {
                        ArrayList al = Media.find(" AND m.community=" + DbAdapter.cite(h.community) + " AND m.type=39 AND ml.name=" + DbAdapter.cite(mn),0,1);
                        if(al.size() > 0)
                        {
                            obj.media = ((Media) al.get(0)).media;
                        }
                    } else
                        obj.media = 0;
                    obj.classes = h.getInt("classes");
                    obj.classes2 = h.getInt("classesc");

                    // 添加水印
                    obj.flag = h.getInt("flag");

                    obj.manuscripttype = h.getInt("manuscripttype"); //稿件类型
                    if(obj.exists)
                        obj.iseditreport = 1; //编辑过新闻
                    obj.set();
                    ///
                    String author = h.get("author","");
                    if(author.length() > 0)
                    {
                        int rsum = Report.getAutherSum(author);
                        if(!ReportMember.isExists(author))
                        {
                            ReportMember.set(0,author,rsum,h.community);
                        }
                    }

                    String picture = h.get("picture");
                    if(picture != null && h.get("tbn") != null)
                    {
                        File f = new File(getServletContext().getRealPath(picture));
                        Img img = new Img(f);
                        img.width = img.height = 300;
                        img.start(f);
                    } else if(h.get("clearpicture") != null)
                        picture = "";
                    if(picture == null)
                        picture = h.get("picturepath");

                    // 添加水印/////////////////
                    if(picture != null && obj.flag == 1)
                    {
                        Watermark.mark(h.community,new File(getServletContext().getRealPath(picture)));
                    }
                    //标题图片
                    String subjectfilename = h.get("subjectfilename","");
                    if(subjectfilename.length() > 0)
                    {
                        if(subjectfilename.charAt(0) != '/')
                            subjectfilename = Attch.find(Integer.parseInt(subjectfilename)).path;
                    } else if(h.get("subjectfileclearpicture") != null)
                    {
                        subjectfilename = "";
                    }

                    //副标题图片
                    String subheadfilename = h.get("subheadfilename","");
                    if(subheadfilename.length() > 0)
                    {
                        if(subheadfilename.charAt(0) != '/')
                            subheadfilename = Attch.find(Integer.parseInt(subheadfilename)).path;
                    } else if(h.get("subheadfileclearpicture") != null)
                    {
                        subheadfilename = "";
                    }
                    //添加作者图片
                    String authorfilename = h.get("authorfilename","");
                    if(authorfilename.length() > 0)
                    {
                        if(authorfilename.charAt(0) != '/')
                            authorfilename = Attch.find(Integer.parseInt(authorfilename)).path;
                    } else if(h.get("authorfileclearpicture") != null)
                    {
                        authorfilename = "";
                    }
                    obj.setLayer(h.language,picture,h.get("locus"),h.get("subhead"),author,h.get("kicker"),h.get("editmember"),h.get("newquota"),h.get("quotasource"),subjectfilename,subheadfilename,authorfilename,h.get("experts"),h.get("providemember"),h.get("signature"));

                    // 手动列举
                    StringBuffer sb = new StringBuffer();
                    sb.append("0");
                    String[] ls = h.get("listing").split("/");
                    DbAdapter db = new DbAdapter();
                    try
                    {
                        for(int i = 1;i < ls.length;i++)
                        {
                            sb.append(",").append(ls[i]);
                            db.executeQuery("SELECT listed FROM Listed WHERE node=" + h.node + " AND listing=" + ls[i]);
                            if(!db.next())
                            {
                                Listed.create(h.node,Integer.parseInt(ls[i]),null);
                            }
                        }
                        if(!isnew)
                            db.executeUpdate(h.node,"DELETE FROM Listed WHERE node=" + h.node + " AND listing NOT IN(" + sb.toString() + ")");
                    } finally
                    {
                        db.close();
                    }

                    delete(n);

                    if("back".equals(h.get("act")))
                    {
                        nexturl = "/jsp/general/EditNode.jsp?node=" + h.node;
                    } else if("next".equals(h.get("act")))
                    {
                        response.sendRedirect("/jsp/type/report/EditReportKeywords.jsp?node=" + h.node);
                    } else
                    {
                        n.finished(h.node);
                        // 后台创建
                        if(nexturl != null)
                        {
                            String my = h.get("my");
                            if(my != null)
                                if(isnew && my.equals("on"))
                                    request.getSession().setAttribute("tea.isnew","on");
                        } else if(category.getClewtype() != 0)
                        {
                            out.print("<script>parent.showDialog('" + category.getClewcontent() + "','<a href=/servlet/Node?node=" + h.node + " class=bag>确定</a>　<a href=javascript:dialog_close(); class=trade>取消</a>');</script>");
                        } else
                        {
                            nexturl = "/html/" + h.community + "/report/" + h.node + "-" + h.language + ".htm";
                        }
                    }
                } else
                {
                    String nodes[] = request.getParameterValues("nodes");
                    if(nodes != null)
                    {
                        String subject = node.getSubject(h.language);
                        for(int index = 1;index < nodes.length;index++)
                        {
                            Node obj = Node.find(Integer.parseInt(nodes[index]));
                            if(obj.getKeywords(h.language).indexOf(subject) == -1)
                            {
                                obj.setKeywords(obj.getKeywords(h.language) + " " + subject,h.language);
                            }
                        }
                    }
                    if("GoBack".equals(h.get("act")))
                    {
                        nexturl = "/jsp/type/report/EditReport.jsp?node=" + h.node;
                    } else
                    {
                        nexturl = "/html/" + h.community + "/report/" + h.node + "-" + h.language + ".htm";
                    }
                }
            }
            out.print("<script>window.open('" + nexturl + "','_parent');</script>");
            //out.print("<script>mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
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
