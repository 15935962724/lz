<%@page contentType="text/html;charset=UTF-8" %><%

tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect(request.getContextPath()+"/servlet/StartLogin?Node="+teasession._nNode);
  return;
}
String community=request.getParameter("community");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Frameset//EN">
<html>
<head>
<META http-equiv=Content-Type content="text/html; charset=UTF-8">

</head>
<FRAMESET id="function_fs" border=0 frameSpacing=0 rows=* frameBorder=YES cols=200,*>
  <FRAME name="function_funlist" src="/jsp/type/goods/GoodsTypeList.jsp?Node=<%=teasession._nNode%>&community=<%=community%>&editgoodstype=ON" frameBorder=NO noResize scrolling=yes>
  <FRAME name="function_fun" src="" noResize scrolling=yes>
</FRAMESET>
</html>
