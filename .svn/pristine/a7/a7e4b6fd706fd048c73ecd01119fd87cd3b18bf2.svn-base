<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.league.*" %><%
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+request.getRequestURI()+"?"+request.getQueryString());
  return;
}
String act = teasession.getParameter("act");
Node node = Node.find(teasession._nNode);
Resource r = new Resource();
r.add("/tea/ui/node/type/buy/EditCommodity");
String nexturl=request.getParameter("nexturl");
if(nexturl==null)
{
  nexturl="/jsp/type/goods/GoodsMemberList.jsp?node="+teasession._nNode;
}
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body topmargin="0" leftmargin="0" marginheight="0" marginwidth="0" scroll="yes">
<script type="text/javascript">
window.name='tar';
function f_c(igd,igd2)
{

  var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:557px;dialogHeight:375px;';
  var url = '/jsp/type/buy/EditBuy2.jsp?node='+igd+"&cid="+igd2+"&t="+new Date().getTime();
  var rs =  window.showModalDialog(url,self,y);
  if(rs==1)
  {
    window.open(location.href+"&t="+new Date().getTime(),window.name);

  }
}
function f_delete(igd,igd2)
{
  if(confirm('如果删除,这些商品将无法恢复.您确定吗?')){
    sendx("/jsp/type/buy/EditBuy2.jsp?act=delete&node="+igd+"&cid="+igd2,
    function(data)
    {
      alert(data.trim());
      window.open(location.href+"&t="+new Date().getTime(),window.name);
    }
    );
  }
}
function f_wc()
{
  window.returnValue=1;
  window.close();
}
function f_syb()
{
window.returnValue=2;
window.close();
}
</script>
<h1><%=r.getString(teasession._nLanguage, "Commodity")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<h2><%=r.getString(teasession._nLanguage, "设置供货商和价格")%></h2>
<form action="?" name="form1" method="POST" target="tar">
<table cellspacing="0" cellpadding="0" border="0" id="tablecenter">
  <tr ID=Tableonetr>
    <td nowrap><%=r.getString(teasession._nLanguage, "Supplier")%></td>
    <td nowrap><%=r.getString(teasession._nLanguage, "库存预警数量")%></td>
    <td nowrap>进货价</td>
    <td nowrap>供货价</td>
    <td nowrap>销售价</td>
    <td nowrap>操作</td>
  </tr>
  <%
  java.util.Enumeration  enumeration = tea.entity.node.Commodity.findByGoods(teasession._nNode);
    if(!enumeration.hasMoreElements())
   {
       out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
   }
  while( enumeration.hasMoreElements() )
  {
    int cid = ((Integer)enumeration.nextElement()).intValue();
   Commodity coobj = Commodity.find(cid);
    BuyPrice bpobj = BuyPrice.find(cid, 1);

%>

<tr onmouseover="javascript:this.bgColor='#BCD1E9';" onmouseout="javascript:this.bgColor='';" >
  <td><%=tea.entity.admin.Supplier.find(coobj.getSupplier()).getName(teasession._nLanguage)%></td>
  <td id= MinQuantityid><%=coobj.getMinQuantity()%></td>
  <td><%=bpobj.getList()%></td>
  <td><%=bpobj.getSupply()%></td>
  <td><%=bpobj.getPrice()%></td>
  <input type="hidden" name="delete" value="ON"/>
  <input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
  <input type="hidden" name="commodity" value="<%=cid%>"/>
  <td>
    <input type=button value="编辑"  onclick="f_c('<%=coobj.getGoods()%>','<%=cid%>');"/>
    <input type=button value="删除"  onclick="f_delete('<%=coobj.getGoods()%>','<%=cid%>');"/>
  </td>

  </tr>
  <%
    }
 %>
</table>
<br>
<%
if(!"szjg".equals(act)){
%>
 <input type=button value="上一步" onclick="f_syb();"/>&nbsp;
 <%}%>
<input type="button" value="设置供货商和价格" onclick="f_c('<%=teasession._nNode%>','0');"/>&nbsp;
<%
if(!"szjg".equals(act)){
%>
<input type="button" value="完成" onclick="f_wc();">
<%}
else
{
  out.print("<input type=button value=关闭 onclick=javascript:window.close();");
}
%>

</form>

<div id="head6"><img height="6" src="about:blank"></div>

</body>
</html>

