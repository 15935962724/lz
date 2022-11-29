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
int type = 0;
if(teasession.getParameter("type")!=null && teasession.getParameter("type").length()>0)
{
  type = Integer.parseInt(teasession.getParameter("type"));
}

StringBuffer sql = new StringBuffer();
StringBuffer param = new StringBuffer();
param.append("?id=").append(request.getParameter("id"));
param.append("&nexturl=").append(java.net.URLEncoder.encode(nexturl,"UTF-8"));
param.append("&type=").append(type);
if(type==1)
{
  sql.append(" AND type = ").append(type);
}
//退货日期
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
//仓库
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
//退货单号
String rgidname = teasession.getParameter("rgidname");
if(rgidname!=null && rgidname.length()>0)
{
  sql.append(" AND purchase LIKE "+DbAdapter.cite("%"+rgidname+"%")+" " );
  param.append("&rgidname=").append(rgidname);
}
//供应商名称
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

count = RetreatGoods.count(teasession._strCommunity,sql.toString());
 String o=request.getParameter("o");
  if(o==null)
  {
    o="purchase";
  }
  boolean aq=Boolean.parseBoolean(request.getParameter("aq"));
  sql.append(" ORDER BY ").append(o).append(" ").append(aq?"DESC":"ASC");
  param.append("&o=").append(o).append("&aq=").append(aq);
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
       form1.action="/jsp/erp/EditRetreatGoods.jsp"
       form1.submit();
   }
   function f_delete(igd)
   {
     if(confirm('确实要删除吗？')){
       form1.purid.value=igd;
       form1.act.value='delete';
       form1.action="/jsp/erp/EditRetreatGoods.jsp"
       form1.submit();
     }
   }
   function f_submit()
   {
     return ((form1.time_c.value==''||submitDate(form1.time_c,'您输入的时间格式不正确，时间格式是：2009-01-01')) &&
     (form1.time_d.value==''||submitDate(form1.time_d,'您输入的时间格式不正确，时间格式是：2009-01-01')));
   }
   function f_order(v)
   {
     var aq=form1.aq.value=="true";
     if(form1.o.value==v)
     {
       form1.aq.value=!aq;
     }else
     {
       form1.o.value=v;
     }
     form1.action="?";
     form1.submit();
   }
   function f_show(igd,str)
   {
     var url;
     var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:857px;dialogHeight:605px;';
     if(str==1){
      url = '/jsp/erp/RetreatGoodsShow.jsp?purid='+igd+'&act=ruku'
     }else if(str==2)
     {
        y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:457px;dialogHeight:215px;';
        url = '/jsp/erp/PurchaseShow.jsp?warid='+igd+'&act=cangku'
     }
      var rs = window.showModalDialog(url,self,y);
   }
</script>
<h1><%if(type==0){out.print("退货单管理");}else if(type==1){out.print("审核退货单");} %></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>


<form name="form1" action="?" onsubmit="return f_submit();">
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="type" value="<%=type%>"/>
<input type="hidden" name="purid"/>
<input type="hidden" name="act"/>
 <input type="hidden" name="o" VALUE="<%=o%>">
  <input type="hidden" name="aq" VALUE="<%=aq%>">
<input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>
<h2>查询</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>退货日期:</td>
     <td>

        从&nbsp;
        <input id="time_c" name="time_c" size="7"  value="<%if(time_c!=null)out.print(time_c);%>" readonly="readonly">
        <img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_c');" />
        &nbsp;到&nbsp;
        <input id="time_d" name="time_d" size="7"  value="<%if(time_d!=null)out.print(time_d);%>" readonly="readonly">
        <img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_d');" />
    </td>
    <td>仓库名称: </td>
    <td><select name="waridname" class="lzj_huo">

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
      </tr>
      <tr>
    <td>退货单号: </td>
    <td><input type="text" name="rgidname" value="<%if(rgidname!=null)out.print(rgidname);%>"></td>
    <td>供应商名称: </td>
   <td> <select name="supplname"  class="lzj_huo">
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
    <td nowrap><a href="javascript:f_order('purchase');">退货单号</a>
     <%
          if(o.equals("purchase"))
          {
            if(aq)
            out.print("↓");
            else
            out.print("↑");
          }
          %>
    </td>
    <td nowrap><a href="javascript:f_order('time_s');">退货日期</a>
     <%
          if(o.equals("time_s"))
          {
            if(aq)
            out.print("↓");
            else
            out.print("↑");
          }
          %></td>
    <td nowrap><a href="javascript:f_order('supplname');">供应商名称</a>
     <%
          if(o.equals("supplname"))
          {
            if(aq)
            out.print("↓");
            else
            out.print("↑");
          }
          %></td>
    <td nowrap><a href="javascript:f_order('waridname');">仓库名称</a>
     <%
          if(o.equals("waridname"))
          {
            if(aq)
            out.print("↓");
            else
            out.print("↑");
          }
          %></td>
    <td nowrap><a href="javascript:f_order('member');">经办人</a>
     <%
          if(o.equals("member"))
          {
            if(aq)
            out.print("↓");
            else
            out.print("↑");
          }
          %></td>
    <td nowrap><a href="javascript:f_order('quantity');">退货数量</a>
     <%
          if(o.equals("quantity"))
          {
            if(aq)
            out.print("↓");
            else
            out.print("↑");
          }
          %></td>
          <%
           if(type ==0)//审核的退货单页面
           {
             out.print("<td nowrap>订单状态</td>");
           }
          %>

    <td nowrap>操作</td>
  </tr>
<%
   java.util.Enumeration e = RetreatGoods.find(teasession._strCommunity,sql.toString(),pos,pageSize);
   if(!e.hasMoreElements())
   {
      out.print("<tr><td colspan=10 align=center>暂没有退货记录</td></tr>");
   }
   while(e.hasMoreElements()){
     String pur = ((String)e.nextElement());
     RetreatGoods pobj = RetreatGoods.find(pur);
     Supplier sobj=Supplier.find(pobj.getSupplname());
     Warehouse warobj = Warehouse.find(pobj.getWaridname());
    tea.entity.member.Profile  p = tea.entity.member.Profile.find(pobj.getMember());

%>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td align="center"><a href="#" onclick="f_show('<%=pur%>','1');" ><%=pur %></a></td>
    <td align="center"><%=pobj.getTime_sToString() %></td>
    <td><%=sobj.getName(teasession._nLanguage)%></td>
    <td><a href="#" onclick="f_show('<%=pobj.getWaridname()%>','2');" ><%=warobj.getWarname() %></a></td>
    <td><%=p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage) %></td>
    <td align="center"><%=pobj.getQuantity() %></td>
    <%
       if(type==0)
       {
         out.print("<td>");
         if(pobj.getType()==1)
         {
           out.print("等待审核退货单");
         }else if(pobj.getType()==2)
         {
           out.print("退货单审核通过");
         }
         out.print("</td>");
       }
    %>
    <td >
    <%
    if(type==0)
    {
      if(pobj.getType()==2)
      {
        out.print("<input type=button disabled=disabled style=background:#666666 value=编辑>&nbsp;<a href=\"#\"  onclick=f_delete('"+pur+"');>删除</a>");
      }
      else
      {
        out.print("<a href=\"#\" onclick=f_edit('"+pur+"');>编辑</a>&nbsp;<a href=\"#\" onclick=f_delete('"+pur+"');>删除</a>");
      }
    } else if(type==1)
    {
      out.print(" <a href=\"#\" onclick=f_edit('"+pur+"');>审核退货单</a>");
    }
   %>
    </td>
  </tr>
<%} %>
  <%if (count > pageSize) {  %>
   <tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
  <%}  %>

</table>
<br />
<%if(type==0){ %>
<input type="button" value="添加退货单" onclick="window.open('/jsp/erp/EditRetreatGoods.jsp?nexturl=<%=nexturl%>','_self');"/>
<%} %>
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>


</body>
</html>
