package tea.ui.util;

import tea.db.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import tea.entity.*;
import tea.entity.member.*;
import tea.entity.node.*;
import tea.entity.site.*;
import tea.ui.*;
import tea.entity.admin.*;
import javax.servlet.ServletConfig;

public class LoginNew extends TeaServlet
{
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        int lt = 0;
        try
        {
            lt = Integer.parseInt(request.getParameter("LoginType"));
        } catch (Exception ex)
        {
        }
        try
        {
            HttpSession session = request.getSession(true);
            TeaSession teasession = new TeaSession(request);
//			String errurl = "/servlet/StartLogin%3FNode%3D" + teasession._nNode;
            String errurl = null;
            if (session.getAttribute("nexturl") == null)
            {
                errurl = "/jsp/admin/logg.jsp";
            } else
            {
                errurl = "/jsp/admin/logg.jsp?nexturl=" + session.getAttribute("nexturl").toString();
            }
            if (lt == 10) // /9000双象卡
            {
                errurl = "/servlet/Node%3FNode%3D" + teasession._nNode;
            }
            String LoginId = teasession.getParameter("LoginId");
            if (LoginId == null || (LoginId = LoginId.trim()).length() < 1)
            {
                response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "InvalidMemberId"), "UTF-8") + "&nexturl=" + errurl);
                return;
            }
            LoginId = LoginId.toLowerCase();

            String sessionvertify = (String) session.getAttribute("sms.vertify");
            String vertify = request.getParameter("vertify");
            if (sessionvertify != null && vertify != null)
            {
                if (!sessionvertify.equals(vertify.trim()))
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "ConfirmCodeError"), "UTF-8") + "&nexturl=" + errurl);
                    return;
                }
            }
            AdminUsrRole aur = AdminUsrRole.find(teasession._strCommunity, LoginId);
            String s1 = request.getParameter("Password");
            String s2 = request.getParameter("nexturl");
//			if (s2 != null)
//			{
//				s2 = "/jsp/profile/tloginsuc.jsp";
//			}
            if (lt == 0) // 会员登陆
            {
                String role = request.getParameter("role");
//                           if(request.getParameter("role")=null && request.getParameter("role").length()>0)
//                               role = Integer.parseInt(request.getParameter("role"));
                if ("2".equals(role))
                { //酒店管理者

//                               if (!AdminUsrRole.isExist(" and member =" + DbAdapter.cite(LoginId) + " and role like " + DbAdapter.cite("/2/") + " "))
//                               {
//                                   response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("您的用户身份还没有审核通过，请等待管理员审核!", "UTF-8"));
//                                   return;
//                               }

                    // String str = AdminUsrRole.findUsrRole(role, LoginId, teasession._strCommunity);
                    s2 = "/jsp/admin/?Node=2180731&Language=1";
                    if (aur.getRole().indexOf("/2/") == -1)
                    {
                        //outText(teasession, response, "您的用户身份可能不正确，请重新选择！<a href=/servlet/Folder?node=2&language=1>返回首页</a> ");
                        response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("您的用户登陆失败，请检查登陆身份是否正确或者是用户名密码不正确，请重新登陆！<a href=/servlet/Folder?node=2&language=1>返回首页</a>", "UTF-8"));
                        return;
                    }
                } else if ("3".equals(role)) //普通用户
                {

//                               String str = AdminUsrRole.findPuTong(LoginId, teasession._strCommunity);
//                               if (str != null)
//                               {
//                                   outText(teasession, response, "您的用户身份不正确，请重新选择！");
//                                   return;
//                               }
                    int valid = Profile.findValid(LoginId);
                    if (valid == 1)
                    {
                        response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("您的帐号已被停用，暂时无法进行登陆！<a href=/servlet/Folder?node=2&language=1>返回首页</a>", "UTF-8"));
                        return;
                    }
                    if (aur.isExists())
                    {
                        //outText(teasession, response, "您的用户身份可能不正确，请重新选择！<a href=/servlet/Folder?node=2&language=1>返回首页</a> ");
                        response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("您的用户登陆失败，请检查登陆身份是否正确或者是用户名密码不正确，请重新登陆！<a href=/servlet/Folder?node=2&language=1>返回首页</a>", "UTF-8"));
                        return;
                    }

                } else if ("4".equals(role)) //话务员
                {
                    if (!Caller.isExistedType(LoginId))
                    {
                        outText(teasession, response, "您的用户身份还没有审核，请等待管理员审核！");
                        return;
                    }
                    if (aur.getRole().indexOf("/" + role + "/") == -1)
                    {
                        outText(teasession, response, "您的用户身份不正确，请重新选择！");
                        return;
                    }

                } else if ("5".equals(role)) //网站管理者
                {
//                               String str = AdminUsrRole.findUsrRole(role, LoginId, teasession._strCommunity);
//                               if (str == null)
//                               {
//                                   outText(teasession, response, "您的用户身份不正确，请重新选择！");
//                                   return;
//                               }
                    //对网站管理员，超级管理员，高级管理员 登陆判断
                    if (aur.getRole().indexOf("/5/") == -1 || aur.getRole().indexOf("/6/") == -1)
                    {
                        //outText(teasession, response, "您的用户身份可能不正确，请重新选择！<a href=/servlet/Folder?node=2&language=1>返回首页</a> ");
                        response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("您的用户登陆失败，请检查登陆身份是否正确或者是用户名密码不正确，请<a href=/jsp/admin/log.jsp>重新登陆</a>", "UTF-8"));
                        return;
                    }
                }
            } else if (lt == 1) // 手机登陆
            {
                LoginId = Profile.numtoid(LoginId);
            } else if (lt == 2) // email登录
            {
                LoginId = Profile.findByEmail(LoginId, teasession._strCommunity);
                if (LoginId == null)
                {
                    outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidEmail"));
                    return;
                }
            }
            RV rv = new RV(LoginId);
            if (!rv.isExisted())
            {
                response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "InvalidMemberId"), "UTF-8") + "&nexturl=" + errurl);
                return;
            }

            if (!Profile.isPassword(rv._strV, s1)) // lt,
            {
                response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "InvalidPassword"), "UTF-8") + "&nexturl=" + errurl);
                return;
            }
            // 对企业会员的判断(末审核以前不能登陆)
            ProfileEnterprise pe = ProfileEnterprise.find(LoginId, teasession._strCommunity);
            if (pe.isExists())
            {
                if (!pe.isAuditing())
                {
                    outText(teasession, response, "对不起,你的账号还没有审核,审核之后才可以登陆,请等待...");
                    return;
                } else if (System.currentTimeMillis() - pe.getValid().getTime() > 0)
                {
                    outText(teasession, response, "对不起,你的账号已过期,你不可以登陆.");
                    return;
                }
            }
            Logs.create(teasession._strCommunity, rv, 1, teasession._nNode, request.getRemoteAddr()); //记录用户登陆信息
            OnlineList ol_obj = OnlineList.find(session.getId()); //添加到用户临时表中
            ol_obj.setMember(LoginId);
            session.setAttribute("tea.RV", rv); //创建用户登陆 session
            session.setAttribute("LoginId", LoginId);
            session.setAttribute("password", s1);
            if (s2 == null)
            {
                Profile obj = Profile.find(LoginId);
                String url = obj.getStartUrl(teasession._nLanguage);
                if (url != null && url.length() > 0)
                {
                    response.sendRedirect(url);
                    return;
                }
            }
            if (!rv._strR.equals(rv._strV))
            {
                String s4 = Associate.find(rv._strR, rv._strV).getStartUrl();
                if (s4 != null && s4.length() != 0)
                {
                    s2 = s4;
                }
            }

            if (s2 == null)
            {
                s2 = "/jsp/profile/loginsuc.jsp";
            }
            response.sendRedirect(s2);
        } catch (Exception ex)
        {
            response.sendError(400, ex.toString());
            ex.printStackTrace();
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("/tea/ui/node/type/sms/EditUser");
    }
}
