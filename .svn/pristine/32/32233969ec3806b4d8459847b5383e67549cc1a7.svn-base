<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %>
<%@ page import="tea.html.*" %><%@ page import="java.math.*" %><%@ page import="tea.entity.member.*" %>
<%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.node.*" %>
<%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String s = request.getParameter("Member");
if(s == null)
if(teasession._rv != null)
{
  s = teasession._rv._strR;
} else
{
  response.sendRedirect("/servlet/StartLogin");
  return;
}
Resource r=new Resource("/tea/ui/member/profile/ProfileServlet");r.add("/tea/ui/member/profile/Coupons");

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Profile")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="PathDiv"><A href="/jsp/access/Glance.jsp?Member=<%=java.net.URLEncoder.encode(s,"UTF-8")%>" TARGET="_blank"><%=s%></A> ><%=r.getString(teasession._nLanguage, "Profile")%></div>
<UL>
  <%
            boolean flag = teasession._rv != null && teasession._rv._strR.equals(s);
            if(flag)
            {%>
  <LI><A href="/servlet/LoginHistory"><%=r.getString(teasession._nLanguage, "LoginHistory")%></A> </LI>
  <%              if(teasession._rv.isHR())
                {%>
  <LI><A href="/servlet/Associates"><%=r.getString(teasession._nLanguage, "Associates")%></A> </LI>
  <%              }
		if(teasession._rv.isAccountant())
                {%>
  <LI><A href="/servlet/BuyInstructions"><%=r.getString(teasession._nLanguage, "BuyInstructions")%></A> </LI>
  <LI><A href="/servlet/Shippings"><%=r.getString(teasession._nLanguage, "Shippings")%></A> </LI>
  <LI><A href="/servlet/Coupons"><%=r.getString(teasession._nLanguage, "Coupons")%></A> </LI>
  <%              }
            }%>
</UL>
<%          boolean flag1 = false;
            boolean flag2 = false;
            if(teasession._rv != null)
            {
                flag1 = ProfileRequest.isExisted(s, teasession._rv);
                flag2 = s.equals(teasession._rv._strR) || teasession._rv.isWebMaster() || ProfileGrant.isExisted(s, teasession._rv) || tea.entity.site.Subscriber.inOrganizer(s, teasession._rv._strR);
            }
            Profile profile = Profile.find(s);%>
<FONT ID=MemberId><%=s%> <FONT ID=MemberName> <%//=ts.hrefNewMessage(s, RequestHelper.makeName(teasession._nLanguage, profile.getFirstName(teasession._nLanguage), profile.getLastName(teasession._nLanguage)))%> <br/>
<%          if(flag2 || profile.getType() == 1)
            {
              %>
<FONT ID=MemberEmail><%//=ts.hrefNewMessage(profile.getEmail())%><br/>
<%              String s1 = profile.getOrganization(teasession._nLanguage);
                if(s1!=null&&s1.length() != 0)
                {%>
<%=r.getString(teasession._nLanguage, "Organization")%>:
<%                  Text text4 = new Text(s1);
                    text4.setId("MemberOrganization");
                    out.print(text4);
                }
                String s3 = profile.getWebPage(teasession._nLanguage);
                if(s3!=null&&s3.length() != 0)
                {
                    out.print(new Text(" " + r.getString(teasession._nLanguage, "WebPage") + ": "));
                    Anchor anchor = new Anchor((s3.toLowerCase().startsWith("http://") ? "" : "http://") + s3, s3, "_blank");
                    out.print(anchor);
                }
                String s4 = profile.getAddress(teasession._nLanguage);
                if(s4!=null&&s4.length() != 0)
                {
                    out.print(new Text(" " + r.getString(teasession._nLanguage, "Address") + ":"));
                    Text text5 = new Text(s4);
                    text5.setId("MemberAddress");
                    out.print(text5);
                }
                String s5 = profile.getCity(teasession._nLanguage);
                if(s5!=null&&s5.length() != 0)
                {
                    out.print(new Text(" " + r.getString(teasession._nLanguage, "City") + ":"));
                    Text text6 = new Text(s5);
                    text6.setId("MemberCity");
                    out.print(text6);
                }
                String s6 = profile.getState(teasession._nLanguage);
                if(s6!=null&&s6.length() != 0)
                {
                    out.print(new Text(" " + r.getString(teasession._nLanguage, "State") + ":"));
                    Text text7 = new Text(s6);
                    text7.setId("MemberState");
                    out.print(text7);
                }
                String s7 = profile.getZip(teasession._nLanguage);
                if(s7!=null&&s7.length() != 0)
                {
                    out.print(new Text(" " + r.getString(teasession._nLanguage, "Zip") + ":"));
                    Text text8 = new Text(s7);
                    text8.setId("MemberZip");
                    out.print(text8);
                }
                String s8 = profile.getCountry(teasession._nLanguage);
                if(s8!=null&&s8.length() != 0)
                {
                    out.print(new Text(" " + r.getString(teasession._nLanguage, "Country") + ":"));
                    Text text9 = new Text(s8);
                    text9.setId("MemberCountry");
                    out.print(text9);
                }
                String s9 = profile.getTelephone(teasession._nLanguage);
                if(s9!=null&&s9.length() != 0)
                {
                    out.print(new Text(" " + r.getString(teasession._nLanguage, "Telephone") + ":"));
                    Text text10 = new Text(s9);
                    text10.setId("MemberTelephone");
                    out.print(text10);
                }
                String s10 = profile.getFax(teasession._nLanguage);
                if(s10!=null&&s10.length() != 0)
                {
                    out.print(new Text(" " + r.getString(teasession._nLanguage, "Fax") + ":"));
                    Text text11 = new Text(s10);
                    text11.setId("MemberFax");
                    out.print(text11);
                }
            } else
            if(flag1)
            {    out.print(r.getString(teasession._nLanguage, "InfAlreadyRequestedProfile"));
            }else
            {
			    out.print(new Anchor("/servlet/RequestProfile?Member=" + s, new Text(r.getString(teasession._nLanguage, "RequestProfile")), "return(confirm('" + r.getString(teasession._nLanguage, "ConfirmRequest") + "'));"));
            }%>
<br/>
<%			if(flag && teasession._rv.isSupport())
            {%>
<input type="button" value="<%=r.getString(teasession._nLanguage, "CBEditAddress")%>" ID="CBEditAddress" CLASS="CB" onClick="window.open('/servlet/EditAddress', '_self');">
<br/>
<br/>
<%          }
            Home home = Home.find(teasession._strCommunity,s);
            String picture=home.getPicture(teasession._nLanguage);
            String voice=home.getVoice(teasession._nLanguage);
            String file=home.getFile(teasession._nLanguage);
            String s2 = home.getContent(teasession._nLanguage);

            if(s2 != null)
                out.print(s2);
            if(picture!=null&&picture.length()>0)
            out.print(new Image(picture));
            if(voice!=null&&voice.length()>0)
            {%>
<input type="button" value="<%=r.getString(teasession._nLanguage, "CBPlay")%>" ID="CBPlay" CLASS="CB" onClick="window.open('<%=voice%>', '_self');">
<%          }
	if(file!=null&&file.length()>0)
            {%>
<input type="button" value="<%=r.getString(teasession._nLanguage, "CBDownload")%>" ID="CBDownload" CLASS="CB" onClick="<%out.print("window.open('/jsp/include/DownFile.jsp?uri="+java.net.URLEncoder.encode(file,"UTF-8")+"&name="+java.net.URLEncoder.encode(home.getFileName(teasession._nLanguage),"UTF-8")+"','_self');");%>" >
<%          }%>
<br/>
<%          if(flag && teasession._rv.isSupport())
            {%>
<input type="button" value="<%=r.getString(teasession._nLanguage, "CBEdit")%>" ID="CBEdit" CLASS="CB" onClick="window.open('/servlet/EditHome', '_self');">
<%          }
			if(flag && teasession._rv.isReal())
            {%>
<input type="button" value="<%=r.getString(teasession._nLanguage, "CBChangePassword")%>" ID="CBChangePassword" CLASS="CB" onClick="window.open('/servlet/ChangePassword', '_self');">
<input type="button" value="<%=r.getString(teasession._nLanguage, "CBCancelMemberShip")%>" ID="CBCancelMemberShip" CLASS="CB" onClick="window.open('/servlet/CancelMembership', '_self');">
<%          }%>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>

