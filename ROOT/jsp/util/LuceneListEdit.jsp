<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%>
<%@page import="tea.entity.util.*"%><%@page import="tea.resource.*" %><%

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Http h=new Http(request,response);

Resource r=new Resource("/tea/resource/Lucene");

int lucenelist=h.getInt("lucenelist");
LuceneList t=LuceneList.find(lucenelist);


%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>添加/编辑——搜索管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/Lucenes.do" method="post" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="lucenelist" value="<%=lucenelist%>"/>
<input type="hidden" name="act" value="ledit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td>名称：</td>
    <td><input name="name" value="<%=MT.f(t.name)%>" alt="名称"/></td>
  </tr>
  <tr>
    <td>类型：</td>
    <td><%=new tea.htmlx.TypeSelection(h.community,h.language,t.type, false)%></td>
  </tr>
  <tr>
    <td>排序类型：</td>
    <td><select name="sorttype"><%=h.options(LuceneList.SORT_TYPE,t.sorttype)%></select></td>
  </tr>
  <tr>
    <td>排除节点：</td>
    <td><input name="node_not" value="<%=MT.f(t.node_not)%>"/> 多个请用“,”分隔。</td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>mt.focus();</script>
</body>
</html>
