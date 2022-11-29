<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%>
<%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

int menuid=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
par.append("&community="+h.community+"&id="+menuid);

int father=h.getInt("father");
int node=h.getInt("node");

String subject=null,content=null,subject0=null,content0=null,subject1=null,content1=null;
int red=0,blue=0;
if(node>0)
{
  Enumeration es=Node.findAllSons(node);
  red=((Integer)es.nextElement()).intValue();
  blue=((Integer)es.nextElement()).intValue();

  Node n=Node.find(node);
  subject=n.getSubject(h.language);
  content=n.getText(h.language);

  n=Node.find(red);
  subject0=n.getSubject(h.language);
  content0=n.getText(h.language);

  n=Node.find(blue);
  subject1=n.getSubject(h.language);
  content1=n.getText(h.language);
}

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
</head>
<body>
<h1>观点碰撞</h1>
<div id="head6"><img height="6" src="about:blank"></div>


<form name="form1" action="/NFasts.do" method="post" target="_ajax" onsubmit="return mt.check(this)&&mt.show(null,0)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="father" value="<%=father%>"/>
<input type="hidden" name="node" value="<%=node%>"/>
<input type="hidden" name="red" value="<%=red%>"/>
<input type="hidden" name="blue" value="<%=blue%>"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>
<input type="hidden" name="act" value="opinionedit"/>
<table id="tablecenter" cellspacing="0">
  <tr>
    <td>标题:</td>
    <td><input type="text" name="subject" value="<%=MT.f(subject)%>" size="50" alt="标题"></td>
  </tr>
  <tr>
    <td>内容:</td>
    <td>
      <textarea style="display:none" name="content" rows="12" cols="90"><%=MT.f(content)%></textarea>
      <iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=<%=h.community%>" width="730" height="300" frameborder="no" scrolling="no"></iframe>
    </td>
    <tr>
      <td colspan="2"><h2>红方</h2>
    </tr>
    <tr>
      <td>标题</td>
      <td><input type="text" name="subject0" value="<%=MT.f(subject0)%>" size="50" alt="红方标题"></td>
    </tr>
    <tr>
      <td>内容</td>
      <td>
        <textarea style="display:none" name="content0" rows="12" cols="90"><%=MT.f(content0)%></textarea>
        <iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content0&Toolbar=<%=h.community%>" width="730" height="250" frameborder="no" scrolling="no"></iframe>
      </td>
    </tr>
    <tr>
      <td colspan="2"><h2>蓝方</h2>
    </tr>
    <tr>
      <td>标题</td>
      <td><input type="text" name="subject1" value="<%=MT.f(subject1)%>" size="50" alt="蓝方标题"></td>
    </tr>
    <tr>
      <td>内容</td>
      <td>
        <textarea style="display:none" name="content1" rows="12" cols="90"><%=MT.f(content1)%></textarea>
        <iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content1&Toolbar=<%=h.community%>" width="730" height="250" frameborder="no" scrolling="no"></iframe>
      </td>
    </tr>
  </table>
<br/>
<input type="submit" value="提交"/>
<input type="button" value="返回" onClick="history.back()">
</form>

<script>
mt.focus(document.form1);
</script>


</body>
</html>
