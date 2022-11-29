<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.resource.*" %><%@ page import="java.io.*" %><%@ page import="java.net.*" %><%@ page import="tea.entity.site.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

License license = License.getInstance();
String sn=license.getSerialNumber();
if("POST".equals(request.getMethod()))
{
  String domain=license.getWebSite();

  sn=request.getParameter("serialnumber");
  String password=request.getParameter("password");
  int rs=0;
  try
  {
    InputStream is=new URL("http://"+domain+"/servlet/EditEarth?act=license&serialnumber="+sn+"&password="+password).openStream();
    rs=is.read();
    is.close();
  }catch(Exception ex)
  {
  }
  if(rs!=1)
  {
    response.sendRedirect("/jsp/info/Alert.jsp?info="+URLEncoder.encode("密码错误","UTF-8"));
    return;
  }
  license.set(sn);
  //指域名
  domain=sn+domain.substring(domain.indexOf("."));
  DNS d=DNS.find(domain);
  d.set("Home",teasession._nStatus,null,1,true);

  response.sendRedirect("/");
  return;
}


Resource r=new Resource("/tea/ui/site/EditLicense");


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
<body onload="form1.serialnumber.focus();">
<h1><%=r.getString(teasession._nLanguage, "EditLicense")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<FORM name="form1" METHOD=POST action="?" onSubmit="return submitText(this.serialnumber,'<%=r.getString(teasession._nLanguage, "无效-序列号")%>')&&submitText(this.password,'<%=r.getString(teasession._nLanguage, "无效-密码")%>');">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage, "序列号")%>:</td>
    <td><input type="TEXT" class="edit_input" name="serialnumber" value="<%if(sn!=null)out.print(sn);%>" SIZE=21 MAXLENGTH=21></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "密码")%>:</td>
    <td><input type="TEXT" class="edit_input" name="password" SIZE=40 MAXLENGTH=40></td>
  </tr>
  <tr>
    <td></td>
    <td><input type="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>"></td>
  </tr>
</table>

</FORM>


<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
