<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.erp.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.admin.erp.*" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String nexturl = request.getRequestURI()+"?"+request.getContextPath();

StringBuffer sql = new StringBuffer("  and type !=1");
StringBuffer param = new StringBuffer();
param.append("?id=").append(request.getParameter("id"));
//param.append("&nexturl=").append(java.net.URLEncoder.encode(nexturl,"UTF-8"));


String time_c = teasession.getParameter("time_c");
if(time_c!=null && time_c.length()>0)
{
  sql.append(" AND time_s >=").append(DbAdapter.cite(time_c));
  param.append("&time_c=").append(time_c);
}
String time_d = teasession.getParameter("time_d");
if(time_d!=null && time_d.length()>0)
{
  sql.append(" AND time_s <=").append(DbAdapter.cite(time_d));
  param.append("&time_d=").append(time_d);
}
int waridname = 0;
if(teasession.getParameter("waridname")!=null && teasession.getParameter("waridname").length()>0)
{
    waridname = Integer.parseInt(teasession.getParameter("waridname"));
}
if(waridname>0)
{
  sql.append(" AND waridname =").append(waridname);
  param.append("&waridname=").append(waridname);
}
String goods = teasession.getParameter("goods");
if(goods!=null && goods.length()>0)
{
  boolean f = false;
  DbAdapter db = new DbAdapter();
  try
  {
    db.executeQuery("SELECT node FROM Node WHERE  type =34 AND hidden = 0 AND node IN (SELECT node FROM NodeLayer WHERE  subject LIKE '%"+goods+"%')");
    if(Purchase.isGoods(goods)>0)
    {
      sql.append(" AND( ");
    }else
    {
      out.print("<script>alert('暂没有您搜索的商品！');</script>");
    }
    for(int i=1;db.next();i++)
    {
      sql.append(" rsgoods like '%/"+db.getInt(1)+"/%' ");
      if(i>1 && Purchase.isGoods(goods)!=i)
        out.print("  OR ");
      f = true;
    }
    if(f)
    {
      sql.append(" )");
      param.append("&goods=").append(java.net.URLEncoder.encode(goods,"UTF-8"));
    }
  }finally
  {
    db.close();
  }
}
int supplname = 0;
if(teasession.getParameter("supplname")!=null && teasession.getParameter("supplname").length()>0)
{
    supplname = Integer.parseInt(teasession.getParameter("supplname"));
}
if(supplname>0)
{
  sql.append(" AND supplname =").append(supplname);
  param.append("&supplname=").append(supplname);
}

int pos = 0, pageSize = 10, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}

count = Purchase.count(teasession._strCommunity,sql.toString());
sql.append(" order by time_s desc ");

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">

<body>
<script type="">
   function f_edit(igd)
   {
       form1.purid.value=igd;
       form1.action="/jsp/erp/EditPurchase.jsp"
       form1.submit();
   }
   function f_delete(igd)
   {
     if(confirm('确实要删除吗？')){
       form1.purid.value=igd;
       form1.act.value='delete';
       form1.action="/jsp/erp/EditPurchase.jsp"
       form1.submit();
     }
   }
   function f_submit()
   {
     return ((form1.time_c.value==''||submitDate(form1.time_c,'您输入的时间格式不正确，时间格式是：2009-01-01')) &&
     (form1.time_d.value==''||submitDate(form1.time_d,'您输入的时间格式不正确，时间格式是：2009-01-01')));
   }

   function f_show(igd,str)
   {
     var url;
     var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:1057px;dialogHeight:705px;';
     if(str==1){
      url = '/jsp/erp/PurchaseShow.jsp?purid='+igd+'&act=ruku'
     }else if(str==2)
     {
        y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:457px;dialogHeight:215px;';
        url = '/jsp/erp/PurchaseShow.jsp?warid='+igd+'&act=cangku'
     }
      var rs = window.showModalDialog(url,self,y);
   }
</script>
<h1>入库单统计</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<form name="form1" action="?" onsubmit="return f_submit();">
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="purid"/>
<input type="hidden" name="act"/>

<input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>
<h2>查询</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>入库日期:&nbsp;

        从&nbsp;
        <input id="time_c" name="time_c" size="7"  value="<%if(time_c!=null)out.print(time_c);%>" readonly="readonly">
        <img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_c');" />
        &nbsp;到&nbsp;
        <input id="time_d" name="time_d" size="7"  value="<%if(time_d!=null)out.print(time_d);%>" readonly="readonly">
        <img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_d');" />
    </td>
    <td>仓库名称: &nbsp;<select name="waridname" class="lzj_huo">

       <option value="0">---------------</option>
       <%
          java.util.Enumeration e2 = Warehouse.find(teasession._strCommunity,"",0,Integer.MAX_VALUE);
          while (e2.hasMoreElements())
          {
            int warid = ((Integer)e2.nextElement()).intValue();
            Warehouse warobj = Warehouse.find(warid);
             out.print("<option value= "+warid);
             if(waridname==warid)
             {
               out.print(" selected");
             }
             out.print(">"+warobj.getWarname());
             out.print("</option>");
          }

       %>

      </select>  </td>
    <td>商品名称: &nbsp;<input type="text" name="goods" value="<%if(goods!=null)out.print(goods);%>"></td>
    <td>供应商名称: &nbsp; <select name="supplname"  class="lzj_huo">
        <option value="0">---------------</option>
         <%
           java.util.Enumeration e1=Supplier.findByCommunity(teasession._strCommunity);
           while(e1.hasMoreElements()){
             int sid=((Integer)e1.nextElement()).intValue();
             Supplier sobj=Supplier.find(sid);
             out.print("<option value= "+sid);
             if(supplname==sid)
             {
               out.print(" SELECTED");
             }
             out.print(">"+sobj.getName(teasession._nLanguage));
             out.print("</option>");
           }
         %>
        </select>     </td>
    <td><input type="submit" value="查询"/></td>
  </tr>
</table>
<h2>列表(<%=count%>)</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td nowrap>入库单号</td>
    <td nowrap>入库日期</td>
    <td nowrap>供应商名称</td>
    <td nowrap>仓库名称</td>
    <td nowrap>入库数量</td>
    <td nowrap>商品总金额</td>
    <td nowrap>操作</td>
  </tr>
<%
   java.util.Enumeration e = Purchase.find(teasession._strCommunity,sql.toString(),pos,pageSize);
   if(!e.hasMoreElements())
   {
      out.print("<tr><td colspan=10 align=center>暂没有入库记录</td></tr>");
   }
   while(e.hasMoreElements()){
     String pur = ((String)e.nextElement());
     Purchase pobj = Purchase.find(pur);
     Supplier sobj=Supplier.find(pobj.getSupplname());
     Warehouse warobj = Warehouse.find(pobj.getWaridname());
    tea.entity.member.Profile  p = tea.entity.member.Profile.find(pobj.getMember());

%>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td align="center"><a href="#" onclick="f_show('<%=pur%>','1');" ><%=pur %></a></td>
    <td align="center"><%=pobj.getTime_sToString() %></td>
    <td><%=sobj.getName(teasession._nLanguage)%></td>
    <td><a href="#" onclick="f_show('<%=pobj.getWaridname()%>','2');" ><%=warobj.getWarname() %></a></td>
    <td><%=pobj.getQuantity() %></td>
    <td ><%=pobj.getTotal() %></td>
    <td align="center"><input type="button"  value="查看详细" onclick="f_show('<%=pur%>','1');"> </td>
  </tr>
<%} %>
<%if(count>0){ %>
<tr>
<td colspan="4" align="right"><b>合计数量和金额</b></td>
<td><%=Purchase.getQ(teasession._strCommunity,sql.toString()) %></td>
<td><%=Purchase.getT(teasession._strCommunity,sql.toString()) %></td>
<td>&nbsp;</td>
</tr>
<%}%>
  <%if (count > pageSize) {  %>
   <tr> <td colspan="10"  align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
  <%}  %>

</table>

</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>


</body>
</html>
