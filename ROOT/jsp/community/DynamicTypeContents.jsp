<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="java.util.*"%>
<%@page import="java.net.*"%>
<%@page import="java.io.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.ui.TeaSession"%><%
request.setCharacterEncoding("UTF-8");
response.setHeader("Cache-Control", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

int dynamictype=Integer.parseInt(request.getParameter("dynamictype"));

DynamicType dt=DynamicType.find(dynamictype);
String content=dt.getContent(teasession._nLanguage);

Resource r=new Resource();


%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script type="">
function f_act(id,act)
{
  if(act=='delete')
  {
    if(!confirm('确认删除?'))
    {
      return;
    }
    form1.method="post";
  }
  form1.id.value=id;
  form1.act.value=act;
  form1.submit();
}
</script>
</head>
<body>

<h1><%=r.getString(teasession._nLanguage, "编辑内容")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<form name="form1" action="/jsp/community/EditDynamicTypeContent.jsp">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="dynamictype" value="<%=dynamictype%>">
<input type="hidden" name="id" value="">
<input type="hidden" name="act" value="">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr id=tableonetr>
  <td>序号</td>
  <td>标题</td>
  <td>操作</td>
</tr>
<%
StringTokenizer st = new StringTokenizer(content, "/");
for(int i=1;st.hasMoreTokens();)
{
  String str=st.nextToken();
  if(!"-".equals(str))
  {
	  out.print("<tr><td>"+i);
	  out.print("<td>"+str);
	  out.print("<td><input type=button value="+r.getString(teasession._nLanguage,"CBEdit")+" onclick=f_act('"+str+"','edit')>");
	  out.print("<input type=button value="+r.getString(teasession._nLanguage,"CBDelete")+" onclick=f_act('"+str+"','delete')>");
	  i++;
  }
}
%>
</table>

<input type=button value="<%=r.getString(teasession._nLanguage,"CBNew")%>" onclick="f_act('','new');">

</form>

</body>
</html>
