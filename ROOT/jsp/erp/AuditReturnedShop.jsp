<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.erp.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.admin.erp.*" %>
<%@page import="tea.entity.league.*" %>

<%
  request.setCharacterEncoding("UTF-8");

  TeaSession teasession = new TeaSession(request);
  if (teasession._rv == null) {
    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
    return;
  }
  String nexturl = request.getRequestURI()+"?"+request.getContextPath();
  StringBuffer sql = new StringBuffer();
  StringBuffer param = new StringBuffer();
  param.append("?id=").append(request.getParameter("id"));
  //sql.append(" AND type = 0");


  String paidinfull = teasession.getParameter("paidinfull");
  if(paidinfull!=null && paidinfull.length()>0)
  {
    sql.append(" AND purchase LIKE ").append(DbAdapter.cite("%"+paidinfull+"%"));
    param.append("&paidinfull=").append(paidinfull);
  }
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

  String supplname = teasession.getParameter("supplname");
  if(supplname!=null && supplname.length()>0)
  {
   sql.append(" AND supplname IN (SELECT id FROM LeagueShop WHERE lsname LIKE "+DbAdapter.cite("%"+supplname+"%")+"  )");
   param.append("&supplname=").append(java.net.URLEncoder.encode(supplname,"UTF-8"));

  }



  int pos = 0, pageSize = 10, count = 0;
  if (request.getParameter("pos") != null) {
    pos = Integer.parseInt(request.getParameter("pos"));
  }
  count = ReturnedShop.count(teasession._strCommunity,sql.toString());

  sql.append(" order by time_s desc ");
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<title>审核加盟店退货单</title>
</head>
<body id="bodynone">
<script type="">
  function f_sd(igd)
  {
    form1.purid.value=igd;
    form1.action="/servlet/EditReturnedShop";
    form1.submit();
  }
  function f_c(igd)
  {
    var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:1057px;dialogHeight:705px;';
    var url = '/jsp/erp/ReturnedShopShow.jsp?paid='+igd;
    window.showModalDialog(url,self,y);
  }
</script>
  <h1>审核加盟店退货单</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<h2>查询</h2>
<form accept="?" name="form1">
 <input type="hidden" name="id" value="<%=request.getParameter("id")%>" >
 <input type="hidden" name="purid"/>
  <input type="hidden" name="act" value="sd"/>
  <input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>加盟店退货单:</td>
    <td><input type="text" name="paidinfull" value="<%if(paidinfull!=null)out.print(paidinfull);%>"> </td>
    <td>加盟店名称:</td>
    <td><input type="text" name="supplname" value="<%if(supplname!=null)out.print(supplname);%>"/></td>
    <td>退单日期:</td>
     <td>

        从&nbsp;
        <input id="time_c" name="time_c" size="7"  value="<%if(time_c!=null)out.print(time_c);%>" readonly="readonly">
        <img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_c');" />
        &nbsp;到&nbsp;
        <input id="time_d" name="time_d" size="7"  value="<%if(time_d!=null)out.print(time_d);%>" readonly="readonly">
        <img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_d');" />

</td>

<td><input type="submit" value="查询"/></td>
  </tr>

</table>

<h2>列表(<%=count%>)</h2>

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td nowrap>加盟店退货单</td>
      <td nowrap>加盟店名称</td>
      <td nowrap>退单日期</td>
      <td nowrap>退单数量</td>
      <td nowrap>退单金额</td>
      <td nowrap>订单状态</td>
      <td nowrap>操作</td>
    </tr>
    <%
    java.util.Enumeration e = ReturnedShop.find(teasession._strCommunity,sql.toString(),pos,pageSize);
    if(!e.hasMoreElements())
    {
      out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
    }
    while(e.hasMoreElements()){
      String paid = ((String)e.nextElement());
      ReturnedShop pobj = ReturnedShop.find(paid);
      tea.entity.member.Profile p = tea.entity.member.Profile.find(pobj.getMember());
      LeagueShop lsobj = LeagueShop.find(pobj.getSupplname());
    %>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td ><a href="#" onclick="f_c('<%=paid%>');"><%=paid %></a></td>
        <td ><%=lsobj.getLsname() %></td>
      <td ><%=pobj.getTime_sToString()%></td>
      <td ><%=pobj.getQuantity() %></td>
      <td ><%=pobj.getTotal_2() %></td>
      <td >
      <%

      if(pobj.getType()==0){
        out.print("<font color=red>订单等待审核</font>");
      }else if(pobj.getType() ==1)
      {
        out.print("同意退货");
      }else if(pobj.getType() ==2)
      {
        out.print("不同意退货");
      }else if(pobj.getType() ==4)
      {
        out.print("已经收到货物");
      }
      %>
      </td>
      <td>
      <%//EditAuditReturnedShop
        if(pobj.getType() == 0)
        {
          out.print("<input type=\"button\" value=\"审核加盟店退货单\" onclick=\"window.open('/jsp/erp/EditReturnedShop.jsp?purid="+paid+"&refundtype=1&nexturl="+nexturl+"','_self');\"/>&nbsp;<input type=button value=收到退货 disabled=\"disabled\"  style=\"background:#666666\">");
        }else if(pobj.getType()==1)
        {
           out.print("<input  type=button value=审核加盟店退货单 disabled=\"disabled\"  style=\"background:#666666\" >&nbsp;<input type=button value=收到退货 onclick=f_sd('"+paid+"'); >");
        }else if(pobj.getType() ==2 || pobj.getType()==4)
        {
            out.print("<input  type=button value=审核加盟店退货单 disabled=\"disabled\"  style=\"background:#666666\" >&nbsp;<input type=button value=收到退货  disabled=\"disabled\"  style=\"background:#666666\" >");
        }
      %>


      </td>
    </tr>
    <%}%>
     <%if (count > pageSize) {  %>
   <tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
  <%}  %>
  </table>

  </form>
  <div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

