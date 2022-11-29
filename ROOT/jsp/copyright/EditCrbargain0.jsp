<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@page  import="tea.entity.copyright.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

String nexturl=request.getParameter("nexturl");

int crbargain=Integer.parseInt(request.getParameter("crbargain"));

String scrbid=null,name=null,pubarea=null,crto=null,impower=null;
if(crbargain>0)
{
	Crbargain obj=Crbargain.find(crbargain);
	scrbid=obj.getScrbid();
	name=obj.getName();
	pubarea=obj.getPubarea();
	crto=obj.getCrto();
	impower=obj.getImpower();
}

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body onload="form1.scrbid.focus();">
<h1>录音制品著作权合同登记公告</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>

<FORM NAME="form1" ACTION="/servlet/EditCopyRight" METHOD="post" onSubmit="return submitText(this.scrbid,'无效-国权音字')&&submitText(this.name,'无效-专辑名称');">
  <input type="hidden" name="act" value="editcrbargain"/>
  <input type="hidden" name="flag" value="false">
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>">
  <input type="hidden" name="crbargain" value="<%=crbargain%>">
  <input type="hidden" name="nexturl" value="<%=nexturl%>">

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <TR>
      <TD >国权音字</TD>
      <TD><input name="scrbid" type="text" <%if(crbargain>0)out.print(" disabled ");%>  value="<%if(scrbid!=null)out.print(scrbid);%>"></TD>
    </tr>
    <tr>
      <TD>专辑名称</TD>
      <TD><input name="name" type="text" value="<%if(name!=null)out.print(name);%>"></TD>
    </tr>
    <tr>
      <TD>出品地</TD>
      <TD><input name="pubarea" type="text" value="<%if(pubarea!=null)out.print(pubarea);%>"></TD>
    </tr>
    <tr>
      <TD>出版单位</TD>
      <TD><input name="crto" type="text" value="<%if(crto!=null)out.print(crto);%>"></TD>
    </tr>
    <tr>
      <TD>授权方</TD>
      <TD><input name="impower" type="text" value="<%if(impower!=null)out.print(impower);%>"></TD>
    </tr>
  </TABLE>
  <input type="submit" value="提交">
  <input type="reset" value="重置">
  <input type="button" value="返回" onclick="window.history.back();">
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

