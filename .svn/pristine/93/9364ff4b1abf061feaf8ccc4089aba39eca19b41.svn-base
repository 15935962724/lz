<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.net.URLDecoder"%>
<%@page import="tea.entity.Entity"%>
<%@   page   language="java"   import="java.util.*"   %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %><%@page import="tea.entity.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

int id=Integer.parseInt(teasession.getParameter("id"));
DayOrder t=DayOrder.find(id);

String ymd = teasession.getParameter("ymd");

if("POST".equals(request.getMethod()))
{
  //道教的日历
  Date ydate = null;
  if(teasession.getParameter("ymd")!=null && teasession.getParameter("ymd").length()>0)
  {
    ydate = Entity.sdf.parse(teasession.getParameter("ymd"));
  }

  String text =teasession.getParameter("content");
  DayOrder dobj = DayOrder.find(DayOrder.getId(teasession._strCommunity,ydate));
  if(DayOrder.getId(teasession._strCommunity,ydate)>0)
  {
    dobj.set(text);
  }else
  {
    DayOrder.create(text,ydate,teasession._strCommunity,teasession._rv.toString());
  }
  out.println("<script>parent.ymPrompt.close();parent.window.location.reload()</script>");
  return;
}

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/ym/ymPrompt.js" type=""></SCRIPT>
<link href="/tea/ym/skin/simple/ymPrompt.css" rel="stylesheet" type="text/css">
</head>
<body>
<form name="sm" method="post" action="?">
<input type="hidden" name="id" value="<%=id%>">
<input type="hidden" name="ymd" value="<%=ymd%>">
<table   border="0"   width="168"   height="20">
  <tr id="TableControl">
    <td>
      <textarea style="display:none" name="content" rows="12" cols="90" class="edit_input"><%=MT.f(t.getAffaircontent())%></textarea>
      <iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=<%=teasession._strCommunity%>" width="740" height="300" frameborder="no" scrolling="no"></iframe>
    </td>
</table>
<input type="submit" value="提交" >
<input type="button" value="关闭" onclick="parent.ymPrompt.close()"/>
</form>

</body>
</html>
