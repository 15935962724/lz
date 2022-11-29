<%@page contentType="text/html;charset=UTF-8"  %><%@page import="java.util.*" %><%@page import="tea.ui.*" %><%@page import="tea.resource.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.node.*" %><%

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

Node node=Node.find(teasession._nNode);


if(!node.isCreator(teasession._rv))
{
  response.sendError(403);
  return;
}

int id=0;
if(teasession.getParameter("id")!=null)
id=Integer.parseInt(teasession.getParameter("id"));



tea.resource.Resource r=new tea.resource.Resource("/tea/resource/Job");

String nexturl=request.getRequestURI()+"?"+request.getContextPath();//request.getParameter("nexturl");


%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
  <HEAD>
    <script src="/tea/tea.js" type="text/javascript"></script>
    <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script type="text/javascript">
function submitSelect(obj,text)
{
  if(obj.selectedIndex==0)
  {
    alert(text);
    obj.focus();
    return false;
  }
  return true;
}
</script>
  </HEAD>
  <body >
<h1><%=r.getString(teasession._nLanguage,"1167470941156")%><!--教育背景--></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" method="post" action="/servlet/EditEducate"  >
<input type="hidden" name="node" value="<%=teasession._nNode%>" />
<input type="hidden" name="id" value="<%=id%>" />
<input type="hidden" name="nexturl" value="<%=nexturl%>" />

<h2><%=r.getString(teasession._nLanguage,"1167443831593")%><!--列表--></h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr ID=tableonetr>
    <td><%=r.getString(teasession._nLanguage,"Time")%><!--Time--></td>
    <td><%=r.getString(teasession._nLanguage,"1167471003140")%><!--学校名称--></td>
    <td><%=r.getString(teasession._nLanguage,"1167471030656")%><!--专业名称--></td>
    <td><%=r.getString(teasession._nLanguage,"1167446517671")%><!--学历--></td>
    <td></td>
  </tr>
  <%
  java.util.Enumeration e1=Educate.find(teasession._nNode,teasession._nLanguage);
  if(!e1.hasMoreElements())
  {
    out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
  }

  while(e1.hasMoreElements())
  {
    Educate educateobj=Educate.find(((Integer)e1.nextElement()).intValue());

    %>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td><%=educateobj.getStart("yyyy/MM")%>--<%=educateobj.getStop("yyyy/MM")%></td>
      <td><%=educateobj.getSchool()%></td>
      <td><%=educateobj.getMajorName()%></td>
      <td><%=educateobj.getDegree(teasession._nLanguage)%></td>
      <td><input class="edit_button" type=button name=Edit value="<%=r.getString(teasession._nLanguage,"CBEdit")%>" onClick="window.open('EditEducate2.jsp?id=<%=educateobj.getId()%>&node=<%=teasession._nNode%>&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self')"/>
        <input  class="edit_button" type=button name=Edit value="<%=r.getString(teasession._nLanguage,"CBDelete")%>" onClick="if(confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>')){window.open('/servlet/DeleteEducate?id=<%=educateobj.getId()%>&node=<%=teasession._nNode%>&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self')};"/>
</td>
    </tr>

    <%} %>
</table>
<input  type="button" value="添加教育背景" onclick="window.open('/jsp/type/resume/EditEducate2.jsp?node=<%=teasession._nNode%>&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self');"  />
</form>

<h1><%=r.getString(teasession._nLanguage,"1167457783859")%><!--工作经验--></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form2" method="post" action="/servlet/EditEmployments" >
<input type="hidden" name="node" value="<%=teasession._nNode%>" />
<input type="hidden" name="id" value="<%=id%>" />
<input type="hidden" name="nexturl" value="<%=nexturl%>" />

<h2><%=r.getString(teasession._nLanguage,"1167443831593")%><!--列表--></h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr ID=tableonetr>
    <td><%=r.getString(teasession._nLanguage,"单位名称")%><!--公司名称--> </td>
    <td><%=r.getString(teasession._nLanguage,"Time")%><!--时间--></td>
    <td><%=r.getString(teasession._nLanguage,"1167465522578")%><!--工作地点--></td>
    <td><%=r.getString(teasession._nLanguage,"1167454389921")%><!--职位名称--></td>
    <td></td>
  </tr>
  <%
  java.util.Enumeration e2=Employment.find(teasession._nNode,teasession._nLanguage);
  if(!e2.hasMoreElements())
  {
    out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
  }
  while(e2.hasMoreElements())
  {
    Employment educateobj=Employment.find(((Integer)e2.nextElement()).intValue());
    %>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td><%=educateobj.getOrgName()%></td>
      <td><%=educateobj.getStartDate("yyyy/MM")%>--<%=educateobj.getEndDate("yyyy/MM")%></td>
      <td><%=educateobj.getWorkSite()%></td>
      <td><%=educateobj.getPositionName()%></td>
      <td><input class="edit_button" type=button name=Edit value="<%=r.getString(teasession._nLanguage,"CBEdit")%>" onClick="window.open('EditEmployment2.jsp?node=<%=teasession._nNode%>&id=<%=educateobj.getId()%>&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self')"/>
        <input class="edit_button" type=button name=Edit value="<%=r.getString(teasession._nLanguage,"CBDelete")%>" onClick="if(confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>')){window.open('/servlet/DeleteEmployment?node=<%=teasession._nNode%>&id=<%=educateobj.getId()%>&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self')};"/> </td>
    </tr>
    <%} %>
  </table>
<input  type="button" value="添加工作经验" onclick="window.open('/jsp/type/resume/EditEmployment2.jsp?node=<%=teasession._nNode%>&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self');"  />
  </form>
</div>

<h1><%=r.getString(teasession._nLanguage,"职业资格")%><!--职业资格--></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<h2><%=r.getString(teasession._nLanguage,"1167443831593")%><!--列表--></h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr ID=tableonetr>
  <td><%=r.getString(teasession._nLanguage,"Time")%><!--时间--></td>
  <td><%=r.getString(teasession._nLanguage,"1167537108875")%><!--认证级别--></td>
  <td><%=r.getString(teasession._nLanguage,"1167537108875")%><!--发证单位--></td>
  <td></td>
</tr>
<%
java.util.Enumeration enumeration=Professional.find(teasession._nNode,teasession._nLanguage);
if(!enumeration.hasMoreElements())
  {
    out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
  }
while(enumeration.hasMoreElements())
{
  int ids=((Integer)enumeration.nextElement()).intValue();
  Professional professionalobj=Professional.find(ids);

%>
	<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
          <td><%=professionalobj.getBegdaToString()%> -- <%=professionalobj.getEnddaToString()%></td>
          <td><%=Professional.ZRZJB_TYPE[professionalobj.getZrzjb()]%></td>
          <td><%=professionalobj.getZfzdw()%></td>
        <td><input  type=button  value="<%=r.getString(teasession._nLanguage,"CBEdit")%>" onClick="window.open('EditProfessional2.jsp?professional=<%=ids%>&node=<%=teasession._nNode%>&community=<%=teasession._strCommunity%>&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self')"/>

             <input class="edit_button" type=button name=Edit value="<%=r.getString(teasession._nLanguage,"CBDelete")%>" onClick="if(confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>')){window.open('EditProfessional2.jsp?node=<%=teasession._nNode%>&delete=delete&professional=<%=ids%>&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self')};"/> </td>
        </td>
	</tr>

    <%} %>
</table>
<input  type="button" value="添加职业资格" onclick="window.open('/jsp/type/resume/EditProfessional2.jsp?node=<%=teasession._nNode%>&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self');"  />
<br>
<br>
<input type="button"  name="btnSaveAndNext2" value="<%=r.getString(teasession._nLanguage,"1167472219140")%>" onClick="window.open('/jsp/type/resume/EditResume.jsp?EditNode=ON&node=<%=teasession._nNode%>&nexturl=/jsp/type/resume/Resume.jsp%3F','_self');"/>
<input  type="button" value="完成简历" onclick="window.open('/jsp/type/resume/Resume.jsp','_self');"  />
  </body>
</HTML>

