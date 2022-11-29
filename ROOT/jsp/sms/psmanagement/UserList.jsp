<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.resource.Resource" %><%@page import="tea.entity.node.*" %><%@page import="tea.ui.TeaSession" %><%request.setCharacterEncoding("UTF-8");

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

%><html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>

<h1><%=r.getString(teasession._nLanguage,"SelectPersonnel")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
   <tr>
   <td><a href="javascript:fclickall();" ><%=r.getString(teasession._nLanguage,"SelectAll")%></A><td>
   </tr>
   <tr id="tableonetr">
   <td><%=r.getString(teasession._nLanguage,"Name")%></td>
   <td>
   <%
   if(field==null||field.length()<1)
   {
     out.print(r.getString(teasession._nLanguage,"Mobile"));
   }else
   if("email".equals(field)||"member".equals(field))
   {
     out.print("E-Mail");
   }
   %>
   </td>
   </tr>
    <%
    StringBuffer sb=new StringBuffer();
    java.util.Enumeration enumer=tea.entity.node.SMSPhoneBook.findByGroup(groupid);
    while(enumer.hasMoreElements())
    {
      tea.entity.node.SMSPhoneBook smspb=tea.entity.node.SMSPhoneBook.find(((Integer)enumer.nextElement()).intValue());
      if(groupid!=0||(smspb.getPhonenumber().equals(teasession._rv._strV)&&teasession._strCommunity.equals(smspb.getCommunity())))
      {
        String value=null,value2=null;
        if(field==null||field.length()<1)
        {
          if(smspb.getMobile().length()>=11)
          sb.append(smspb.getMobile()).append(";");
          value2=value=smspb.getMobile();
        }else
        if("email".equals(field))
        {
          sb.append(smspb.getEmail()).append(";");
          value2=value=smspb.getEmail();
        }else
        if("member".equals(field))
        {
          sb.append(smspb.getMemberx()).append(";");
          value=smspb.getMemberx();
          value2=smspb.getEmail();
        }
        %>
        <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
          <td  align=center nowrap><a href="javascript:fclick('<%=smspb.getMobile()%>');" ><%=smspb.getName()%></A></td>
          <td  align=center><a href="javascript:fclick('<%=value%>');" ><%=value2%></a>&nbsp;</td>
        </tr>
        <%}
      }
	%>
  </table>

<div id="head6"><img height="6" src="about:blank"></div>
<br>







<script type="">
var add=top.location.href.indexOf("&add=")!=-1;
var obj = window.dialogArguments.<%=name%>;
function fclick(v)
{
   if(add)v=obj.value+";"+v;
   obj.value=f(v);
   window.close();
}
function fclickall()
{
   var v="<%=sb%>";
   if(add)v=obj.value+";"+v;
   obj.value=f(v);
   window.close();
}
function f(v)
{
  if(v.indexOf(';')==0)v=v.substring(1);
  return v.replace(/;;/g,";");
}
</script>

