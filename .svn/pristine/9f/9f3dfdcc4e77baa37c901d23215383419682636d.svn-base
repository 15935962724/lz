<%@page contentType="text/html;charset=UTF-8" %><%
int type=39;
try
{
  type=Integer.parseInt(request.getParameter("type"));
}catch(Exception e)
{}
tea.resource.Resource r=new tea.resource.Resource();
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
String value=null;
if(request.getParameter("value")==null)
value=r.getString(teasession._nLanguage, "CBNew" + tea.entity.node.Node.NODE_TYPE[type]);
else
value=new String(request.getParameter("value").getBytes("ISO-8859-1"));
%>
<INPUT TYPE="BUTTON" VALUE="我要加入<%//=value%>" ID="CBNew<%= tea.entity.node.Node.NODE_TYPE[type]%>" CLASS="CB" onClick="window.open('/jsp/type/<%=tea.entity.node.Node.NODE_TYPE[type].toLowerCase()%>/Edit<%=tea.entity.node.Node.NODE_TYPE[type]%>.jsp?NewNode=ON&Type=<%=type%>&TypeAlias=0&node=<%=teasession._nNode%>', '_parent');"/>

