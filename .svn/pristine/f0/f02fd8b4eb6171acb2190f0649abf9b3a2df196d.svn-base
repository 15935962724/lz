<%@page contentType="text/html;charset=GBK" %>
<%
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
String community=request.getParameter("community");
if(community==null)
{
    //tea.entity.node.Node node=  tea.entity.node.Node.find(teasession._nNode);
    //community=node.getCommunity();
}
tea.entity.node.Node node=  tea.entity.node.Node.find(teasession._nNode);

int nodex=22019;
try
{
  nodex=Integer.parseInt(request.getParameter("Nodex"));
}catch(Exception e)
{}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

<script src="/tea/tea.js" type="text/javascript"></script>
<style type="text/css">
<!--
#pinpai{padding:10px}

-->
</style>
</head>

<body>


<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" style="padding:10px">

  <tr bgcolor="#FFFFFF">
    <td colspan="3"><strong><%=node.getSubject(teasession._nLanguage)%></strong></td>
  </tr>
<%
java.util.Enumeration brand_enumer =tea.entity.node.Brand.findByGoods(teasession._nNode);
int index=0;
for(;brand_enumer.hasMoreElements();index++)
{
  int brand_id=((Integer)brand_enumer.nextElement()).intValue();
  tea.entity.node.Brand brand_obj=tea.entity.node.Brand.find(brand_id);
  if(index%3==0)
  {
    out.println("<tr bgcolor=#FFFFFF>");
  }
%>
<td><table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" id="pinpai">
      <tr bgcolor="#FFFFFF">
        <td width="121" rowspan="2">
        <A href="/servlet/Folder?node=<%=nodex%>&brand=<%=brand_id%>&Nodex=<%=teasession._nNode%>" ><img alt="" src="<%=brand_obj.getLogo()%>" width="111" height="93"/></A>
        </td>
        <td width="218" height="28">
<A href="/servlet/Folder?node=<%=nodex%>&brand=<%=brand_id%>&Nodex=<%=teasession._nNode%>" ><%=brand_obj.getName(teasession._nLanguage)%></A>
  </td>
</tr>
 <tr>
        <td bgcolor="#FFFFFF"><%=brand_obj.getContent(teasession._nLanguage)%></td>
      </tr>
    </table></td>
<%}
for(;index%3!=0;index++)
{
  out.print("<td></td>");
}
%>
</tr>

</table>

</body>
</html>
<!---

<span id=showImport></span>
<IE:Download ID="oDownload" STYLE="behavior:url(#default#download)" />
<script type="">
function onDownloadDone(downDate){
showImport.innerHTML=downDate
}
oDownload.startDownload('/jsp/type/goods/GoodsList.jsp?node=20390',onDownloadDone)
</script>

-->

