<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%>
<%@page import="tea.entity.node.*"%><%@page import="tea.entity.admin.*"%><%

Http h=new Http(request,response);

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}
Outside t=Outside.find(h.node,h.language);

StringBuilder sql=new StringBuilder();
sql.append(" AND member NOT IN(");

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/city.js" type="text/javascript"></script>
</head>
<body>
<h1>权限——校外机构</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/Outsides.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="mt.submit()">
<input type="hidden" name="node" value="<%=h.node%>"/>
<input type="hidden" name="act" value="member"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>
<input type="hidden" name="member" value="|"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td>已选</td>
    <td></td>
    <td>备选</td>
  </tr>
  <tr>
    <td>
      <select name="member1" size="10" style="width:150px" multiple ondblclick="mt.move(this,form1.member2,true)">
      <%
      String[] arr=t.member.split("[|]");
      for(int i=1;i<arr.length;i++)
      {
        out.print("<option value='"+arr[i]+"'>"+arr[i]);
        sql.append(DbAdapter.cite(arr[i])).append(",");
      }
      %>
      </select>
    </td>
    <td>
      <input type="button" value="&lt;&lt;" onclick="form1.member2.ondblclick()"/><br/>
      <input type="button" value="&gt;&gt;" onclick="form1.member1.ondblclick()"/>
    </td>
    <td>
      <select name="member2" size="10" style="width:150px" multiple ondblclick="mt.move(this,form1.member1,true)">
      <%
      Enumeration e=AdminUsrRole.findByCommunity(h.community,sql.append("'')").toString());
      while(e.hasMoreElements())
      {
        String member=(String)e.nextElement();
        out.print("<option value='"+member+"'>"+member);
      }
      %>
      </select>
    </td>
  </tr>
</table>

<br/>
<input type="submit" value="提交" onclick="mt.submit()" /> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>
mt.submit=function()
{
  form1.member.value=mt.value(form1.member1,'|');
};
</script>

</body>
</html>
