<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.*" %><%@ page import="java.util.*" %><%@ page import="tea.entity.site.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.resource.*" %><%@ page import="tea.ui.*" %><%@ page import="tea.entity.node.*" %><%request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

CommunityOption co=CommunityOption.find(teasession._strCommunity);
int subday=co.getInt("subday");
String subnode=co.get("subnode");
String customnode="0";
if(co.get("customnode")!=null){
	customnode=co.get("customnode");
}

int pos=0;
String tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}

Resource r=new Resource();

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>

<h1>订阅管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>可以订阅的栏目</h2>
<form name="form1" method="post" action="/servlet/Subscibes" >
<script type="">document.write("<input type='hidden' name='nexturl' value='"+document.location.href+"' />");</script>
<input type="hidden" name="act" value="set"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%
DbAdapter db=new DbAdapter();
try
{
  db.executeQuery("SELECT DISTINCT n.node FROM Node n,Category c WHERE n.node=c.node AND n.community="+db.cite(teasession._strCommunity)+" AND n.type=1 AND n.finished=1 AND c.category=39");
  for(int i=0;db.next();i++)
  {
    int node=db.getInt(1);
    if(i%5==0)
    {
      out.print("<tr>");
    }
    out.println("<td><input name='nodes' type='checkbox' value="+node+" id='"+i+"'");
    if(subnode.indexOf("/"+node+"/")!=-1)
    {
      out.print(" checked ");
    }
    out.print("/><label for='"+i+"'>"+Node.find(node).getSubject(teasession._nLanguage)+"</label>");
  }
}finally
{
  db.close();
}
%>
</table>
<input type="checkbox" onClick="selectAll(form1.nodes,checked)" id="sa"/><label for="sa">全选</label><br>
自定义节点<input type="text" name="customnode" value="<%=customnode%>">

<h2>自动发送周期</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td>间隔<input type="text" name="day" value="<%=subday%>" mask="int" />天,发送一次订阅.</td></tr>
</table>

<input type="submit" value="提交"/>
</form>

<h2>引用</h2>
<textarea cols="60" rows="3" readonly="readonly" onFocus="select()">&lt;script src=&quot;/jsp/subscibe/IncSubscibe.jsp&quot;&gt;&lt;/script&gt;</textarea>

<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
