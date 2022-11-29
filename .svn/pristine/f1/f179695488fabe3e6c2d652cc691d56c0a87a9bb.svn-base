<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.eon.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.io.*" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


String nexturl=request.getParameter("nexturl");


Profile p = Profile.find(teasession._rv._strV);

EonTeleset et = EonTeleset.find(teasession._strCommunity,teasession._rv._strV);

Resource r=new Resource();


String telephone=p.getTelephone(teasession._nLanguage);
String introduce=p.getIntroduce(teasession._nLanguage);
String photopath=p.getPhotopath(teasession._nLanguage);
long len=0L;
if(photopath!=null)
{
  len=new File(application.getRealPath(photopath)).length();
}
boolean secret=et.isSecret();
boolean automessage=et.isAutoMessage();

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function defaultfocus()
{
  form1.telephone.focus();
}
</script>
</head>
<body onLoad="defaultfocus();">

<h1>联系信息设置</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<form name="form1" action="/servlet/EditEonTeleset" method="post" enctype="multipart/form-data" onSubmit="return submitText(this.telephone, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-电话')">
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<script>document.write("<input type=hidden name=nexturl value="+document.location+">");</script>
<input type=hidden name="act" value="edit"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>用户名</td>
    <td nowrap><%=teasession._rv._strV%></td>
  </tr>
  <tr>
    <td>电话</td>
    <td nowrap><input name="telephone" type="text" value="<%if(telephone!=null)out.print(telephone);%>" size="50"></td>
  </tr>
  <tr>
    <td>简介</td>
    <td nowrap><textarea name="introduce" cols="50" rows="5"><%if(introduce!=null)out.print(introduce);%></textarea></td>
  </tr>
  <tr>
    <td>头像</td>
    <td nowrap><input type="file" name="photopath" >
    <%
    if(len>0)
    {
      out.print("<a href="+photopath+" target=_blank>"+len+r.getString(teasession._nLanguage,"Bytes")+"</a><input type=checkbox name=clear onclick=\"form1.photopath.disabled=this.checked;\"/>清空");
    }
    %>
    </td>
  </tr>
  <tr>
    <td>选项</td>
    <td nowrap>
      <input type="checkbox" name="secret" value="true" <%if(secret)out.print(" checked ");%>>将号码显示给对方
      <input type="checkbox" name="automessage" value="true" <%if(automessage)out.print(" checked ");%>>设置为自动留言
    </td>
  </tr>
  <tr>
    <td>余额</td>
    <td nowrap><%=et.getBalanceToString()%></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td nowrap>
      <input type="submit"  value="提交">
    </td>
  </tr>
</table>
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
