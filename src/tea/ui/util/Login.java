package tea.ui.util;

import java.io.IOException;
import java.util.Date;
import java.util.Enumeration;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import tea.db.DbAdapter;
import tea.entity.Entity;
import tea.entity.*;
import tea.entity.admin.AdminUsrRole;
import tea.entity.admin.mov.MemberOrder;
import tea.entity.admin.orthonline.ProfileOrth;
import tea.entity.bpicture.Bperson;
import tea.entity.integral.IntegralRecord;
import tea.entity.member.Associate;
import tea.entity.member.Logs;
import tea.entity.member.OnlineList;
import tea.entity.member.Profile;
import tea.entity.member.ProfileEnterprise;
import tea.entity.member.ProfileZh;
import tea.entity.site.Community;
import tea.entity.site.CommunityOption;
import tea.entity.site.Subscriber;
import tea.service.SMS;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class Login extends TeaServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        java.io.PrintWriter out = response.getWriter();
        r.add("/tea/resource/Photography");

        int lt = 0;
        try
        {
            lt = Integer.parseInt(request.getParameter("LoginType"));
        } catch(Exception ex)
        {
        }
        try
        {

            TeaSession teasession = new TeaSession(request);
            String errurl = "/servlet/StartLogin%3FNode%3D" + teasession._nNode;
            if(lt == 10) // /9000双象卡
            {
                errurl = "/servlet/Node%3FNode%3D" + teasession._nNode;
            }
            String LoginId = teasession.getParameter("LoginId");

            //是否判断会员是否数字
            String membernumber = teasession.getParameter("membernumber");
            //如果是会员编号登陆

            if(membernumber != null && membernumber.length() > 0 && Entity.isNumeric(LoginId))
            {
                LoginId = Profile.getMember(LoginId);
            }

            if(LoginId == null || (LoginId = LoginId.trim()).length() < 1)
            {
                response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"InvalidMemberId"),"UTF-8") + "&nexturl=" + errurl);
                return;
            }
            LoginId = LoginId.toLowerCase();
            HttpSession session = request.getSession(true);

            String sv = (String) session.getAttribute("sms.vertify");
            String vertify = request.getParameter("vertify");
            if(vertify != null)
            {
                if(!vertify.trim().equals(sv))
                {
                    session.removeAttribute("vertify"); //退出session
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"ConfirmCodeError"),"UTF-8") + "&nexturl=" + errurl);
                    return;
                }
            }

            String s1 = request.getParameter("Password");
            String nu = request.getParameter("nexturl");
            if(nu == null)
            {
                nu = request.getParameter("NextUrl");
            }
            if(lt == 0) // 会员登陆
            {
            } else if(lt == 1) // 手机登陆
            {
                LoginId = Profile.numtoid(LoginId);
            } else if(lt == 2) // email登录
            {
                LoginId = Profile.findByEmail(LoginId,teasession._strCommunity);
                if(LoginId == null)
                {
                    outText(teasession,response,super.r.getString(teasession._nLanguage,"InvalidEmail"));
                    return;
                }
            } else if(lt == 20) //万能登录, 支持手机,邮箱,卡号,信用卡
            {
                Enumeration e = Profile.find(" AND(member=" + DbAdapter.cite(LoginId) + " OR email=" + DbAdapter.cite(LoginId) + " OR mobile=" + DbAdapter.cite(LoginId) + " OR code=" + DbAdapter.cite(LoginId) + " OR creditcard=" + DbAdapter.cite(LoginId.replaceAll(" ","")) + ")",0,1);
                if(!e.hasMoreElements())
                {
                    outText(teasession,response,super.r.getString(teasession._nLanguage,"您输入的会员ID不存在..."));
                    return;
                }
                LoginId = (String) e.nextElement();
            }

            if("csvclub".equals(teasession._strCommunity))
            {
                s1 = SMS.md5_16(s1);
            }
            RV rv = new RV(LoginId);
            if(!Profile.isPassword(rv._strV,s1)) // lt,
            {
                if(teasession._strCommunity.equals("bigpic"))
                {
                    errurl = "/servlet/Folder?node=2198284&language=1";
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("会员ID和密码不匹配。（您提供的会员ID为" + LoginId + "）","UTF-8") + "&nexturl=" + errurl);
                } else
                {
                    // response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"InvalidPassword"),"UTF-8") + "&nexturl=" + errurl);
                    if(request.getParameter("nexturl") != null && request.getParameter("nexturl").length() > 0)
                    {
                        errurl = request.getParameter("nexturl");
                    }
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"6681037915"),"UTF-8") + "&nexturl=" + errurl);
                }
                return;
            }
            Profile p = Profile.find(LoginId);
            if(p.isLocking())
            {
                response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"您的账号已被禁止登陆!"),"UTF-8"));
                return;
            }
            CommunityOption co = CommunityOption.find(teasession._strCommunity);
            int lv = co.getInt("loginvalid"); //"所有会员","审核会员","后台会员"
            if(lv > 0)
            {
                String info = co.get("logininfo");
                switch(lv)
                {
                case 1:
                    if(p.isValidate() || Subscriber.find(teasession._strCommunity,rv).getTerm() != null)
                    {
                        break;
                    }
                case 2:
                    AdminUsrRole aur = AdminUsrRole.find(teasession._strCommunity,LoginId);
                    if(aur.getRole().length() < 3)
                    {
                        response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(info,"UTF-8"));
                        return;
                    }
                }
            }
            if("bigpic".equals(teasession._strCommunity))
            {
                Bperson bpro = Bperson.findmember(LoginId);
                if(bpro.getTypestatic() == 1)
                {
                    errurl = "/servlet/Folder?node=2198284&language=1";
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("此会员ID以被注销，如有需要请与管理员联系！（您提供的会员ID为" + LoginId + "）","UTF-8") + "&nexturl=" + errurl);
                    return;
                }
            }
            if("ycserver".equals(teasession._strCommunity))
            {
                //  ServletOutputStream out = response.getOutputStream();

                //如果用户登陆需要审核的判断
                StringBuffer sp = new StringBuffer();
                int ver = tea.entity.admin.mov.MemberOrder.getVerifg(teasession._strCommunity,LoginId);
                String verutl = "/servlet/Node?node=" + teasession._nNode + "&language=" + teasession._nLanguage;

                if(ver == 0 && !"webmaster".equals(LoginId))
                {
                    // response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "您的用户正在等待管理员的审核，请耐心等待。。"), "UTF-8") + "&nexturl=" + errurl);
                    //  return;

                    sp.append("<script>alert('您的用户正在等待管理员的审核，请耐心等待。。');</script>");
                    sp.append("<script>self.location='" + verutl + "';</script>");
                    System.out.print(sp.toString());
                    out.write(sp.toString());
                    return;

                }
                if(ver == 2 && !"webmaster".equals(LoginId))
                {
                    //                        response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"您注册的会员填写的信息可能不符合我们站的要求，暂不能登陆！有问题请于管理员联系！"),"UTF-8") + "&nexturl=" + errurl);
                    //                        return;
                    sp.append("<script>alert('您注册的会员填写的信息可能不符合我们站的要求，没有通过管理员审核，暂不能登陆！有问题请于管理员联系！');</script>");
                    sp.append("<script>self.location='" + verutl + "';</script>");
                    System.out.print(sp.toString());
                    out.write(sp.toString());
                    return;
                }
                int stype = tea.entity.admin.mov.MemberOrder.getServiceType(teasession._strCommunity,LoginId);
                //如果用户的服务暂停了，则不能登陆系统判断
                if(stype == 1) //用户为1 是停止了服务
                {
                    sp.append("<script>alert('您的服务已经到期，不能登陆系统，有问题请联系管理员！');</script>");
                    sp.append("<script>self.location='" + verutl + "';</script>");
                    System.out.print(sp.toString());
                    out.write(sp.toString());
                    return;

                }

            }
            // 对企业会员的判断(末审核以前不能登陆)
            ProfileEnterprise pe = ProfileEnterprise.find(LoginId,teasession._strCommunity);
            if(pe.isExists())
            {
                if(!pe.isAuditing())
                {
                    outText(teasession,response,"对不起,你的账号还没有审核,审核之后才可以登陆,请等待...");
                    return;
                } else if(System.currentTimeMillis() - pe.getValid().getTime() > 0)
                {
                    outText(teasession,response,"对不起,你的账号已过期,你不可以登陆.");
                    return;
                }
            }
            if(teasession._strCommunity.equals("china-corea"))
            {
                AdminUsrRole aur = AdminUsrRole.find(teasession._strCommunity,LoginId);
                if(aur.getRole().length() < 2)
                {
                    ProfileZh pz = ProfileZh.find(LoginId);
                    if(pz.getRegbuffer() != 1)
                    {
                        response.sendRedirect("/jsp/info/Alert_Interlocution1.jsp?info=&nbsp;&nexturl=http://zh.redcome.com");
                        return;
                    }
                }
            }
            //邮箱验证，如果没有验证则提示验证

            String appemail = teasession.getParameter("appemail");
            if(appemail != null && appemail.length() > 0)
            {
                Profile profile = Profile.find(LoginId);
                AdminUsrRole aur = AdminUsrRole.find(teasession._strCommunity,LoginId);

                if(aur.getRole() != null && aur.getRole().split("/").length > 1)
                {} else if(!profile.isValidate())
                {
                    ProfileOrth.send(teasession,profile);
                    response.sendRedirect("/jsp/user/UserConfirm.jsp?membertype=" + MemberOrder.getMemberType(teasession._strCommunity,LoginId) + "&user=" + java.net.URLEncoder.encode(LoginId,"UTF-8") + "&community=" + teasession._strCommunity);
                    return;
                }
            }
            //英文的登陆邮箱验证
            String appemail_en = teasession.getParameter("appemail_en");
            if(appemail_en != null && appemail_en.length() > 0)
            {
                Profile profile = Profile.find(LoginId);
                AdminUsrRole aur = AdminUsrRole.find(teasession._strCommunity,LoginId);

                if(aur.getRole() != null && aur.getRole().split("/").length > 1)
                {} else if(!profile.isValidate())
                {
                    //ProfileOrth.send(teasession,profile);
                    MemberOrder.send(teasession,profile);
                    response.sendRedirect("/jsp/user/UserConfirm_en.jsp?membertype=" + MemberOrder.getMemberType(teasession._strCommunity,LoginId) + "&user=" + java.net.URLEncoder.encode(LoginId,"UTF-8") + "&community=" + teasession._strCommunity);
                    return;
                }
            }

            /*用户没有邮箱验证的，不能登陆
                   Profile profile=Profile.find(LoginId);
                   if(!profile.isValidate())
                   {
                    response.sendRedirect("/jsp/user/ValidateConfirm.jsp?user=" + java.net.URLEncoder.encode(LoginId, "utf-8") + "&community=" + teasession._strCommunity);
                      return;
                   }
             */
            //判断用户天登录次数
            int logs = 0;
            if(teasession.getParameter("logs") != null && teasession.getParameter("logs").length() > 0)
            {
                logs = Integer.parseInt(teasession.getParameter("logs"));
            }
            //参数是判断那个会员类型的
            AdminUsrRole auobj = AdminUsrRole.find(teasession._strCommunity,LoginId);
            boolean f = true;
            // System.out.println(auobj.getRole().split("/").length);
            if(auobj.getRole() != null && auobj.getRole().length() > 0 && auobj.getRole().split("/").length > 1)
            {
                f = false;
            }
            /// logs = 1;
            if(logs > 0 && f)
            {
                int membertype = 25;
                if(teasession.getParameter("membertype") != null && teasession.getParameter("membertype").length() > 0)
                {
                    membertype = Integer.parseInt(teasession.getParameter("membertype"));
                }
                MemberOrder mobj = MemberOrder.find(MemberOrder.getMemberOrder(teasession._strCommunity,MemberOrder.getMemberType(teasession._strCommunity,LoginId),LoginId));
                //当前会员是否是 要判断的会员类型
                if(mobj.getBecometime() != null)
                {
                    int d = Entity.countDays(Entity.sdf.format(new Date()),Entity.sdf.format(mobj.getBecometime()));
                    if(d >= 1)
                    {
                        int l = Logs.countlogs(LoginId," and time >=" + DbAdapter.cite(Entity.sdf.format(new Date()) + " 00:00") + " and time <=" + DbAdapter.cite(Entity.sdf.format(new Date()) + " 23:59") + " and type =1 ");
                        if(mobj.getServicetype() == 1 && l >= logs) //说明是锁定了
                        {
                            response.sendRedirect("/jsp/user/Loginshow.jsp?type=1&member=" + java.net.URLEncoder.encode(LoginId,"UTF-8"));
                            return;
                        } else
                        {
                            if(l >= logs) //超出登录次数
                            {
                                String rstr = "";
                                for(int i = 0;i < 7;i++)
                                {
                                    double a = Math.random() * 10;
                                    a = Math.ceil(a);
                                    int randomNum = new Double(a).intValue();
                                    rstr = rstr + String.valueOf(randomNum);
                                }
                                p.setPassword(rstr);

                                //发送邮件
                                String subject = "中国劳动保障新闻网：请妥善保管您的新密码"; //主题
                                String conent = "<font color=red><b>" + LoginId + "</b></font>，您好!<br>　　您的账户出现频繁登录的异常状况，已超过每日规定登录次数（5次），您的密码可能被盗。为了确保您的账户安全，我们已重置您的密码。<br>";

                                conent = conent + "　　您的新密码是<font color=red>" + rstr + "</font>，请妥善保管。<br>";
                                conent = conent + "　　您的账户今日已被锁定，请您持新密码于<b>明日0点</b>以后登录。<br>";
                                conent = conent + "　　<font color=red><b>重要提示：如果账户被锁定超过3次，本网有权进行调查并重新评估您对本账户的使用。</b></font><br>";
                                conent = conent + "　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　中国劳动保障新闻网网站管理员";
                                //rstr
                                try
                                {
                                    //如果锁定，记录锁定次数
                                    mobj.setServicetypenumber(mobj.getServicetypenumber() + 1);
                                    mobj.setServicetype(1);
                                    tea.service.SendEmaily se = new tea.service.SendEmaily(teasession._strCommunity);
                                    se.sendEmail(p.getEmail(),subject,conent); //p.getEmail()
                                    response.sendRedirect("/jsp/user/Loginshow.jsp?type=0&member=" + java.net.URLEncoder.encode(LoginId,"UTF-8"));
                                    return;
                                } catch(Exception _ex)
                                {
                                    _ex.printStackTrace();
                                }

                            } else
                            {
                                //没有锁定，则重置是否锁定项
                                mobj.setServicetype(0);
                            }
                        }
                    }
                }
            }

            //判断是否登陆过，如果没有登陆 则添加 登陆积分，每天只有一次添加机会
            Date td = new Date();

            if(!Logs.isLogs(" and time <= " + DbAdapter.cite(td),rv._strR,1))
            {
                tea.entity.integral.CommunityPoints cp = tea.entity.integral.CommunityPoints.find(tea.entity.integral.CommunityPoints.getIgid(teasession._strCommunity));
                p.addIntegral(cp.getDlhyjf(),p.getProfile());
            }

            //int datediff=now.getTime()-lastlogin.getTime())/1000/60
            Logs.create(teasession._strCommunity,rv,1,teasession._nNode,request.getRemoteAddr());

            //添加登陆次数
            p.setLogin(request.getRemoteAddr(),request.getHeader("user-agent") + " Screen/" + request.getParameter("screen"),new Date());

            Date now = new Date();
            Date lastlogin = IntegralRecord.getLastLoginGift(rv._strV);
            if(lastlogin == null)
            {
                IntegralRecord.create(teasession._strCommunity,LoginId,1,3,0,LoginId);
            } else
            {
                long datediff = (now.getTime() - lastlogin.getTime()) / 1000 / 60 / 60;
                if(datediff > 24)
                {
                    IntegralRecord.create(teasession._strCommunity,LoginId,1,3,0,LoginId);
                }
            }
            OnlineList.create(session.getId(),teasession._strCommunity,LoginId,request.getRemoteAddr());

            //
            Community c = Community.find(teasession._strCommunity);
            session.setAttribute("member",p.getProfile());
            if(!c.isSession())
            {
                Cookie cs = new Cookie("member",MT.enc(p.getLogint() + "|" + p.getProfile() + "|" + p.getPassword()));
                cs.setPath("/");
                String sn = request.getServerName();
                int j = sn.indexOf(".");
                if(j != -1 && sn.charAt(sn.length() - 1) > 96)
                    cs.setDomain(sn.substring(j));
                response.addCookie(cs);
            }
            if(nu == null)
            {
                Profile obj = Profile.find(LoginId);
                String url = obj.getStartUrl(teasession._nLanguage);
                if(url != null && url.length() > 0)
                {
                    response.sendRedirect(url);
                    return;
                }
            }
            if(!rv._strR.equals(rv._strV))
            {
                String s4 = Associate.find(rv._strR,rv._strV).getStartUrl();
                if(s4 != null && s4.length() != 0)
                {
                    nu = s4;
                }
            }
            if(nu == null)
            {
                nu = "/servlet/Node?node=" + teasession._nNode + "&language=" + teasession._nLanguage;
                session.setAttribute("em","0");
            }
            //论坛会员 登陆以后 默认进入自己的版块
            if("bbslogin".equals(request.getParameter("type")))
            {
                if(p.getBbspermissions() != null && p.getBbspermissions().length() > 2)
                {
                    nu = "/html/folder/" + p.getBbspermissions().split("/")[1] + "-" + teasession._nLanguage + ".htm";
                }
            }

            ///////////////////////////////////////////////////////////
            if("csvclub".equals(teasession._strCommunity))
            {
                response.sendRedirect("/jsp/csvclub/guide/Csvtest.jsp?member=" + java.net.URLEncoder.encode(LoginId,"UTF-8") + "&password=" + java.net.URLEncoder.encode(s1,"UTF-8") + "&nexturl=" + nu);
                return;
            } else
            {
                response.sendRedirect(nu);
                return;
            }

        } catch(Exception ex)
        {
            ex.printStackTrace();
            response.sendError(500,ex.toString());
        } finally
        {
            out.close();
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("/tea/ui/node/type/sms/EditUser");
    }
}
