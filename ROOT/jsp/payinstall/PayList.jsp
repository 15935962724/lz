<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.admin.mov.*"%>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.site.*" %>
<%
request.setCharacterEncoding("UTF-8");


TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String nexturl =request.getRequestURI()+"?"+request.getContextPath();
%>
<!DOCTYPE html>
<html>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body bgcolor="#ffffff">
<script type="text/javascript">
function f_edit(igd,igdtype)
{
  form1.pay.value=igd;
  form1.paytype.value=igdtype;
  form1.action="/jsp/payinstall/EditPay.jsp";
  form1.submit();
}
function f_edit2(igd,igdtype)
{
  form1.payid.value=igd;
  form1.paytype.value=igdtype;
  form1.action="/jsp/payinstall/EditPay.jsp";
  form1.submit();
}
function f_delete(igd,igdtype)
{
  if(confirm('您确认要删除此条记录吗？'))
  {
    form1.payid.value=igd;
    form1.paytype.value=igdtype;
    form1.act.value='delete';
    form1.action="/servlet/EditPay";
    form1.submit();
  }
}
function f_use(igd,igdtype)
{
  form1.pay.value=igd;
  form1.paytype.value=igdtype;
  form1.act.value='use';
  form1.action="/servlet/EditPay";
  form1.submit();
}
function f_use2(igd,igdtype)
{
  form1.payid.value=igd;
  form1.paytype.value=igdtype;
  form1.act.value='use';
  form1.action="/servlet/EditPay";
  form1.submit();
}
</script>
<h1>支付设置</h1>
<form action="?" name="form1" method="POST">
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="pay"/>
<input type="hidden" name="paytype"/>
<input type="hidden" name="payid"/>
<input type="hidden" name="act">
<div class='radiusBox'>
<table cellspacing="0" class='newTable' id='tdbor'>
<thead>
<tr><td colspan='6'>线上支付列表</td></tr>
</thead>
    <th>支付方式</th>
    <th>商户号ID</th>
    <th>安全校验码</th>
    <th>支付信箱</th>
    <th>启用状态</th>
    <th>操作</th>
  </tr>
  <%

  for(int i=1;i<Payinstall.PAYNAME.length;i++)
  {
    Payinstall piobj = Payinstall.findpay(i);

    %>
    <tr>
      <td><%=Payinstall.PAYNAME[i]%></td>
      <td><%if(piobj.getMerchant()!=null && piobj.getMerchant().length()>0)out.print(piobj.getMerchant());else out.print("暂未设置"); %></td>
      <td><%if(piobj.getSafety()!=null && piobj.getSafety().length()>0)out.print(piobj.getSafety());else out.print("暂未设置"); %></td>
      <td><%if(piobj.getPayeail()!=null && piobj.getPayeail().length()>0)out.print(piobj.getPayeail());else out.print("暂未设置"); %></td>
      <td><%if(piobj.getUsetype()==0)out.print("暂停使用");else if(piobj.getUsetype()==1)out.print("正在使用"); %></td>
      <td><input type="button" value="编辑" onclick="f_edit('<%=i%>','1');"/>&nbsp;&nbsp;

        <input type="button" value="<%if(piobj.getMerchant()!=null && piobj.getMerchant().length()>0){if(piobj.getUsetype()==0)out.print("启用支付接口");else if(piobj.getUsetype()==1)out.print("暂停使用");}else{out.print("本社区该支付接口暂未设置");}%>"  <%if(piobj.getMerchant()==null)out.print("disabled=\"disabled\"  style=\"background:#666666\"");%> onclick="f_use('<%=i%>','1');"/>
</td>
    </tr>
    <%} %>
</table>

</div>
<div class='radiusBox mt15'>
<table cellspacing="0" class='newTable' id='tdbor'>
<thead>
<tr><td colspan='6'>线下支付列表</td></tr>
</thead>
  <tr id="">
    <th>支付方式</th>
    <th>支付说明</th>
    <th>启用状态</th>
    <th>操作</th>
  </tr>
  <%
  java.util.Enumeration e = Payinstall.find(teasession._strCommunity," AND paytype=2",0,Integer.MAX_VALUE);
  if(!e.hasMoreElements())
  {
    out.print("<tr><td colspan=10 class='noCont'>暂无记录</td></tr>");
  }

  while(e.hasMoreElements()){
    int payid = ((Integer)e.nextElement()).intValue();
    Payinstall piobj = Payinstall.find(payid);
    %>
    <tr>
      <td><%=piobj.getPayname()%></td>
      <td><%=piobj.getPaycontent()%></td>
       <td><%if(piobj.getUsetype()==0)out.print("暂停使用");else if(piobj.getUsetype()==1)out.print("正在使用"); %></td>
      <td>
        <input type="button" value="编辑" onclick="f_edit2('<%=payid%>',2);"/>&nbsp;&nbsp;
        <input type="button" value="<%if(piobj.getUsetype()==0)out.print("启用支付接口");else if(piobj.getUsetype()==1)out.print("暂停使用");%>" onclick="f_use2('<%=payid%>','2');"/>

        <input type="button" value="删除" onclick="f_delete('<%=payid%>','2');"/></td>

    </tr>
    <%}%>
</table>
</div>

<div class='mt15'><input type="button" value="创建支付方式" class='btn btn-primary' onclick="window.open('/jsp/payinstall/EditPay.jsp?paytype=2&nexturl=<%=nexturl%>','_self');"/></div>

</form>


</body>
</html>

