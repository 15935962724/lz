<%@page contentType="text/html;charset=utf-8" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.entity.bpicture.*" %><%@ page import="java.util.*" %><%@ page import="java.math.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.*" %><%@ page import="tea.ui.*" %><%@page import="tea.entity.util.*"%><% request.setCharacterEncoding("utf-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/Node?node=2198284&language=1");
  return;
}

Profile p=Profile.find(teasession._rv._strV);

Resource r=new Resource();

int showcount=Integer.parseInt(request.getParameter("showcount"));
int igd=Integer.parseInt(request.getParameter("igd"));

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
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style></head>
<body id=leftupbottom>
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" id=index_profile_table>
  <tr>
    <td align="left">
<%--<<SPAN ID=profilephoto><img src="<%=p.getPhotopath(teasession._nLanguage)%>" onerror="onerror=null;src=src.substring(src.indexOf('/',9));" ></SPAN><br>--%>
欢迎您&nbsp;<SPAN ID=profilename><%=p.getFirstName(teasession._nLanguage)%></SPAN>
<SCRIPT>
var today=new Date();
var hour=today.getHours()

var hello;
if(hour < 6)hello='早上好'
else if(hour < 9)hello='早上好'
else if(hour < 11)hello='上午好'
else if(hour < 13)hello='中午好'
else if(hour < 19)hello='下午好'
else if(hour < 22)hello='晚上好'
else {hello='晚上好'}

if(today.getDay()==0)day='星期日'
else if(today.getDay()==1)day='星期一'
else if(today.getDay()==2)day='星期二'
else if(today.getDay()==3)day='星期三'
else if(today.getDay()==4)day='星期四'
else if(today.getDay()==5)day='星期五'
else if(today.getDay()==6)day='星期六'

var date=(today.getYear())+'年'+(today.getMonth() + 1 )+'月'+today.getDate()+'日';
//var date=(today.getYear())+'-'+(today.getMonth() + 1 )+'-'+today.getDate()+'';
document.write("　　"+hello+"！ 现在是："+date+"　　");
</SCRIPT>

<%
//String email=p.getEmail();
//if(email!=null&&email.length()>0)
//{
//	out.println("<SPAN ID=profileemail>E-Mail:"+email+"</SPAN><br>");
//}
//String org=p.getOrganization(teasession._nLanguage);
//if(org!=null&&org.length()>0)
//{
//	out.println("<SPAN ID=profileorg>公司:"+org+"</SPAN><br>");
//}
//String address=p.getAddress(teasession._nLanguage);
//if(address!=null&&address.length()>0)
//{
//	out.println("<SPAN ID=profileaddress>地址:"+address+"</SPAN><br>");
//}
//String zip=p.getZip(teasession._nLanguage);
//if(zip!=null&&zip.length()>0)
//{
//	out.println("<SPAN ID=profilezip>邮编:"+zip+"</SPAN><br>");
//}
//String birth=p.getBirthToString();
//if(birth!=null&&birth.length()>0)
//{
//	out.println("<SPAN ID=profilebirth>生日:"+birth+"</SPAN><br>");
//}
AdminUsrRole aur=AdminUsrRole.find(teasession._strCommunity,teasession._rv.toString());
int unit=aur.getUnit();
String role = aur.getRole() ;
String rs[]=role.split("/");
String sfname = "注册会员";
if(!teasession._strCommunity.equals("bigpic")){
  out.print("您所在的部门：<SPAN ID=profileunit>"+(unit>0?AdminUnit.find(unit).getName():"无部门")+"</SPAN>");
}else
{
sfname="买家";
}
out.print("　　你的身份：<SPAN ID=profilerole>"+(rs.length>1?AdminRole.find(Integer.parseInt(rs[1])).getName():sfname)+"</SPAN>");
%></td>
  </tr>
</table>
</body>
</html>
