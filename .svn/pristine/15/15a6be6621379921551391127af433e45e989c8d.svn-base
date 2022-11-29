<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.site.*" %><%@page import="java.util.*" %><%@page import="java.io.*" %><%@page import="tea.ui.*" %><%

Cluster c=Cluster.getInstance();
String act=request.getParameter("act");
if("sync".equals(act))
{
  Date time=null;
  String tmp=request.getParameter("time");
  if(tmp!=null)
  {
    time=new Date(Long.parseLong(tmp));
  }
  c.list(out,time);
  return;
}

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String path=c.getPath();
String host=c.getHost();
if("POST".equals(request.getMethod()))
{
  if("manual".equals(act))
  {
    Date time = Community.sdf.parse(request.getParameter("timeYear")+"-"+teasession.getParameter("timeMonth")+"-"+teasession.getParameter("timeDay"));
    c.sync(time);
  }else
  {
    path=teasession.getParameter("path");
    host=teasession.getParameter("host");
    if(host.length()<1)
    {
      host=null;
    }
    c.set(path,host);
    response.sendRedirect("/jsp/info/Succeed.jsp");
  }
  return;
}

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link type="text/css" rel="stylesheet" href="/tea/community.css">
<script type="text/javascript" src="/tea/tea.js"></script>
</head>
<body>

<h1>集群-文件同步设置</h1>
<form name="form1" action="?" method="post" onsubmit="returm submitText(this.path,'无效-路径')">

<table id="tablecenter">
  <tr>
    <td>RES路径:</td>
    <td><input type="text" name="path" value="<%=path%>" />本地的资源文件夹名.</td>
  </tr>
  <tr>
    <td>主机:</td>
    <td><input type="text" name="host" size="50" value="<%if(host!=null)out.print(host);%>" />多个有“,”分隔.</td>
  </tr>
</table>
<input type="submit" value="提交" />
</form>

注: 每5秒差异备份一次,每天晚上12点校对7天内的文件.

<h2>手动同步</h2>
<form name="form2" action="?" method="post" >
<input type="hidden" name="act" value="manual"/>
<%=new tea.htmlx.TimeSelection("time", null)%>
<input type="submit" value="提交" />
</form>

</body>
</html>
