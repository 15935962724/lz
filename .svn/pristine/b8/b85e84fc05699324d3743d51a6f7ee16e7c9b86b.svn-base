package tea.ui.cio;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import java.text.*;
import tea.ui.*;
import tea.entity.*;
import tea.entity.member.*;
import tea.entity.cio.*;
import tea.entity.site.*;
import jxl.*;
import jxl.write.*;

public class EditCioCompany extends TeaServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        TeaSession teasession = new TeaSession(request);
        if(teasession._rv == null)
        {
            response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode + "&nexturl=" + java.net.URLEncoder.encode(request.getRequestURI() + "?" + request.getQueryString(),"UTF-8"));
            return;
        }
        String act = teasession.getParameter("act");
        String nu = teasession.getParameter("nexturl");
        try
        {
            if(act.equals("create"))
            {
                String name = teasession.getParameter("name").trim();
                boolean central = !"0".equals(teasession.getParameter("central"));
                String ns[] = name.split("\r\n");
                for(int i = 0;i < ns.length;i++)
                {
                    CioCompany.create(teasession._strCommunity,ns[i],central);
                }
            } else if(act.equals("edit"))
            {
                int ciocompany = Integer.parseInt(teasession.getParameter("ciocompany"));
                String name = teasession.getParameter("name");
                String contact = teasession.getParameter("contact");
                String tel = teasession.getParameter("tel");
                String mobile = teasession.getParameter("mobile");
                String email = teasession.getParameter("email");
                String invoice = teasession.getParameter("invoice");
                String delattach = teasession.getParameter("delattach");
                String remark = teasession.getParameter("remark");
                StringBuilder sb = new StringBuilder();
                StringBuilder jsfile = new StringBuilder();
                for(int i = 0;i < 50;i++)
                {
                    byte by[] = teasession.getBytesParameter("attach" + i);
                    if(by != null)
                    {
                        String aname = teasession.getParameter("attach" + i + "Name");
                        String attach = write(teasession._strCommunity,"cio",by,aname);
                        sb.append(attach).append(":");
                        jsfile.append("form1.attach" + i + ".disabled=true;");
                    }
                }
                if(ciocompany > 0)
                {
                    CioCompany cc = CioCompany.find(ciocompany);
                    String as[] = cc.getAttach();
                    String da[] = delattach.split("/");
                    for(int i = 1;i < da.length;i++)
                    {
                        as[Integer.parseInt(da[i])] = null;
                    }
                    for(int i = 0;i < as.length;i++)
                    {
                        if(as[i] != null)
                        {
                            sb.append(as[i] + ":");
                        }
                    }
                    cc.set(name,contact,tel,mobile,email,remark,sb.toString());
                } else
                {
                    ciocompany = CioCompany.create(ciocompany,teasession._strCommunity,teasession._rv._strR,name,contact,tel,mobile,email,invoice,remark,sb.toString());
                }
                CioCompany cc = CioCompany.find(ciocompany);
                String attach[] = cc.getAttach();
                StringBuilder ih = new StringBuilder();
                for(int i = 0;i < attach.length;i++)
                {
                    int j = attach[i].lastIndexOf('/') + 1;
                    String aname = attach[i].substring(j);
                    String ex = aname.substring(aname.lastIndexOf('.') + 1).toLowerCase();
                    ih.append("<span id='filespan_" + i + "'><a href='/jsp/include/DownFile.jsp?uri=" + java.net.URLEncoder.encode(attach[i],"UTF-8") + "&name=" + java.net.URLEncoder.encode(aname,"UTF-8") + "'><img src='/tea/image/netdisk/" + ex + ".gif' align='top' />" + aname + "</a><a href=javascript:f_del('_" + i + "')><img src='/tea/image/public/del2.gif'/></a>　</span>");
                }
                PrintWriter out = response.getWriter();
                out.write("<script>");
                out.write("form1=parent.document.form1; alert('参会企业信息提交成功');");
                out.write("form1.bs.value='提交'; form1.bs.disabled=false;");
                out.write("form1.delattach.value='/';"); //删除附件记录//
                out.write("var fl=parent.document.getElementById('filelist'); fl.innerHTML=\"" + ih.toString() + "\";");
                out.write(jsfile.toString()); //禁用以使用过的FILE框
                out.write("</script>");
                out.close();
                return;
                //nu = "/jsp/info/Succeed.jsp?community=" + teasession._strCommunity + "&info=" + java.net.URLEncoder.encode("报名信息提交成功.","UTF-8");
            } else if(act.equals("delete"))
            {
                int ciocompany = Integer.parseInt(teasession.getParameter("ciocompany"));
                CioCompany cc = CioCompany.find(ciocompany);
                cc.delete();
            } else if(act.equals("setname"))
            {
                int ciocompany = Integer.parseInt(teasession.getParameter("ciocompany"));
                String name = request.getParameter("name");
                CioCompany cc = CioCompany.find(ciocompany);
                cc.setName(name);
                PrintWriter out = response.getWriter();
                out.write("<script>opener.location.reload();window.close();</script>");
                out.close();
            } else if(act.equals("invite"))
            {
                StringBuilder sb = new StringBuilder();
                DecimalFormat df = new DecimalFormat("0000");
                sb.append(" AND invite=1 AND ciocompany NOT IN(");
                String ccs[] = teasession.getParameterValues("ciocompany");
                if(ccs != null)
                {
                    for(int i = 0;i < ccs.length;i++)
                    {
                        sb.append(ccs[i]).append(",");
                        int ciocompany = Integer.parseInt(ccs[i]);
                        CioCompany cc = CioCompany.find(ciocompany);
                        String member = cc.getMember();
                        if(member == null)
                        {
                            String pwd = String.valueOf(Math.random()).substring(2,8);
                            member = df.format(ciocompany);
                            if(!Profile.isExisted(member))
                            {
                                Profile.create(member,pwd,teasession._strCommunity,"",request.getServerName());
                            }
                            Profile p = Profile.find(member);
                            p.setPassword(pwd);
                        }
                        cc.set(true,member);
                    }
                }
                sb.append("0)");
                //去掉选中状态
                Enumeration e = CioCompany.find(teasession._strCommunity,sb.toString(),0,Integer.MAX_VALUE);
                while(e.hasMoreElements())
                {
                    CioCompany cc = (CioCompany) e.nextElement();
                    cc.set(false,cc.getMember());
                }
            } else if(act.equals("stop"))
            {
                String starttime = teasession.getParameter("starttime");
                String stoptime = teasession.getParameter("stoptime");
                CommunityOption co = new CommunityOption(teasession._strCommunity);
                co.set("ciostoptime",CioCompany.sdf.parse(stoptime));
                co.set("ciostarttime",CioCompany.sdf.parse(starttime));
                StringBuilder sb = new StringBuilder();
                sb.append(" AND special=1 AND ciocompany NOT IN(");
                String ccs[] = teasession.getParameterValues("ciocompany");
                if(ccs != null)
                {
                    for(int i = 0;i < ccs.length;i++)
                    {
                        sb.append(ccs[i]).append(",");
                        int ciocompany = Integer.parseInt(ccs[i]);
                        CioCompany cc = CioCompany.find(ciocompany);
                        cc.setSpecial(true);
                    }
                }
                sb.append("0)");
                //去掉选中状态
                Enumeration e = CioCompany.find(teasession._strCommunity,sb.toString(),0,Integer.MAX_VALUE);
                while(e.hasMoreElements())
                {
                    CioCompany cc = (CioCompany) e.nextElement();
                    cc.setSpecial(false);
                }
            } else if(act.equals("import"))
            {
                response.setHeader("Content-Disposition","attachment; filename=" + new String("Excel.xls".getBytes("GBK"),"ISO-8859-1"));
                OutputStream out = response.getOutputStream();
                WritableWorkbook ww = Workbook.createWorkbook(out);
                WritableSheet ws = ww.createSheet("cio",0);
                ws.addCell(new Label(0,0,"企业(集团)名称"));
                ws.addCell(new Label(1,0,"参会企业序号"));
                ws.addCell(new Label(2,0,"系统登密码"));
                Enumeration e = CioCompany.find(teasession._strCommunity," AND invite=1",0,Integer.MAX_VALUE);
                for(int i = 1;e.hasMoreElements();i++)
                {
                    CioCompany cc = (CioCompany) e.nextElement();
                    String name = cc.getName();
                    String member = cc.getMember();
                    Profile p = Profile.find(member);
                    String password = p.getPassword();
                    ws.addCell(new Label(0,i,name));
                    ws.addCell(new Label(1,i,member));
                    ws.addCell(new Label(2,i,password));
                }
                ww.write();
                ww.close();
                out.close();
                return;
            } else if(act.equals("receipt")) //给选中的企业发参会回执
            {
                String ccs[] = request.getParameterValues("ciocompanys");
                if(ccs != null)
                {
                    for(int i = 0;i < ccs.length;i++)
                    {
                        CioCompany cc = CioCompany.find(Integer.parseInt(ccs[i]));
                        cc.setReceipt(true);
                        Email.create(teasession._strCommunity,null,cc.getEmail(),"参会回执",cc.getReceiptToHtml());
                    }
                }
                response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("参会回执发送成功！","UTF-8") + "&nexturl=/jsp/cio/OkCioCompany.jsp");
                return;
            }
            //nu = "/jsp/cio/CioCompanys.jsp?community=" + teasession._strCommunity;
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
        response.sendRedirect(nu);
    }
}
