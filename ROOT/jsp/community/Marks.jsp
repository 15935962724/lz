<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.*" %><%@page import="tea.db.DbAdapter" %><%@page  import="tea.resource.Resource"  %><%@page  import="tea.entity.site.*" %><%@page import="java.util.*" %><%@page import="tea.ui.*" %><%
request.setCharacterEncoding("UTF-8");


Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

Resource r=new Resource();


String rt=h.get("type");

int pos=0;
String tmp=request.getParameter("pos");
if(tmp!=null)pos=Integer.parseInt(tmp);

String sql=" AND community="+DbAdapter.cite(h.community);
StringBuffer par=new StringBuffer();
par.append("?community=").append(h.community);
par.append("&id=").append(request.getParameter("id"));
par.append("&pos=");

int sum=Mark.count(sql);

String title=r.getString(h.language, "节点分类");

%>
<html>
<head>
<title><%=title%></title>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<script type="">
function f_edit(id,act)
{
  mt.show('/jsp/community/EditMark.jsp?community='+form2.community.value+"&mark="+id+"&act="+act,2,'',400,130);
}
</script>
</head>
<body>
<h1><%=title%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<%--
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>名称:<input name="name" value="<%if(name!=null)out.print(name);%>" type="text"><input type="submit" value="GO"></td>
  </tr>
</table>
</form>
<br>

<h2>列表 ( <%=count %> )</h2>
--%>
<form name="form2" action="/servlet/EditClasses" method="post">
<input type="hidden" name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>"/>
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="classid" value="0"/>
<input type="hidden" name="act" value="del"/>
<input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td>&nbsp;</td>
    <td><%=r.getString(h.language, "名称")%></td>
    <td><%=r.getString(h.language, "类型")%></td>
    <td>&nbsp;</td>
  </tr>
<%
if(sum<1)
out.print("<tr><td colspan='20'>暂无记录！");
else
{
  ArrayList e=Mark.find(sql,pos,10);
  for(int i=0;i<e.size();i++)
  {
    Mark obj=(Mark)e.get(i);
    out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
    out.print("<td>"+(i+pos+1));
    out.print("<td>"+obj.name);
    out.print("<td>"+CLicense.getName(obj.getType(),h.language));
    out.println("<td><input type='button' value="+r.getString(h.language, "CBEdit")+" onClick=f_edit("+obj.mark+");>");
    out.print("<input type='button' value="+r.getString(h.language, "CBDelete")+" onClick=f_edit("+obj.mark+",'del');>");
  }
  if(sum>10)out.print("<tr><td colspan='4' align='right'>"+new tea.htmlx.FPNL(h.language,par.toString(),pos,sum,10));
}
%>
</table>

<input type="button" value="<%=r.getString(h.language, "CBNew")%>" ID="CBNew" CLASS="CB" onClick="f_edit(0)">
</form>

<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
