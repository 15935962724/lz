<%@page contentType="text/html;charset=UTF-8"  %>

<html>
<head>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">

</head>

<SCRIPT language="JavaScript" TYPE="text/JavaScript">
function OpenWin(theURL,winName,features)
{
  window.open(theURL,winName,features);
}
function HideFrm()
{
	parent.window.mainFrm.cols = '0,*'
	parent.mainpg.document.all['showBtn'].style.display = ''
}
function DelAgent(id)  {
	if (confirm('你确定要删除吗？')) {
		document.location.href='frame_left_chr.asp?cv_agent_id='+id;
	}
}
</SCRIPT>

<BODY>
<TABLE  BORDER=0  class="section" CELLPADDING=3 CELLSPACING=0>
<%
java.util.Enumeration enumerationsave=tea.entity.node.EntSearch.find();
while(enumerationsave.hasMoreElements())
{
    String name=enumerationsave.nextElement().toString();
%>
          <TR VALIGN="TOP">
            <TD CLASS="funcbg"><A HREF="cv_search_agent.asp?cv_agent_id=14973" CLASS="menu" TARGET="mainpg"><%=name%></A></TD>
            <TD CLASS="funcbg" NOWRAP><A HREF="EditEntSearch.jsp?name=<%=name%>" CLASS="menu" >修改</A>
              <A HREF="#" onClick="if(confirm('确认删除')){window.open('/servlet/DeleteEntSearch?name=<%=name%>', '_self')};">删除</A></TD>
          </TR>
<%}%>
 </TABLE>

