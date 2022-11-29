<%@page contentType="text/html;charset=UTF-8" %><%@ include file="/jsp/Header.jsp" %><%

r.add("/tea/resource/deptuser");
String right=request.getParameter("right");
if(right==null)
{
  right="/jsp/criterion/dept_user.jsp";
}
String name=request.getParameter("name");

%>
<html>
  <head>
    <META http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
      <script src="/tea/tea.js" type="text/javascript"></script>
      <style type="text/css">
      <!--
      body {
      margin-left: 0px;
      margin-top: 0px;
      margin-right: 0px;
      margin-bottom: 0px;
      }
      -->
      </style>
  </head>
  <BODY leftMargin="0" text="#000000" leftmargin="0" topmargin="5" marginwidth="0" marginheight="0">
    <DIV align="center" class="Big1"><br>
      <%//=r.getString(teasession._nLanguage, "PersonnelList")%>编制组
      <hr color="#CB9966" size="1">
    </DIV>
    <form action="<%=request.getRequestURI()%>" method="get">
    <input type="text" name="name" size="15" value="<%if(name!=null)out.print(name);%>"/><input type="submit" value="GO"/>
    </form>
    <br/>

<%
//只显示"编制组"单位
StringBuffer sb=new StringBuffer("SELECT id FROM AdminUnit WHERE other3=1 AND  community=" + DbAdapter.cite(node.getCommunity()));
if(!tea.entity.site.License.getInstance().getWebMaster().equals(teasession._rv.toString()))
{
  //sb.append(" AND creator="+DbAdapter.cite(teasession._rv.toString()));
}
if(name!=null)
sb.append(" AND name LIKE "+DbAdapter.cite("%"+name+"%"));

DbAdapter dbadapter=new DbAdapter();
try
{
  dbadapter.executeQuery(sb.toString());
  while (dbadapter.next())
  {
    int unltid=(dbadapter.getInt(1));
    tea.entity.admin.AdminUnit au_obj=tea.entity.admin.AdminUnit.find(unltid);
%>

<TABLE class="small" cellSpacing="1" cellPadding="3" width="100%" bgColor=#F4F4F4  align="center" border="0">
  <TBODY>
    <TR class="TableHeader" title=""  >
      <TD noWrap align="middle"><A href="<%=right%>?node=<%=teasession._nNode%>&UnitId=<%=unltid%><%//=rs("UnitId").Value%>" target="dept_user"><%=au_obj.getName()%><%//=rs("UnitName").Value%></A></TD>
    </TR>
  </TBODY>
</TABLE>

<%
  }
}catch(Exception ex)
{
ex.printStackTrace();
}finally
{
  dbadapter.close();
}
%>


		<%--
java.util.Enumeration enumer=tea.entity.admin.AdminUnit.findByCommunity(node.getCommunity());

                        for(int intCount=1;enumer.hasMoreElements();intCount++)
                        {
                        int unltid=((Integer)  enumer.nextElement()).intValue();
                        tea.entity.admin.AdminUnit au_obj=tea.entity.admin.AdminUnit.find(unltid);
		%>

		<TABLE class="small" cellSpacing="1" cellPadding="3" width="100%" bgColor=#F4F4F4  align="center" border="0">
			<TBODY>
				<TR class="TableHeader" title="" style="CURSOR: hand" onclick="clickMenu('<%=intCount%>')">
					<TD noWrap align="middle"><A href="<%=right%>?node=<%=teasession._nNode%>&UnitId=<%=unltid%><%//=rs("UnitId").Value%>" target="dept_user"><%=au_obj.getName()%><%//=rs("UnitName").Value%></A></TD>
				</TR>
                        </TBODY>
                </TABLE>
			<TABLE class="small" id="<%=intCount%>" style="DISPLAY: none" cellSpacing="1" cellPadding="3" width="100%" border="0">
				<TBODY>
					<%
                                        java.util.Enumeration enumer_pro= tea.entity.member.Profile.findByUnit(unltid);
                                        while(enumer_pro.hasMoreElements())
                                        {
                                          String profile_id=(String)enumer_pro.nextElement();
                                          tea.entity.member.Profile profile=  tea.entity.member.Profile.find(profile_id);
                                          profile_id=new String(profile_id.getBytes("ISO-8859-1"));

                                          %>
                                          <TR class="TableData" align="middle" colspan="2">
                                            <TD noWrap><A href="<%=right%>?node=<%=teasession._nNode%>&UsrId=<%=profile_id%>&UnitId=<%=unltid%>&del=1" target="dept_user"><%=profile.getFirstName(teasession._nLanguage)%> <%=profile.getLastName(teasession._nLanguage)%></A></TD>
                                          </TR>
                                          <%
                                        }
					%>
				</TBODY></TABLE>


		<%
                        }
		%><TABLE class="small" cellSpacing="1" cellPadding="3" width="100%" bgColor=#F4F4F4  align="center" border="0">
                   			<TBODY>
				<TR class="TableHeader" title="" style="CURSOR: hand" onclick="clickMenu('0')">
					<TD noWrap align="middle"><A href="<%=right%>?node=<%=teasession._nNode%>&UnitId=0" target="dept_user"><%=r.getString(teasession._nLanguage, "NoDept")%></A></TD>
				</TR>
                        </TBODY></TABLE> --%>
        <br>
    <hr color="#CB9966" size="1">

<SCRIPT language="JavaScript" >
function clickMenu(ID)
{
    targetelement=document.all(ID);
    if (targetelement.style.display=="none")
        targetelement.style.display='';
    else
        targetelement.style.display="none";

    parent.dept_user.location="<%=right%>?node=<%=teasession._nNode%>&UnitId="+ID;
}
</SCRIPT>
</BODY>
</html>

