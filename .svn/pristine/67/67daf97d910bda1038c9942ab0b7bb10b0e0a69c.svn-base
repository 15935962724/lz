
<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@ page  import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="java.util.*" %>
<%@ page import ="java.io.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.entity.site.*" %>
<%@ page import="tea.entity.confab.*" %>

<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String nexturl = request.getParameter("nexturl");

//int sort =7;
//if(request.getParameter("sort")!=null && request.getParameter("sort").length()>0)
//     sort = Integer.parseInt(request.getParameter("sort"));
String community = teasession._strCommunity;

String members =teasession.getParameter("members");

StringBuffer param=new StringBuffer("&community="+teasession._strCommunity);
StringBuffer sql=new StringBuffer();

String text=request.getParameter("text");
String hidden=request.getParameter("hidden");

param.append("&text="+text);
param.append("&hidden="+hidden);

param.append("&members="+members);
int unit=0;
String tmp=request.getParameter("unit");
if(tmp!=null&&tmp.length()>0)
{
  unit=Integer.parseInt(tmp);
  sql.append(" AND unit=").append(unit);
}

String member=request.getParameter("member");
if(member!=null&&member.length()>0)
{
  sql.append(" AND member LIKE ").append(DbAdapter.cite("%"+member+"%"));
}
 %>

<HTML>
  <HEAD>
    <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
    <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
        <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
          <META HTTP-EQUIV="Expires" CONTENT="0">

  </HEAD>

 <SCRIPT >
 function aaa()
 {
   var name="",v="";
   var check=document.all('select');
   if(!check.length)
   {
     check=new Array(check);
   }
   for(var i=0;i<check.length;i++)
   {
     if(check[i].checked)
     {
       v=v+check[i].value+";";
       name=name+check[i].label+";";
     }
   }
   window.opener.document.all.<%=text%>.value=name;
   window.opener.document.all.<%=hidden%>.value=v;
   window.close();

 }

 function yh(n)
 {
   window.opener.document.all.<%=text%>.value=n;
   window.opener.document.all.<%=hidden%>.value=n;
   window.close();
 }

</SCRIPT>
    <body >
      <h1>发布范围（会员）</h1>
  <div id="head6"><img height="6" src="about:blank" alt=""></div>
    <br>

    <FORM name="form2" METHOD="post"  action="?" onSubmit="return sub(this);">
<input name="text" type="hidden" value="<%=text%>">
<input name="hidden" type="hidden" value="<%=hidden%>">
<input name="members" type="hidden" value="<%=members%>"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td>会员:<input type="text" name="member" value="<%if(member!=null)out.print(member);%>"/></td>
 <%--  <td>部门:<select name="unit">
  <option value="">--------------------</option>
  <%
  Enumeration eau=AdminUnit.findByCommunity(teasession._strCommunity,"");
  while(eau.hasMoreElements())
  {
    int id=((Integer)eau.nextElement()).intValue();
    AdminUnit obj=AdminUnit.find(id);
    out.print("<option value="+id);
    if(id==unit)out.print(" selected ");
    out.print(">"+obj.getName());
  }
  %>
  </select></td>--%>
  <td><input type="submit" value="检索"/></td>
</tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" width="100%"  id="tablecenter">
  <tr id="tableonetr" >
  <td nowrap="nowrap">会员名称</td>
 <%--  <td nowrap="nowrap">部门</td>--%>
  </tr>
<%
// java.util.Enumeration adme=AdminRole.findByCommunity(teasession._strCommunity,-1);
java.util.Enumeration e =AdminUsrRole.findByCommunity(teasession._strCommunity,sql.toString());
for(int i=1;e.hasMoreElements();i++)
{
  String membername=(String)e.nextElement();
    AdminUsrRole aur=AdminUsrRole.find(teasession._strCommunity,membername);
  AdminUnit au=AdminUnit.find(aur.getUnit());

  out.print(" <tr onMouseOver=\"javascript:this.bgColor='#BCD1E9'\" onMouseOut=\"javascript:this.bgColor=''\" >");
//  out.print("<td><input type=\"CHECKBOX\" name=select value="+membername+" label="+membername+" ");
//  if(members!=null && members.length()>0)
//  {
//    String a[] = members.split(";");
//
//    for(int j=0;j<a.length;j++)
//    {
//      if(membername.equals(a[j]))
//      {
//        out.print("  checked=checked");
//      }
//    }
//  }
//  out.print("</td>");

  out.print("<td onclick=\"yh('"+membername+"');\">"+membername+"</td>");
//  out.print("<td>");
//    if(au.isExists())
//  {
//    out.print(au.getName());
//  }
//  out.print("</td>");
  out.print("</tr>");

}
%>

<%--
<tr>

 <td ><input type="CHECKBOX" onclick="selectAll(form2.select,this.checked)" value="0" style="cursor:hand">全选</td>
<td>
  <input type="button" value="提交" onclick="aaa();">
</td>
 </tr>
--%>
</table>
    </FORM>

    <br>
   <div id="head6"><img height="6" src="about:blank" alt=""></div>
  </body>
</HTML>
