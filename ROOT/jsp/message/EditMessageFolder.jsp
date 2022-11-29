<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="java.math.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
if(!teasession._rv.isSupport())
{
  response.sendError(403);
  return;
}

Resource r=new Resource("/tea/ui/member/message/Messages");
r.add("/tea/ui/member/messagefolder/ManageMessageFolders");

int messagefolder=0;
String tmp =  request.getParameter("messagefolder");
if(tmp!=null)
{
  messagefolder=Integer.parseInt(tmp);
}

int type=0,options=0;
String name = "";
if(messagefolder>0)
{
  MessageFolder obj = MessageFolder.find(messagefolder);
  name = obj.getName(teasession._nLanguage);
  type=obj.getType();
  options=obj.getOptions();
}

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body onload="form1.name.focus();">
<h1><%=r.getString(teasession._nLanguage, "ManageFolders")%></h1>
<div id="head6"><img height="6" src="about:blank" alt=""></div>


<FORM name=form1 METHOD=POST action="/servlet/EditMessageFolder" onSubmit="return(submitText(this.name,'<%=r.getString(teasession._nLanguage, "InvalidName")%>'));">
<input type='hidden' name="community" value="<%=teasession._strCommunity%>">
<input type='hidden' name="messagefolder" VALUE="<%=messagefolder%>">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

  <tr>
    <td><%=r.getString(teasession._nLanguage, "Name")%>:</td>
    <td COLSPAN=2><input type="TEXT" class="edit_input"  name=name VALUE="<%=name%>" size="40" MAXLENGTH="255"></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Category")%>:</td>
    <td><input  id="radio" type="radio" name=nType VALUE=0 <%if(type==0)out.print(" checked ");%>></td>
      <td><%=r.getString(teasession._nLanguage, "Private")%></td>
  </tr>
  <tr>
    <td>&nbsp; </td>
    <td><input  id="radio" type="radio" name=nType VALUE=1 <%if(type==1)out.print(" checked ");%>></td>
      <td><%=r.getString(teasession._nLanguage, "ProtectedI(ReadOnly)")%></td>
  </tr>
  <tr>
    <td>&nbsp; </td>
    <td><input  id="radio" type="radio" name=nType VALUE=2 <%if(type==2)out.print(" checked ");%>></td>
      <td><%=r.getString(teasession._nLanguage, "ProtectedII(AddLetter)")%></td>
  </tr>
  <tr>
    <td>&nbsp; </td>
    <td><input  id="radio" type="radio" name=nType VALUE=3 <%if(type==3)out.print(" checked ");%>></td>
      <td><%=r.getString(teasession._nLanguage, "Public(AddDeleteLetter)")%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Options")%>:</td>
    <td><input id="CHECKBOX" type="CHECKBOX" name=OpenSubscriberList value=null <%if((options & 1) != 0)out.print(" checked ");%>></td>
      <td><%=r.getString(teasession._nLanguage, "OpenSubscriberList")%></td>
  </tr>
  <tr>
    <td colspan="3"><input type=SUBMIT value="<%=r.getString(teasession._nLanguage, "CBSubmit")%>" id="CBSubmit" class="CB" onClick="">
      <input type=button value="<%=r.getString(teasession._nLanguage, "CBBack")%>"  class="CB" onClick="window.history.back();">
    </td>
  </tr>
</table>
</FORM>


              <div id="head6"><img height="6" src="about:blank" alt=""></div>
               <%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</body>
</html>
