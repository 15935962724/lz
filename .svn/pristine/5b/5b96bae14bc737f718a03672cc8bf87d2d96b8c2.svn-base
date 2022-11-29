<%@page contentType="text/html;charset=UTF-8" %>
<%@ include file="/jsp/Header.jsp" %>
<html>
	<head>
		<TITLE>办事处列表</TITLE>
		<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>

</head>
	<BODY >
		<DIV align="center"><br>
	    办事处列表（全体）
	      <hr color="#CB9966" size="1">
		</DIV>
                <br/>
		<%
                java.util.Enumeration enumer=tea.entity.admin.AdminZone.findByFather(tea.entity.admin.AdminZone.getRootId(node.getCommunity()));//tea.entity.admin.AdminZone.findByCommunity(node.getCommunity());
                        for(int intCount=1;enumer.hasMoreElements();intCount++)
                        {
                          int unltid=((Integer)  enumer.nextElement()).intValue();
                          tea.entity.admin.AdminZone au_obj=tea.entity.admin.AdminZone.find(unltid);
                          if(intCount==1)
                          {%>
                          <script type="">window.open('WaiterList.jsp?node=<%=teasession._nNode%>&zone=<%=unltid%>','dept_user');</script>
                          <%}
                          %>
                          <TABLE cellSpacing="1" cellPadding="3" width="100%" bgColor=#F4F4F4  align="center" border="0">
			<TBODY>
                        <TR title="点击伸缩列表" style="CURSOR: hand" onclick="clickMenu('<%=unltid%>')">
                          <TD noWrap align="middle"><A href="WaiterList.jsp?node=<%=teasession._nNode%>&zone=<%=unltid%>" target="dept_user"><%=au_obj.getName()%></A></TD>
                        </TR>
                        </TBODY></TABLE>

                        <TABLE class="small" id="<%=unltid%>" style="DISPLAY: none" cellSpacing="1" cellPadding="3" width="100%" border="0">
				<TBODY>
					<%
                                        java.util.Enumeration enumer_pro= tea.entity.admin.AdminZone.findByFather(unltid);
                                        while(enumer_pro.hasMoreElements())
                                        {
                                          int profile_id=((Integer)enumer_pro.nextElement()).intValue();
                                          tea.entity.admin.AdminZone profile=  tea.entity.admin.AdminZone.find(profile_id);

                                          %>
                                          <TR class="TableData" align="middle" colspan="2">
                                            <TD noWrap><A href="WaiterList.jsp?node=<%=teasession._nNode%>&zone=<%=profile_id%>" target="dept_user"><%=profile.getName()%></A></TD>
                                          </TR>
                                          <%
                                        }
					%>
				</TBODY></TABLE>

                        <%}%>
                          <TABLE cellSpacing="1" cellPadding="3" width="100%" bgColor=#F4F4F4  align="center" border="0">
                                                <TR title="点击伸缩列表" style="CURSOR: hand" onclick="window.open('WaiterList.jsp?node=<%=teasession._nNode%>&zone=<%=0%>','dept_user')">
                          <TD noWrap align="middle"><A href="WaiterList.jsp?node=<%=teasession._nNode%>&zone=<%=0%>" target="dept_user">其它</A></TD>
                        </TR>
                        </TBODY>
                </TABLE>
<SCRIPT language="JavaScript" >
function clickMenu(ID)
{
    targetelement=document.all(ID);
    if (targetelement.style.display=="none")
        targetelement.style.display='';
    else
        targetelement.style.display="none";

    parent.dept_user.location="WaiterList.jsp?node=<%=teasession._nNode%>&zone="+ID;
}
</SCRIPT>
</BODY>
</html>

