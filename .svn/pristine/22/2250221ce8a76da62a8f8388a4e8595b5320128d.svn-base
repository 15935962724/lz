<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*" %><%@page import="tea.ui.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.resource.Resource" %><%
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

Resource r=new Resource("/tea/resource/SMS");


%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function f_edit(code,pwd,scode,name)
{
  form1.code.value=code;
  form1.code.setAttribute('readonly','true');
  form1.code.style.color='#999999';
  form1.pwd.value=pwd;
  form1.scode.value=scode;
  form1.name.value=name;
  form1.name.focus();
}
function f_delete(code)
{
  if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>'))
  {
    form1.code.value=code;
  }else
  {
    return false;
  }
}
function f_submit()
{
  return(submitInteger(form1.code,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-<%=r.getString(teasession._nLanguage, "Code")%>')
	&&submitIdentifier(form1.pwd,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-<%=r.getString(teasession._nLanguage, "Password")%>')
	//&&submitText(form1.scode,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-<%=r.getString(teasession._nLanguage, "1172549426366")%>')
	&&submitText(form1.name,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-<%=r.getString(teasession._nLanguage, "Name")%>')
	);
}
</script>
</head>
<body onload="form1.code.focus();">

<h1><%=r.getString(teasession._nLanguage, "SMS")%></h1>
<div id="head6"><img height="6" alt=""></div>
<br>

<FORM name=form1 METHOD=POST action="/servlet/EditSMSEnterprise" >
<input type="hidden" name="node" value="<%=teasession._nNode%>">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <!--1172549329635=企业编号-->
    <td><%=r.getString(teasession._nLanguage, "1172549329635")%>:</td>
    <td><input type="text" name="code" value=""/></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Password")%>:</td>
    <td><input type="text" name="pwd" value=""/>
</td>
  </tr>
  <tr>
    <!--1172549426366=特服号-->
    <td><%=r.getString(teasession._nLanguage, "1172549426366")%>:</td>
    <td><select name="scode"><option value="">--------
    <%
    Enumeration e=SMSScode.find();
    while(e.hasMoreElements())
    {
      String value=(String)e.nextElement();
      out.print("<option value="+value+" >"+value);
    }
    %></select>
    </td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Name")%>:</td>
    <td><input type="text" name="name" value="" size="40" maxlength="50"/></td>
  </tr>
</table>
<input type="submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>"  onclick="return f_submit();">




<br><br>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <TR id="tableonetr">
      <td width="1">&nbsp;</td>
      <TD><%=r.getString(teasession._nLanguage, "1172549329635")%></TD>
      <TD><%=r.getString(teasession._nLanguage, "1172549426366")%></TD>
      <TD><%=r.getString(teasession._nLanguage, "Name")%></TD>
      <TD><%=r.getString(teasession._nLanguage, "Time")%></TD>
      <TD><%=r.getString(teasession._nLanguage, "AddMoney")%></TD>
      <TD><%=r.getString(teasession._nLanguage, "1172546531118")%></TD>
      <td>&nbsp;</td>
</tr>
<%
Enumeration enumer=SMSEnterprise.find();
for(int index=1;enumer.hasMoreElements();index++)
{
  int id=((Integer)enumer.nextElement()).intValue();
  SMSEnterprise obj=SMSEnterprise.find(id);
%>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
<td width="1"><%=index%></td>
<td><%=id%></td>
<td><%=obj.getScode()%></td>
<td><%=obj.getName()%></td>
<td><%=obj.getTimeToString()%></td>
<td><%=obj.getBalance()%></td>
<td><%=obj.getHits()%></td>
<td>
  <input type="button" onclick="f_edit(<%=id%>,'<%=obj.getPwd()%>','<%=obj.getScode()%>','<%=obj.getName()%>');" value="<%=r.getString(teasession._nLanguage, "CBEdit")%>"/>
  <input type="submit" name="delete" onclick="f_delete(<%=id%>);" value="<%=r.getString(teasession._nLanguage, "CBDelete")%>"/>
  <input type="button" onclick="window.open('/jsp/sms/SMSEnterprise2.jsp?community=<%=teasession._strCommunity%>&node=<%=teasession._nNode%>&code=<%=id%>','_self');" value="<%=r.getString(teasession._nLanguage, "AddMoney")%>"/>
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
