<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%>
<%@page import="java.io.*" %>
<%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}
//h.member=teasession._rv.toString();


Node n=Node.find(h.node);
People t;

String subject=null,content=null,keywords=null,file=null,picture=null;
long l2=0;
if(n.getType()==1)
{
  t=new People(0,h.language);
}else
{
  subject=n.getSubject(h.language);
  content=n.getText(h.language);
  file=n.getFile(h.language);
  picture=n.getPicture(h.language);

  t=People.find(h.node,h.language);
}



%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>添加/编辑——人物</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/Peoples.do?repository=people" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="node" value="<%=h.node%>"/>
<input type="hidden" name="act" value="edit"/>
<%
String nexturl=h.get("nexturl");
if(nexturl!=null)
{
  out.print("<input type='hidden' name='nexturl' value="+h.get("nexturl")+" />");
}
%>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td>姓名：</td>
    <td><input name="subject" value="<%=MT.f(subject)%>" size="30" alt="姓名"/></td>
    <td>性别：</td>
    <td><select name="sex"><%=h.options(People.SEX_TYPE,t.sex)%></select></td>
  </tr>
  <tr>
    <td>单位名称：</td>
    <td><input name="org" value="<%=MT.f(t.org)%>" size="30"/></td>
    <td>职务：</td>
    <td><input name="job" value="<%=MT.f(t.job)%>"/></td>
  </tr>
  <tr>
    <td>电话：</td>
    <td><input name="tel" value="<%=MT.f(t.tel)%>"/></td>
    <td>手机：</td>
    <td><input name="mobile" value="<%=MT.f(t.mobile)%>"/></td>
  </tr>
  <tr>
    <td>电子邮箱：</td>
    <td><input name="email" value="<%=MT.f(t.email)%>"/></td>
    <td>头像：</td>
    <td><input type="file" name="picture" />
      <%
      if(picture!=null)
      {
        out.print("<a href='"+picture+"' target='_blank'>查看</a>");
        out.print("<input type='checkbox' name='clear' onclick='form1.picture.disabled=checked'>清空");
      }
      %>
      <input type="checkbox" name="tbn"/>自动缩小图片
    </td>
  </tr>
  <tr>
    <td>国籍：</td>
    <td><input name="nationality" value="<%=MT.f(t.nationality)%>"/></td>
    <td>籍贯：</td>
    <td><input name="place" value="<%=MT.f(t.place)%>"/></td>
  </tr>
  <tr>
    <td>出生年月：</td>
    <td><input name="birth" value="<%=MT.f(t.birth)%>" onclick="mt.date(this)" class="date"/></td>
  </tr>
  <tr>
    <td>毕业院校：</td>
    <td><input name="school" value="<%=MT.f(t.school)%>"/></td>
    <td>学历：</td>
    <td><input name="degree" value="<%=MT.f(t.degree)%>"/></td>
  </tr>
  <tr>
    <td>简介：</td>
    <td colspan="3">
      <textarea style="display:none" name="content" rows="12" cols="90" class="edit_input"><%=MT.f(content)%></textarea>
      <iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=<%=h.community%>" width="740" height="300" frameborder="no" scrolling="no"></iframe>
    </td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>mt.focus();</script>
</body>
</html>
