<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.criterion.Item" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=request.getParameter("community");
String nexturl=request.getParameter("nexturl");




Resource r=new Resource();







%><html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/criterion/js.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function defaultfocus()
{
  try
  {
    document.form1.principal.focus();
  }catch(e)
  {}
}
</script>
</head>
<body onLoad="defaultfocus();">

<h1>人员变动管理</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<form name="form1" action="/servlet/EditItem" method="post" onSubmit="return submitText(this.principal, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-<%=Item.ROLE_PRINCIPAL%>')&&submitText(this.director, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-<%=Item.ROLE_DIRECTOR%>');">
<%
String items[]=request.getParameterValues("item");
for(int index=0;index<items.length;index++)
out.print("<input type=hidden name=item value="+items[index]+" >");
%>
<input type=hidden name="act" value="useredititem2"/>
<input type=hidden name="community" value="<%=community%>"/>
<input type=hidden name="nexturl" value="<%=nexturl%>"/>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
       <%
       if(request.getParameter("principal")!=null)
       {
         out.print("<tr><td>"+Item.ROLE_PRINCIPAL+"</td><td nowrap><select name=principal ><option value=\"\" >------------</option>");
         int adminrole_id=tea.entity.admin.AdminRole.findByName(Item.ROLE_PRINCIPAL,community);//"标准处管理员"
         java.util.Enumeration enumer=tea.entity.admin.AdminUsrRole.findByRole(adminrole_id);
         while(enumer.hasMoreElements())
         {
           String member=(String)enumer.nextElement();
           out.print("<option value="+member);
//           if(member.equals(obj.getPrincipal()))
//           out.print(" SELECTED ");
           out.print(" >"+member);
         }
         out.print("</select></td></tr>");
       }else
       {
//         out.print("<input type=hidden name=principal value=\""+obj.getPrincipal()+"\" >");
       }


       if(request.getParameter("director")!=null)
       {
         out.print("<tr><td>"+Item.ROLE_DIRECTOR+"</td><td nowrap><select name=director ><option value=\"\" >------------</option>");
         int adminrole_id=tea.entity.admin.AdminRole.findByName(Item.ROLE_DIRECTOR,community);//"标准所管理员"
         java.util.Enumeration enumer=tea.entity.admin.AdminUsrRole.findByRole(adminrole_id);
         while(enumer.hasMoreElements())
         {
           String member=(String)enumer.nextElement();
           out.print("<option value="+member);
//           if(member.equals(obj.getDirector()))
//           out.print(" SELECTED ");
           out.print(" >"+member);
         }
         out.print("</select></td></tr>");
       }else
       {
//         out.print("<input type=hidden name=director value=\""+obj.getDirector()+"\" >");
       }
       %>
       <tr>
         <td>&nbsp;</td>
         <td nowrap>
           <input type="submit" name="Submit" value="提交">
           <input type="reset" name="Submit2" value="重置" onClick="defaultfocus();">
           <input type="button" value="返回" onClick="history.back();">
         </td>
       </tr>
  </table>
</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

