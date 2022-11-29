package tea.ui.member.community;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.*;
import tea.entity.site.*;
import tea.entity.node.*;
import tea.http.RequestHelper;
import tea.ui.*;
import tea.db.*;
import tea.resource.*;
import tea.entity.admin.*;

public class EditCommunity extends TeaServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request,response);
        PrintWriter out = response.getWriter();
        try
        {
            out.println("<script>var mt=parent.mt;</script>");
            if(h.member < 1)
            {
                out.print("<script>top.location.replace('/servlet/StartLogin?community=" + h.community + "');</script>");
                return;
            }
            String nexturl = h.get("nexturl");
            RV rv = new RV(h.username);
            String community = h.get("community");
            if(request.getMethod().equals("GET"))
            {
                boolean flag = community == null;
                if(!flag && !rv.isWebMaster() && !rv.isOrganizer(community))
                {
                    response.sendError(403);
                    return;
                }
                if(!flag)
                {
                    response.sendRedirect("/jsp/community/EditCommunity.jsp?community=" + community);
                } else
                {
                    response.sendRedirect("/jsp/community/EditCommunity.jsp");
                }
                return;
            }
            boolean _bNew = h.get("new") != null;
            if(!RequestHelper.isIdentifier(community))
            {
                out.print("<script>mt.show('" + super.r.getString(h.language,"InvalidCommunity") + "');</script>");
                return;
            }
            Community obj = Community.find(community);
            if(_bNew && obj.isExists())
            {
                out.print("<script>mt.show('“" + community + "”已存在！');</script>");
                return;
            }
            obj.type = Integer.parseInt(h.get("type"));
            obj.state = Integer.parseInt(h.get("state"));
            obj.smtp = h.get("Smtp");
            obj.webName = h.get("WebName");
            obj.email = h.get("Email");
            obj.smtpname = h.get("SmtpName");
            obj.smtpuser = h.get("SmtpUser");
            obj.smtppassword = h.get("SmtpPassword");
            obj.regMail = h.get("regmail") != null;
            obj.regmap = h.get("regmap") != null;
            obj.publicity = h.get("publicity") != null;
            String s1 = h.get("Name");
            String s3 = h.get("Term");
            String s5 = h.get("Welcome");
            String css = h.get("css");
            String filtrate = h.get("filtrate");
            filtrate = filtrate.length() < 1 ? "李洪志,江泽民,胡金涛,法轮功,代开发票" : filtrate.replaceAll("(^,*)|(,*$)","").replaceAll("(,,+)|(\r\n)",",");
            String mailbefore = h.get("mailbefore");
            String mailafter = h.get("mailafter");
            String jspbefore = h.get("jspbefore");
            String jspafter = h.get("jspafter");
            String smallmap = h.get("smallmap"); // 小图
            if(h.get("clear") != null)
            {
                smallmap = "";
            }
            String keywords = h.get("keywords");
            String synopsis = h.get("synopsis"); // 简介
            if(_bNew)
            {
                obj.node = h.node = Node.create(0,0,community,new RV(h.username),0,false,1325924416,0,1,null,null,new java.util.Date(),0,0,0,0,null,h.language,s1,null,null,null,null,null,0,null,null,null,null,null,null,"");
                //h.node = Community.create(community,i,state,webmaster,h.language,s1,s3,s5,webName,email,smtp,SmtpName,SmtpUser,SmtpPassword,css,filtrate,regmail,regmap,publicity,mailbefore,mailafter,jspbefore,jspafter,smallmap,keywords,synopsis);
                //模版
                String template = h.get("template");
                if(template != null && template.length() > 0)
                {
                    Node old = Node.find(Integer.parseInt(template));
                    String oldc = old.getCommunity();
                    Node.clone(old._nNode,h.node,true,true,0,rv,null);
                    //
                    AdminFunction af = AdminFunction.getRoot(old.getCommunity(),h.status);
                    af.clone(0,community,h.status,true);
                    StringBuffer ars = new StringBuffer("/");
                    ArrayList al = AdminRole.find(" AND community=" + DbAdapter.cite(oldc),0,Integer.MAX_VALUE);
                    for(int j = 0;j < al.size();j++)
                    {
                        AdminRole ar = (AdminRole) al.get(j);
                        String afs = ar.getAdminfunction();
                        DbAdapter db = new DbAdapter();
                        try
                        {
                            db.executeQuery("SELECT id,syncid FROM AdminFunction WHERE community=" + DbAdapter.cite(community));
                            while(db.next())
                            {
                                String id = db.getString(1);
                                String id2 = db.getString(2);
                                afs = afs.replaceAll("/" + id2 + "/","/" + id + "/");
                            }
                        } finally
                        {
                            db.close();
                        }
                        int arid = AdminRole.create(community,ar.getStatus(),ar.getType(),null,null,ar.getName());
                        AdminRole.find(arid).setAdminfunction(afs,"");
                        ars.append(arid).append("/");
                    }
                    AdminUsrRole.create(community,h.member,ars.toString(),"/",0,"/","/");
                }
            }
            obj.set();
            obj.setLayer(h.language,s1,s3,s5,mailbefore,mailafter,jspbefore,jspafter,smallmap,keywords,synopsis);
            obj.set(css,h.language,jspbefore,jspafter);
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

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("/tea/ui/member/community/EditCommunity");
    }
}
