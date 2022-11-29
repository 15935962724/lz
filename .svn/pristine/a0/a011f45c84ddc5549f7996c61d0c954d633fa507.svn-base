<%@page contentType="text/html;charset=utf-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
ProfileBBS pb =ProfileBBS.find(teasession._strCommunity ,teasession._rv._strV);
r.add("/tea/resource/BBS");

int len=0;
String isign=pb.getISign(teasession._nLanguage);
if(isign!=null)
{
  len=(int)new File(application.getRealPath(isign)).length();
}

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "设置签名")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<form name="form1" action="/servlet/EditProfileBBS" METHOD=POST enctype="multipart/form-data">
<input type="hidden" name="act" value="isign">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">

<table cellspacing="0" cellpadding="0" border="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage,"签字")%></td>
    <td><input type="file" name="isign" onclick="document.getElementById('view').src=this.value;">
    <%
    if(len>0)
    {
      out.print("<a href="+isign+" target=_blank>"+len+r.getString(teasession._nLanguage,"Bytes")+"</a><input name=clear type=checkbox onclick='form1.isign.disabled=this.checked;'>"+r.getString(teasession._nLanguage,"Clear"));
    }
    %>
    </td>
  </tr>
</table>
<input type="submit" value="<%=r.getString(teasession._nLanguage,"Submit")%>"/>
</form>

<img alt="" id="view" src="<%=isign%>" onerror="this.style.display='none';">

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>
