<%@page contentType="text/html;charset=UTF-8" %>
<%
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);

String community=request.getParameter("community");
if(community==null)
{
    tea.entity.node.Node node=  tea.entity.node.Node.find(teasession._nNode);
    community=node.getCommunity();
}
int nodex=Integer.parseInt(request.getParameter("Nodex"));
%>


<table width="100%" border="0" cellpadding="0" cellspacing="0" >

<%
java.util.Enumeration brand_enumer =tea.entity.node.Brand.findByCommunity(community);
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
<td><table border="1" cellpadding="0" cellspacing="0" id="chanpinlist">
      <tr>
        <td rowspan="2">
        <A href="/servlet/Folder?node=<%=nodex%>&brand=<%=brand_id%>&Nodex=<%//=id%>" ><img alt="" src="<%=brand_obj.getLogo()%>" width="111" height="93"/></A>
        </td>
        <td>
<A href="/servlet/Folder?node=<%=nodex%>&brand=<%=brand_id%>&Nodex=<%//=id%>" ><%=brand_obj.getName(teasession._nLanguage)%></A>
  </td>
</tr>
 <tr>
        <td ><%=brand_obj.getContent(teasession._nLanguage)%></td>
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

