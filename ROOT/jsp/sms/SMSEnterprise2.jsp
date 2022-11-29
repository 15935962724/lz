<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="tea.entity.site.*" %><%@ page import="java.math.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

boolean  flag2 = teasession._rv.isOrganizer(teasession._strCommunity);
boolean flag3 = teasession._rv.isWebMaster();
if(!flag2&&!flag3)
{
  response.sendError(403);
  return;
}

Resource r=new Resource("/tea/resource/SMS");


int code=Integer.parseInt(request.getParameter("code"));
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body onload="form1.balance.focus();">

   <h1><%=r.getString(teasession._nLanguage, "SMS")%></h1>
   <div id="head6"><img height="6" src="about:blank"></div>
   <br>
   <FORM name=form1 METHOD=POST action="/servlet/EditSMSEnterprise?node=<%=teasession._nNode%>" onSubmit="">
    <input type="hidden" name="Node" value="<%=teasession._nNode%>">
    <input type="hidden" name="community" value="<%=teasession._strCommunity%>">
    <input type="hidden" name="smsenterprise" value="0">
     <input type="hidden" name="code" value="<%=code%>">
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
       <tr>
         <td><%=r.getString(teasession._nLanguage, "1172549329635")%>:</td>
         <td><%=code%></td>
       </tr>
       <tr>
         <td><%=r.getString(teasession._nLanguage, "AddMoney")%>:</td>
         <td><input type="text" name="balance" value=""/></td>
       </tr>
       <!--tr>
         <td><%=r.getString(teasession._nLanguage, "Price")%>:</td>
         <td><select name="price">
         <option value="0.8">0.8</option>
</select>
         </td>
       </tr-->
      </table>
  <input type="submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>"  onclick="return(submitFloat(form1.balance,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-<%=r.getString(teasession._nLanguage, "Code")%>'));">




<br><br>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<TR id="tableonetr"><td width="1"></td>
<TD><%=r.getString(teasession._nLanguage, "1172549329635")%></TD>
<TD><%=r.getString(teasession._nLanguage, "Time")%></TD>
<TD><%=r.getString(teasession._nLanguage, "Count")%></TD>
<TD><%=r.getString(teasession._nLanguage, "AddMoney")%></TD>
</tr>
<%
java.util.Enumeration enumer=SMSEnterprise2.findByCode(code);
for(int index=1;enumer.hasMoreElements();index++)
{
  int id=((Integer)enumer.nextElement()).intValue();
  SMSEnterprise2 obj=SMSEnterprise2.find(id);
  %>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
<td width="1"><%=index%></td>
<td><%=code%></td>
<td><%=obj.getTimeToString()%></td>
<td><%= obj.getCount()%></td>
<td><%= obj.getBalance()%></td>
</tr>
  <%
}
     %>


  </table>

</form>

<br><br>
<div id="head6"><img height="6" alt=""></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>

