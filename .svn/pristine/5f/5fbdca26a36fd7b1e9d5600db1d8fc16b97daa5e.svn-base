<%@page contentType="text/html;charset=GBK" %>
<%
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
java.util.Enumeration enumer=tea.entity.node.Node.findAllSons(teasession._nNode);
String community=request.getParameter("community");
if(community==null)
{
    //tea.entity.node.Node node=  tea.entity.node.Node.find(teasession._nNode);
    //community=node.getCommunity();
}
int nodex=Integer.parseInt(request.getParameter("Nodex"));
%>


<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#CCCCCC" >
<%
while(enumer.hasMoreElements())
{
  int id=((Integer)enumer.nextElement()).intValue();
  tea.entity.node.Category c=  tea.entity.node.Category.find(id);
  if(c.getCategory()!=34)
  {
    continue ;
  }
  tea.entity.node.Node node=  tea.entity.node.Node.find(id);
%>
  <tr >
    <td colspan="3" bgcolor="#FFFFFF"><strong><A href="/servlet/Node?node=<%=id%>" target="_top" ><%=node.getSubject(teasession._nLanguage)%></A></strong></td>
  </tr>

<%
java.util.Enumeration brand_enumer =tea.entity.node.Brand.findByGoods(id);
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
<td bgcolor="#FFFFFF"><table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#999999" style="padding:5px " id="chanpinlist">
      <tr bgcolor="#FFFFFF">
        <td width="9%" rowspan="2">
        <A href="/servlet/Folder?node=<%=nodex%>&brand=<%=brand_id%>&Nodex=<%=id%>" ><img alt="" src="<%=brand_obj.getLogo()%>" width="111" height="93"/></A>
        </td>
        <td width="91%">
<A href="/servlet/Folder?node=<%=nodex%>&brand=<%=brand_id%>&Nodex=<%=id%>" ><%=brand_obj.getName(teasession._nLanguage)%></A>  </td>
</tr>
 <tr>
        <td bgcolor="#FFFFFF" ><%=brand_obj.getContent(teasession._nLanguage)%></td>
      </tr>
    </table></td>
<%}
for(;index%3!=0;index++)
{
  out.print("<td></td>");
}
%>
</tr>
<%}%>
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

