<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.entity.admin.cebbank.*" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

int rootid=AnnuityEnt.getRootId(teasession._strCommunity);

%><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Frameset//EN">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
        <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
          <META HTTP-EQUIV="Expires" CONTENT="0">
<FRAMESET border=0 frameSpacing=0 rows=* frameBorder=YES cols=300,*>
  <FRAME name="annuityent_tree" src="/jsp/admin/cebbank/TreeAnnuityEnt.jsp?community=<%=teasession._strCommunity%>" frameBorder=NO noResize scrolling=yes>
  <FRAME name="annuityent_edit" src="/jsp/admin/cebbank/EditAnnuityEnt.jsp?community=<%=teasession._strCommunity%>&annuityent=<%=rootid%>" noResize scrolling=yes>
</FRAMESET>

</html>



