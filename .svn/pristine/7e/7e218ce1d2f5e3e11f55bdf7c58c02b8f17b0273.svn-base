<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.*"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.util.*" %>
<%@page import="java.io.*" %>
<% request.setCharacterEncoding("UTF-8");

Http h=new Http(request);


TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}

Table.post(Table.GTYPE,h,response);

int tid=h.getInt("tid");
Table t=Table.find(Table.GTYPE,tid);


%><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<BODY> 
<h1>添加球场类型</h1>
<div id="head6"><img height="6" src="about:blank"></div>

  <form name="form1" action="?" method="post" onsubmit="return submitText(this.name,'名称不能为空!');">
  <input type="hidden" name="community" value="<%=h.community%>" />
  <input type="hidden" name="nexturl" value="/jsp/type/golf/GTypes.jsp" />
  <input type="hidden" name="tid" value="<%=tid%>" />
    <table id="tablecenter">
      <tr>
        <td>名称</td>
        <td><input type="text" name="name" value="<%=MT.f(t.name)%>"></td>
      </tr>
      <tr>
        <td>顺序</td>
        <td><input type="text" name="sequence" value="<%if(t.sequence>0)out.print(t.sequence);%>" mask="int"></td>
      </tr>
    </table>
  <br>
  <input type="submit" value="提交">
  <input type="button" value="返回" onclick="history.back();"/>
</form>
<script>form1.name.focus();</script>
</BODY></html>
