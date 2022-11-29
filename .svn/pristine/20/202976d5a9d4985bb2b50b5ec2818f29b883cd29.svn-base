<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}

InfraredGroup t=InfraredGroup.find(h.getInt("infraredgroup"));


%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>编辑——红外相机首选图</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/Infrareds.do?repository=infraredgroup&resize=170" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="infraredgroup" value="<%=t.infraredgroup%>"/>
<input type="hidden" name="act" value="gedit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td class="th">名称：</td>
    <td><%=MT.f(t.name)%></td>
  </tr>
  <tr>
    <td class="th">数量：</td>
    <td><%=t.count%></td>
  </tr>
  <tr>
    <td class="th">图片：</td>
    <td><input type="file" name="picture" value="<%=MT.f(t.picture)%>"/>
    <%
    if(t.picture>0)
    {
      Attch a=Attch.find(t.picture);
      out.println("<a href=javascript:mt.img('"+a.path+"')>查看</a>");
      out.println("<input type='checkbox' name='clear' id='clear' onclick='form1.picture.disabled=checked'/><label for='clear'>清空</label>");
    }
    %>
    </td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>mt.focus();</script>
</body>
</html>
