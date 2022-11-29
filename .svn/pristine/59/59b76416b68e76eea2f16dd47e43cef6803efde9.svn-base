package tea.ui.member.profile;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import tea.ui.*;
import tea.entity.*;
import tea.entity.bpicture.*;
import tea.entity.member.*;

import java.util.Date;
import java.math.BigDecimal;
import java.text.*;
import java.sql.*;

public class EditProfileZh extends TeaServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");

        TeaSession teasession = new TeaSession(request);
        String type = teasession.getParameter("type");
        String nexturl = teasession.getParameter("nexturl");

        try
        {
            String member = teasession.getParameter("member");
            String password = teasession.getParameter("password");
            if(type.equals("uppwd"))
            {

                String newpwd = request.getParameter("newpwd");

                Profile p = Profile.find(member);
                p.setPassword(newpwd);
                response.sendRedirect("/jsp/user/EditProfileZhPwd.jsp");
            }
            if(type.equals("regstyle"))
            {
                String regstyle = request.getParameter("regstyle");
                int reg = Integer.parseInt(regstyle);
                int pur = 64;
                if(reg == 1)
                {
                    pur = 65;
                }
                if(reg == 2)
                {
                    pur = 66;
                }
                if(reg == 3)
                {
                    pur = 67;
                }

                ProfileZh.set(member,reg);
                ProfileZh.setAccess(member,pur);
                response.sendRedirect("/jsp/user/ApprovalPer.jsp");
            }

            String name = teasession.getParameter("name");
            String email = teasession.getParameter("email");
            String mobile = teasession.getParameter("mobile");
            int sex = Integer.parseInt(teasession.getParameter("sex"));
            String sbirth = teasession.getParameter("birth");
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date d = sdf.parse(sbirth);
            String nationnal = teasession.getParameter("national");
            String nactive = teasession.getParameter("nactive");
            String bplace = teasession.getParameter("bplace");
            String political = teasession.getParameter("political");
            String card = teasession.getParameter("card");

            byte by[] = teasession.getBytesParameter("photo"); //图片
            String photo = null;
            if(by != null)
            {
                photo = super.write(teasession._strCommunity,by,".gif");
            }
            String phtot = teasession.getParameter("phtot");
            String ph = null;
            if(photo == null)
            {
                ph = phtot;
            } else
            {
                ph = photo;
            }

            String faddr = teasession.getParameter("faddr");
            String zip = teasession.getParameter("zip");
            String homephone = teasession.getParameter("homephone");

            String web = teasession.getParameter("web");
            String comname = teasession.getParameter("comname");
            String job = teasession.getParameter("job");
            String comphone = teasession.getParameter("comphone");
            String fax = teasession.getParameter("fax");
            String comaddr = teasession.getParameter("comaddr");
            String comzip = teasession.getParameter("comzip");
            String otherjob = teasession.getParameter("otherjob");
            String cper = teasession.getParameter("cper");
            String cjob = teasession.getParameter("cjob");
            String cphone = teasession.getParameter("cphone");
            String cfax = teasession.getParameter("cfax");

            String zs0 = teasession.getParameter("zipsend0");
            if(zs0 == null)
            {
                zs0 = "";
            }
            String zs1 = teasession.getParameter("zipsend1");
            if(zs1 == null)
            {
                zs1 = "";
            }

            String zs = zs0 + "/" + zs1;
            String is0 = teasession.getParameter("infosend0");
            if(is0 == null)
            {
                is0 = "";
            }
            String is1 = teasession.getParameter("infosend1");
            if(is1 == null)
            {
                is1 = "";
            }

            String is = is0 + "/" + is1;

            StringBuffer resume = new StringBuffer(",");
            String date = null,com = null,jobb = null;
            for(int i = 1;i <= 10;i++)
            {
                date = teasession.getParameter("date" + i);
                if(date == null || date.length() == 0)
                {
                    date = "　";
                }

                com = teasession.getParameter("com" + i);
                if(com == null || com.length() == 0)
                {
                    com = "　";
                }

                jobb = teasession.getParameter("job" + i);
                if(jobb == null || jobb.length() == 0)
                {
                    jobb = "　";
                }

                resume.append(date).append("`").append(com).append("`").append(jobb).append(",");
            }

            int isopen = 0;

            int regstyle = 0;
            if(teasession.getParameter("regstyle")!=null){
                regstyle = Integer.parseInt(teasession.getParameter("regstyle"));
            }
            String open = teasession.getParameter("isopen");
            if(open != null && open.length() > 0)
            {
                isopen = Integer.parseInt(open);
            }
            boolean bsex = sex == 1;

            if(type.equals("regist"))
            {
                ProfileZh.create(member,password,teasession._strCommunity,email,mobile,bsex,sbirth);

                ProfileZh.create(member,name,nationnal,nactive,bplace,political,card,photo,faddr,zip,homephone,web,comname,job,comphone,fax,comaddr,comzip,otherjob,cper,cjob,cphone,cfax,zs,is,resume.toString(),isopen,regstyle);
                //System.out.println("注册成功");

                response.sendRedirect("/jsp/info/Alert_Interlocution.jsp?info=&nbsp;&nexturl=" + nexturl);
            } else
            {
                System.out.println("编辑会员资料："+member);
                Profile p = Profile.find(member);
                p.setMobile(mobile);
                p.setEmail(email);
                p.setSex(bsex);
                p.setBirth(d);
                ProfileZh.set(member,name,nationnal,nactive,bplace,political,card,ph,faddr,zip,homephone,web,comname,job,comphone,fax,comaddr,comzip,otherjob,cper,cjob,cphone,cfax,zs,is,resume.toString(),isopen);
                response.sendRedirect(nexturl);
            }
        } catch(Exception ex)
        {
            ex.getStackTrace();
        }
    }
}

