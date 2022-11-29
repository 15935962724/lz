<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
String community=teasession.getParameter("community");
if(community==null)
community=node.getCommunity();
boolean flag2 = teasession._rv.isOrganizer(community);
boolean flag3 = teasession._rv.isWebMaster();
if(!flag2&&!flag3)
{
  response.sendError(403);
  return;
}
r.add("/tea/resource/SMS");

java.util.Date starttime=null,endtime=new java.util.Date(System.currentTimeMillis()+1000*60*60*24*30L);


String member=teasession.getParameter("member");
int smsmoney=0;
java.math.BigDecimal money;
if(teasession.getParameter("smsmoney")!=null)
{
  smsmoney=Integer.parseInt(teasession.getParameter("smsmoney"));
  SMSMoney obj=SMSMoney.find(smsmoney);
  starttime=obj.getStarttime();
  endtime=obj.getEndtime();
  money=obj.getMoney();
}else
{
  money=new java.math.BigDecimal(0);
}

 

SMSProfile sp=SMSProfile.find(member,community);
String signature=sp.getSignature(teasession._nLanguage);

Profile profile=Profile.find(member);
%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="">
function fc(obj,value)
{
  for(var index=0;index<obj.length;index++)
  {
    if(obj.options[index].value==value)
    {
      obj.options[index].selected=true;
      break;
    }
  }
}
</script>
</head>
<body onload="document.foEdit.money.focus();">

   <h1><%=r.getString(teasession._nLanguage, "SMS")%></h1>
   <div id="head6"><img height="6" src="about:blank"></div>
   <br>
   <FORM name=foEdit METHOD=POST action="/servlet/EditSMSMoney?node=<%=teasession._nNode%>" onSubmit="">
    <input type="hidden" name="member" value="<%=member%>">
    <input type="hidden" name="Node" value="<%=teasession._nNode%>">
    <input type="hidden" name="community" value="<%=community%>">
     <input type="hidden" name="smsmoney" value="<%=smsmoney%>">
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
         <td>本企业剩余短信条数:</td>
         <td><%=SMSEnterCode.find(community).getBalance()%></td>
       </tr>
       <tr>
         <td><%=r.getString(teasession._nLanguage, "MemberId")%>:</td>
         <td><%=member%></td>
       </tr>

       <tr>
         <td><%=r.getString(teasession._nLanguage, "StartTime")%>:</td>
         <td><%=new TimeSelection("starttime", starttime)%></td>
       </tr>
       <tr>
         <td><%=r.getString(teasession._nLanguage, "EndTime")%>:</td>
         <td><%=new TimeSelection("endtime", endtime)%>
         </td>
       </tr>
       <tr>
         <td><%=r.getString(teasession._nLanguage, "AddMoney")%>:</td>
         <td><input type="TEXT" class="edit_input"  name=money value="<%=money%>" size=40 maxlength=40>
</td>
       </tr>

  </table>
  <input type="submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>"  onclick="return(submitFloat(document.foEdit.money,'<%=r.getString(teasession._nLanguage, "InvalidMoney")%>'));">




<br><br>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id=tableonetr><td></td>
         <TD><%=r.getString(teasession._nLanguage, "StartTime")%></TD>

         <TD><%=r.getString(teasession._nLanguage, "EndTime")%></TD>
<TD><%=r.getString(teasession._nLanguage, "AddMoney")%></TD>
<TD><%=r.getString(teasession._nLanguage, "Count")%></TD>
<TD><%=r.getString(teasession._nLanguage, "Balance")%></TD>

<td></td>
       </tr>
     <%
java.util.Enumeration enumer=     SMSMoney.findByMember(member,community);
for(int index=1;enumer.hasMoreElements();index++)
{
  int id=((Integer)enumer.nextElement()).intValue();
  SMSMoney obj=SMSMoney.find(id);

  %>
       <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
       <td><%=index%></td>
         <td><%=  obj.getStarttimeToString()%></td>

         <td><%= obj.getEndtimeToString()%></td>
<td><%= obj.getMoney()%></td>
<td><%= obj.getPayout()%></td>
<td><%=( obj.getBalance())%></td>
  <td>
  <%
  if(index==1)
  {
  %>
  <input type="button" onclick="window.location='/jsp/sms/EditSMSMoney.jsp?node=<%=teasession._nNode%>&community=<%=community%>&member=<%=member%>&smsmoney=<%=id%>'" value="<%=r.getString(teasession._nLanguage, "Edit")%>"/>
<%
if(obj.getPayout()==0)
{%>
  <input type="submit" name="delete" onclick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>')){foEdit.smsmoney.value=<%=id%>;}else return false;" value="<%=r.getString(teasession._nLanguage, "Delete")%>"/>
<%  }}%>
</td>
 </tr>
  <%
}
     %>


  </table>

</form>

<br><br>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>



 <FORM name=foEdit2 METHOD=POST action="/servlet/EditSMSProfile?node=<%=teasession._nNode%>" onSubmit="">
   <input type="hidden" name="member" value="<%=member%>">
   <input type="hidden" name="Node" value="<%=teasession._nNode%>">
   <input type="hidden" name="community" value="<%=community%>">
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr> <TD><%=r.getString(teasession._nLanguage, "Service")%>:</TD>
       <td>
       <input  id="radio" type="radio" name="states"  value="true" checked="checked"/>
       <%=r.getString(teasession._nLanguage, "Startup")%>
       <input  id="radio" type="radio" name="states" value="false" <%if(!sp.isStates())out.print("checked");%>/>
       <%=r.getString(teasession._nLanguage, "Stop")%>
       </td>
       </tr><tr>
       <TD><%=r.getString(teasession._nLanguage, "Signature")%></TD>
       <td>

<input type="text" name="signature" value="<%if(signature!=null)out.print(signature);%>"/>
       </td>
     </tr>
     </table>
     <input type="submit" name="setsignature"  value="<%=r.getString(teasession._nLanguage, "Submit")%>"  >


<br/>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>


<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td>指定子号:</td>
<td><input type="text" name="subcode" value="<%=sp.getCode()%>"/>
<td><input type=submit name="assigncode" value="注册" ></td>
</tr> 
</table>

<br/><br/>
<h1><%=r.getString(teasession._nLanguage,"Autor")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
<TD><%=r.getString(teasession._nLanguage,"Autor")%></TD>
<td><input name="autor"  id="radio" type="radio" value="false" onclick="" checked><%=r.getString(teasession._nLanguage, "Stop")%>
  <input name="autor"  id="radio" type="radio" value="true" onclick="" <% if(!profile.isValidate())out.print(" disabled ");else if(sp.isAutor())out.print("checked");%>><%=r.getString(teasession._nLanguage, "Startup")%>
</td>
</tr>
</table>
<input name="SetAutor" value="<%=r.getString(teasession._nLanguage,"CBSubmit")%>" type="submit">

</form>

<br/>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>

</body>
</html>

