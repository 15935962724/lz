<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.ui.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.resource.Resource" %><%
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



boolean flag2 = teasession._rv.isOrganizer(teasession._strCommunity);
boolean flag3 = teasession._rv.isWebMaster();
if(!flag2&&!flag3)
{
  response.sendError(403);
  return;
}

if(request.getMethod().equals("POST"))
{
  String scode=request.getParameter("scode");
  SMSScode obj=SMSScode.find(scode);
  if(request.getParameter("delete")!=null)
  {
    obj.delete();
  }else
  {
    String pwd=request.getParameter("pwd").trim();
    obj.set(pwd);
  }
  //response.sendRedirect("?id="+request.getParameter("id")+"&node="+teasession._nNode+"&community="+teasession._strCommunity);
  //return;
}

Resource r=new Resource("/tea/resource/SMS");


%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body onload="form1.scode.focus();">

   <h1><%=r.getString(teasession._nLanguage, "SMS")%></h1>
   <div id="head6"><img height="6" alt=""></div>
   <br>
   <FORM name=form1 METHOD=POST action="?" onSubmit="return(submitText(this.pwd,'<%=r.getString(teasession._nLanguage, "InvalidPassword")%>'));">
    <input type="hidden" name="Node" value="<%=teasession._nNode%>">
    <input type="hidden" name="community" value="<%=teasession._strCommunity%>">
    <input type="hidden" name="id" value="<%=request.getParameter("id")%>">

     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
       <tr>
       <!--1172549426366=特服号-->
         <td><%=r.getString(teasession._nLanguage, "1172549426366")%>:</td>
         <td><select name="scode">
         <%
         for(int i=0;i<100;i++)
         {
           String value=(i<10)?"0"+i:String.valueOf(i);
           out.print("<option value="+value+" >"+value);
         }
         %>
         </td>
         </tr>
         <tr>
         <td><%=r.getString(teasession._nLanguage, "Password")%>:</td>
         <td><input type="text" name="pwd" value=""/>
         </td>
       </tr>
      </table>
  <input type="submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>"  onclick="">




<br><br>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <TR id="tableonetr"><td width="1">&nbsp;</td>
         <TD><%=r.getString(teasession._nLanguage, "1172549426366")%></TD>
         <TD><%=r.getString(teasession._nLanguage, "Password")%></TD>
         <!--//移动子号-->
         <TD><%=r.getString(teasession._nLanguage, "1172561523654")%></TD>
         <!--//联通子号-->
         <TD><%=r.getString(teasession._nLanguage, "1172561523655")%></TD>
         <!--//剩余短信数量-->
         <TD><%=r.getString(teasession._nLanguage, "1172561761638")%></TD>
         <td></td>
       </tr>
     <%
java.util.Enumeration enumer=SMSScode.find();
for(int index=1;enumer.hasMoreElements();index++)
{
  String scode=((String)enumer.nextElement());
  SMSScode obj=SMSScode.find(scode);

  %>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
<td width="1"><%=index%></td>
<td>65622463<%=scode%></td>
<td><%=obj.getPwd()%></td>
<td>6201711127<%=scode%></td>
<td>501127<%=scode%></td>
<td>
<%
tea.service.SMS sms=new  tea.service.SMS();
String s1 = sms.GetBanlance(scode);
int bq_1=s1.indexOf("<QueryBalance>")+"<QueryBalance>".length();
int bq_2=s1.indexOf("</QueryBalance>",bq_1);
if(bq_2!=-1)
{
  out.print("<A href=/jsp/sms/AddSMSMoney.jsp?node="+teasession._nNode+"&community="+teasession._strCommunity+"&scode="+scode+">"+s1.substring(bq_1,bq_2)+"</a>");
}
%></td>
<td>
  <input type="button" onclick="form1.scode.value='<%=scode%>';form1.scode.setAttribute('readonly','true');form1.pwd.value='<%=obj.getPwd()%>';form1.pwd.focus();" value="<%=r.getString(teasession._nLanguage, "CBEdit")%>"/>
  <input type="submit" name="delete" onclick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>')){form1.scode.value='<%=scode%>';}else return false;" value="<%=r.getString(teasession._nLanguage, "CBDelete")%>"/>
</td>
 </tr>
<%
}
%>
</table>

</form>

<br>
<div id="head6"><img height="6" alt=""></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>

