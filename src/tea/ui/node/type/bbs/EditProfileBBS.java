package tea.ui.node.type.bbs;

import javax.servlet.*;
import javax.servlet.http.*;

import java.io.*;
import java.util.*;
import tea.entity.*;
import tea.entity.node.*;
import tea.ui.TeaSession;
import tea.entity.member.*;
import tea.entity.site.*;
import tea.service.SMS;
import java.security.NoSuchAlgorithmException;

public class EditProfileBBS extends tea.ui.TeaServlet
{
    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        r.add("tea/ui/util/SignUp1").add("/tea/ui/node/type/sms/EditUser");
    }

    // Process the HTTP Get request
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        Http h = new Http(request);
        TeaSession teasession = new TeaSession(request);
        try
        {
            String act = h.get("act");
            String nu = h.get("nexturl");
            boolean _bAffirm = h.get("affirm") != null;
            boolean _bCancel = h.get("cancel") != null;
            String MemberId = h.get("MemberId");

            boolean _bSend = h.get("sendaffirmemail") != null;
            if(_bAffirm) // 确认会员
            {
                MemberId = h.get("member");
                if(!Profile.isExisted(MemberId))
                { // 1169607402250=该会员不存在或已经取消了验证. <A href="/">回首页</A> <A href="javascript:window.opener=null;windown.close();">关闭</A>
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"1169607402250"),"UTF-8"));
                    return;
                }
                ProfileBBS pb = ProfileBBS.find(h.community,MemberId);
                if(pb.isValidate())
                { // 1169607851484=该会员已经通过验证了,无需在此验证. <A href="/">回首页</A> <A href="javascript:window.opener=null;windown.close();">关闭</A>
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"1169607851484"),"UTF-8"));
                    return;
                }
                Profile profile = Profile.find(MemberId);
                String dig = BBS.md5(MemberId + profile.getTime().getTime());
                String validate = h.get("validate");
                if(dig.equals(validate))
                {
                    pb.setValidate(true);
                    response.sendRedirect("/jsp/info/Succeed.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"ValidateSucceed"),"UTF-8"));
                } else
                {
                    // 1169607769453=验证码错误. <A href="/">回首页</A> <A href="javascript:window.opener=null;windown.close();">关闭</A>
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"1169607769453"),"UTF-8"));
                }
                return;
            } else // 取消会员
            if(_bCancel)
            {
                MemberId = h.get("member");
                if(!Profile.isExisted(MemberId))
                { // 1169607402250=该会员不存在或已经取消了验证. <A href="/">回首页</A> <A href="javascript:window.opener=null;windown.close();">关闭</A>
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"1169607402250"),"UTF-8"));
                    return;
                }
                ProfileBBS pb = ProfileBBS.find(h.community,MemberId);
                if(pb.isValidate())
                { // 1169607667296=该会员已经验证了,不能取消. <A href="/">回首页</A> <A href="javascript:window.opener=null;windown.close();">关闭</A>
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"1169607667296"),"UTF-8"));
                    return;
                }
                Profile profile = Profile.find(MemberId);
                String dig = BBS.md5(MemberId + profile.getTime().getTime());
                String validate = h.get("validate");
                if(dig.equals(validate))
                {
                    if(request.getParameter("ok") == null)
                    {
                        response.setContentType("text/html;charset=UTF-8");
                        java.io.PrintWriter out = response.getWriter();
                        out.print("<HTML><HEAD>                                                                       ");
                        out.print("<link href=/res/" + h.community + "/cssjs/community.css rel=stylesheet type=text/css>             ");
                        out.print("<SCRIPT LANGUAGE=JAVASCRIPT SRC=/tea/tea.js  ></SCRIPT>                            ");
                        out.print("<meta http-equiv=Content-Type content=text/html; charset=UTF-8 >                   ");
                        out.print("</HEAD>                                                                            ");
                        out.print("<body>                                                                             ");
                        out.print("<h1>" + r.getString(teasession._nLanguage,"INFO") + "</h1>                            ");
                        out.print("<div id=head6><img height=6></div>                                                 ");
                        out.print("<form action=\"/servlet/EditProfileBBS\" method=post >");
                        out.print("<input type=hidden name=validate2 value=" + request.getParameter("validate2") + " >");
                        out.print("<input type=hidden name=validate value=" + validate + " >");
                        out.print("<input type=hidden name=member value=" + MemberId + " >");
                        out.print("<input type=hidden name=community value=" + h.community + " >");
                        out.print("<input type=hidden name=Node value=" + teasession._nNode + " >");
                        out.print("<input type=hidden name=cancel value=ON >");
                        out.print("<table border=0 cellpadding=0 cellspacing=0 id=tablecenter >                       ");
                        out.print("<tr><td>" + r.getString(teasession._nLanguage,"MemberId") + "</td><td>" + MemberId + "</td></tr>                    ");
                        out.print("<tr><td>" + r.getString(teasession._nLanguage,"EmailAddress") + "</td><td>" + profile.getEmail() + "</td></tr>                    ");
                        out.print("<tr><td>" + r.getString(teasession._nLanguage,"1169608574768") + "</td><td>" + profile.getTime() + "</td></tr>                    ");
                        out.print("<tr><td colspan=2 align=center>" + r.getString(teasession._nLanguage,"1169608574765") + "</td></tr>");
                        out.print("<tr><td colspan=2 align=center><input type=submit name=ok value=" + r.getString(teasession._nLanguage,"1169608574766") + ">  <input type=button value=" + r.getString(teasession._nLanguage,"1169608574767") + " onclick=\" window.opener=null;window.open('/','_self'); \" ></td></tr></table>");
                        out.print("</form></DIV>                                                                             ");
                        out.print("<div id=head6><img height=6></div>                                                 ");
                        out.print("</body>                                                                            ");
                        out.print("</HTML>                                                                            ");
                        out.close();
                    } else
                    {
                        profile.delete(teasession._nLanguage);
                        response.sendRedirect("/jsp/info/Succeed.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"CancelSucceed"),"UTF-8"));
                    }
                } else
                {
                    // 1169607769453=验证码错误. <A href="/">回首页</A> <A href="javascript:window.opener=null;windown.close();">关闭</A>
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"1169607769453"),"UTF-8"));
                }
                return;
            } else // 重新发送E-Mail
            if(_bSend)
            {
                if(teasession._rv == null)
                {
                    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                    return;
                }
                Profile profile = Profile.find(teasession._rv._strV);
                boolean bool = BBS.send(h,profile);
                if(bool)
                {
                    response.sendRedirect("/jsp/info/Succeed.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"EmailSend"),"UTF-8"));
                } else
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"EmailSendErr"),"UTF-8"));
                }
                return;
            } else // 注册论坛会员
            if(MemberId != null)
            {
                MemberId = MemberId.toLowerCase();
                /*
                 * for(int index=0;index<s1.length();index++) if(s1.charAt(index)>='A'&&s1.charAt(index)<='Z') s1=s1.substring(0,index)+(char)(s1.charAt(index)+32)+ s1.substring(index+1);
                 */
                javax.servlet.http.HttpSession session = request.getSession(true);
                String vertify = (String) session.getAttribute("sms.vertify");
                String vertify1 = h.get("vertify").trim();
                if(!vertify1.equals(vertify))
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"ConfirmCodeError"),"UTF-8"));
                    return;
                }
                if(Profile.isExisted(MemberId))
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(tea.http.RequestHelper.format(r.getString(teasession._nLanguage,"RepetitionRegisters"),MemberId),"UTF-8"));
                    return;
                }
                String psw = h.get("ConfirmPassword");
                String email = h.get("Email");
                String sn = request.getServerName() + ":" + request.getServerPort();
                Profile profile = Profile.create(MemberId,psw,h.community,email,sn);

                boolean sex = Integer.parseInt(h.get("sex")) != 0;
                profile.setSex(sex);

                String firstname = h.get("firstname");
                if(firstname != null)
                {
                    profile.setFirstName(firstname,teasession._nLanguage);
                }

                String card = h.get("card");
                if(card != null)
                {
                    profile.setCard(card);
                }

                String telephone = h.get("telephone");
                if(telephone != null)
                {
                    profile.setTelephone(telephone,teasession._nLanguage);
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
                    profile.setDegree(degree,teasession._nLanguage);
                }

                String job = request.getParameter("job");
                if(job != null)
                {
                    profile.setJob(job,teasession._nLanguage);
                }

                String address = request.getParameter("address");
                if(address != null)
                {
                    profile.setAddress(address,teasession._nLanguage);
                }

                String zip = request.getParameter("zip");
                if(zip != null)
                {
                    profile.setZip(zip,teasession._nLanguage);
                }

                String mobile = request.getParameter("mobile");
                if(mobile != null)
                {
                    profile.setMobile(mobile);
                }
                /*
                 * String _strCityzone = request.getParameter("cityzone"); if (_strCityzone != null) { String street = request.getParameter("street"); String comm = request.getParameter("comm"); String saddress = request.getParameter("saddress"); String event = request.getParameter("event"); String info = request.getParameter("info"); int stype = 0; //网上注册 String remark = request.getParameter("remark"); ProfilePostulant.create(MemberId, community, Integer.parseInt(_strCityzone), street, comm,
                 * saddress, event, info, stype, remark); }
                 */
                // BBS.send(teasession, profile);//发送邮件
                RV rv = new RV(MemberId);
                Profile p = Profile.find(MemberId);
                Cookie cs = new Cookie("tea.RV",java.net.URLEncoder.encode(MemberId + "," + SMS.md5(String.valueOf(p.getTime().getTime())),"UTF-8"));
                cs.setPath("/");
                String sn2 = request.getServerName();
                int j = sn2.indexOf(".");
                if(j != -1 && sn2.charAt(sn2.length() - 1) > 96)
                {
                    cs.setDomain(sn2.substring(j));
                }
                response.addCookie(cs);

                if(nu == null)
                {
                    nu = "/jsp/user/regsuccess.jsp?node=" + teasession._nNode;
                }
                response.sendRedirect(nu);
                return;
            } else
            {
                if(teasession._rv == null)
                {
                    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                    return;
                }
                if("isign".equals(act)) //
                {
                    String isign = h.getBool("clear") ? "" : h.get("isign");
                    if(isign != null)
                    {
                        ProfileBBS pb = ProfileBBS.find(h.community,teasession._rv._strV);
                        pb.setISign(teasession._nLanguage,isign);
                    }
                } else if("allisign".equals(act)) // /jsp/admin/office/AllProfileISign.jsp
                {
                    String[] param = h.get("param").split("/");
                    for(int i = 1;i < param.length;i++)
                    {
                        String v = h.getBool("clear_" + param[i]) ? "" : h.get(param[i]);
                        if(v == null)
                            continue;
                        ProfileBBS.find(h.community,java.net.URLDecoder.decode(param[i].replace('_','%'),"utf-8")).setISign(h.language,v);
                    }
                } else
                {
                    String title = h.get("title");
                    String portrait = h.get("portrait",h.get("portraitpath"));
                    String signature = h.get("signature");
                    if(signature.length() > 200)
                        signature = signature.substring(0,200);
                    ProfileBBS pb = ProfileBBS.find(h.community,teasession._rv._strV);
                    pb.set(h.language,title,portrait,signature);
                }
                response.sendRedirect("/jsp/info/Succeed.jsp?info=" + java.net.URLEncoder.encode(r.getString(h.language,"UpdateSuccessful"),"UTF-8"));
            }
        } catch(Exception ex)
        {
            ex.printStackTrace();
            response.sendRedirect("/jsp/info/Error.jsp?info=" + ex.getMessage());
        }
    }

    // Clean up resources
    public void destroy()
    {
    }
}
