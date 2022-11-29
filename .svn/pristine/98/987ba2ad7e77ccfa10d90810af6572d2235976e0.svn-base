<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@ page  import="java.util.*" %><%@ page  import="tea.entity.node.*" %><%@ page  import="tea.entity.bbs.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}



Resource r=new Resource();

BBSForum f=BBSForum.find(teasession._nNode);


%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function f_act(url,n)
{
  form1.action=url;
  form1.node.value=n;
  form1.nexturl.value=location;
  form1.submit();
}
</script>
</head>
<body>

<h1>论坛设置</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<form name="form1" action="?" >
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="node" />
<input type="hidden" name="nexturl"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%
Iterator it=Category.find(teasession._strCommunity,57,0,200).iterator();
while(it.hasNext())
{
  int nid=((Integer)it.next()).intValue();
  Node n=Node.find(nid);
  out.println("<tr onMouseOver=bgColor='#FFFFCA' onMouseOut=bgColor=''>");
  out.println("<td>"+n.getAnchor(teasession._nLanguage));
  out.println("<td><input type='button' value='积分设置' onclick=f_act('/jsp/type/bbs/SetBBSForumPoint.jsp',"+nid+"); />");
  out.println("<input type='button' value='权限设置' onclick=f_act('/jsp/type/bbs/SetBBSForumLevel.jsp',"+nid+"); />");
}
%>
</table>

</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
