<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Frameset//EN">
<html>
<head>
<%
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
      int strid=0;
      if(request.getParameter("MenuId")!=null)
      {
        strid=Integer.parseInt(request.getParameter("MenuId"));
      }

%>
<META http-equiv=Content-Type content="text/html; charset=UTF-8">
<LINK href="user.files/style.css" type=text/css rel=stylesheet>
<META content="MSHTML 6.00.2600.0" name=GENERATOR>
</head>
<FRAMESET border=0 frameSpacing=0 rows=* frameBorder=YES cols=200,*>
  <FRAME name=user_list SRC="/jsp/admin/popedom/zonelist.jsp?node=<%=teasession._nNode%>" frameBorder=NO noResize scrolling=yes>
  <FRAME name="t" SRC="/jsp/admin/popedom/editzone.jsp?node=<%=teasession._nNode%>&sub=0&MenuId=<%=strid%>" noResize scrolling=yes>
</FRAMESET>
</html>



