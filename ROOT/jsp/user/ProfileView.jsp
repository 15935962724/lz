<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page import="tea.resource.Resource" %>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.ui.TeaSession" %>
<% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource();

String member=request.getParameter("member");
Profile p=Profile.find(member);
String photo=p.getPhotopath2(teasession._nLanguage);

AdminUsrRole aur=AdminUsrRole.find(teasession._strCommunity,member);

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<BODY>
<h1><%=r.getString(teasession._nLanguage, "浏览员工记录")%></h1>
<div id="head6"><img height="6" alt=""></div>

<style>
#tablecenter td{line-height:20px;height:20px}
</style>
<TABLE cellSpacing="0" cellPadding="0"  border="1" id="tablecenter" style="border-collapse: collapse". >
    <tr id="tableonetr"><td colspan="5" style="font-size:14px; letter-spacing:10px;height:25px;padding-top:5px"><%=p.getName(teasession._nLanguage)%></td></tr>
	<TR>
      <td width="128" rowspan="8" align=center valign="top"  style="padding:0px;margin:0px"><%
    if(photo!=null&&photo.length()>0)
    {
      out.print("<a href="+photo+" target=_blank> ");
      out.print("<img width=180 src="+photo+">");
      out.print("</a>");
    }
    %></td>
      <td valign="top" style="padding:0px;margin:0px">
        <TABLE cellSpacing="0" cellPadding="0"  border="0" width=100%　style="bl">
          <tr>
      <td width="80" height="20" align="right">姓　　名</td>
      <td height="20" align="left"><%=p.getName(teasession._nLanguage)%>　</td>
      <td width="80" align="right"><%=r.getString(teasession._nLanguage, "性　　别")%></td>
      <td align="left"><%=p.isSex()?"男":"女"%>　</td>
    </TR>
  <TR>

    <td width="80" height="20" align="right"><%=r.getString(teasession._nLanguage, "出生日期")%></td>
    <td height="20" align="left"><%=p.getBirthToString()%>　</td>
      <td width="80" height="20" align="right"><%=r.getString(teasession._nLanguage, "政治面貌")%></td>
    <td height="20" align="left"><%if(p.getPolity()>0)out.print(Profile.POLITY_TYPE[p.getPolity()]);%>　</td>
  </TR>
  <TR>
    <td width="80" height="20" align="right"> 　<%=r.getString(teasession._nLanguage, "学　　历")%></td>
    <td height="20" align="left"><%=p.getDegree(teasession._nLanguage)%>　</td>
  <td width="80" height="20" align="right"> 　<%=r.getString(teasession._nLanguage, "职　　称")%></td>
    <td height="20" align="left"><%=p.getTitle(teasession._nLanguage)%>　</td>
  </TR>
  <TR>

    <td width="80" height="20" align="right"><%=r.getString(teasession._nLanguage, "所属部门")%></td>
    <td height="20" align="left"><%
    int unit=aur.getUnit();
    AdminUnit au=AdminUnit.find(unit);
    if(au.isExists())
    {
      out.print("<a href=/jsp/admin/popedom/AdminUnitView.jsp?adminunit="+unit+" target=_blank>"+au.getName()+"</a>");
    }else
    {
      out.print("无部门");
    }
    %>　    </td>
    <td width="80" height="20" align="right"><%=r.getString(teasession._nLanguage, "职　　务")%></td>
    <td height="20" align="left"><%=p.getJob(teasession._nLanguage)%>　</td>
  </TR>

  <TR>
      <td width="80" height="20" align="right"><%=r.getString(teasession._nLanguage, "入职时间")%></td>
    <td height="20" align="left"><%=p.getETimeToString()%>　 </td>

    <td width="80" height="20" align="right"><%=r.getString(teasession._nLanguage, "手机号码")%></td>
    <td height="20" align="left"><%=p.getMobile()%>　</td>
  </TR>
  <TR>
<td width="80" height="20" align="right"><%=r.getString(teasession._nLanguage, "办公电话")%></td>
    <td height="20" align="left"><%=p.getTelephone(teasession._nLanguage)%>　 </td>

    <td width="80" height="20" align="right"><%=r.getString(teasession._nLanguage, "传　　真")%></td>
    <td height="20" align="left"><%=p.getFax(teasession._nLanguage)%>&nbsp;　</td>
  </TR>
  <TR>
    <td width="80" height="20" align="right"><%=r.getString(teasession._nLanguage, "电子信箱")%></td>
    <td height="20" colspan="3" align="left"><%=p.getEmail()%>　</td>
  </TR>
  <TR>
    <td width="80" height="20" align="right"><%=r.getString(teasession._nLanguage, "岗位职责")%></td>
    <td height="20" colspan="3" align="left">&nbsp;<%=p.getFunctions(teasession._nLanguage)%>　</td>
  </TR>
  <TR>
    <td width="80" height="20" align="right"><%=r.getString(teasession._nLanguage, "地　　址")%></td>
    <td height="20" colspan="3" align="left"><%=p.getAddress(teasession._nLanguage)%>　</td>
  </TR></table></td></tr>
</TABLE>


<br>
<div id="head6"><img height="6" alt=""></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</BODY>
</html>
