<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter" %><%@page import="tea.resource.Resource" %><%@page import="tea.entity.node.*" %><%@page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

String _strId=request.getParameter("id");

StringBuffer param=new StringBuffer();
param.append("?community=").append(teasession._strCommunity);
param.append("&node=").append(teasession._nNode);
param.append("&id=").append(_strId);

Resource r=new Resource();
r.add("/tea/resource/Company");

StringBuffer sql=new StringBuffer(" AND type=21 AND community=");
sql.append(DbAdapter.cite(teasession._strCommunity));
sql.append(" AND rcreator=").append(DbAdapter.cite(teasession._rv._strR));

int type=0;
String q=request.getParameter("q");
if(q!=null&&(q=q.trim()).length()>0)
{
  param.append("&q="+java.net.URLEncoder.encode(q,"UTF-8"));
  sql.append(" AND node IN ( SELECT node FROM NodeLayer nl WHERE nl.subject LIKE ").append(DbAdapter.cite("%"+q+"%")).append(")");
}

int pos=0;
String _strPos=request.getParameter("pos");
if(_strPos!=null)
{
  pos=Integer.parseInt(_strPos);
}
int count=Node.count(sql.toString());



%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>

<h1>公司管理</h1>
<div id="head6"><img height="6" alt=""></div>

<h2>查询</h2>
<FORM  name=form1 METHOD=GET action="?" >
<input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
<input type='hidden' name=community VALUE="<%=teasession._strCommunity%>">
<input type='hidden' name=id VALUE="<%=_strId%>">

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Name")%>:<input type="TEXT" name="q" size="40" MAXLENGTH="255" VALUE="<%if(q!=null)out.print(q);%>"></td>
      <td><input type="submit" value="GO" /></td>
    </tr>
  </table>
</form>
<br>

<h2>列表 ( <%=count%> )</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<TR id="tableonetr">
      <td>名称</td>
      <td>类型</td>
      <td>人气</td>
      <td>时间</td>
      <td></td>
</tr>
<%
java.util.Enumeration e=Node.find(sql.toString(),pos,25);
while(e.hasMoreElements())
{
   int id=((Integer)e.nextElement()).intValue();
   Node obj=Node.find(id);
   out.print("<tr onmouseover=\"javascript:this.bgColor='#BCD1E9';\" onMouseOut=\"javascript:this.bgColor='';\" >");
   out.print("<td>"+obj.getSubject(teasession._nLanguage)+"</td>");
   out.print("<td>"+Node.find(obj.getFather()).getSubject(teasession._nLanguage)+"</td>");
   out.print("<td>"+obj.getClick()+"</td>");
   out.print("<td>"+obj.getTimeToString()+"</td>");
   out.print("<td><input type=button value="+r.getString(teasession._nLanguage,"CBEdit")+" onclick=\"window.open('/jsp/type/company/EditCompany.jsp?node="+id+"','_self');\"/>");
   out.print("<input type=button value="+r.getString(teasession._nLanguage,"CBDelete")+" onclick=\"if(confirm('"+r.getString(teasession._nLanguage,"ConfirmDelete")+"')){window.open('/servlet/DeleteNode?node="+id+"&nexturl='+encodeURI(document.location), '_self')};\"/></td></tr>");
}
%>
<tr><td colspan="3" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString()+ "&pos=", pos, count)%></td></tr>
</table>

<input type="button" onclick="window.open('/jsp/type/company/EditCompany.jsp?NewNode=ON&node=<%=teasession._nNode%>&community=<%=teasession._strCommunity%>','_self');" value="<%=r.getString(teasession._nLanguage,"CBNew")%>"/>


<div id="head6"><img height="6" alt=""></div>
</body>
</html>
