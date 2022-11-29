<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.member.*" %>
<%request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
 response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
 return;
}

int groupid=0;
if( request.getParameter("groupid")!=null)
{
  groupid=Integer.parseInt(request.getParameter("groupid"));
}
         //   intRowCount=tea.entity.node.SMSPhoneBook.countByGroup(groupid);

Resource r=new Resource("/tea/resource/Group");

String name=request.getParameter("index");
if(name==null)
name="form1.number";

String field=request.getParameter("field");

%>
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>

<h1><%=r.getString(teasession._nLanguage,"SelectPersonnel")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

   <tr id="tableonetr">
   <td><%=r.getString(teasession._nLanguage,"Name")%></td>
   <td><%
   if(field==null||field.length()<1)
   {  out.print(r.getString(teasession._nLanguage,"Mobile"));
   }else
   if("email".equals(field)||"member".equals(field))
   {  out.print("E-Mail");
   }
   %></td>
   </tr>
    <%
StringBuffer sb=new StringBuffer();
java.util.Enumeration enumer=AdminUsrRole.findByUnit(groupid,teasession._strCommunity);
while(enumer.hasMoreElements())
{
  //AdminUsrRole aur=AdminUsrRole.find(((Integer)enumer.nextElement()).intValue());
  AdminUsrRole aur = AdminUsrRole.find(teasession._strCommunity,(String)enumer.nextElement());
  Profile p=Profile.find(aur.getMember());
  String value=null,value2=null;
   if(field==null||field.length()<1)
   {
     if(p.getMobile().length()>=11)
     sb.append(p.getMobile()).append(";");
     value2=value=p.getMobile();
   }else
   if("email".equals(field))
   {
     sb.append(p.getEmail()).append(";");
     value2=value=p.getEmail();
   }else
   if("member".equals(field))
   {
     sb.append(aur.getMember()).append(";");
     value=aur.getMember();
     value2=p.getEmail();
   }

    %>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td  align=center nowrap><a href="javascript:fclick('<%=value+"/"+p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage)+"/"+ p.getCard()%>');" ><%=p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage)%></A></td>
      <td  align=center><a href="javascript:fclick('<%=value+"/"+p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage)+"/"+p.getCard()%>');" ><%=value2%></A>&nbsp;</td>
    </tr>
    <%
  }
	%>
  </table>

<div id="head6"><img height="6" src="about:blank"></div>
<br>







<script type="">
var parent_window = window.dialogArguments;
function fclick(theDate)
{
//  alert('parent_window.<%=name%>.value');
   parent_window.<%=name%>.value=theDate;
   window.close();
}
function fclickall()
{
   parent_window.<%=name%>.value='<%=sb%>';
   window.close();
}
</script>

