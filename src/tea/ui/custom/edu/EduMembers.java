package tea.ui.custom.edu;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.member.*;
import tea.ui.TeaServlet;
import tea.db.DbAdapter;
import tea.entity.*;
import tea.entity.site.*;
import jxl.write.*;
import java.util.*;
import tea.ui.*;
import tea.entity.util.*;
import jxl.format.Alignment;
import jxl.format.BorderLineStyle;
import jxl.format.Border;
import jxl.format.Colour;
import jxl.format.VerticalAlignment;

public class EduMembers extends TeaServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request,response);
        String act = h.get("act"),nexturl = h.get("nexturl","");
        if(act.endsWith("exp"))
        {
            response.setContentType("application/octet-stream");
            OutputStream out = response.getOutputStream();
            try
            {
                //页眉
                WritableCellFormat HE = new WritableCellFormat(new WritableFont(WritableFont.ARIAL,20,WritableFont.BOLD));
                HE.setAlignment(Alignment.CENTRE);
                //标题
                WritableCellFormat TH = new WritableCellFormat();
                TH.setBorder(Border.ALL,BorderLineStyle.THIN);
                TH.setBackground(Colour.LIGHT_TURQUOISE2);
                TH.setAlignment(Alignment.CENTRE);
                TH.setVerticalAlignment(VerticalAlignment.CENTRE);
                TH.setWrap(true);
                //日期
                WritableCellFormat DF = new WritableCellFormat(new DateFormat("yyyy-MM-dd HH:mm"));
                if("exp".equals(act)) //导出用户
                {
                    response.setHeader("Content-Disposition","attachment; filename=" + new String("用户.xls".getBytes("GBK"),"ISO-8859-1"));
                    WritableWorkbook wwb = jxl.Workbook.createWorkbook(response.getOutputStream());
                    WritableSheet ws = wwb.createSheet("工作表",0);
                    for(int i = 0;i < 10;i++)
                        ws.setColumnView(i,20);
                    ws.setColumnView(2,10);
                    int col = 0,row = 0;
                    //
                    ws.setRowView(0,500);
                    ws.mergeCells(col,row,9,row);
                    ws.addCell(new Label(col,row++,Community.find(h.community).getName(h.language) + "——用户列表",HE));
                    //
                    ws.addCell(new Label(col++,row,"用户名",TH));
                    ws.addCell(new Label(col++,row,"姓名",TH));
                    ws.addCell(new Label(col++,row,"性别",TH));
                    ws.addCell(new Label(col++,row,"单位",TH));
                    ws.addCell(new Label(col++,row,"职务",TH));
                    ws.addCell(new Label(col++,row,"出生日期",TH));
                    ws.addCell(new Label(col++,row,"手机",TH));
                    ws.addCell(new Label(col++,row,"电话",TH));
                    ws.addCell(new Label(col++,row,"邮箱",TH));
                    ws.addCell(new Label(col++,row,"注册时间",TH));
                    ws.getSettings().setVerticalFreeze(++row);
                    //
                    Enumeration e = Profile.find(h.key,0,Integer.MAX_VALUE);
                    for(;e.hasMoreElements();row++)
                    {
                        String member = (String) e.nextElement();
                        Profile t = Profile.find(member);
                        col = 0;
                        ws.addCell(new Label(col++,row,member));
                        ws.addCell(new Label(col++,row,t.getName(h.language)));
                        ws.addCell(new Label(col++,row,t.isSex() ? "男" : "女"));
                        ws.addCell(new Label(col++,row,t.getOrganization(h.language)));
                        ws.addCell(new Label(col++,row,t.getJob(h.language)));
                        ws.addCell(new DateTime(col++,row,t.getBirth(),DF));
                        ws.addCell(new Label(col++,row,t.getMobile()));
                        ws.addCell(new Label(col++,row,t.getTelephone(h.language)));
                        ws.addCell(new Label(col++,row,t.getEmail()));
                        ws.addCell(new DateTime(col++,row,t.getTime(),DF));
                    }
                    wwb.write();
                    wwb.close();
                }
            } catch(WriteException wex)
            {
            } catch(Exception ex)
            {
                ex.printStackTrace();
            } finally
            {
                out.close();
            }
            return;
        }
        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();
        try
        {
            out.println("<script>var mt=parent.mt,doc=parent.document;</script>");

            String info = h.get("info","操作执行成功！");
            if("reg".equals(act))
            {
                String username = h.get("username");
                if(username == null || Profile.isExisted(username))
                {
                    out.print("<script>mt.show('抱歉“" + username + "”已存在！');</script>");
                    return;
                }
                Profile p = Profile.create(username,h.get("password"),h.community,h.get("email"),request.getServerName());
                p.setFirstName(h.get("name"),h.language);
                p.setSex(h.getBool("sex"));
                p.setOrganization(h.get("org"),h.language);
                p.setJob(h.get("job"),h.language);
                p.setBirth(h.getDate("birth"));
                p.setMobile(h.get("mobile"));
                p.setTelephone(h.get("tel"),h.language);
                p.setCard(h.get("card"));
                p.setPhotopath(h.get("photopath"),h.language);

                //登录
                RV rv = new RV(username);
                Logs.create(h.community,rv,1,h.node,request.getRemoteAddr());
                OnlineList.create(session.getId(),h.community,username,request.getRemoteAddr());
                session.setAttribute("member",p.getProfile());
                h.setCook("member",MT.enc(p.getProfile() + "|" + p.getPassword()), -1);
                out.print("<script>parent.location.replace('" + nexturl + "');</script>");
                return;
            }
            TeaSession ts = new TeaSession(request);
            if(ts._rv == null)
            {
                out.print("<script>parent.location.replace('/servlet/StartLogin?node=" + h.node + "');</script>");
                return;
            }
            h.username = ts._rv._strR;

            if("myedit".equals(act))
            {
                Profile p = Profile.find(h.username);
                p.setEmail(h.get("email"));
                p.setFirstName(h.get("name"),h.language);
                p.setSex(h.getBool("sex"));
                p.setOrganization(h.get("org"),h.language);
                p.setJob(h.get("job"),h.language);
                p.setBirth(h.getDate("birth"));
                p.setMobile(h.get("mobile"));
                p.setTelephone(h.get("tel"),h.language);
                p.setCard(h.get("card"));
                p.setPhotopath(h.get("avatar"),h.language);
            } else
            {
                int member = h.getInt("member");
                if("edit".equals(act))
                {
                    if(member < 1)
                    {
                        String username = h.get("username","");
                        if(username == null || Profile.isExisted(username))
                        {
                            out.print("<script>mt.show('抱歉“" + username + "”已存在！');</script>");
                            return;
                        }
                        member = Profile.create(username,h.get("password"),h.community,h.get("email"),request.getServerName()).getProfile();
                    }
                    Profile p = Profile.find(member);
                    p.setEmail(h.get("email"));
                    p.setFirstName(h.get("name"),h.language);
                    p.setSex(h.getBool("sex"));
                    p.setOrganization(h.get("org"),h.language);
                    p.setJob(h.get("job"),h.language);
                    p.setBirth(h.getDate("birth"));
                    p.setMobile(h.get("mobile"));
                    p.setTelephone(h.get("tel"),h.language);
                    p.setCard(h.get("card"));
                    p.setPhotopath(h.get("avatar"),h.language);
                } else if("clear".equals(act)) //清空密码
                {
                    Profile.find(member).setPassword("");
                } else if("del".equals(act)) //删除用户
                {
                    String[] arr = member < 1 ? h.getValues("members") : new String[]
                                   {String.valueOf(member)};
                    for(int i = 0;i < arr.length;i++)
                    {
                        Profile p = Profile.find(Integer.parseInt(arr[i]));
                        p.delete();
                    }
                }
            }

            out.print("<script>mt.show('" + info + "',1,'" + nexturl + "');</script>");
        } catch(Exception ex)
        {
            out.print("<textarea id='ta'>" + ex.toString() + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }
}
