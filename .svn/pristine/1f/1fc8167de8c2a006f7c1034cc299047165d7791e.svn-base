package tea.ui.admin.mov;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import tea.entity.Entity;
import tea.entity.Http;
import tea.entity.RV;
import tea.entity.SeqTable;
import tea.entity.admin.AdminUsrRole;
import tea.entity.admin.mov.MemberOrder;
import tea.entity.admin.mov.MemberRecord;
import tea.entity.admin.mov.MemberType;
import tea.entity.admin.mov.RegisterInstall;
import tea.entity.admin.orthonline.ProfileOrth;
import tea.entity.integral.IntegralRecord;
import tea.entity.member.Email;
import tea.entity.member.Logs;
import tea.entity.member.OnlineList;
import tea.entity.member.Profile;
import tea.entity.member.*;
import tea.entity.site.Communityintegral;
import tea.entity.westrac.WestracIntegralLog;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;


public class EditMember extends TeaServlet
{
    // Initialize global variables
    public void init() throws ServletException
    {
    }

    // Process the HTTP Get request
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        java.io.PrintWriter out = response.getWriter();
        TeaSession teasession = new TeaSession(request);
//                if (teasession._rv == null)
//                {
//                        response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
//                        return;
//                }
        HttpSession session = request.getSession();
        String act = teasession.getParameter("act");
        String nexturl = teasession.getParameter("nexturl");
        Http h = new Http(request);

        try
        {
            int membertype = 0;
            if(teasession.getParameter("membertype") != null && teasession.getParameter("membertype").length() > 0)
            {
                membertype = Integer.parseInt(teasession.getParameter("membertype"));
            }

            MemberType myobj = MemberType.find(membertype);
            RegisterInstall riobj = RegisterInstall.find(membertype);

            if("register".equals(act))
            {
                //验证码判断

                if(teasession.getParameter("vertify") != null && teasession.getParameter("vertify").length() > 0)
                {

                    if(riobj.isRegister("verify"))
                    {
                        String vertify = (String) session.getAttribute("sms.vertify");
                        String vertify1 = request.getParameter("vertify").trim();

                        if(!vertify1.equals(vertify) && !vertify1.equals("vertify"))
                        {
                            response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"验证码输入错误 ") + "<a href=\"javascript:history.back();\">" + r.getString(teasession._nLanguage,"Tautology") + "</A>","UTF-8"));
                            return;
                        }
                    }
                } else
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"请输入验证码") + "<a href=\"javascript:history.back();\">" + r.getString(teasession._nLanguage,"Tautology") + "</A>","UTF-8"));
                    return;
                }
                //用户名判断
                String MemberId = teasession.getParameter("MemberId");
                if(Profile.isExisted(MemberId))
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?community=" + teasession._strCommunity + "&info=" + java.net.URLEncoder.encode("用户名" + MemberId + "已经存在，请重新填写! <a href=\"javascript:history.back();\">重试</a>","UTF-8"));
                    return;
                }
                String EnterPassword = teasession.getParameter("EnterPassword");
                String email = teasession.getParameter("email");
                String firstname = teasession.getParameter("firstname");

                int sex = 0;
                if(teasession.getParameter("sex") != null && teasession.getParameter("sex").length() > 0)
                {
                    sex = Integer.parseInt(teasession.getParameter("sex")); //性别
                }
                boolean b = true;
                if(sex == 1)
                {
                    b = false;
                }

                String card = teasession.getParameter("card");

                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
                Date birthyear = null;
                if(request.getParameter("BirthYear") != null && request.getParameter("BirthYear").length() > 0)
                {
                    birthyear = sdf.parse(request.getParameter("BirthYear") + "-" + request.getParameter("BirthMonth") + "-" + request.getParameter("BirthDay"));
                }

                String state = teasession.getParameter("State");
                String city = teasession.getParameter("City");
                String address = teasession.getParameter("address");
                String phonenumber = teasession.getParameter("phonenumber");
                String zip = teasession.getParameter("zip");
                String telephone = teasession.getParameter("telephone");
                String fax = teasession.getParameter("fax");
                String Country = teasession.getParameter("Country");
                String position = teasession.getParameter("position"); //职称
                String organization = teasession.getParameter("organization"); //单位

                Profile.create(MemberId,EnterPassword,teasession._strCommunity,email,birthyear,0,teasession._nLanguage,firstname,null,null,address,city,state,zip,null,telephone,fax,null,phonenumber);
                Profile p = Profile.find(MemberId);
                p.setCard(card);

                p.setSex(b);
                p.setCountry(Country,teasession._nLanguage);

                p.setTitle(position,teasession._nLanguage);
                p.setOrganization(organization,teasession._nLanguage);

                int v = 0;

                if(!MemberOrder.isMemberOrder(teasession._strCommunity,membertype,0,p.getMember()))
                {
                    if(riobj.getVerify() == 0) //如果这个用户类型注册时候不需要审核，则，把标示修改成3
                    {
                        v = 3;
                    }
                    MemberOrder.create(membertype,0,p.getMember(),teasession._strCommunity,v,0,0);
                }

                MemberOrder mo = MemberOrder.find(MemberOrder.getMemberOrder(teasession._strCommunity,p.getMember()));
                mo.setIp(request.getRemoteAddr());

                //每注册一个用户，都用放到临时表MemberRecord 中，来标明这个用户都注册了那些类型的会员
                MemberRecord.create(p.getMember(),membertype,teasession._strCommunity);

                //建立session
                if(myobj.getAppemail() == 0) //如果不用邮箱验证
                {
                    RV rv = new RV(p.getMember());
                    Logs.create(teasession._strCommunity,rv,1,teasession._nNode,request.getRemoteAddr());
                    OnlineList ol_obj = OnlineList.find(session.getId());
                    ol_obj.setMember(p.getMember());
                    session.setAttribute("tea.RV",rv);
                } else
                {
                    session.setAttribute("member_id",MemberId);
                }
                session.setAttribute("member",p.getProfile());
                //注册设置里面的 是否关联填写类别信息relatednews
                String next = teasession.getParameter("next"); //用户登陆后看到的注册列表跳转过来的路径，直接到支付页面

                nexturl = "/jsp/mov/Success.jsp?membertype=" + membertype;

                if(riobj.getRelated() == 1)
                {
                    if(riobj.getRelatednews() == 21) // 公司
                    {
                        response.sendRedirect("/jsp/mov/EditCompany.jsp?NewNode=NewNode&nexturl=" + nexturl + "&father=" + riobj.getFathernode() + "&membertype=" + membertype);
                        return;
                    } else
                    {
                        response.sendRedirect("/jsp/type/dynamicvalue/EditDynamicValue.jsp?NewNode=O&nexturl=" + nexturl + "N&Type=" + riobj.getRelatednews() + "&node=" + riobj.getFathernode());
                        return;
                        //NewNode=ON&Type=" + j3 + "&node=" + node_code
                    }
                }

            } else if("Clssnregister".equals(act))
            {

                if(membertype != 1)
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"您的类型不正确，请重新注册 "),"UTF-8"));
                    return;
                }
                //验证码判断

                if(teasession.getParameter("vertify") != null && teasession.getParameter("vertify").length() > 0)
                {

                    if(riobj.isRegister("verify"))
                    {
                        String vertify = (String) session.getAttribute("sms.vertify");
                        String vertify1 = request.getParameter("vertify").trim();

                        if(!vertify1.equals(vertify) && !vertify1.equals("vertify"))
                        {
                            response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"验证码输入错误 ") + "<a href=\"javascript:history.back();\">" + r.getString(teasession._nLanguage,"Tautology") + "</A>","UTF-8"));
                            return;
                        }
                    }
                } else
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"请输入验证码") + "<a href=\"javascript:history.back();\">" + r.getString(teasession._nLanguage,"Tautology") + "</A>","UTF-8"));
                    return;
                }
                //用户名判断
                String MemberId = teasession.getParameter("MemberId");
                if(Profile.isExisted(MemberId))
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?community=" + teasession._strCommunity + "&info=" + java.net.URLEncoder.encode("用户名" + MemberId + "已经存在，请重新填写! <a href=\"javascript:history.back();\">重试</a>","UTF-8"));
                    return;
                }
                String EnterPassword = teasession.getParameter("EnterPassword");
                String email = teasession.getParameter("email");
                String firstname = teasession.getParameter("firstname");

                int sex = 0;
                if(teasession.getParameter("sex") != null && teasession.getParameter("sex").length() > 0)
                {
                    sex = Integer.parseInt(teasession.getParameter("sex")); //性别
                }
                boolean b = true;
                if(sex == 1)
                {
                    b = false;
                }

                String card = teasession.getParameter("card");

                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
                Date birthyear = null;
                if(request.getParameter("BirthYear") != null && request.getParameter("BirthYear").length() > 0)
                {
                    birthyear = sdf.parse(request.getParameter("BirthYear") + "-" + request.getParameter("BirthMonth") + "-" + request.getParameter("BirthDay"));
                }

                String state = teasession.getParameter("State");
                String city = teasession.getParameter("City");
                String address = teasession.getParameter("address");
                String phonenumber = teasession.getParameter("phonenumber");
                String zip = teasession.getParameter("zip");
                String telephone = teasession.getParameter("telephone");
                String fax = teasession.getParameter("fax");
                String Country = teasession.getParameter("Country");
                String position = teasession.getParameter("position"); //职称
                String organization = teasession.getParameter("organization"); //单位

                Profile.create(MemberId,EnterPassword,teasession._strCommunity,email,birthyear,0,teasession._nLanguage,firstname,null,null,address,city,state,zip,null,telephone,fax,null,phonenumber);
                Profile p = Profile.find(MemberId);
                p.setCard(card);

                p.setSex(b);
                p.setCountry(Country,teasession._nLanguage);

                p.setTitle(position,teasession._nLanguage);
                p.setOrganization(organization,teasession._nLanguage);

                int v = 0;

                if(!MemberOrder.isMemberOrder(teasession._strCommunity,membertype,0,p.getMember()))
                {
                    if(riobj.getVerify() == 0) //如果这个用户类型注册时候不需要审核，则，把标示修改成3
                    {
                        v = 3;
                    }
                    MemberOrder.create(membertype,0,p.getMember(),teasession._strCommunity,v,0,0);
                }

                MemberOrder mo = MemberOrder.find(MemberOrder.getMemberOrder(teasession._strCommunity,p.getMember()));
                mo.setIp(request.getRemoteAddr());

                //每注册一个用户，都用放到临时表MemberRecord 中，来标明这个用户都注册了那些类型的会员
                MemberRecord.create(p.getMember(),membertype,teasession._strCommunity);

                //建立session
                if(myobj.getAppemail() == 0) //如果不用邮箱验证
                {
                    RV rv = new RV(p.getMember());
                    Logs.create(teasession._strCommunity,rv,1,teasession._nNode,request.getRemoteAddr());
                    OnlineList ol_obj = OnlineList.find(session.getId());
                    ol_obj.setMember(p.getMember());
                    session.setAttribute("tea.RV",rv);
                } else
                {
                    session.setAttribute("member_id",MemberId);
                }

                //注册设置里面的 是否关联填写类别信息relatednews
                String next = teasession.getParameter("next"); //用户登陆后看到的注册列表跳转过来的路径，直接到支付页面

                nexturl = "/jsp/mov/Success.jsp?membertype=" + membertype;

                if(riobj.getRelated() == 1)
                {
                    if(riobj.getRelatednews() == 21) // 公司
                    {
                        response.sendRedirect("/jsp/mov/EditCompany.jsp?NewNode=NewNode&nexturl=" + nexturl + "&father=" + riobj.getFathernode() + "&membertype=" + membertype);
                        return;
                    } else
                    {
                        response.sendRedirect("/jsp/type/dynamicvalue/EditDynamicValue.jsp?NewNode=O&nexturl=" + nexturl + "N&Type=" + riobj.getRelatednews() + "&node=" + riobj.getFathernode());
                        return;
                        //NewNode=ON&Type=" + j3 + "&node=" + node_code
                    }
                }
            } else if("EditBBSMember".equals(act)) //论坛用户添加
            {
                String MemberId = teasession.getParameter("MemberId");
                Profile p = Profile.find(MemberId);
                String password = teasession.getParameter("EnterPassword");
                String firstname = teasession.getParameter("firstname");
                int sex = Integer.parseInt(teasession.getParameter("sex"));

                boolean b = true;
                if(sex == 1)
                {
                    b = false;
                }

                String email = teasession.getParameter("email");
                String mobile = teasession.getParameter("phonenumber");

                if(!(Profile.isExisted(MemberId)))
                {
                    Profile.create(MemberId,teasession._strCommunity,password,null,b,null,0,firstname,MemberId,teasession._nLanguage,null);
                }

                p.setPassword(password);
                p.setFirstName(firstname,teasession._nLanguage);
                p.setSex(b);
                p.setEmail(email);
                p.setMobile(mobile);

                StringBuffer sp = new StringBuffer();
                String[] bbs = teasession.getParameterValues("bbspermissions");
                if(bbs != null)
                {
                    for(int i = 0;i < bbs.length;++i)
                    {
                        sp.append("/").append(bbs[i]);
                    }
                    sp.append("/");
                }
                if(sp != null)
                {
                    p.setBbspermissions(sp.toString());
                }
                //添加角色用户
                String bbsrole[] = teasession.getParameterValues("bbsrole");
                StringBuffer sp2 = new StringBuffer();
                if(bbsrole != null && bbsrole.length > 0)
                {
                    for(int i = 0;i < bbsrole.length;++i)
                    {
                        sp2.append("/").append(bbsrole[i]);
                    }
                    sp2.append("/");
                }

                if(sp2 != null && sp2.length() > 0)
                {
                    AdminUsrRole aur_obj = AdminUsrRole.find(teasession._strCommunity,MemberId);
                    aur_obj.setRole(sp2.toString());

                }

            } else if("ClssnEditMember".equals(act)) //劳动报注册文件
            {
                String MemberId = teasession.getParameter("MemberId");
                Profile p = Profile.find(MemberId);
                String email = teasession.getParameter("email");
                String firstname = teasession.getParameter("firstname");
                String memberorder = teasession.getParameter("memberorder");
                MemberOrder moobj = MemberOrder.find(memberorder);
                int sex = Integer.parseInt(teasession.getParameter("sex")); //性别
                boolean b = true;
                if(sex == 1)
                {
                    b = false;
                }

                String card = teasession.getParameter("card");

                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
                Date birthyear = null;
                if(request.getParameter("BirthYear") != null && request.getParameter("BirthYear").length() > 0)
                {
                    birthyear = sdf.parse(request.getParameter("BirthYear") + "-" + request.getParameter("BirthMonth") + "-" + request.getParameter("BirthDay"));
                }

                String password = teasession.getParameter("EnterPassword");
                String state = teasession.getParameter("State");
                String city = teasession.getParameter("City");
                String address = teasession.getParameter("address");
                String phonenumber = teasession.getParameter("phonenumber");
                String zip = teasession.getParameter("zip");
                String telephone = teasession.getParameter("telephone");
                String fax = teasession.getParameter("fax");
                String Country = teasession.getParameter("Country");
                String position = teasession.getParameter("position"); //职称
                String organization = teasession.getParameter("organization"); //单位
                int identitys = -1;
                if(teasession.getParameter("identitys") != null && teasession.getParameter("identitys").length() > 0)
                {
                    identitys = Integer.parseInt(teasession.getParameter("identitys"));
                }
                p.setIdentitys(identitys);
                p.setEmail(email);
                p.setBirth(birthyear);
                p.setFirstName(firstname,teasession._nLanguage);
                p.setAddress(address,teasession._nLanguage);
                p.setCity(city,teasession._nLanguage);
                p.setState(state,teasession._nLanguage);
                p.setZip(zip,teasession._nLanguage);
                p.setTelephone(telephone,teasession._nLanguage);
                p.setFax(fax,teasession._nLanguage);
                p.setMobile(phonenumber);
                p.setPassword(password);

                p.setCard(card);
                p.setTitle(position,teasession._nLanguage);
                p.setOrganization(organization,teasession._nLanguage);

                p.setSex(b);
                p.setCountry(Country,teasession._nLanguage);

                int member_audit = 0;
                if(teasession.getParameter("member_audit") != null && teasession.getParameter("member_audit").length() > 0)
                {
                    member_audit = Integer.parseInt(teasession.getParameter("member_audit"));
                }
                if(member_audit > 0)
                {

                    moobj.setVerifg(member_audit); //审核
                    //修改会员的有效期天数
                    Date becometime = null;
                    if(teasession.getParameter("becometime") != null && teasession.getParameter("becometime").length() > 0)
                    {
                        becometime = tea.entity.Entity.sdf.parse(teasession.getParameter("becometime"));
                    }
                    //moobj.setPeriod(period);
                    moobj.setVerifgtime(new Date()); //审核日期
                    moobj.setBecometime(becometime); //到期日期
                    //转换会员类型
                    //moobj.setMembertype(25);

                }

            } else if("WomenRegister".equals(act))
            {
                //妇联英文网 注册 字段

                String member = teasession.getParameter("member"); //邮箱格式 的用户名

                //用户名判断

                if(Profile.isExisted(member))
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?community=" + teasession._strCommunity + "&info=" + java.net.URLEncoder.encode("用户名" + member + "已经存在，请重新填写! <a href=\"javascript:history.back();\">重试</a>","UTF-8"));
                    return;
                }

                String membername = teasession.getParameter("membername"); //用户名姓名;
                String password = teasession.getParameter("EnterPassword"); //用户密码

                int newsletter = 0; //是否订阅电子报
                if(teasession.getParameter("newsletter") != null && teasession.getParameter("newsletter").length() > 0)
                {
                    newsletter = Integer.parseInt(teasession.getParameter("newsletter"));
                }
                int abstracts = 0; //是否订阅学术论文摘要
                if(teasession.getParameter("abstracts") != null && teasession.getParameter("abstracts").length() > 0)
                {
                    abstracts = Integer.parseInt(teasession.getParameter("abstracts"));
                }

                int sex = Integer.parseInt(teasession.getParameter("sex")); //性别
                boolean b = true;
                if(sex == 1)
                {
                    b = false;
                }
                int age = Integer.parseInt(teasession.getParameter("age")); //年龄
                String city = teasession.getParameter("city"); //城市

                String country = teasession.getParameter("Country"); //国家

                int industry = 0; //行业
                if(teasession.getParameter("industry") != null && teasession.getParameter("industry").length() > 0)
                {
                    industry = Integer.parseInt(teasession.getParameter("industry"));
                }
                // System.out.println(teasession.getParameter("industry"));

                int job = 0; //工作
                if(teasession.getParameter("job") != null && teasession.getParameter("job").length() > 0)
                {
                    job = Integer.parseInt(teasession.getParameter("job"));
                }

                int v = 0;

                if(!MemberOrder.isMemberOrder(teasession._strCommunity,membertype,0,member))
                {
                    if(riobj.getVerify() == 0) //如果这个用户类型注册时候不需要审核，则，把标示修改成3
                    {
                        v = 3;
                    }
                    MemberOrder.create(membertype,0,member,teasession._strCommunity,v,0,0);
                }
                MemberOrder mobj = MemberOrder.find(MemberOrder.getMemberOrder(teasession._strCommunity,membertype,member));
                mobj.setNewsletter(newsletter);
                mobj.setAbstracts(abstracts);

                Profile pobj = Profile.find(member);
                //添加
                if(!pobj.isExisted(member))
                {
                    Profile.create(member,teasession._strCommunity,password,null,b,null,0,membername,member,teasession._nLanguage,null);
                }
                pobj.setSex(b);
                pobj.setAgent(age);
                pobj.setCity(city,teasession._nLanguage);
                pobj.setCountry(country,teasession._nLanguage);
                pobj.setIndustry(industry);
                pobj.setJob(job);
                pobj.setEmail(member);
                //注册选项
                String woid = teasession.getParameter("woid");
                StringBuffer sp = new StringBuffer("/");
                if(woid != null && woid.length() > 0)
                {
                    String woidall[] = teasession.getParameterValues("woid");
                    for(int i = 0;i < woidall.length;i++)
                    {
                        sp.append(woidall[i]).append("/");
                    }
                }
                pobj.setWoid(sp.toString());

                //发送邮件
                MemberOrder.send(teasession,pobj);

                String url = "http://" + request.getServerName() + ":" + request.getServerPort(); ///jsp/mov/WomenRegister_ok.jsp

                out.print("<script  language='javascript'>alert('Your registration is successfully completed. Please activate your account.We\\'ve already sent you " + pobj.getEmail() + " an activation email Please click the affirm link and your account will be activated immediately.');window.location.href='" + url + "';</script> ");

                return;

            } else if("WomenRegister_edit".equals(act))
            {

                //妇联英文网 注册 字段  编辑使用

                String member = teasession.getParameter("member"); //邮箱格式 的用户名
                String password = teasession.getParameter("EnterPassword"); //用户密码
                String en = teasession.getParameter("en");

                String membername = teasession.getParameter("membername"); //用户名姓名;

                int newsletter = 0; //是否订阅电子报
                if(teasession.getParameter("newsletter") != null && teasession.getParameter("newsletter").length() > 0)
                {
                    newsletter = Integer.parseInt(teasession.getParameter("newsletter"));
                }
                int abstracts = 0; //是否订阅学术论文摘要
                if(teasession.getParameter("abstracts") != null && teasession.getParameter("abstracts").length() > 0)
                {
                    abstracts = Integer.parseInt(teasession.getParameter("abstracts"));
                }

                int sex = Integer.parseInt(teasession.getParameter("sex")); //性别
                boolean b = true;
                if(sex == 1)
                {
                    b = false;
                }
                int age = Integer.parseInt(teasession.getParameter("age")); //年龄
                String city = teasession.getParameter("city"); //城市

                String country = teasession.getParameter("Country"); //国家

                int industry = 0; //行业
                if(teasession.getParameter("industry") != null && teasession.getParameter("industry").length() > 0)
                {
                    industry = Integer.parseInt(teasession.getParameter("industry"));
                }
                // System.out.println(teasession.getParameter("industry"));

                int job = 0; //工作
                if(teasession.getParameter("job") != null && teasession.getParameter("job").length() > 0)
                {
                    job = Integer.parseInt(teasession.getParameter("job"));
                }

                MemberOrder mobj = MemberOrder.find(MemberOrder.getMemberOrder(teasession._strCommunity,membertype,member));
                mobj.setNewsletter(newsletter);
                mobj.setAbstracts(abstracts);

                Profile pobj = Profile.find(member);
                pobj.setPassword(password);

                pobj.setFirstName(membername,teasession._nLanguage);
                pobj.setSex(b);
                pobj.setAgent(age);
                pobj.setCity(city,teasession._nLanguage);
                pobj.setCountry(country,teasession._nLanguage);
                pobj.setIndustry(industry);
                pobj.setJob(job);
                pobj.setEmail(member);
                //注册选项
                String woid = teasession.getParameter("woid");
                StringBuffer sp = new StringBuffer("/");
                if(woid != null && woid.length() > 0)
                {
                    String woidall[] = teasession.getParameterValues("woid");
                    for(int i = 0;i < woidall.length;i++)
                    {
                        sp.append(woidall[i]).append("/");
                    }
                }
                pobj.setWoid(sp.toString());

                String str = "会员信息修改成功";
                if("en".equals(en))
                {
                    str = "Successfully modified.";
                }

                out.print("<script  language='javascript'>alert('" + str + "');window.location.href='" + nexturl + "';</script> ");

                return;

            }else if("TelWestracRegister".equals(act))
            {
                //威斯特手机注册=1
                String member = teasession.getParameter("member");
                if(Profile.isExisted(member))
                {

                    out.print("<script  language='javascript'>alert('用户名已经被占用，不能重复用户名');history.go(-1);</script> ");

                    return;
                }

                String invite = teasession.getParameter("invite");

                String membername = teasession.getParameter("membername");
                int sex = 1; //默认是男
                if(teasession.getParameter("sex") != null && teasession.getParameter("sex").length() > 0)
                {
                    sex = Integer.parseInt(teasession.getParameter("sex"));
                }
                String password = teasession.getParameter("EnterPassword");

                String card = teasession.getParameter("card");
                String mobile = teasession.getParameter("mobile");
                Date birth = null;
                if(teasession.getParameter("birth") != null && teasession.getParameter("birth").length() > 0)
                {
                    birth = Entity.sdf.parse(teasession.getParameter("birth"));
                }

                String address = h.get("address");

                int xybcheck = h.getInt("xybcheck"); //如果0 没有下一步 1

                java.text.DecimalFormat df = new java.text.DecimalFormat("000000");

                SeqTable seq = new SeqTable();
                String code = df.format(seq.getSeqNo(teasession._strCommunity));

                Profile.create(member,password,h.community,null,request.getServerName());

                Profile pobj = Profile.find(member);
                pobj.setFirstName(membername,teasession._nLanguage);
                pobj.setSex(sex == 1 ? false : true);
                pobj.setCard(card);
                pobj.setMobile(mobile);
                pobj.setBirth(birth);
                //省市
                pobj.setProvince(h.getInt("city1",h.getInt("city0")),h.language);
                pobj.setAddress(address,teasession._nLanguage);

                pobj.setCode(code);
                pobj.setType(xybcheck);

                //默认是普通会员，审核过后才是俱乐部会员--2 没审核
                pobj.setMembertype(2);

                //选填项
                int language = h.language;
                //学历
                pobj.setDegree(h.get("degree"),language);

                pobj.setZzracky(h.get("zzracky"));
                pobj.setTelephone(h.get("telephone"),language);
                pobj.setZzhkszd(h.get("zzhkszd1",h.get("zzhkszd0")),language);
                pobj.setPAddress(h.get("paddress"),language);

                pobj.setState(h.get("state1",h.get("state0")),language);
                pobj.setOrganization(h.get("organization"),language);
                pobj.setZip(h.get("zip"),language);
                pobj.setEmail(h.get("email"));
                pobj.setMsnID(h.get("msn"));

                String tjmember = teasession.getParameter("tjmember");

                int source = h.getInt("source");

                if(source == 1)
                {
                    pobj.setTrainname(h.get("trainname"));
                    pobj.setTrainaddress(h.get("trainaddress"));
                    pobj.setTraintime(h.get("traintime"));
                } else if(source == 2)
                {

                    if(invite != null && invite.length() > 0 && !"null".equals(invite))
                    {
                        //邀请的会员
                        Profile p = Profile.find(Integer.parseInt(invite));
                        tjmember = p.getCode(); //添加会员编号

                    } else
                    {
                        if(tjmember != null && tjmember.length() > 0)
                        {

                            if(Entity.isNumeric(tjmember))
                            {
                                tjmember = Profile.getMember(tjmember);
                            }
                        }
                    }
                } else if(source == 3)
                {
                    pobj.setBelsell(h.get("belsell"));
                    pobj.setTjmobile(h.get("tjmobile"));
                }

                pobj.setSource(source);

/*
                if(tjmember != null && tjmember.length() > 0)
                {
                    Profile p = Profile.find(Profile.getMember(tjmember));
                    //添加邀请积分
                    Communityintegral cobj = Communityintegral.find(teasession._strCommunity);

                    p.setMyintegral(p.getMyintegral() + cobj.getInvitepoint());
                    WestracIntegralLog.create(p.getMember(),3,null,0,cobj.getInvitepoint(),null,new Date(),0,teasession._strCommunity);
                    //添加要求次数
                    p.setTjmemberint(p.getTjmemberint() + 1);

                }
                */

                pobj.setWST(tjmember,h.getInt("sfshanggang"),h.get("fazhengjiguan"),h.get("caozuonianxian"),
                            h.getInt("xpinpai"),h.getInt("xxinghao"),h.get("xqita"),h.getInt("cpinpai"),h.getInt("cxinghao"),
                            h.get("cqita"),h.get("jzname"),h.get("jzxinghao"),h.get("jzxuliehao"),h.get("jzlianxi"),h.get("aihao"),
                            h.getInt("wsttype"),h.get("wstmodel","|").substring(1).replace('|',','));

                //获取手机发送手机验证码
                //添加积分功能

                /*
                                   if(xybcheck==0)
                                   {
                 nexturl = "/jsp/westrac/WestracRegister3.jsp";
                                   }else if(xybcheck==1)
                                   {
                 nexturl= "/jsp/westrac/WestracRegister2.jsp";
                                   }
                 */

                //nexturl = "/jsp/westrac/WestracRegister2.jsp";


                out.print("<script>mt.show('感谢您注册履友会员，请尽快到lvyou.westrac.com.cn上完善您的信息，更多惊喜等着您！',1,'"+nexturl+"');</script>");

                return;

            } else if("WestracRegister".equals(act))
            {
                //威斯特注册=1
                String member = teasession.getParameter("member");
                if(Profile.isExisted(member))
                {

                    out.print("<script  language='javascript'>alert('用户名已经被占用，不能重复用户名');history.go(-1);</script> ");

                    return;
                }

                String invite = teasession.getParameter("invite");

                String membername = teasession.getParameter("membername");
                int sex = 1; //默认是男
                if(teasession.getParameter("sex") != null && teasession.getParameter("sex").length() > 0)
                {
                    sex = Integer.parseInt(teasession.getParameter("sex"));
                }
                String password = teasession.getParameter("EnterPassword");

                String card = teasession.getParameter("card");
                String mobile = teasession.getParameter("mobile");
                Date birth = null;
                if(teasession.getParameter("birth") != null && teasession.getParameter("birth").length() > 0)
                {
                    birth = Entity.sdf.parse(teasession.getParameter("birth"));
                }

                String address = h.get("address");

                int xybcheck = h.getInt("xybcheck"); //如果0 没有下一步 1

                java.text.DecimalFormat df = new java.text.DecimalFormat("000000");

                SeqTable seq = new SeqTable();
                String code = df.format(seq.getSeqNo(teasession._strCommunity));

                Profile.create(member,password,h.community,null,request.getServerName());

                Profile pobj = Profile.find(member);
                pobj.setFirstName(membername,teasession._nLanguage);
                pobj.setSex(sex == 1 ? false : true);
                pobj.setCard(card);
                pobj.setMobile(mobile);
                pobj.setBirth(birth);
                //省市
                pobj.setProvince(h.getInt("city1",h.getInt("city0")),h.language);
                pobj.setAddress(address,teasession._nLanguage);

                pobj.setCode(code);
                pobj.setType(xybcheck);

                //默认是普通会员，审核过后才是俱乐部会员--2 没审核
                pobj.setMembertype(2);

                //选填项
                int language = h.language;
                //学历
                pobj.setDegree(h.get("degree"),language);

                pobj.setZzracky(h.get("zzracky"));
                pobj.setTelephone(h.get("telephone"),language);
                pobj.setZzhkszd(h.get("zzhkszd1",h.get("zzhkszd0")),language);
                pobj.setPAddress(h.get("paddress"),language);

                pobj.setState(h.get("state1",h.get("state0")),language);
                pobj.setOrganization(h.get("organization"),language);
                pobj.setZip(h.get("zip"),language);
                pobj.setEmail(h.get("email"));
                pobj.setMsnID(h.get("msn"));

                String tjmember = teasession.getParameter("tjmember");

                int source = h.getInt("source");

                if(source == 1)
                {
                    pobj.setTrainname(h.get("trainname"));
                    pobj.setTrainaddress(h.get("trainaddress"));
                    pobj.setTraintime(h.get("traintime"));
                } else if(source == 2)
                {

                    if(invite != null && invite.length() > 0 && !"null".equals(invite))
                    {
                        //邀请的会员
                        Profile p = Profile.find(Integer.parseInt(invite));
                        tjmember = p.getCode(); //添加会员编号

                    } else
                    {
                        if(tjmember != null && tjmember.length() > 0)
                        {

                            if(Entity.isNumeric(tjmember))
                            {
                                tjmember = Profile.getMember(tjmember);
                            }
                        }
                    }
                } else if(source == 3)
                {
                    pobj.setBelsell(h.get("belsell"));
                    pobj.setTjmobile(h.get("tjmobile"));
                }

                pobj.setSource(source);

                /*
                                if(tjmember != null && tjmember.length() > 0)
                                {
                                    Profile p = Profile.find(Profile.getMember(tjmember));
                                    //添加邀请积分
                                    Communityintegral cobj = Communityintegral.find(teasession._strCommunity);

                                    p.setMyintegral(p.getMyintegral() + cobj.getInvitepoint());
                                    WestracIntegralLog.create(p.getMember(),3,null,0,cobj.getInvitepoint(),null,new Date(),0,teasession._strCommunity);
                                    //添加要求次数
                                    p.setTjmemberint(p.getTjmemberint() + 1);

                                }
                 */

                pobj.setWST(tjmember,h.getInt("sfshanggang"),h.get("fazhengjiguan"),h.get("caozuonianxian"),
                            h.getInt("xpinpai"),h.getInt("xxinghao"),h.get("xqita"),h.getInt("cpinpai"),h.getInt("cxinghao"),
                            h.get("cqita"),h.get("jzname"),h.get("jzxinghao"),h.get("jzxuliehao"),h.get("jzlianxi"),h.get("aihao"),
                            h.getInt("wsttype"),h.get("wstmodel","|").substring(1).replace('|',','));

                //获取手机发送手机验证码
                //添加积分功能

                /*
                                   if(xybcheck==0)
                                   {
                 nexturl = "/jsp/westrac/WestracRegister3.jsp";
                                   }else if(xybcheck==1)
                                   {
                 nexturl= "/jsp/westrac/WestracRegister2.jsp";
                                   }
                 */

                nexturl = "/jsp/westrac/WestracRegister2.jsp";

                out.print("<script>window.open('" + nexturl + "','_parent');</script>");


                return;

            } else if("WestracRegister2".equals(act))
            {
                //威斯特注册=2

                String member = (String) session.getAttribute("member");
                Profile pobj = Profile.find(member);
                int language = h.language;

                pobj.setZzracky(h.get("zzracky"));
                pobj.setTelephone(h.get("telephone"),language);
                pobj.setZzhkszd(h.get("zzhkszd1",h.get("zzhkszd0")),language);
                pobj.setPAddress(h.get("paddress"),language);

                pobj.setState(h.get("state1",h.get("state0")),language);
                pobj.setOrganization(h.get("organization"),language);
                pobj.setZip(h.get("zip"),language);
                pobj.setEmail(h.get("email"));
                pobj.setMsnID(h.get("msn"));

                //学历
                pobj.setDegree(h.get("degree"),language);

                pobj.setWST(h.get("tjmember"),h.getInt("sfshanggang"),h.get("fazhengjiguan"),h.get("caozuonianxian"),
                            h.getInt("xpinpai"),h.getInt("xxinghao"),h.get("xqita"),h.getInt("cpinpai"),h.getInt("cxinghao"),
                            h.get("cqita"),h.get("jzname"),h.get("jzxinghao"),h.get("jzxuliehao"),h.get("jzlianxi"),h.get("aihao"),0,null);

                //获取推荐人 来添加推荐人积分


                nexturl = "/jsp/westrac/WestracRegister3.jsp";

            } else if("EditWestracMmeber".equals(act)) //管理员修改用户信息
            {

                if(teasession._rv == null)
                {
                    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                    return;
                }

                String member = teasession.getParameter("member");

                String membername = teasession.getParameter("membername");
                int sex = 1; //默认是男
                if(teasession.getParameter("sex") != null && teasession.getParameter("sex").length() > 0)
                {
                    sex = Integer.parseInt(teasession.getParameter("sex"));
                }
                String password = teasession.getParameter("EnterPassword");

                String card = teasession.getParameter("card");
                String mobile = teasession.getParameter("mobile");
                Date birth = null;
                if(teasession.getParameter("birth") != null && teasession.getParameter("birth").length() > 0)
                {
                    birth = Entity.sdf.parse(teasession.getParameter("birth"));
                }

                String address = h.get("address");

                int xybcheck = h.getInt("xybcheck"); //如果0 没有下一步 1

                java.text.DecimalFormat df = new java.text.DecimalFormat("000000");

                SeqTable seq = new SeqTable();

                String code = df.format(seq.getSeqNo(teasession._strCommunity));
                if(teasession.getParameter("code") != null && teasession.getParameter("code").length() > 0)
                {
                    code = teasession.getParameter("code");
                }

                Profile pobj = Profile.find(member);
                pobj.setPassword(password);
                pobj.setFirstName(membername,teasession._nLanguage);
                pobj.setSex(sex == 1 ? false : true);
                pobj.setCard(card);
                pobj.setMobile(mobile);
                pobj.setBirth(birth);
                //省市
                pobj.setProvince(h.getInt("city1",h.getInt("city0")),h.language);
                pobj.setAddress(address,teasession._nLanguage);

                pobj.setCode(code);
                pobj.setType(xybcheck);

                //修改详细信息

                int language = h.language;
                //学历
                pobj.setDegree(h.get("degree"),language);

                pobj.setZzracky(h.get("zzracky"));
                pobj.setTelephone(h.get("telephone"),language);
                pobj.setZzhkszd(h.get("zzhkszd1",h.get("zzhkszd0")),language);
                pobj.setPAddress(h.get("paddress"),language);

                pobj.setState(h.get("state1",h.get("state0")),language);
                pobj.setOrganization(h.get("organization"),language);
                pobj.setZip(h.get("zip"),language);
                pobj.setEmail(h.get("email"));
                pobj.setMsnID(h.get("msn"));

                String tjmember = h.get("tjmember");

                int source = h.getInt("source");

                if(source == 1)
                {
                    pobj.setTrainname(h.get("trainname"));
                    pobj.setTrainaddress(h.get("trainaddress"));
                    pobj.setTraintime(h.get("traintime"));
                } else if(source == 2)
                {

                    if(tjmember != null && tjmember.length() > 0)
                    {

                        if(Entity.isNumeric(tjmember))
                        {
                            tjmember = Profile.getMember(tjmember);
                        }
                    }

                } else if(source == 3)
                {
                    pobj.setBelsell(h.get("belsell"));
                    pobj.setTjmobile(h.get("tjmobile"));
                }

                pobj.setSource(source);

                pobj.setWST(h.get("tjmember"),h.getInt("sfshanggang"),h.get("fazhengjiguan"),h.get("caozuonianxian"),
                            h.getInt("xpinpai"),h.getInt("xxinghao"),h.get("xqita"),h.getInt("cpinpai"),h.getInt("cxinghao"),
                            h.get("cqita"),h.get("jzname"),h.get("jzxinghao"),h.get("jzxuliehao"),h.get("jzlianxi"),h.get("aihao"),
                            h.getInt("wsttype"),h.get("wstmodel","|").substring(1).replace('|',','));

                //审核信息
                if(pobj.getMembertype() == 2)
                {

                    if(teasession.getParameter("membertype") != null && teasession.getParameter("membertype").length() > 0)
                    {
                        membertype = Integer.parseInt(teasession.getParameter("membertype"));
                    } else
                    {
                        membertype = 2; //默认不填写 是没有审核
                    }

                    pobj.setMembertype(membertype); //审核状态

                    pobj.setVerifgmember(teasession._rv.toString());
                    pobj.setVerifgtime(new Date());

                    if(membertype == 1) //审核通过加分
                    {
                        Communityintegral cobj = Communityintegral.find(teasession._strCommunity);
                        pobj.setMyintegral(pobj.getMyintegral() + cobj.getRegpoint());
                        WestracIntegralLog.create(pobj.getMember(),2,null,0,cobj.getRegpoint(),null,new Date(),0,teasession._strCommunity);

                        //审核成功，给邀请会员加分
                        if(pobj.getSource() == 2 && pobj.getTjmember() != null && pobj.getTjmember().length() > 0)
                        {
                            Profile p = Profile.find(pobj.getTjmember());
                            p.setMyintegral(p.getMyintegral() + cobj.getInvitepoint());
                            WestracIntegralLog.create(pobj.getTjmember(),3,null,0,cobj.getInvitepoint(),null,new Date(),0,teasession._strCommunity);
                        }

                        //发送短信
                        String c = "您好，您已成功注册为履友，您的会员ID号是“" + pobj.getCode() + "”，为您增加" + cobj.getRegpoint() + "积分，请登录lvyou.westrac.com.cn,畅游我们的家！";
                        if(pobj.getImptype() == 1)
                        {
                            //说明是导入会员
                            c = "您好，您成为履友成员，您的ID号是“" + pobj.getCode() + "”,缺省密码是123456，为您增加" + cobj.getRegpoint() + "积分，请登录lvyou.westrac.com.cn绑定用户名,畅游我们的家！";
                        }

                        SMSMessage.create(teasession._strCommunity,pobj.getMember(),pobj.getMobile(),teasession._nLanguage,c);

                    } else if(membertype == 3)
                    {
                        //发送短信
                        String c = "您好，您的履友账号是“" + pobj.getMember() + "”因信息不完整不能通过审核，请补充信息重新提交！";
                        SMSMessage.create(teasession._strCommunity,pobj.getMember(),pobj.getMobile(),teasession._nLanguage,c);
                    }

                }

                if("WestracUpgradeMemberRegister".equals(teasession.getParameter("act2")))
                {
                    pobj.setMembertype(2); //升级会员

                    out.print("<script>window.open('" + nexturl + "','_parent');</script>");

                    return;
                }

            } else if("WestracMemberDelete".equals(act)) //批量删除
            {
                String value[] = request.getParameterValues("memberorder");

                if(value != null)
                {
                    String next_str = "操作成功";
                    //boolean f = false;
                    for(int index = 0;index < value.length;index++)
                    {

                        String member = value[index];

                        Profile pobj = Profile.find(member);

                        pobj.delete(teasession._nLanguage);
                        WestracIntegralLog.delete(member);

                    }

                    out.print("<script  language='javascript'>alert('" + next_str + "');window.location.href='" + nexturl + "&id=" + teasession.getParameter("id") + "';</script> ");

                    return;
                }
            } else if("WestracMemberDeleteAll".equals(act)) //会员信息彻底删除
            {
                String value[] = request.getParameterValues("memberorder");

                if(value != null)
                {
                    String next_str = "操作成功";
                    //boolean f = false;
                    for(int index = 0;index < value.length;index++)
                    {

                        String member = value[index];

                        Profile pobj = Profile.find(member);

                        pobj.deleteall();

                    }

                    out.print("<script  language='javascript'>alert('" + next_str + "');window.location.href='" + nexturl + "&id=" + teasession.getParameter("id") + "';</script> ");

                    return;
                }
            } else if("WestracMemberve".equals(act)) //批量审核
            {
                String value[] = request.getParameterValues("memberorder");

                if(teasession.getParameter("membertype") != null && teasession.getParameter("membertype").length() > 0)
                {
                    membertype = Integer.parseInt(teasession.getParameter("membertype"));
                } else
                {
                    membertype = 2;
                }

                if(value != null && membertype != 2)
                {
                    String next_str = "";
                    //boolean f = false;
                    for(int index = 0;index < value.length;index++)
                    {

                        String member = value[index];

                        Profile pobj = Profile.find(member);

                        pobj.setMembertype(membertype); //审核状态

                        pobj.setVerifgmember(teasession._rv.toString());
                        pobj.setVerifgtime(new Date());

                        if(membertype == 1) //审核通过加分
                        {
                            Communityintegral cobj = Communityintegral.find(teasession._strCommunity);
                            pobj.setContributeintegral(pobj.getMyintegral() + cobj.getRegpoint());
                            WestracIntegralLog.create(pobj.getMember(),2,null,0,cobj.getRegpoint(),null,new Date(),0,teasession._strCommunity);
                            next_str = "审核通过";
                        } else if(membertype == 3)
                        {
                            next_str = "审核不通过";
                        }

                    }

                    out.print("<script>parent.f_win('" + next_str + "');</script> ");

                    return;
                } else
                {
                    out.print("<script  language='javascript'>window.location.href='" + nexturl + "&id=" + teasession.getParameter("id") + "';</script> ");

                    return;
                }

            } else if("WestracMemberlocking".equals(act)) //批量锁定
            {
                String value[] = request.getParameterValues("memberorder");
                String next_str = "操作成功";
                if(value != null)
                {

                    //boolean f = false;
                    for(int index = 0;index < value.length;index++)
                    {

                        String member = value[index];

                        Profile pobj = Profile.find(member);

                        if(pobj.isLocking())
                        {
                            pobj.setLocking(false);
                            next_str = "会员解锁成功";
                        } else
                        {
                            pobj.setLocking(true);
                            next_str = "会员已经锁定";

                        }

                    }
                }

                out.print("<script  language='javascript'>alert('" + next_str + "');window.location.href='" + nexturl + "';</script> ");

                return;

            } else if("EditMyWestracMmeber".equals(act))
            {

                //履友俱乐部 个人信息
                if(teasession._rv == null)
                {
                    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                    return;
                }

                String member = teasession.getParameter("member");

                String mobile = teasession.getParameter("mobile");

                String address = h.get("address");

                int xybcheck = h.getInt("xybcheck"); //如果0 没有下一步 1

                Profile pobj = Profile.find(member);

                pobj.setMobile(mobile);

                //省市
                pobj.setProvince(h.getInt("city1",h.getInt("city0")),h.language);
                pobj.setAddress(address,teasession._nLanguage);

                //修改详细信息

                int language = h.language;

                pobj.setZzracky(h.get("zzracky"));
                pobj.setTelephone(h.get("telephone"),language);
                pobj.setZzhkszd(h.get("zzhkszd1",h.get("zzhkszd0")),language);
                pobj.setPAddress(h.get("paddress"),language);

                pobj.setState(h.get("state1",h.get("state0")),language);
                pobj.setOrganization(h.get("organization"),language);
                pobj.setZip(h.get("zip"),language);
                pobj.setEmail(h.get("email"));
                pobj.setMsnID(h.get("msn"));

                pobj.setWST(h.get("tjmember"),h.getInt("sfshanggang"),h.get("fazhengjiguan"),h.get("caozuonianxian"),
                            h.getInt("xpinpai"),h.getInt("xxinghao"),h.get("xqita"),h.getInt("cpinpai"),h.getInt("cxinghao"),
                            h.get("cqita"),h.get("jzname"),h.get("jzxinghao"),h.get("jzxuliehao"),h.get("jzlianxi"),h.get("aihao"),
                            h.getInt("wsttype"),h.get("wstmodel","|").substring(1).replace('|',','));

                //
                ProfileBBS pb = ProfileBBS.find(teasession._strCommunity,teasession._rv.toString());
                pb.set(h.language,pb.getTitle(h.language),h.get("portrait"),pb.getSignature(h.language));

                out.print("<script  language='javascript'>parent.f_alert();</script> ");
                return;

            } else if("EditMyGolfMmeber".equals(act))
            {
                //高尔夫俱乐部
                if(teasession._rv == null)
                {
                    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                    return;
                }

                String member = teasession.getParameter("member");

                String mobile = teasession.getParameter("mobile");

                String address = teasession.getParameter("address");

                int xybcheck = 0; //如果0 没有下一步 1
                if(teasession.getParameter("xybcheck") != null && teasession.getParameter("xybcheck").length() > 0)
                {
                    xybcheck = Integer.parseInt(teasession.getParameter("xybcheck"));
                }

                Profile pobj = Profile.find(member);

                pobj.setMobile(mobile);

                //省市
                //省市
                String city1 = teasession.getParameter("city1");

                if(city1 != null && city1.length() > 0)
                {
                    pobj.setProvince(Integer.parseInt(city1),teasession._nLanguage);
                }
                pobj.setAddress(address,teasession._nLanguage);

                //修改详细信息

                int language = teasession._nLanguage;

                pobj.setZzracky(teasession.getParameter("zzracky"));
                pobj.setTelephone(teasession.getParameter("telephone"),language);

                if(teasession.getParameter("zzhkszd1") != null && teasession.getParameter("zzhkszd1").length() > 0)
                {
                    pobj.setZzhkszd(teasession.getParameter("zzhkszd1"),language);
                }
                pobj.setPAddress(teasession.getParameter("paddress"),language);

                pobj.setState(teasession.getParameter("state1"),language);

                pobj.setOrganization(teasession.getParameter("organization"),language);
                pobj.setZip(teasession.getParameter("zip"),language);
                pobj.setEmail(teasession.getParameter("email"));
                pobj.setMsnID(teasession.getParameter("msn"));

                pobj.setMemberheight(teasession.getParameter("memberheight"));
                pobj.setBallage(teasession.getParameter("ballage"));
                pobj.setAlmostscore(teasession.getParameter("almostscore"));
                pobj.setLikeitems(teasession.getParameter("likeitems"));
                pobj.setHandfoot(teasession.getParameter("handfoot"));
                pobj.setGdistance(teasession.getParameter("gdistance"));
                pobj.setYhand(teasession.getParameter("yhand"));
                pobj.setSwingrhythm(teasession.getParameter("swingrhythm"));

                int xpinpai = 0,xxinghao = 0;
                if(teasession.getParameter("xpinpai") != null && teasession.getParameter("xpinpai").length() > 0)
                {
                    xpinpai = Integer.parseInt(teasession.getParameter("xpinpai"));
                }
                if(teasession.getParameter("xxinghao") != null && teasession.getParameter("xxinghao").length() > 0)
                {
                    xxinghao = Integer.parseInt(teasession.getParameter("xxinghao"));
                }

                pobj.setWST(pobj.getTjmember(),0,null,null,xpinpai,xxinghao,teasession.getParameter("xqita"),0,0,null,null,null,null,null,null,0,null);

                //企业的

                pobj.setWoid2(teasession.getParameter("woid2"));
                pobj.setEntername(teasession.getParameter("entername"));

                String enterpic = teasession.getParameter("enterpic");

                pobj.setEnterpic(enterpic);

                pobj.setEnterwebsite(teasession.getParameter("enterwebsite"));
                pobj.setEntercontact(teasession.getParameter("entercontact"));
                pobj.setEnteraddress(teasession.getParameter("enteraddress"));
                pobj.setEnterproduct(teasession.getParameter("enterproduct"));
                pobj.setEnterweibo(teasession.getParameter("enterweibo"));
                pobj.setPersonalweibo(teasession.getParameter("personalweibo"));
                pobj.setEntertext(teasession.getParameter("entertext"));

                out.print("<script  language='javascript'>parent.f_alert();</script> ");

                return;
            } else if("GolfRegister".equals(act))
            {
                //高尔夫俱乐部高级会员 注册

                String member = teasession.getParameter("member");
                if(Profile.isExisted(member))
                {

                    out.print("<script  language='javascript'>alert('用户名已经被占用，不能重复用户名');history.go(-1);</script> ");

                    return;
                }

                String invite = teasession.getParameter("invite");

                String membername = teasession.getParameter("membername");
                int sex = 1; //默认是男
                if(teasession.getParameter("sex") != null && teasession.getParameter("sex").length() > 0)
                {
                    sex = Integer.parseInt(teasession.getParameter("sex"));
                }
                String password = teasession.getParameter("EnterPassword");

                String card = teasession.getParameter("card");
                String mobile = teasession.getParameter("mobile");
                Date birth = null;
                if(teasession.getParameter("birth") != null && teasession.getParameter("birth").length() > 0)
                {
                    birth = Entity.sdf.parse(teasession.getParameter("birth"));
                }

                String address = teasession.getParameter("address");

                int xybcheck = 0; //如果0 没有下一步 1
                if(teasession.getParameter("xybcheck") != null && teasession.getParameter("xybcheck").length() > 0)
                {
                    xybcheck = Integer.parseInt(teasession.getParameter("xybcheck"));
                }

                java.text.DecimalFormat df = new java.text.DecimalFormat("000000");

                SeqTable seq = new SeqTable();
                String code = df.format(seq.getSeqNo(teasession._strCommunity));

                Profile.create(member,password,h.community,null,request.getServerName());

                Profile pobj = Profile.find(member);

                pobj.setFirstName(membername,teasession._nLanguage);
                pobj.setSex(sex == 1 ? false : true);
                pobj.setCard(card);
                pobj.setMobile(mobile);
                pobj.setBirth(birth);
                //省市
                String city1 = teasession.getParameter("city1");

                if(city1 != null && city1.length() > 0)
                {
                    pobj.setProvince(Integer.parseInt(city1),teasession._nLanguage);
                }
                pobj.setAddress(address,teasession._nLanguage);

                pobj.setCode(code);
                pobj.setType(xybcheck);

                //默认是普通会员，审核过后才是俱乐部会员--2 没审核
                pobj.setMembertype(2);

                //选填项
                int language = h.language;

                pobj.setZzracky(teasession.getParameter("zzracky"));
                pobj.setTelephone(teasession.getParameter("telephone"),language);

                if(teasession.getParameter("zzhkszd1") != null && teasession.getParameter("zzhkszd1").length() > 0)
                {
                    pobj.setZzhkszd(teasession.getParameter("zzhkszd1"),language);
                }
                pobj.setPAddress(teasession.getParameter("paddress"),language);

                pobj.setState(teasession.getParameter("state1"),language);

                pobj.setOrganization(teasession.getParameter("organization"),language);
                pobj.setZip(teasession.getParameter("zip"),language);
                pobj.setEmail(teasession.getParameter("email"));
                pobj.setMsnID(teasession.getParameter("msn"));

                String tjmember = teasession.getParameter("tjmember");

                int source = 0;
                if(teasession.getParameter("source") != null && teasession.getParameter("source").length() > 0)
                {
                    source = Integer.parseInt(teasession.getParameter("source"));
                }

                if(source == 1)
                {
                    pobj.setTrainname(teasession.getParameter("trainname"));
                    pobj.setTrainaddress(teasession.getParameter("trainaddress"));
                    pobj.setTraintime(teasession.getParameter("traintime"));
                } else if(source == 2)
                {

                    if(invite != null && invite.length() > 0 && !"null".equals(invite))
                    {
                        //邀请的会员
                        Profile p = Profile.find(Integer.parseInt(invite));
                        tjmember = p.getCode(); //添加会员编号

                    } else
                    {
                        if(tjmember != null && tjmember.length() > 0)
                        {

                            if(!Entity.isNumeric(tjmember))
                            {
                                tjmember = Profile.getMember(tjmember);
                            }
                        }
                    }
                } else if(source == 3)
                {
                    pobj.setBelsell(teasession.getParameter("belsell"));
                }

                pobj.setSource(source);

                if(tjmember != null && tjmember.length() > 0)
                {
                    Profile p = Profile.find(Profile.getMember(tjmember));
                    //添加邀请积分
                    Communityintegral cobj = Communityintegral.find(teasession._strCommunity);

                    p.setMyintegral(p.getMyintegral() + cobj.getInvitepoint());
                    WestracIntegralLog.create(p.getMember(),3,null,0,cobj.getInvitepoint(),null,new Date(),0,teasession._strCommunity);
                }

                pobj.setMemberheight(teasession.getParameter("memberheight"));
                pobj.setBallage(teasession.getParameter("ballage"));
                pobj.setAlmostscore(teasession.getParameter("almostscore"));
                pobj.setLikeitems(teasession.getParameter("likeitems"));
                pobj.setHandfoot(teasession.getParameter("handfoot"));
                pobj.setGdistance(teasession.getParameter("gdistance"));
                pobj.setYhand(teasession.getParameter("yhand"));
                pobj.setSwingrhythm(teasession.getParameter("swingrhythm"));

                int xpinpai = 0,xxinghao = 0;
                if(teasession.getParameter("xpinpai") != null && teasession.getParameter("xpinpai").length() > 0)
                {
                    xpinpai = Integer.parseInt(teasession.getParameter("xpinpai"));
                }
                if(teasession.getParameter("xxinghao") != null && teasession.getParameter("xxinghao").length() > 0)
                {
                    xxinghao = Integer.parseInt(teasession.getParameter("xxinghao"));
                }

                pobj.setWST(tjmember,0,null,null,xpinpai,xxinghao,teasession.getParameter("xqita"),0,0,null,null,null,null,null,null,0,null);

                //企业的

                pobj.setWoid2(teasession.getParameter("woid2"));
                pobj.setEntername(teasession.getParameter("entername"));

                String enterpic = teasession.getParameter("enterpic");

                pobj.setEnterpic(enterpic);

                pobj.setEnterwebsite(teasession.getParameter("enterwebsite"));
                pobj.setEntercontact(teasession.getParameter("entercontact"));
                pobj.setEnteraddress(teasession.getParameter("enteraddress"));
                pobj.setEnterproduct(teasession.getParameter("enterproduct"));
                pobj.setEnterweibo(teasession.getParameter("enterweibo"));
                pobj.setPersonalweibo(teasession.getParameter("personalweibo"));
                pobj.setEntertext(teasession.getParameter("entertext"));

                //获取手机发送手机验证码
                //添加积分功能

                /*
                                  if(xybcheck==0)
                                  {
                 nexturl = "/jsp/westrac/WestracRegister3.jsp";
                                  }else if(xybcheck==1)
                                  {
                 nexturl= "/jsp/westrac/WestracRegister2.jsp";
                                  }
                 */

                nexturl = "/jsp/user/GolfRegister2.jsp";

                out.print("<script>window.open('" + nexturl + "','_parent');</script>");

                return;
            } else if("GenergyRegister".equals(act))
            {
                Resource r = new Resource("/tea/resource/Genergy");
                //验证码判断
                if(request.getParameter("vertify") != null)
                {
                    String vertify = (String) session.getAttribute("sms.vertify");
                    String vet = request.getParameter("vertify").trim();
                    if(vertify == null)
                    {

                    } else if(!vet.equals(vertify))
                    {
                        out.print("<script>alert('" + r.getString(teasession._nLanguage,"verrification") + "');window.location.href='" + nexturl + "';</script>");
                        return;
                    }
                }
                /*if(teasession.getParameter("vertify")!=null && teasession.getParameter("vertify").length()>0)
                              {

                    if(riobj.isRegister("verify"))
                    {
                        String vertify = (String) session.getAttribute("sms.vertify");
                        String vertify1 = request.getParameter("vertify").trim();

                        if(!vertify1.equals(vertify) && !vertify1.equals("vertify"))
                        {
                            response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"验证码输入错误 ") + "<a href=\"javascript:history.back();\">" + r.getString(teasession._nLanguage,"Tautology") + "</A>","UTF-8"));
                            return;
                        }
                    }
                              }else
                              {
                 response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"请输入验证码") + "<a href=\"javascript:history.back();\">" + r.getString(teasession._nLanguage,"Tautology") + "</A>","UTF-8"));
                       return;
                              }*/
                //用户名判断
                String MemberId = teasession.getParameter("email");
                if(Profile.isExisted(MemberId))
                {
                    out.print("<script>alert('" + r.getString(teasession._nLanguage,"eaae") + "');window.location.href='" + nexturl + "';</script>");
                    return;
                }
                String EnterPassword = teasession.getParameter("password");
                String email = MemberId;
                String firstname = teasession.getParameter("name");
                String[] field = teasession.getParameterValues("ifield");
                StringBuffer sp = new StringBuffer("/");
                if(field != null)
                {
                    for(int i = 0;i < field.length;i++)
                    {
                        sp.append(field[i]).append("/");
                    }
                }

                String unit = teasession.getParameter("unit");
                String position = teasession.getParameter("position");
                String phone = teasession.getParameter("pnumber");
                Profile.create(MemberId,EnterPassword,teasession._strCommunity,email,null,0,teasession._nLanguage,firstname,null,null,"","","","",null,"","",null,phone);
                Profile p = Profile.find(MemberId);
                p.setTitle(position,teasession._nLanguage);
                p.setOrganization(unit,teasession._nLanguage);
                p.setField(sp.toString(),teasession._nLanguage);
                p.setTime(new Date());
                int v = 0;

                if(!MemberOrder.isMemberOrder(teasession._strCommunity,membertype,0,p.getMember()))
                {

                    MemberOrder.create(membertype,0,p.getMember(),teasession._strCommunity,3,0,0);
                }

                MemberOrder mo = MemberOrder.find(MemberOrder.getMemberOrder(teasession._strCommunity,p.getMember()));
                mo.setIp(request.getRemoteAddr());

                //每注册一个用户，都用放到临时表MemberRecord 中，来标明这个用户都注册了那些类型的会员
                MemberRecord.create(p.getMember(),membertype,teasession._strCommunity);

                //建立session
//                if(myobj.getAppemail() == 0) //如果不用邮箱验证
//                {
//                    RV rv = new RV(p.getMember());
//                    Logs.create(teasession._strCommunity,rv,1,teasession._nNode,request.getRemoteAddr());
//                    OnlineList ol_obj = OnlineList.find(session.getId());
//                    ol_obj.setMember(p.getMember());
//                    session.setAttribute("tea.RV",rv);
//                } else
//                {
//                    session.setAttribute("member_id",MemberId);
//                }

                //注册设置里面的 是否关联填写类别信息relatednews
                //String next = teasession.getParameter("next"); //用户登陆后看到的注册列表跳转过来的路径，直接到支付页面
                String subject = teasession._strCommunity + r.getString(teasession._nLanguage,"ar");
                String content = r.getString(teasession._nLanguage,"rc") + ":<br>" + r.getString(teasession._nLanguage,"ty") + teasession._strCommunity + "," + r.getString(teasession._nLanguage,"pc") + "<br><a href='" + "'>" + "</a>";
                ProfileOrth.send(teasession,p);
//                Email.create(teasession._strCommunity, null, email, subject, content);
//                out.print("<script>alert('"+r.getString(teasession._nLanguage, "successInfo")+"');window.location.href='"+nexturl+"';</script>");
                response.sendRedirect("/jsp/user/UserConfirm.jsp?membertype=" + MemberOrder.getMemberType(teasession._strCommunity,MemberId) + "&user=" + java.net.URLEncoder.encode(MemberId,"UTF-8") + "&community=" + teasession._strCommunity);
                return;

            } else if("EditGenergy".equals(act))
            {

                Resource r = new Resource("/tea/resource/Genergy");
                if(h.member <= 0)
                {
                    response.sendRedirect("/servlet/StartLogin?node=" + h.node);
                    return;
                }
                String member = h.get("member");
                Profile p = Profile.find(member);
                if(Profile.isExisted(member))
                {
                    String firstname = h.get("name");
                    String[] field = h.getValues("ifield");
                    StringBuffer sp = new StringBuffer("/");
                    if(field != null)
                    {
                        for(int i = 0;i < field.length;i++)
                        {
                            sp.append(field[i]).append("/");
                        }
                    }
                    String email = h.get("email");
                    String unit = h.get("unit");
                    String position = h.get("position");
                    String phone = h.get("pnumber");

                    p.setEmail(email);
                    p.setFirstName(firstname,h.language);
                    p.setTitle(position,h.language);
                    p.setOrganization(unit,h.language);
                    p.setMobile(phone);
                    p.setField(sp.toString(),h.language);
                }

            } else if("EditGolfMmeber".equals(act))
            {

                //管理员修改
                if(teasession._rv == null)
                {
                    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                    return;
                }

                String member = teasession.getParameter("member");

                String membername = teasession.getParameter("membername");
                int sex = 1; //默认是男
                if(teasession.getParameter("sex") != null && teasession.getParameter("sex").length() > 0)
                {
                    sex = Integer.parseInt(teasession.getParameter("sex"));
                }
                String password = teasession.getParameter("EnterPassword");

                String card = teasession.getParameter("card");
                String mobile = teasession.getParameter("mobile");
                Date birth = null;
                if(teasession.getParameter("birth") != null && teasession.getParameter("birth").length() > 0)
                {
                    birth = Entity.sdf.parse(teasession.getParameter("birth"));
                }

                String address = teasession.getParameter("address");

                int xybcheck = 0; //如果0 没有下一步 1
                if(teasession.getParameter("xybcheck") != null && teasession.getParameter("xybcheck").length() > 0)
                {
                    xybcheck = Integer.parseInt(teasession.getParameter("xybcheck"));
                }

                java.text.DecimalFormat df = new java.text.DecimalFormat("000000");

                SeqTable seq = new SeqTable();

                String code = df.format(seq.getSeqNo(teasession._strCommunity));
                if(teasession.getParameter("code") != null && teasession.getParameter("code").length() > 0)
                {
                    code = teasession.getParameter("code");
                }

                Profile pobj = Profile.find(member);
                pobj.setPassword(password);
                pobj.setFirstName(membername,teasession._nLanguage);
                pobj.setSex(sex == 1 ? false : true);
                pobj.setCard(card);
                pobj.setMobile(mobile);
                pobj.setBirth(birth);

                //省市
                String city1 = teasession.getParameter("city1");

                if(city1 != null && city1.length() > 0)
                {
                    pobj.setProvince(Integer.parseInt(city1),teasession._nLanguage);
                }
                pobj.setAddress(address,teasession._nLanguage);

                pobj.setCode(code);
                pobj.setType(xybcheck);

                //修改详细信息

                int language = teasession._nLanguage;

                pobj.setZzracky(teasession.getParameter("zzracky"));
                pobj.setTelephone(teasession.getParameter("telephone"),language);

                if(teasession.getParameter("zzhkszd1") != null && teasession.getParameter("zzhkszd1").length() > 0)
                {
                    pobj.setZzhkszd(teasession.getParameter("zzhkszd1"),language);
                }
                pobj.setPAddress(teasession.getParameter("paddress"),language);

                pobj.setState(teasession.getParameter("state1"),language);

                pobj.setOrganization(teasession.getParameter("organization"),language);
                pobj.setZip(teasession.getParameter("zip"),language);
                pobj.setEmail(teasession.getParameter("email"));
                pobj.setMsnID(teasession.getParameter("msn"));

                String tjmember = teasession.getParameter("tjmember");

                int source = 0;
                if(teasession.getParameter("source") != null && teasession.getParameter("source").length() > 0)
                {
                    source = Integer.parseInt(teasession.getParameter("source"));
                }
                if(source == 1)
                {
                    pobj.setTrainname(teasession.getParameter("trainname"));
                    pobj.setTrainaddress(teasession.getParameter("trainaddress"));
                    pobj.setTraintime(teasession.getParameter("traintime"));
                } else if(source == 2)
                {

                    if(tjmember != null && tjmember.length() > 0)
                    {

                        if(!Entity.isNumeric(tjmember))
                        {
                            tjmember = Profile.getMember(tjmember);
                        }
                    }

                } else if(source == 3)
                {
                    pobj.setBelsell(teasession.getParameter("belsell"));
                }

                pobj.setSource(source);

                pobj.setMemberheight(teasession.getParameter("memberheight"));
                pobj.setBallage(teasession.getParameter("ballage"));
                pobj.setAlmostscore(teasession.getParameter("almostscore"));
                pobj.setLikeitems(teasession.getParameter("likeitems"));
                pobj.setHandfoot(teasession.getParameter("handfoot"));
                pobj.setGdistance(teasession.getParameter("gdistance"));
                pobj.setYhand(teasession.getParameter("yhand"));
                pobj.setSwingrhythm(teasession.getParameter("swingrhythm"));

                int xpinpai = 0,xxinghao = 0;
                if(teasession.getParameter("xpinpai") != null && teasession.getParameter("xpinpai").length() > 0)
                {
                    xpinpai = Integer.parseInt(teasession.getParameter("xpinpai"));
                }
                if(teasession.getParameter("xxinghao") != null && teasession.getParameter("xxinghao").length() > 0)
                {
                    xxinghao = Integer.parseInt(teasession.getParameter("xxinghao"));
                }

                // pobj.setWST(tjmember, 0, null,null, 0, 0,null,0, 0,null, null, null,null, null,null);
                pobj.setWST(tjmember,0,null,null,xpinpai,xxinghao,teasession.getParameter("xqita"),0,0,null,null,null,null,null,null,0,null);

                // 企业
                pobj.setWoid2(teasession.getParameter("woid2"));
                pobj.setEntername(teasession.getParameter("entername"));

                String enterpic = teasession.getParameter("enterpic");

                if(teasession.getParameter("clearpic") != null && teasession.getParameter("clearpic").length() > 0)
                {
                    enterpic = "";
                } else if(enterpic != null && enterpic.length() > 0)
                {} else
                {
                    enterpic = pobj.getEnterpic();
                }

                pobj.setEnterpic(enterpic);

                pobj.setEnterwebsite(teasession.getParameter("enterwebsite"));
                pobj.setEntercontact(teasession.getParameter("entercontact"));
                pobj.setEnteraddress(teasession.getParameter("enteraddress"));
                pobj.setEnterproduct(teasession.getParameter("enterproduct"));
                pobj.setEnterweibo(teasession.getParameter("enterweibo"));
                pobj.setPersonalweibo(teasession.getParameter("personalweibo"));
                pobj.setEntertext(teasession.getParameter("entertext"));

                if("GolfUpgradeMemberRegister".equals(teasession.getParameter("act2")))
                {
                    pobj.setMembertype(2); //升级会员

                    out.print("<script>window.open('" + nexturl + "','_parent');</script>");

                    return;
                }

                //审核信息
                if(pobj.getMembertype() == 2)
                {

                    if(teasession.getParameter("membertype") != null && teasession.getParameter("membertype").length() > 0)
                    {
                        membertype = Integer.parseInt(teasession.getParameter("membertype"));
                    } else
                    {
                        membertype = 2; //默认不填写 是没有审核
                    }

                    pobj.setMembertype(membertype); //审核状态

                    pobj.setVerifgmember(teasession._rv.toString());
                    pobj.setVerifgtime(new Date());

                    if(membertype == 1) //审核通过加分
                    {
                        Communityintegral cobj = Communityintegral.find(teasession._strCommunity);
                        pobj.setContributeintegral(pobj.getMyintegral() + cobj.getRegpoint());
                        WestracIntegralLog.create(pobj.getMember(),2,null,0,cobj.getRegpoint(),null,new Date(),0,teasession._strCommunity);
                    }

                }

            }

            response.sendRedirect(nexturl);
            return;

        } catch(Exception ex)
        {
            ex.printStackTrace();
        } finally
        {
            out.close();
        }

    }

    // Clean up resources
    public void destroy()
    {
    }
}
