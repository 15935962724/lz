<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.ui.*" %><%

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Frameset//EN">
<html>
<head>
<META http-equiv=Content-Type content="text/html; charset=UTF-8">
</head>
<FRAMESET id="function_fs" border=0 frameSpacing=0 rows=* frameBorder=YES cols=200,*>
  <FRAME name="function_funlist" src="/jsp/type/goods/GoodsTypeList.jsp?node=<%=teasession._nNode%>&community=<%=teasession._strCommunity%>&editgoodstype=ON" frameBorder=NO noResize scrolling=yes>
  <FRAME name="function_fun" src="" noResize scrolling=yes>
</FRAMESET>
</html>

