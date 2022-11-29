<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}

int node=h.getInt("node");
Node n=Node.find(node);

SPicture t;
if(n.getType()==1)
{
  t=new SPicture(0);
}else
{
  t=SPicture.find(node);
}

int specimen=h.getInt("specimen");
Specimen s=Specimen.find(specimen);
Node ns=Node.find(specimen);

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>添加/编辑——图片</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/SPictures.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="node" value="<%=node%>"/>
<input type="hidden" name="specimen" value="<%=specimen%>"/>
<input type="hidden" name="reserve" value="<%=s.reserve%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<input type="hidden" name="subject" value="<%=ns.getSubject(h.language)%>"/>
<table id="tablecenter" cellspacing="0">
  <tr>
    <td class="th">标本：</td>
    <td><%=ns.getAnchor(h.language)%></td>
  </tr>
  <tr>
    <td class="th">保护区：</td>
    <td><%=Node.find(s.reserve).getAnchor(h.language)%></td>
  </tr>
  <tr>
    <td class="th">文件名：</td>
    <td><input name="mulname" value="<%=MT.f(t.mulname)%>" size="50"/></td>
  </tr>
  <tr>
    <td class="th">多媒体类型：</td>
    <td><input name="multype" value="<%=MT.f(t.multype)%>"/></td>
  </tr>
  <tr>
    <td class="th">主题词：</td>
    <td><input name="keywords" value="<%=MT.f(t.keyword)%>"/></td>
  </tr>
  <tr>
    <td class="th">版权人：</td>
    <td><input name="copyrightowner" value="<%=MT.f(t.copyrightowner)%>"/></td>
  </tr>
  <tr>
    <td class="th">备注：</td>
    <td><textarea name="content" cols="60" rows="5"><%=MT.f(t.remark)%></textarea></td>
  </tr>
  <tr>
    <td class="th">资源归类码：</td>
    <td><input name="zyglm" value="<%=MT.f(t.zyglm)%>"/></td>
  </tr>
  <tr>
    <td class="th">拍摄时间：</td>
    <td><%=MT.f(t.time,1)%></td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>mt.focus();</script>
</body>
</html>
