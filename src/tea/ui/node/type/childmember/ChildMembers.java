package tea.ui.node.type.childmember;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.Date;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import jxl.Workbook;
import jxl.format.UnderlineStyle;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

import tea.entity.Http;
import tea.entity.Img;
import tea.entity.custom.jjh.Voltype;
import tea.entity.custom.jjh.Volunteer;
import tea.entity.member.Profile;
import tea.entity.node.ChildMember;
import tea.entity.site.Community;
import tea.entity.util.Card;
import tea.service.SendEmaily;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import tea.entity.Err;

public class ChildMembers extends TeaServlet
{

    public void init() throws ServletException
    {
    }

    // Process the HTTP Get request
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        Http h = new Http(request,response);
		HttpSession session = request.getSession(true);
        String act = h.get("act");
        String nextUrl = h.get("nextUrl","");
        try
        {
            if("Excel".equals(act))
            {
                String sql = h.get("vid");
                Enumeration e = ChildMember.find(h.community," and membertype!=1 order by profile desc",0,Integer.MAX_VALUE);
//				pw.close();
                ServletOutputStream s = response.getOutputStream();
                WritableWorkbook ww = Workbook.createWorkbook(s);
                WritableSheet sheet = ww.createSheet("查询结果",0);
                response.setContentType("application/x-msdownload");
                String name = "会员信息表.xls";
                response.setHeader("Content-Disposition","attachment; filename=\"" + new String(name.getBytes("GBK"),"ISO-8859-1") + "\"");
                WritableFont wf = new WritableFont(WritableFont.TIMES,10,WritableFont.BOLD,false,UnderlineStyle.NO_UNDERLINE,jxl.format.Colour.BLACK); // 定义格式 字体 下划线 斜体 粗体 颜色
                WritableCellFormat cf = new WritableCellFormat(wf); // 单元格定义
                cf.setAlignment(jxl.format.Alignment.LEFT); // 设置对齐方式
                // ws.getSettings().setPrintGridLines(true);//是否打印网格线
                String[] showcol = new String[]
                                   {"会员ID","用户名","姓名","单位全称","职务","性别","出生年月日","手机号","电话","邮箱","注册时间","审核状态"};
                int cols = showcol.length;
                for(int i = 0;i < cols;i++)
                {
                    sheet.setColumnView(i,20); // 设置列的宽度
                }
                for(int i = 0;i < cols;i++)
                {
                    sheet.addCell(new Label(i,0,showcol[i],cf));
                }
                int j = 1;
                while(e.hasMoreElements())
                {
                    String mem = (String) e.nextElement();
                    ChildMember cm = ChildMember.findChildMember(mem,h.language);
                    if(cm.isExist())
                    {
                        sheet.addCell(new Label(0,j,cm.getMid()));
                        sheet.addCell(new Label(1,j,cm.getMember()));
                        sheet.addCell(new Label(2,j,cm.getFname()));
                        sheet.addCell(new Label(3,j,cm.getUnitname()));
                        sheet.addCell(new Label(4,j,cm.getPosition()));
                        sheet.addCell(new Label(5,j,cm.getSex() ? "男" : "女"));
                        sheet.addCell(new Label(6,j,cm.getBirth()));
                        sheet.addCell(new Label(7,j,cm.getMobile()));
                        sheet.addCell(new Label(8,j,cm.getPhone()));
                        sheet.addCell(new Label(9,j,cm.getEmail()));
                        sheet.addCell(new Label(10,j,cm.getTime()));
                        sheet.addCell(new Label(11,j,cm.getMembertypes()));
                    }

                    j++;
                }
                ww.write();
                ww.close();
                s.close();
                return;
            } else if("verify".equals(act))
            {
                OutputStream out = response.getOutputStream();
                int verify = h.getInt("verify",Community.find(h.community).verify);
                if(verify == 3)
                {
                    session.removeAttribute("vertifyValue");
                    String rand = Img.verify(out,20);
                    session.setAttribute("vertifyValue",rand);
                }
                return;
            }
        } catch(Throwable ex)
        {
            ex.printStackTrace();
        } finally
        {
        }
        PrintWriter out = response.getWriter();
        try
        {
            if("register".equals(act))
            {
                out.println("<script>var mt=parent.mt;</script>");
                String username = h.get("member");
                if(username == null || Profile.isExisted(username))
                {
                    out.print("<script>mt.show('抱歉，“" + username + "”已存在，请更换其它用户名！');</script>");
                    return;
                }
                int member = ChildMember.create(username,h.get("password"),h.community,h.get("fname"),h.getInt("sex"),h.get("unitname"),h.get("position"),h.getDate("birth"),h.get("email"),h.get("mobile"),h.get("qq"),h.get("phone"),h.language,new Date());
                if(h.get("isloginin")!=null&&"true".equals(h.get("isloginin"))){
                	session.setAttribute("member",member);
                }
                //
                request.setAttribute("nextUrl",nextUrl);
                String jump = h.get("jump");
                out.print("<script>parent.location='" + jump + "';</script>");
            } else if("edit".equals(act))
            {
                out.print("<script>var mt=parent.mt;</script>");
                String member = h.get("member");
                ChildMember cm = ChildMember.findChildMember(member,h.language);
                if(cm.isExist())
                {
                    String pwd = "";
                    if(!h.get("password","").equals(cm.getPassword()) && h.get("password","").length() > 0)
                    {
                        pwd = h.get("password","");
                    } else
                    {
                        pwd = cm.getPassword();
                    }
                    cm.set(pwd,h.community,h.get("fname"),h.getInt("sex"),h.get("unitname"),h.get("position"),h.getDate("birth"),h.get("email"),h.get("mobile"),h.get("qq"),h.get("phone"),h.language);
                }
                out.print("<script>mt.show('编辑信息成功',1,'" + nextUrl + "');</script>");
                return;
            } else if("delete".equals(act))
            {
                String member = h.get("member");
                ChildMember.delete(member,h.community);
                out.print("删除成功！");
                return;
            } else if("clearPwd".equals(act))
            {
                String member = h.get("member");
                ChildMember cm = ChildMember.findChildMember(member,h.language);
                if(cm.clearPwd())
                {
                    out.print("清空密码成功！");
                } else
                {
                    out.print("清空密码失败！");
                }
                return;

            } else if("delAll".equals(act))
            {
                String member = h.get("members");
                String[] mr = member.split("[|]");
                if(mr.length > 1)
                {
                    for(int i = 1;i < mr.length;i++)
                    {
                        if(mr[i] != null && mr[i].trim().length() > 0)
                        {
                            ChildMember.delete(mr[i],h.community);
                        }
                    }
                }
                out.print("批量删除成功！");
                return;

            } else if("haschild".equals(act))
            {
                String member = h.get("member","");
                //String community=h.get("community",h.community);
                out.print(ChildMember.isExistChild(member));
                return;
            } else if("changePwd".equals(act))
            {
                TeaSession ts = new TeaSession(request);
                String m = "";
                if(ts._rv != null)
                {
                    if(ts._rv._strR != null && ts._rv._strR.length() > 0)
                    {
                        m = ts._rv._strR;
                    } else
                    {
                        m = ts._rv._strV;
                    }
                }
                ChildMember cm = ChildMember.findChildMember(m,h.language);
                String oldpwd = h.get("old");
                String newpwd = h.get("password");
                if(!oldpwd.equals(cm.getPassword()))
                {
                    out.print("原密码输入错误！");
                    return;
                } else
                {
                    cm.setPwd("password",newpwd);
                    out.print("密码修改成功！");
                    return;
                }

            } else if("WmemberVerifginput".equals(act))
            {
                int membertype = 2;
                membertype = h.getInt("membertype");
                String member = h.get("member","");
                TeaSession ts = new TeaSession(request);
                String m = "";
                if(ts._rv != null)
                {
                    if(ts._rv._strR != null && ts._rv._strR.length() > 0)
                    {
                        m = ts._rv._strR;
                    } else
                    {
                        m = ts._rv._strV;
                    }
                }
                if(member.indexOf("|") >= 0)
                {
                    String members[] = member.split("[|]");
                    for(int i = 0;i < members.length;i++)
                    {
                        if(members[i].length() > 0)
                        {
                            ChildMember cm = ChildMember.findChildMember(members[i],h.language);

                            if(cm.audit(membertype,m,new Date()))
                            {
                            } else
                            {
                            }
                        }
                    }

                    out.print("true");
                } else
                {
                    ChildMember cm = ChildMember.findChildMember(member,h.language);

                    if(cm.audit(membertype,m,new Date()))
                    {
                        out.print("true");
                    } else
                    {
                        out.print("false");
                    }
                }

                return;
            } else if("RetrievePassword".equals(act))
            {
                String community = h.community;
                String cm = h.get("cmember");
                String vertify = h.get("vertify","");
                if(session.getAttribute("vertifyValue") != null && vertify.equals(session.getAttribute("vertifyValue")))
                {
                    ChildMember cmem = ChildMember.findChildMember(cm,h.language);
                    if(cmem.isExist())
                    {
                        String pwd = cmem.getPassword();
                        String email = cmem.getEmail();
                        SendEmaily se = new SendEmaily(community);
                        if(cmem.getPassword().length() == 0 && cmem.isclearPwd())
                        {
                            se.sendEmail(email,"忘记密码","尊敬的用户，您在校外教育信息资源网的用户名是" + cm + "，密码已被管理员清空，支持空密码登录，您还可以通过网站登录获得我们更多服务.");

                        } else
                        {
                            se.sendEmail(email,"忘记密码","尊敬的用户，您在校外教育信息资源网的用户名是" + cm + "，密码是" + pwd + "，您可以通过网站登录获得我们更多服务.");
                        }
                        out.print("<script>alert(\"您的密码已发送到您邮箱，请注意查收！\");window.history.back();</script>");
                    } else
                    {
                        out.print("<script>alert(\"用户名无效！\");window.location='" + nextUrl + "';</script>");
                    }
                } else
                {
                    out.print("<script>alert(\"验证码输入错误！\");window.location='" + nextUrl + "';</script>");
                }
                return;
            }

        } catch(Throwable ex)
        {
            out.print("<textarea id='ta'>" + Err.get(h,ex) + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }
}
