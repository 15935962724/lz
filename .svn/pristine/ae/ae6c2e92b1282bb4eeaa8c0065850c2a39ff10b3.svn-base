<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %><%@ page import="java.math.*" %><%@ page import="tea.entity.member.*" %>
<%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.node.*" %>
<%@ page import="tea.entity.*" %><%@ page import="tea.ui.*" %><%@page import="tea.entity.util.*"%>
<% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Profile p=Profile.find(teasession._rv._strV);

Resource r=new Resource();

int showcount=Integer.parseInt(request.getParameter("showcount"));
int igd=Integer.parseInt(request.getParameter("menuid"));

String sn=request.getServerName()+":"+request.getServerPort();
String jsessionid=request.getParameter("jsessionid");
if(jsessionid!=null)
	jsessionid="&jsessionid="+jsessionid;
else
	jsessionid="";


/*
out.print("<div id=ftl_"+igd+"_"+j+" class=uftl><a href='javascript:void(0)' id='ft_"+igd+"_"+j+"' class='fmaxbox' onclick='_IG_FR_toggle("+igd+","+j+")'></a>");
out.print("  <a target=_blank href=http://"+sn+"/servlet/Node?node="+node_id+"&Language="+teasession._nLanguage+jsessionid+" >"+obj.getSubject(teasession._nLanguage)+"</a><br>");
out.print("  <div id=fb_"+igd+"_"+j+" class='fpad fb' style='display:none'>");
out.print(text);
out.print("  </div>");
out.print("</div>");
*/


%>
<A target="_blank" href="http://<%=sn%>/jsp/user/EditAddress.jsp?community=<%=teasession._strCommunity+jsessionid%>" >编辑档案文件</A><br>
<SPAN ID=profilephoto><img src="<%=p.getPhotopath(teasession._nLanguage)%>" ></SPAN><br>
<SPAN ID=profilename>姓名:<%=p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage)%></SPAN><br>
<%
String email=p.getEmail();
if(email!=null&&email.length()>0)
{
	out.println("<SPAN ID=profileemail>E-Mail:"+email+"</SPAN><br>");
}
String org=p.getOrganization(teasession._nLanguage);
if(org!=null&&org.length()>0)
{
	out.println("<SPAN ID=profileorg>公司:"+org+"</SPAN><br>");
}
String address=p.getAddress(teasession._nLanguage);
if(address!=null&&address.length()>0)
{
	out.println("<SPAN ID=profileaddress>地址:"+address+"</SPAN><br>");
}
String zip=p.getZip(teasession._nLanguage);
if(zip!=null&&zip.length()>0)
{
	out.println("<SPAN ID=profilezip>邮编:"+zip+"</SPAN><br>");
}
String birth=p.getBirthToString();
if(birth!=null&&birth.length()>0)
{
	out.println("<SPAN ID=profilebirth>年龄:"+birth+"</SPAN>");
}
%>


