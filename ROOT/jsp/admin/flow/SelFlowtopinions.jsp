<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter"%> <%@ page import="tea.resource.Resource"%><%@ page import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource();

StringBuffer sql=new StringBuffer();

int type=Integer.parseInt(request.getParameter("type"));
sql.append(" AND type="+type);
if(type==1)
{
  sql.append(" AND member="+DbAdapter.cite(teasession._rv._strV));
}
String q=request.getParameter("q");
if(q!=null&&q.length()>0)
{
  sql.append(" AND content LIKE "+DbAdapter.cite("%"+q+"%"));
}

%><html>
<head>
<title>意见选择</title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script type="">

function f_act(id)
{
  var v=document.getElementById('ftoc'+id).value;
  window.returnValue=v;
  window.close();
}
</script>
</head>
<body>

<h2>查询</h2>
<form action="?">
<input type=hidden name="community" value="<%=teasession._strCommunity%>">
<input type=hidden name="type" value="<%=type%>">

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td>内容<input name="q" value="<%if(q!=null)out.print(q);%>"></td>
      <td><input type="submit" value="查询"/></td>
    </tr>
  </table>
</form>

<h2>列表</h2>
<form name=form2 action="/jsp/admin/flow/EditFlowtopinion.jsp">
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<input type=hidden name="flowtopinion" value="0"/>
<input type="hidden" name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td nowrap>序号</td>
    <td nowrap>内容</td>
    <td>操作</td>
  </tr>
<%
java.util.Enumeration enumer=Flowtopinion.find(teasession._strCommunity,sql.toString());
for(int i=1;enumer.hasMoreElements();i++)
{
  int flow=((Integer)enumer.nextElement()).intValue();
  Flowtopinion obj=Flowtopinion.find(flow);
  String content=obj.getContent();
  out.print("<textarea id='ftoc"+flow+"' style='display:none'>"+content+"</textarea>");
  if(content.length()>100)
  {
    content=content.substring(0,100)+"..";
  }
  if(q!=null)
  {
    content=content.replaceAll(q,"<font color='red'>"+q+"</font>");
  }
%>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
  <td align="center"><%=i%></td>
  <td><%=content%></td>
  <td align="center" nowrap>
    <input type="button" value="选择" onClick="f_act(<%=flow%>);" />
  </td>
</tr>
<%
}
%>
</table>
</form>


<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</HTML>
