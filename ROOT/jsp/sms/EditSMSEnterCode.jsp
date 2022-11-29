<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="tea.entity.site.*" %><%@ page import="java.math.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}



SMSEnterCode sec=SMSEnterCode.find(teasession._strCommunity);
int code=sec.getCode();
String password=sec.getPassword();
if(request.getMethod().equals("POST"))
{
  code=Integer.parseInt(request.getParameter("code"));
  password=(request.getParameter("password"));
  sec.set(code,password);
  response.sendRedirect("/jsp/info/Succeed.jsp");
  return ;
}
if(password==null)
password="";

Resource r=new Resource("/tea/resource/SMS");
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
<body onLoad="form111_net.code.focus();">

<h1><%=r.getString(teasession._nLanguage, "SMSEnterCode")%></h1>
<div id="head6"><img height="6" alt=""></div>
   <br>
   <FORM name=form111_net METHOD=POST action="/jsp/sms/EditSMSEnterCode.jsp" onSubmit="return(submitInteger(this.code,'<%=r.getString(teasession._nLanguage, "InvlaidParameter")+"-"+r.getString(teasession._nLanguage, "Code")%>')&&submitText(this.password,'<%=r.getString(teasession._nLanguage, "InvlaidParameter")+"-"+r.getString(teasession._nLanguage, "Password")%>'));">
   <input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
   <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
       <tr>
       <!--1172561761638=剩余短信数量-->
         <td><%=r.getString(teasession._nLanguage, "1172561761638")%>:</td>
         <td><%=sec.getBalance()%>
         </td>
       </tr>
       <tr>
              <!--1172549329635=企业编号-->
         <td><%=r.getString(teasession._nLanguage, "1172549329635")%>:</td>
         <td><input type="TEXT" class="edit_input"  name=code value="<%=code%>" size=40 maxlength=255>
         </td>
       </tr>
       <tr>
         <td><%=r.getString(teasession._nLanguage, "Password")%>:</td>
         <td><input type="TEXT" class="edit_input"  name=password value="<%=password%>" size=40 maxlength=40>
         </td>
       </tr>
       <tr>
         <td>&nbsp;</td>
         <td><input name="submit" class="edit_button"  type="submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>"></td>
       </tr>
     </table>
   </FORM>

<div id="head6"><img height="6" alt=""></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</body>
</html>

