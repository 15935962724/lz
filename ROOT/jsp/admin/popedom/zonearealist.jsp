<%@page contentType="text/html;charset=UTF-8" %>
<%@ include file="/jsp/Header.jsp" %>
<%
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<!--#include file="../public.inc"-->
<html>
	<head>
		<TITLE>用户列表</TITLE>
		<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<LINK href="../style.css" type="text/css" rel="stylesheet">
		<link rel="stylesheet" href="../STYLE.CSS" type="text/css">
		<link href="../../css/css.css" rel="stylesheet" type="text/css">
			<META content="MSHTML 6.00.2600.0" name="GENERATOR"><style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style></head>
	<BODY leftMargin="0" text="#000000" leftmargin="0" topmargin="5" marginwidth="0" marginheight="0">
		<DIV align="center" class="Big1"><br>
	    区域列表（全体）
	      <hr color="#CB9966" size="1">
		</DIV>
		<br/>
		<%
                java.util.Enumeration enumer=tea.entity.admin.AdminZone.findByCommunity(node.getCommunity());
			/*strQuery = "select * from tabunit order by [order]"
			set rs=server.CreateObject ("ADODB.Recordset")
			rs.CursorLocation = 3
			rs.Open strQuery , conn
			intCount = 0
			while not rs.EOF
			intCount=intCount+1*/

                        for(int intCount=1;enumer.hasMoreElements();intCount++){
                        int unltid=((Integer)enumer.nextElement()).intValue();
                        tea.entity.admin.AdminZone au_obj=tea.entity.admin.AdminZone.find(unltid);
		%>
		<table class="small" cellSpacing="1" cellPadding="3" width="100%" bgColor=#F4F4F4  align="center" border="0">
			<TBODY>
				<TR class="TableHeader"  >
					<td noWrap align="middle"><A id="123" onmousedown="" href="editzonearea.jsp?UnitId=<%=unltid%><%//=rs("UnitId").Value%>" target="dept_user"><%=au_obj.getName()%><%//=rs("UnitName").Value%></A></td>
				</tr>
                        </TBODY>
                </TABLE><%--
			<table class="small" id="<%=intCount%>" style="DISPLAY: none" cellSpacing="1" cellPadding="3" width="100%" border="0">
				<TBODY>
					<%
                                        java.util.Enumeration enumer_pro= tea.entity.member.Profile.findByUnit(unltid);
                                        while(enumer_pro.hasMoreElements())
                                        {
                                          String profile_id=(String)enumer_pro.nextElement();
                                          tea.entity.member.Profile profile=  tea.entity.member.Profile.find(profile_id);
                                          profile_id=new String(profile_id.getBytes("ISO-8859-1"));
                                          /*
                                          strQuery = "select UsrId,UserName,UserUnit,UserPwd,UserRole,(select RoleName from TabRole where RoleId=UserRole) as UsrRoleDes,Usersex from tab_users where UserUnit=" & rs("UnitId").Value
                                          set rss=server.CreateObject ("ADODB.Recordset")
                                          rss.CursorLocation = 3
                                          rss.Open strQuery , conn
                                          while not rss.EOF*/
                                          %>
                                          <TR class="TableData" align="middle" colspan="2">
                                            <td noWrap><A href="dept_user.jsp?UsrId=<%=profile_id%>&UnitId=<%=unltid%>&del=1" target="dept_user"><%=profile.getFirstName(teasession._nLanguage)%><%//=rss("UserName").Value%></A></td>
                                          </tr>
                                          <%
                                          //						rss.MoveNext()
                                          //						wend
                                        }
					%>
				</TBODY></TABLE>--%>
		<%
                        }
		%>
        <br>
    <hr color="#CB9966" size="1">
		<%--TABLE class="small" cellSpacing="1" cellPadding="3" width="100%" bgColor=#F4F4F4  align="center" border="0">
			<TBODY>
				<TR class="TableHeader" title="点击伸缩列表" style="CURSOR: hand" onclick="clickMenu('0')">
					<td noWrap align="middle"><A href="dept_user.jsp?UnitId=<%=0%><%//=rs("UnitId").Value%>" target="dept_user">所有会员</A></td>
				</tr>
                        </TBODY>
                </TABLE>

		<table class="small" id="0" style="DISPLAY: none" cellSpacing="1" cellPadding="3" width="100%" border="0">
			<TBODY>
                          <%
                                        java.util.Enumeration enumer_pro_all= tea.entity.member.Profile.find();
                                        while(enumer_pro_all.hasMoreElements())
                                        {
                                          String profile_id=(String)     enumer_pro_all.nextElement();
                                          tea.entity.member.Profile profile=  tea.entity.member.Profile.find(profile_id);
                                          profile_id=new String(profile_id.getBytes("ISO-8859-1"));
                                          /*
                                          strQuery = "select UsrId,UserName,UserUnit,UserPwd,UserRole,(select RoleName from TabRole where RoleId=UserRole) as UsrRoleDes,Usersex from tab_users where UserUnit=" & rs("UnitId").Value
                                          set rss=server.CreateObject ("ADODB.Recordset")
                                          rss.CursorLocation = 3
                                          rss.Open strQuery , conn
                                          while not rss.EOF*/
                                          %>
                                          <TR class="TableData" align="middle" colspan="2">
                                           <A href="dept_user.jsp?UsrId=<%=profile_id%>&UnitId=<%=profile.getAdminUnit()%>&del=1" target="dept_user"> <td noWrap><%=profile_id%> <td ><%=profile.getFirstName(teasession._nLanguage)%><%//=rss("UserName").Value%></td></A>
                                          </tr>
                                          <%
                                          //						rss.MoveNext()
                                          //						wend
                                        }
					%>
                        </TBODY>
                </TABLE--%>
		<SCRIPT language="JavaScript">
function clickMenu(ID)
{
   /* targetelement=document.all(ID);
    if (targetelement.style.display=="none")
        targetelement.style.display='';
    else
        targetelement.style.display="none";
*/
    parent.dept_user.location="editzonearea.jsp?UnitId="+ID;
}
		</SCRIPT>
	</BODY>
</html>



