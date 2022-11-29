<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import = "tea.entity.site.Community" %>
<%@ page import = "tea.entity.node.*" %>
<%@ page import = "tea.entity.member.*" %>
<%@ page import="tea.htmlx.Languages"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import = "tea.resource.Resource" %>
<%@ page import = "tea.entity.member.*" %>
<%@ page import="tea.ui.TeaServlet"%>
<%@page import="tea.entity.admin.mov.MemberType"%>
<%@page import="tea.entity.admin.mov.RegisterInstall"%>
<%@page import="tea.entity.admin.AdminRole"%>
<%@page import="tea.entity.admin.mov.*"%>

<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession = new TeaSession(request);
 Resource r=new Resource("/tea/resource/AdminList");
 r.add("tea/ui/util/SignUp1").add("/tea/ui/node/type/sms/EditUser");
 teasession._nLanguage =0;
 String act = teasession.getParameter("act");
            String nu = teasession.getParameter("nexturl");
            boolean _bAffirm = teasession.getParameter("affirm") != null;
            boolean _bCancel = teasession.getParameter("cancel") != null;
            String MemberId = teasession.getParameter("MemberId");
System.out.println("调用ValidateProfile.jsp");
int membertype = 0;
if(teasession.getParameter("membertype")!=null && teasession.getParameter("membertype").length()>0 &&!"null".equals(teasession.getParameter("membertype")))
{
	membertype = Integer.parseInt(teasession.getParameter("membertype"));
}else
{  
	membertype = MemberOrder.getMemberType(teasession._strCommunity,teasession.getParameter("member"));
}
            if (_bAffirm) // 确认会员
            {
                MemberId = teasession.getParameter("member");
                if (!Profile.isExisted(MemberId))
                { // 1169607402250=该会员不存在或已经取消了验证. <A href="/">回首页</A> <A href="javascript:window.opener=null;windown.close();">关闭</A>
                   // response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "1169607402250"), "UTF-8"));
                    response.sendRedirect("/jsp/info/Succeed.jsp?type=2&Language=0");
                    return;
                } 
                Profile p = Profile.find(MemberId);  
                if (Profile.findValid(MemberId)==1) 
                { // 1169607851484=该会员已经通过验证了,无需在此验证. <A href="/">回首页</A> <A href="javascript:window.opener=null;windown.close();">关闭</A>
                	  response.sendRedirect("/jsp/info/Succeed.jsp?type=3&Language=0");
                    //response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "1169607851484"), "UTF-8"));
                    return;
                }
      
                String dig = BBS.md5(MemberId + p.getTime().getTime());
                String validate = teasession.getParameter("validate");
                if (dig.equals(validate))
                { 
                    p.setValidate(true);
                    //修改审核状态
                    String memberobder = tea.entity.admin.mov.MemberOrder.getMemberOrder(teasession._strCommunity,membertype,teasession.getParameter("member"));
                    tea.entity.admin.mov.MemberOrder moobj = tea.entity.admin.mov.MemberOrder.find(memberobder);
                	MemberType mtobj = MemberType.find(membertype);
                     
                	
                   
                	 RegisterInstall robj = RegisterInstall.find(membertype);
                	
                	  
                	 AdminRole arobj = AdminRole.find(Integer.parseInt(mtobj.getRole()));
                	 if(arobj.getType()==0){
                    //设置权限  
                   		 tea.entity.admin.AdminUsrRole.create(teasession._strCommunity,MemberId,"/"+MemberType.find(membertype).getRole()+"/","/",0,"/",null);
	                   	 if(robj.getVerify()==1)//需要审核
	                   	 {
	                        	moobj.setVerifg(1);
	                   	 }
                	 }
                    
                	 
                  //如果验证成功了就自动登陆系统了  
                    tea.entity.RV rv = new tea.entity.RV(MemberId);
                    Logs.create(teasession._strCommunity,rv,1,teasession._nNode,request.getRemoteAddr());
                     
                    OnlineList ol_obj = OnlineList.find(session.getId());
                    if(ol_obj.getCommunity() != null && ol_obj.getCommunity().length() > 0)
                    {
                        ol_obj.setMember(MemberId);
                    } else
                    { 
                        OnlineList.create(session.getId().toString(),teasession._strCommunity,MemberId,request.getRemoteAddr());
                        ol_obj.setMember(MemberId);
                    }

                    //
                    Community c = Community.find(teasession._strCommunity);
                    if(c.isSession())
                    {
                        session.setAttribute("tea.RV",rv);
                    } else 
                    {
                        Cookie cs = new Cookie("tea.RV",java.net.URLEncoder.encode(MemberId + "," + tea.service.SMS.md5(String.valueOf(p.getTime().getTime())),"UTF-8"));
                        cs.setPath("/");
                        String sn = request.getServerName();
                        int j = sn.indexOf(".");
                        if(j != -1 && sn.charAt(sn.length() - 1) > 96)
                        {
                            cs.setDomain(sn.substring(j));
                        }
                        response.addCookie(cs);
                    }
              
                    if(mtobj.getFileurl()!=null && mtobj.getFileurl().length()>0)
                    {
                    	response.sendRedirect(mtobj.getFileurl());
                    }else
                    {
                    	response.sendRedirect("/jsp/info/Succeed.jsp?type=1&Language=0");
                    }
                     
                } else
                {
                	
                	
                    // 1169607769453=验证码错误. <A href="/">回首页</A> <A href="javascript:window.opener=null;windown.close();">关闭</A>
                   // response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "1169607769453"), "UTF-8"));
                    response.sendRedirect("/jsp/info/Succeed.jsp?type=4");
                }
                return;
            } else // 取消会员
            if (_bCancel)
            {
                MemberId = teasession.getParameter("member");
                if (!Profile.isExisted(MemberId))
                { // 1169607402250=该会员不存在或已经取消了验证. <A href="/">回首页</A> <A href="javascript:window.opener=null;windown.close();">关闭</A>
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "1169607402250"), "UTF-8"));
                    return;
                }
                Profile p = Profile.find(MemberId);
                if (p.isValidate())
                { // 1169607667296=该会员已经验证了,不能取消. <A href="/">回首页</A> <A href="javascript:window.opener=null;windown.close();">关闭</A>
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "1169607667296"), "UTF-8"));
                    return;
                }
             
                String dig = BBS.md5(MemberId + p.getTime().getTime());
                String validate = teasession.getParameter("validate");
                if (dig.equals(validate))
                {
                    if (request.getParameter("ok") == null)
                    {
                        response.setContentType("text/html;charset=UTF-8");
                        
                        out.print("<HTML><HEAD>                                                                       ");
                        out.print("<link href=/res/" + teasession._strCommunity + "/cssjs/community.css rel=stylesheet type=text/css>             ");
                        out.print("<SCRIPT LANGUAGE=JAVASCRIPT SRC=/tea/tea.js  ></SCRIPT>                            ");
                        out.print("<meta http-equiv=Content-Type content=text/html; charset=UTF-8 >                   ");
                        out.print("</HEAD>                                                                            ");
                        out.print("<body>                                                                             ");
                        out.print("<h1>" + r.getString(teasession._nLanguage, "INFO") + "</h1>                            ");
                        out.print("<div id=head6><img height=6></div>                                                 ");
                        out.print("<form action=\"/servlet/EditProfileBBS\" method=post >");
                        out.print("<input type=hidden name=validate2 value=" + request.getParameter("validate2") + " >");
                        out.print("<input type=hidden name=validate value=" + validate + " >");
                        out.print("<input type=hidden name=member value=" + MemberId + " >");
                        out.print("<input type=hidden name=community value=" + teasession._strCommunity + " >");
                        out.print("<input type=hidden name=Node value=" + teasession._nNode + " >");
                        out.print("<input type=hidden name=cancel value=ON >");
                        out.print("<table border=0 cellpadding=0 cellspacing=0 id=tablecenter >                       ");
                        out.print("<tr><td>" + r.getString(teasession._nLanguage, "MemberId") + "</td><td>" + MemberId + "</td></tr>                    ");
                        out.print("<tr><td>" + r.getString(teasession._nLanguage, "EmailAddress") + "</td><td>" + p.getEmail() + "</td></tr>                    ");
                        out.print("<tr><td>" + r.getString(teasession._nLanguage, "1169608574768") + "</td><td>" + p.getTime() + "</td></tr>                    ");
                        out.print("<tr><td colspan=2 align=center>" + r.getString(teasession._nLanguage, "1169608574765") + "</td></tr>");
                        out.print("<tr><td colspan=2 align=center><input type=submit name=ok value=" + r.getString(teasession._nLanguage, "1169608574766") + ">  <input type=button value=" + r.getString(teasession._nLanguage, "1169608574767") + " onclick=\" window.opener=null;window.open('/','_self'); \" ></td></tr></table>");
                        out.print("</form></DIV>                                                                             ");
                        out.print("<div id=head6><img height=6></div>                                                 ");
                        out.print("</body>                                                                            ");
                        out.print("</HTML>                                                                            ");
                        out.close();
                    } else
                    {
                        p.delete(teasession._nLanguage);
                        response.sendRedirect("/jsp/info/Succeed.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "CancelSucceed"), "UTF-8"));
                    }
                } else
                {
                    // 1169607769453=验证码错误. <A href="/">回首页</A> <A href="javascript:window.opener=null;windown.close();">关闭</A>
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "1169607769453"), "UTF-8"));
                }
                return;
            }
%>
