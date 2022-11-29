<%@page contentType="text/html;charset=UTF-8"  %><%@page import="java.util.*" %><%@page import="tea.db.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.ui.*" %><%@page import="tea.resource.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.node.*" %><%request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}


String community=teasession._strCommunity;


Communityjob communityjob=Communityjob.find(community);


//Purview purview=Purview.find(teasession._rv.toString(),community);
if(!teasession._rv.toString().equalsIgnoreCase(communityjob.getJobmember()) && !License.getInstance().getWebMaster().equals(teasession._rv.toString()))
{
  response.sendError(403);
  return;
}

StringBuffer scriptsb = new StringBuffer();


int pagesize = 25;
int pos=0;
String _strPos = request.getParameter("pos");
if(_strPos!=null)
pos=Integer.parseInt(_strPos);


tea.resource.Resource r=new tea.resource.Resource("/tea/resource/Job");


String nexturl = java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8");

String info=request.getParameter("info");
if(info==null)
{
  info=r.getString(teasession._nLanguage,"1167441852562");
}
String sql=" AND( role LIKE '/%/' OR company LIKE '/%/' ) AND member IN(SELECT profile FROM Profile WHERE community="+DbAdapter.cite(community)+")";
int count=AdminUsrRole.count(community,sql);

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1><%=info+"("+count+")"%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<FORM name=form1 method="post" target="_ajax" action="/jsp/user/yjobnewuser.jsp">
<input type='hidden' name=community VALUE="<%=community%>">
<input type='hidden' name=nexturl VALUE="<%=request.getRequestURI()+"?"+request.getQueryString()%>">
<input type='hidden' name=member VALUE="">
<input type='hidden' name=act VALUE="">

<table id="tablecenter" cellpadding="0" cellspacing="0">
<tr ID=tableonetr>
  <td nowrap><%=r.getString(teasession._nLanguage,"1167441890296")%><!--用户ID--></td>
  <td nowrap><%=r.getString(teasession._nLanguage,"1167441920125")%><!--姓名--></td>
  <td nowrap>E-Mail</td>
  <td nowrap><%=r.getString(teasession._nLanguage,"1167441941562")%><!--电话--></td>
  <td nowrap><%=r.getString(teasession._nLanguage,"1167441966390")%><!--操作--></td>
</tr>
<%
java.util.Enumeration e=AdminUsrRole.find(community,sql,pos,pagesize);
while(e.hasMoreElements())
{
  String member=(String)e.nextElement();
  Profile profile = Profile.find(member);
  String email=profile.getEmail();
  out.print("<tr onMouseOver=\"javascript:this.bgColor='#BCD1E9'\" onMouseOut=\"javascript:this.bgColor=''\">");
  out.print("<td>"+member);
  out.print("<td>&nbsp;"+profile.getFirstName(teasession._nLanguage)+" "+profile.getLastName(teasession._nLanguage));
  out.print("<td>&nbsp;<a href=mailto:"+email+" >"+email+"</a>");
  out.print("<td>&nbsp;"+profile.getTelephone(teasession._nLanguage));
  out.print("<td><input type=button value="+r.getString(teasession._nLanguage,"CBEdit")+" onclick=\"f_act('edit','"+member+"');\" >");
  out.print(" <input type=button value="+r.getString(teasession._nLanguage,"CBDelete")+" onclick=\"f_act('del','"+member+"')\" >");
}
%>
</table>
<%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+"?community="+community+"&pos=",pos,count) %>
<!--创建用户-->
<input type=submit VALUE="<%=r.getString(teasession._nLanguage,"1167442056718")%>" ID="CBNew" onclick="f_act('edit','');">
</form>

<script>
function f_act(a,m)
{
  form1.act.value=a;
  form1.member.value=m;
  if(a=='del')
  {
    mt.show("<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>",2,"form1.submit()");
  }else if(a=='edit')
  {
    form1.method='get';
    form1.target='_self';
    form1.submit();
  }
}
</script>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
</body>
</html>
