<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
if(!teasession._rv.isHR())
{
  response.sendError(403);
  return;
}

Resource r=new Resource("/tea/ui/member/profile/EditAssociate");


String s =  request.getParameter("Associate");
boolean flag = s == null;
int k = 0;
int i1 = 0;
int k1 = 0;
int j2 = 0;
String s2 = "";
if(!flag)
{
  tea.entity.member. Associate associate = tea.entity.member. Associate.find(teasession._rv._strR, s);
  k = associate.getPositions();
  i1 = associate.getManagers();
  k1 = associate.getProviders0();
  j2 = associate.getProviders1();
  s2 = associate.getStartUrl();
}
%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Edit")%><%=r.getString(teasession._nLanguage, "CBAssociates")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

<FORM name=foEdit METHOD=POST action="/servlet/EditAssociate" onSubmit="return(submitText(this.Associates,'<%=r.getString(teasession._nLanguage, "InvalidMemberIds")%>'));">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><TD><%=r.getString(teasession._nLanguage, "MemberIds")%>:</TD>
<td><%
 if(!flag)
{%> <input type='hidden' name=Associates VALUE="<%=s%>">
	<%=s%><%
} else
{%>	<input type="TEXT" class="edit_input"  name=Associates>
  <SCRIPT>document.foEdit.Associates.focus();</SCRIPT>
<%
}%>
<td>
</tr>

<tr><TD><%=r.getString(teasession._nLanguage, "Positions")%>:</TD>
<td>

<input  id="CHECKBOX" type="CHECKBOX" name=PHR value=null <%if((k & 1 << 0) != 0)out.print(" checked ");%>><%=r.getString(teasession._nLanguage, Associate.ASSOCIATE[0])%>
<input  id="CHECKBOX" type="CHECKBOX" name=PSupport value=null <%if((k & 1 << 1) != 0)out.print(" checked ");%>><%=r.getString(teasession._nLanguage, Associate.ASSOCIATE[1])%>
<input  id="CHECKBOX" type="CHECKBOX" name=PPurchaser value=null <%if((k & 1 << 2) != 0)out.print(" checked ");%>><%=r.getString(teasession._nLanguage, Associate.ASSOCIATE[2])%>
<input  id="CHECKBOX" type="CHECKBOX" name=PAccountant value=null <%if((k & 1 << 3) != 0)out.print(" checked ");%>><%=r.getString(teasession._nLanguage, Associate.ASSOCIATE[3])%>
<input  id="CHECKBOX" type="CHECKBOX" name=POrganizer value=null <%if((k & 1 << 4) != 0)out.print(" checked ");%>><%=r.getString(teasession._nLanguage, Associate.ASSOCIATE[4])%>
<input  id="CHECKBOX" type="CHECKBOX" name=PAdManager value=null <%if((k & 1 << 5) != 0)out.print(" checked ");%>><%=r.getString(teasession._nLanguage, Associate.ASSOCIATE[5])%> </td></tr>
<tr><TD><%=r.getString(teasession._nLanguage, "Managers")%>:</TD>
<td>
  <%
  //获得主人所具有的角色
  tea.entity.admin.AdminUsrRole aur_obj=tea.entity.admin.AdminUsrRole.find(teasession._rv._strR,teasession._strCommunity);
  String role=  aur_obj.getRole();
  if(role!=null)
  {
    java.util.StringTokenizer tokenizer_obj=new java.util.StringTokenizer(role,"/");
    boolean check=false;
    String associaterole=null;
    if(!flag)
    {//获得助手所具有的角色
       associaterole= tea.entity.admin.AdminUsrRole.find(s,teasession._strCommunity).getRole();
    }
    while(tokenizer_obj.hasMoreTokens())
    {
      int id=Integer.parseInt((String)tokenizer_obj.nextElement());
      tea.entity.admin.AdminRole ar_obj=tea.entity.admin.AdminRole.find(id);
      if(associaterole!=null)
      {
        check=associaterole.indexOf("/"+id+"/")!=-1;
      }
      out.println("<input type=\"CHECKBOX\" name=Role value="+id);
      if(check)out.print(" checked ");
      out.print(" >"+ar_obj.getName());
    }
  }
  %>
&nbsp;</td></tr>
<tr><TD><%=r.getString(teasession._nLanguage, "StartUrl")%>:</TD>
<td>
<input type="TEXT" class="edit_input"  name=StartUrl VALUE="<%=s2%>" SIZE=60 MAXLENGTH=255></td></tr><tr><td align="center">&nbsp;
</td>
<td><input type="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>"></td>
</tr>
</table>

</FORM>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>

