<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.stat.*"%><%

Http h=new Http(request,response);

int taskmgr=h.getInt("taskmgr");
TaskMgr t=TaskMgr.find(taskmgr);


%><html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>任务管理器——查看</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/TaskMgrs.do" method="post" target="_ajax">
<input type="hidden" name="taskmgr" value="<%=taskmgr%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td>名称</td>
    <td><%=MT.f(t.name)%></td>
    <td>标题</td>
    <td><%=MT.f(t.title)%></td>
  </tr>
  <tr>
    <td>PID</td>
    <td><%=MT.f(t.pid)%></td>
    <td>状态</td>
    <td><%=TaskMgr.STATUS_TYPE[t.status]%></td>
  </tr>
  <tr>
    <td>CPU 使用</td>
    <td><%=t.cpu%>%</td>
    <td>内存使用量</td>
    <td><%=MT.f(t.memusage)%>k</td>
  </tr>
  <tr>
    <td>用户名</td>
    <td><%=MT.f(t.username)%></td>
    <td>会话名</td>
    <td><%=MT.f(t.sessionname)%></td>
  </tr>
  <tr>
    <td>运行时间</td>
    <td><%=MT.f(t.stime,1)%></td>
    <td>终止时间</td>
    <td><%=MT.f(t.etime,1)%></td>
  </tr>
  <tr>
    <td>命令行</td>
    <td colspan="3"><%=MT.f(t.command)%></td>
  </tr>
</table>

<!--
<table id="tablecenter" cellspacing="0">
<tr><td><script>mt.embed('/tea/mt/chart.swf','100%',200,'data-file=/TaskMgrs.do?act=cpu&loading=%E6%AD%A3%E5%9C%A8%E5%88%86%E6%9E%90...');</script>
<tr><td><script>mt.embed('/tea/mt/chart.swf','100%',200,'data-file=/TaskMgrs.do?act=mem&loading=%E6%AD%A3%E5%9C%A8%E5%88%86%E6%9E%90...');</script>
</table>
-->
<br/>
<input type="button" value="结束" onclick="mt.act('kill')"/>
<input type="button" value="返回" onclick="history.back();"/>
</form>

<script>
mt.act=function(a)
{
  form1.act.value=a;
  form1.submit();
}
</script>
</body>
</html>
