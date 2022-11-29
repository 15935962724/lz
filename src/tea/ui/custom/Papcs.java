package tea.ui.custom;

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
import tea.entity.admin.SupExpert;
import tea.entity.custom.papc.*;

public class Papcs extends TeaServlet
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
                int type = h.getInt("type");
                String sname = type == 0 ? "sms.vertify" : "verify";
                if(!h.get("verify" + type,"").equalsIgnoreCase((String) session.getAttribute(sname)))
                {
                    out.print("<script>mt.show('抱歉“验证码”不正确！');</script>");
                    return;
                }
                session.removeAttribute(sname);

                //注册
                Profile p = Profile.create(username,h.get("password"),h.community,h.get("email"),request.getServerName());
                if(type == 0) //普通会员
                {
                } else if(type == 2) //成员单位
                {
                    p.setFirstName(h.get("name"),h.language);
                    p.setSex(h.getBool("sex"));
                }
                p.setMobile(h.get("mobile" + type));
                p.setType(type);

                //登录
                RV rv = new RV(username);
                Logs.create(h.community,rv,1,h.node,request.getRemoteAddr());
                OnlineList.create(session.getId(),h.community,username,request.getRemoteAddr());
                session.setAttribute("member",p.getProfile());
                h.setCook("member",MT.enc(p.getProfile() + "|" + p.getPassword()), -1);
                out.print("<script>parent.location.replace('" + nexturl + "');</script>");
                return;
            }else if("dpxreg".equals(act))
            {
                String username = h.get("username");
                if(username == null || Profile.isExisted(username))
                {
                    out.print("<script>mt.show('抱歉“" + username + "”已存在！');</script>");
                    return;
                }
                int type = h.getInt("type");
                String sname = "verify";
                if(!h.get("verify").equalsIgnoreCase((String) session.getAttribute(sname)))
                {
                    out.print("<script>mt.show('抱歉“验证码”不正确！');</script>");
                    return;
                }
                session.removeAttribute(sname);

                //注册
                Profile p = Profile.create(username,h.get("password"),h.community,h.get("email"),request.getServerName());
                if(type == 0) //普通会员
                {
                } else if(type == 1) //专家
                {
                	p.setOrganization(h.get("org"), h.language);
            		p.setJob(h.get("job"), h.language);
            		p.setTitle(h.get("title"), h.language);
            		p.setMembertype(4);
            		p.setSex(false);
            		p.setProvince(h.getInt("city1", h.getInt("city0")), h.language);
                    /*p.setFirstName(h.get("name"),h.language);
                    p.setSex(h.getBool("sex"));*/
            		SupExpert supExpert = new SupExpert(p.profile);
            		supExpert.deleted = false;
            		supExpert.type = 1;
            		supExpert.setAudit(4);
            		supExpert.set();
                }
                /*p.setMobile(h.get("mobile" + type));*/
                p.setType(type);

                //登录
                RV rv = new RV(username);
                Logs.create(h.community,rv,1,h.node,request.getRemoteAddr());
                OnlineList.create(session.getId(),h.community,username,request.getRemoteAddr());
                session.setAttribute("member",p.getProfile());
                h.setCook("member",MT.enc(p.getProfile() + "|" + p.getPassword()), -1);
                out.print("<script>parent.parent.location.replace('" + nexturl + "');</script>");
                return;
            }else if("dpxlogin".equals(act)){
            	String member = h.get("username");
            	String password = h.get("password");
            	int utype = h.getInt("utype");
            	
                    /*String verify = h.get("verify");
                    String str = h.getCook("verify",null);
                    if((str != null || verify != null) && (str == null || !MT.dec(str).equalsIgnoreCase(verify)))
                    {
                        out.print("<script>alert('抱歉，验证码错误！');</script>");
                        return;
                    }
                    h.setCook("verify",null,0);*/
                    //
                    if(!Profile.isPassworddpx(member,password,utype))
                    {
                        out.print("<script>mt.show('用户名或密码错误！');</script>");
                        return;
                    }
                    Profile p = Profile.find(member);
                    if(p.isLocking())
                    {
                        out.print("<script>mt.show('该用户已被锁定，暂时无法登录！');</script>");
                        return;
                    }
                    RV rv = new RV(member);
                    Logs.create(h.community,rv,1,h.node,request.getRemoteAddr());
                    //OnlineList.create(session.getId(),h.community,member,request.getRemoteAddr());
                    Community c = Community.find(h.community);
                    h.member = p.getProfile();
                    session.setAttribute("member",h.member);
                    if(c.isSession())
                    {
                        //session.setAttribute("tea.RV",rv);
                    } else
                    {
                        h.setCook("member",MT.enc(p.getLogint() + "|" + h.member + "|" + p.getPassword()),h.getInt("expiry", -1));
                    }
                    out.print("<script>mt.show('" + info + "',1,'/index.jsp');</script>");//parent
                    return;
                
            }/*else if("zjreg".equals(act)){

        		out.print("<script>var mt=parent.mt;</script>");
        		if (!h.get("verify").equalsIgnoreCase(
        				(String) session.getAttribute("sms.vertify"))) {
        			out.print("<script>mt.show('验证码不正确。')</script>");
        			return;
        		}
        		String member = h.get("member");
        		if (Profile.isExisted(member)) {
        			out.print("<script>mt.show('该会员名已被使用。')</script>");
        			return;
        		}
        		Profile.createzj(member, h.get("password"), h.community, h
        				.get("jczw"), h.get("yjfx"), request.getServerName());
        		Profile p = Profile.find(member);
        		p.setOrganization(h.get("org"), h.language);
        		p.setJob(h.get("job"), h.language);
        		p.setTitle(h.get("title"), h.language);
        		p.setMembertype(4);
        		p.setSex(false);
        		p.setProvince(h.getInt("city1", h.getInt("city0")), h.language);
        		SupExpert supExpert = new SupExpert(p.profile);
        		supExpert.deleted = false;
        		supExpert.type = 1;
        		supExpert.setAudit(4);
        		supExpert.set();
        		session.setAttribute("tea.RV", new RV(member));
        		session.setAttribute("member", p.getProfile());
        		 
        		out
        				.print("<script>mt.show('/jsp/info/SucInfo.jsp',1,'',600,500);</script>");
        		return;
        	
            }*/ else if("send".equals(act))
            {
                String mobile = h.get("mobile");
                String verify = (Math.random() + "000000").substring(2,8);
                session.setAttribute("verify",verify);
                int[] rs = SMessage.send(1,"|","|" + mobile + "|","欢迎使用中国自然保护区标本资源共享平台服务，请在页面输入验证码：" + verify + "【中国林业科学研究院】",new CharArrayWriter());
                out.print(rs == null || rs[0] == 0 ? "发送失败！" : "验证码已发送，请注意查收。");
                return;
            }
            if(h.member < 1)
            {
                out.print("<script>parent.location.replace('/servlet/StartLogin?node=" + h.node + "');</script>");
                return;
            }

            if("myedit".equals(act))
            {
                Profile p = Profile.find(h.member);
                p.setEmail(h.get("email"));
                p.setFirstName(h.get("name"),h.language);
                p.setSex(h.getBool("sex"));
                p.setOrganization(h.get("org"),h.language);
                p.setJob(h.get("job"),h.language);
                p.setMobile(h.get("mobile"));
                p.setTelephone(h.get("tel"),h.language);
                p.setWebPage(h.get("webpage"),h.language);
                p.setPhotopath(h.get("avatar"),h.language);
            } else if("appedit".equals(act))
            {
                PapcApp t = new PapcApp(0);
                t.member = h.member;
                t.name = h.get("name");
                t.email = h.get("email");
                t.tel = h.get("tel");
                t.position = h.getInt("position");
                t.country = h.getInt("country");
                t.address = h.get("address");
                t.org = h.get("org");
                t.project = h.get("project");
                t.leader = h.get("leader");
                t.purpost = h.get("purpost");
                t.content = h.get("content");
                t.commitment = h.get("commitment");
                t.ip = request.getRemoteAddr();
                t.time = new Date();
                t.set();
            } else if("appdel".equals(act)) //前台删除
            {
                int papcapp = h.getInt("papcapp");
                PapcApp t = PapcApp.find(papcapp);
                if(t.member == h.member)
                    t.delete();
            } else if("appdels".equals(act)) //后台删除
            {
                int papcapp = h.getInt("papcapp");
                String[] arr = papcapp < 1 ? h.getValues("papcapps") : new String[]
                               {String.valueOf(papcapp)};
                for(int i = 0;i < arr.length;i++)
                {
                    PapcApp t = PapcApp.find(Integer.parseInt(arr[i]));
                    t.delete();
                }
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
