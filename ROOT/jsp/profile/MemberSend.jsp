<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.ui.*"%><%@page import="tea.entity.member.*"%><%

Http h=new Http(request,response);
TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  out.print("<script>alert('您还没有登录或登录已超时，请重新登录！');top.location.replace('/');</script>");
  return;
}

String act=h.get("act");
String member=h.get("member");

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<form name="form2" action="/Members.do" method="post" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="act" value="send"/>
<input type="hidden" name="member" value="<%=member%>"/>
<input type="hidden" name="<%=act%>" value="on"/>
<table id="tablecenter" cellspacing="0">
  <tr>
    <td>用户</td>
    <td><%=member.substring(1).replace(',','；')%></td>
  </tr>
  <tr>
    <td>主题</td>
    <td><input name="subject" size="40" alt="主题"></td>
  </tr>
  <tr>
    <td>内容</td>
    <td><textarea style="display:none" name="content"></textarea><iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=MySetting" width="450" height="300" frameborder="no" scrolling="no"></iframe>
    </td>
  </tr>
</table>
<input type="submit" value="发送"/>
<input type="button" value="关闭" onclick="parent.mt.close()" />
</form>

</body>
</html>
