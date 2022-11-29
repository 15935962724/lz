<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.ui.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.resource.Resource" %><%
request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

String scode=request.getParameter("scode");
if(request.getMethod().equals("POST"))
{
  tea.service.SMS sms=new  tea.service.SMS();
  String code=request.getParameter("code");
  String password=request.getParameter("password");
  String s=sms.FinCard(scode,code,password);
  System.out.println(s.substring(74,s.indexOf("/string")-1));
  response.sendRedirect("/jsp/info/Succeed.jsp?info="+s);
  return;
}

Resource r=new Resource("/tea/resource/SMS");

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body onload="foEdit.code.focus();">

   <h1><%=r.getString(teasession._nLanguage, "SMS")%></h1>
   <div id="head6"><img height="6" src="about:blank"></div>
   <br>
   <FORM name=foEdit METHOD=POST action="" onSubmit="">
    <input type="hidden" name="Node" value="<%=teasession._nNode%>">
    <input type="hidden" name="community" value="<%=teasession._strCommunity%>">
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr>
       <!--1172549426366=特服号-->
         <td><%=r.getString(teasession._nLanguage, "1172549426366")%>:</td>
         <td>
         <select name="scode" onchange="window.open(document.location.href.replace('&scode=','&')+'&scode='+this.value,'_self');">
         <option value="">-------</option>
         <%
         java.util.Enumeration e=SMSScode.find();
         while(e.hasMoreElements())
         {
           String value=(String)e.nextElement();
           out.print("<option value="+value);
           if(value.equals(scode))
           {
             out.print(" SELECTED ");
           }
           out.print(" >"+value);
         }
         %></select>
         </td></tr>
      <tr>
      <!--1172560582440=充值卡编号-->
         <TD><%=r.getString(teasession._nLanguage, "1172560582440")%>:</TD>
         <td><input type="TEXT" class="edit_input"  name=code value="" size=40 maxlength=40></td>
       </tr>
       <tr>
         <TD><%=r.getString(teasession._nLanguage, "Password")%>:</TD>
         <td><input type="TEXT" class="edit_input"  name=password value="" size=40 maxlength=40></td>
       </tr>
  </table>
  <input type="submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>"  onclick="return(submitFloat(this.money,'<%=r.getString(teasession._nLanguage, "InvalidMoney")%>'));">
   </form>
<br><br>


   <%
   if(scode!=null&&scode.length()>0)
   {
tea.service.SMS sms=new  tea.service.SMS();
String s1 = sms.GetBanlance(scode);
//sms.parseBalance(s1);
s1=s1.replaceFirst("<SmsStateReport>","<table border=0 cellpadding=0 cellspacing=0 id=tablecenter>");
s1=s1.replaceFirst("<ErrorNumber>","<tr><td>发送失败数量:</td><td>");
s1=s1.replaceFirst("</ErrorNumber>","</td></tr>");

s1=s1.replaceFirst("<ErrorDescription>","<tr><td>信息描述:</td><td>");
s1=s1.replaceFirst("</ErrorDescription>","</td></tr>");

s1=s1.replaceFirst("<QueryBalance>","<tr><td>剩余短信数量:</td><td>");
s1=s1.replaceFirst("</QueryBalance>","</td>");

s1=s1.replaceFirst("<ReaderNumber>","<tr><td>充值次数:</td><td>");
s1=s1.replaceFirst("</ReaderNumber>","</td>");

s1=s1.replaceFirst("<ReaderData>","</table><table border=0 cellpadding=0 cellspacing=0 id=tablecenter><tr id=tableonetr><td width=1><script>var i=0;</script></td><td>充值卡号<td>充值日期<td>充值短信数</tr>");
s1=s1.replaceAll("<Data CordID=\"","<tr onMouseOver=\"javascript:this.bgColor='#BCD1E9'\" onMouseOut=\"javascript:this.bgColor=''\"><td width=1><script>document.write(++i);</script></td><td>");
s1=s1.replaceAll("\" PayTime=\"","</td><td>");
s1=s1.replaceAll("\" SmsBalance=\"","</td><td>");
s1=s1.replaceAll("\" />","</td></tr>");
s1=s1.replaceFirst("</SmsStateReport>","</table>");
out.print(s1);
   }
%>
<div id="head6"><img height="6" src="about:blank"></div>
 <div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>

