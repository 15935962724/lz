<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%>
<%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}

int node=h.getInt("node");
Node n=Node.find(node);
Course t;

String subject=null,content=null;
Date starttime=null,stoptime=null;
if(n.getType()==1)
{
  t=new Course(0,h.language);
  Calendar c=Calendar.getInstance();
  c.add(Calendar.MONTH,1);
  t.regstop=c.getTime();
}else
{
  subject=n.getSubject(h.language);
  content=n.getText(h.language);
  starttime=n.getStartTime();
  stoptime=n.getStopTime();

  t=Course.find(h.node,h.language);
}

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>添加/编辑——课程管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/Courses.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="node" value="<%=node%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl","")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td class="th">课程名称：</td>
    <td><input name="subject" value="<%=MT.f(subject)%>" size="40" alt="课程名称"/></td>
  </tr>
  <tr>
    <td class="th">培训机构：</td>
    <td><input name="org" value="<%=MT.f(t.org)%>" size="40"/></td>
  </tr>
  <tr>
    <td class="th">培训时间：</td>
    <td><input name="starttime" value="<%=MT.f(starttime)%>" onclick="mt.date(this)" class="date"/>至<input name="stoptime" value="<%=MT.f(stoptime)%>" onclick="mt.date(this)" class="date"/></td>
  </tr>
  <tr>
    <td class="th">培训地址：</td>
    <td><input name="address" value="<%=MT.f(t.address)%>" size="40"/></td>
  </tr>
  <tr>
    <td class="th">联系电话：</td>
    <td><input name="tel" value="<%=MT.f(t.tel)%>"/></td>
  </tr>
  <tr>
    <td class="th">培训费用：</td>
    <td><input name="price" value="<%=t.price==0?"":String.valueOf(t.price)%>" size="10" mask="float"/>元</td>
  </tr>
  <tr>
    <td class="th">报名截止时间：</td>
    <td><input name="regstop" value="<%=MT.f(t.regstop)%>" onclick="mt.date(this)" class="date"/></td>
  </tr>
  <tr>
    <td class="th">内容简介：</td>
    <td>
      <textarea name="content" cols="90" rows="12" style="display:none"><%=MT.f(content)%></textarea>
      <iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=<%=h.community%>" width="730" height="300" frameborder="no" scrolling="no"></iframe>
    </td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>mt.focus();</script>
</body>
</html>
