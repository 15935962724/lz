<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.ui.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.html.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.site.*" import="tea.resource.*" import="java.util.*" import="java.io.*"%>
<%
TeaSession teasession = new TeaSession(request);

Resource r=new Resource();

Enumeration e = CssJs.find(" AND node="+teasession._nNode+" AND theme=1",0,200);
if(!e.hasMoreElements())
{
  out.print("<script>alert('不存在模板主题!'); history.back();</script>");
  return;
}

%><html>
<head>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1>主题选择</h1>
<div id="head6"><img height="6" src="about:blank"></div>


<form name="form1" action="/servlet/EditCssJs" method="post" >
<input type="hidden" name="node" value="<%=teasession._nNode%>"/>
<input type="hidden" name="act" value="theme" />

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%
for(int i=0;e.hasMoreElements();i++)
{
   int id = ((Integer)e.nextElement()).intValue();
   CssJs cj =CssJs.find(id);
   if(i%5==0)out.print("<tr>");
   boolean flag=i==0||Cssjshide.find(id,teasession._nNode).getHiden()!=0;
   out.print("<td onmouseover=bgColor='#BCD1E9' onmouseout=bgColor=''><img src='"+cj.getPicture()+"'/><br/><input name='cssjs' type='radio' value='"+id+"' ");
   if(flag)out.print(" checked=''");
   out.print(" id='cssjs_"+id+"' /><label for='cssjs_"+id+"'>"+cj.getName(teasession._nLanguage)+"</label>");
}
%>
</table>


<input type="submit" value="提交" />
</form>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
