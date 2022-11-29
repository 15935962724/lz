<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Profile p = Profile.find(teasession._rv._strV);

Resource r=new Resource("/tea/ui/member/profile/ChangePassword");
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "我的照片")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<FORM action="/servlet/EditProfile" METHOD=POST enctype="multipart/form-data" name=form1 onSubmit="">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>
<input type="hidden" name="nexturl" value=""/>
<input type="hidden" name="act" value="setphoto"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
<TD><%=r.getString(teasession._nLanguage, "MemberId")%>:</TD>
<td><%=(teasession._rv._strR)%></td>

</tr>
<tr>
<TD><%=r.getString(teasession._nLanguage, "照片")%>:</TD>
<td><input type="file" name="photo" onChange="document.getElementById('img').src=this.value;">　60px X 60px</td>
</tr>
<tr>
<TD><%=r.getString(teasession._nLanguage, "预览")%>:</TD>
<td><img id="img" src="<%=p.getPhotopath(teasession._nLanguage)%>" onload="style.display='';" onerror="style.display='none';"></td>
</tr>
</table>
<p>
  <input type="submit" value="<%=r.getString(teasession._nLanguage, "Submit")%>">
</p>
<p>注：请上传正规头像，用于工作中识别!</p>
</FORM>

<SCRIPT>document.form1.photo.focus(); document.form1.nexturl.value=document.location.href;</SCRIPT>
<div id="head6"><img height="6" src="about:blank"></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</body>
</html>

