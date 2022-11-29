<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
String community=request.getParameter("community");
if(community==null)
community=node.getCommunity();


r.add("/tea/resource/SMS");

String member=teasession._rv.toString();

%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <script type="">
  function fselectall(bool)
  {
    foEdit.smsmessage.checked=bool;
    for (var index=0;index<foEdit.smsmessage.length;index++)
    {
      foEdit.smsmessage[index].checked=bool;
    }
  }

  function fcheck()
  {
    if(foEdit.smsmessage=='[object]'||foEdit.smsmessage=='[object NodeList]')
    {
      if(foEdit.smsmessage.checked)
      return true;
      for (var index=0;index<foEdit.smsmessage.length;index++)
      {
        if(foEdit.smsmessage[index].checked)
        return true;
      }
    }
    alert('无效选择');
    return false;
  }
  </script>
</head>
<body>

   <h1><%=r.getString(teasession._nLanguage, "SendList")%></h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<FORM name=foEdit METHOD=POST action="/servlet/EditSMSMessage?node=<%=teasession._nNode%>" onSubmit="">
  <input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
    <input type="hidden" name="community" value="<%=community%>"/>
      <input type="hidden" name="type" value="false"/>
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr id="tableonetr"><td></td><td></td>
          <TD><%=r.getString(teasession._nLanguage, "Time")%></TD>

         <TD><%=r.getString(teasession._nLanguage, "Number")%></TD>
<TD><%=r.getString(teasession._nLanguage, "Text")%></TD>
       </tr>
     <%
java.util.Enumeration enumer=     SMSMessage.findSendByMember(member,community);
for(int index=1;enumer.hasMoreElements();index++)
{
  int id=((Integer)enumer.nextElement()).intValue();
  SMSMessage obj=SMSMessage.find(id);

  %>
       <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">

       <td><input  id="CHECKBOX" type="CHECKBOX" name="smsmessage" value="<%=id%>"/></td>
        <td width="1"><%=index%></td>
         <td nowrap><%=  obj.getTimeToString()%></td>

         <td nowrap><%= obj.getMember()%></td>
         <td><%=HtmlElement.htmlToText(obj.getContent())%></td>
 </tr>
  <%
}
     %>
<tr><td nowrap="nowrap" colspan="2"><input  id="CHECKBOX" type="CHECKBOX" name="" onclick="fselectall(this.checked);" /><%=r.getString(teasession._nLanguage, "SelectAll")%></td>
<td><input type="submit" name="delete" onclick="return (fcheck()&&confirm('<%=r.getString(teasession._nLanguage, "ConfirmDeleteSelected")%>'));" value="<%=r.getString(teasession._nLanguage, "Delete")%>"/>
</td>
</tr>

  </table>

<br>
<div id="head6"><img height="6" src="about:blank"></div>

  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>

</body>
</html>

