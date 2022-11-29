package tea.ui.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.*;
import tea.entity.*;
import tea.entity.member.*;
import tea.entity.node.*;
import tea.resource.Resource;

public class EditProfilePostulant extends HttpServlet
{
    //Initialize global variables
    public void init() throws ServletException
    {
    }

    //Process the HTTP Get request
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            Http h = new Http(request);
            String act = h.get("act");
            if(h.member < 1 && !"reg".equals(act))
            {
                response.sendRedirect("/servlet/StartLogin?community=" + h.community + "&nexturl=" + java.net.URLEncoder.encode(request.getHeader("referer"),"UTF-8"));
                return;
            }
            Resource r = new Resource("/tea/resource/ProfilePostulant").add("/tea/ui/util/SignUp1");
            String nexturl = h.get("nexturl");
            if("setcode".equals(act))
            {
                String code_old = request.getParameter("code_old");
                String code = request.getParameter("code").toLowerCase();
                if(!code.equals(code_old))
                {
                    if(ProfilePostulant.isExists(code,h.community))
                    {
                        response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(h.language,"编号已经存在."),"UTF-8"));
                        return;
                    }
                    String member = request.getParameter("member");
                    ProfilePostulant pp = ProfilePostulant.find(member,h.community);
                    pp.setCode(code);
                }
            } else
            if("setauditing".equals(act))
            {
                boolean auditing = "true".equals(request.getParameter("auditing"));
                String member = request.getParameter("member");
                ProfilePostulant pp = ProfilePostulant.find(member,h.community);
                pp.setAuditing(auditing);
            } else
            if("setpoint".equals(act))
            {
                int point = Integer.parseInt(request.getParameter("point"));
                String member = request.getParameter("member");
                ProfilePostulant pp = ProfilePostulant.find(member,h.community);
                pp.setPoint(point);
            } else
            if("delete".equals(act))
            {
                String member = request.getParameter("member");
                ProfilePostulant pp = ProfilePostulant.find(member,h.community);
                pp.delete();
            } else
            if("export".equals(act))
            {
                response.setContentType("application/x-msdownload");
                response.setHeader("Content-Disposition","attachment; filename=" + new String("志愿者数据.xls".getBytes("GBK"),"ISO-8859-1"));
                String sql = request.getParameter("sql");
                jxl.write.WritableWorkbook wwb = jxl.Workbook.createWorkbook(response.getOutputStream());
                jxl.write.WritableSheet ws = wwb.createSheet("www.redcome.com",0);
                ws.addCell(new jxl.write.Label(0,0,"会员编号"));
                ws.addCell(new jxl.write.Label(1,0,"会员ID"));
                ws.addCell(new jxl.write.Label(2,0,"姓名"));
                ws.addCell(new jxl.write.Label(3,0,"性别"));
                ws.addCell(new jxl.write.Label(4,0,"E-Mail"));
                ws.addCell(new jxl.write.Label(5,0,"电话/手机"));
                ws.addCell(new jxl.write.Label(6,0,"报名方式"));
                ws.addCell(new jxl.write.Label(7,0,"状态"));
                ws.addCell(new jxl.write.Label(8,0,"报名时间"));
                java.util.Enumeration e = ProfilePostulant.find(h.community,sql,0,Integer.MAX_VALUE);
                for(int i = 1;e.hasMoreElements();i++)
                {
                    String member = (String) e.nextElement();
                    Profile p = Profile.find(member);
                    ProfilePostulant pp = ProfilePostulant.find(member,h.community);
                    ws.addCell(new jxl.write.Label(0,i,pp.getCode()));
                    ws.addCell(new jxl.write.Label(1,i,member));
                    ws.addCell(new jxl.write.Label(2,i,p.getLastName(h.language) + p.getFirstName(h.language)));
                    ws.addCell(new jxl.write.Label(3,i,p.isSex() ? "男" : "女"));
                    ws.addCell(new jxl.write.Label(4,i,p.getEmail()));
                    ws.addCell(new jxl.write.Label(5,i,p.getTelephone(h.language) + " " + p.getMobile()));
                    ws.addCell(new jxl.write.Label(6,i,pp.SIGNUP_TYPE[pp.getStype()]));
                    ws.addCell(new jxl.write.Label(7,i,pp.isAuditing() ? "批准" : "拒绝"));
                    ws.addCell(new jxl.write.Label(8,i,String.valueOf(p.getTime())));
                }
                wwb.write();
                wwb.close();
                return;
            } else
            {
                String member = request.getParameter("member").toLowerCase();
                javax.servlet.http.HttpSession session = request.getSession(true);
                String vertify = (String) session.getAttribute("sms.vertify");
                String vertify1 = h.get("vertify").trim();
                if(!vertify1.equals(vertify))
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(h.language,"ConfirmCodeError"),"UTF-8"));
                    return;
                }
                String psw = h.get("ConfirmPassword");
                String email = h.get("email");
                Profile profile = null;
                if("edit".equals(act) || "bgedit".equals(act))
                {
                    profile = Profile.find(member);
                    if(psw != null)
                    {
                        profile.setPassword(psw);
                    }
                } else
                {
                    if(Profile.isExisted(member))
                    {
                        response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(tea.http.RequestHelper.format(r.getString(h.language,"RepetitionRegisters"),member),"UTF-8"));
                        return;
                    }
                    String sn = request.getServerName() + ":" + request.getServerPort();
                    profile = Profile.create(member,psw,h.community,email,sn);
                }
                profile.setEmail(email);
                boolean sex = Integer.parseInt(h.get("sex")) != 0;
                profile.setSex(sex);
                String firstname = h.get("firstname");
                if(firstname != null)
                {
                    profile.setFirstName(firstname,h.language);
                }
                String card = h.get("card");
                if(card != null)
                {
                    profile.setCard(card);
                }
                String telephone = h.get("telephone");
                if(telephone != null)
                {
                    profile.setTelephone(telephone,h.language);
                }
                String _strYear = request.getParameter("birthYear");
                if(_strYear != null)
                {
                    java.util.Date birth = Profile.sdf.parse(_strYear + "-" + request.getParameter("birthMonth") + "-" + request.getParameter("birthDay"));
                    profile.setBirth(birth);
                }
                String degree = request.getParameter("degree");
                if(degree != null)
                {
                    profile.setDegree(degree,h.language);
                }
                String job = request.getParameter("job");
                if(job != null)
                {
                    profile.setJob(job,h.language);
                }
                String address = request.getParameter("address");
                if(address != null)
                {
                    profile.setAddress(address,h.language);
                }
                String zip = request.getParameter("zip");
                if(zip != null)
                {
                    profile.setZip(zip,h.language);
                }
                String mobile = request.getParameter("mobile");
                if(mobile != null)
                {
                    profile.setMobile(mobile);
                }
                String _strCityzone = request.getParameter("cityzone");
                if(_strCityzone != null)
                {
                    int street = Integer.parseInt(request.getParameter("street"));
                    String comm = request.getParameter("comm");
                    String saddress = request.getParameter("saddress");
                    String event = request.getParameter("event");
                    String info = request.getParameter("info");
                    String _strStype = request.getParameter("stype");
                    int stype = 0; //网上注册
                    if(_strStype != null)
                    {
                        stype = Integer.parseInt(_strStype);
                    }
                    String remark = request.getParameter("remark");
                    ProfilePostulant pp = ProfilePostulant.find(member,h.community);
                    if(pp.isExists())
                    {
                        pp.set(Integer.parseInt(_strCityzone),street,comm,saddress,event,info,stype,remark);
                    } else
                    {
                        ProfilePostulant.create(member,h.community,Integer.parseInt(_strCityzone),street,comm,saddress,event,info,stype,remark);
                    }
                }

                if("reg".equals(act))
                {
                    BBS.send(h,profile);
                    response.sendRedirect("/jsp/user/regsuccess.jsp?node=" + h.node);
                    return;
                }
            }
            response.sendRedirect("/jsp/info/Succeed.jsp?community=" + h.community + "&nexturl=" + java.net.URLEncoder.encode(nexturl,"UTF-8"));
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }

    }

    //Clean up resources
    public void destroy()
    {
    }
}
