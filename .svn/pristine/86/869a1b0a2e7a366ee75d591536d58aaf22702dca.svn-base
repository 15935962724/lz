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
StringBuffer sql = new StringBuffer("  AND  paid  IN (SELECT purchase FROM Paidinfull)");
StringBuffer param = new StringBuffer();
param.append("?id=").append(request.getParameter("id"));

  //判断用户加盟店
  AdminUsrRole arobj = AdminUsrRole.find(teasession._strCommunity,teasession._rv.toString());
  LeagueShop lsobj = LeagueShop.find(LeagueShop.findid(arobj.getUnit()));
  if(lsobj.getId()!=0){
    sql.append(" AND paid in (SELECT purchase FROM Paidinfull WHERE supplname ="+lsobj.getId()+" )");
   // sql.append(" supplname= ").append(lsobj.getId());
  }else
  {
   sql.append(" AND paid in (SELECT purchase FROM Paidinfull)");
  }



//进货单
String paids = teasession.getParameter("paids");
if(paids!=null && paids.length()>0)
{
  sql.append(" AND paid LIKE ").append(DbAdapter.cite("%"+paids+"%"));
  param.append("&paids=").append(paids);
}
//商品名称
String goodsname = teasession.getParameter("goodsname");
if(goodsname!=null&&goodsname.length()>0)
{
  DbAdapter db = new DbAdapter();
  try
  {
    db.executeQuery("SELECT node FROM Node WHERE node IN (SELECT node FROM NodeLayer WHERE subject LIKE "+db.cite("%"+goodsname+"%")+"  )");
    while(db.next())
    {
      //sql.append(" AND node = ").append(db.getInt(1));
    }
  }finally
  {
    db.close();
  }
  param.append("&goodsname=").append(java.net.URLEncoder.encode(goodsname,"UTF-8"));
}
//进货日期
String time_c = teasession.getParameter("time_c");
if(time_c!=null && time_c.length()>0)
{
  //sql.append(" paid IN (select purchase from Paidinfull  AND time_s >="+DbAdapter.cite(time_c)+" )");
  sql.append(" AND time_s >=").append(DbAdapter.cite(time_c));
  param.append("&time_c=").append(time_c);
}
String time_d = teasession.getParameter("time_d");
if(time_d!=null && time_d.length()>0)
{
  sql.append(" AND time_s <=").append(DbAdapter.cite(time_d));
// sql.append(" paid IN (select purchase from Paidinfull  AND time_s <="+DbAdapter.cite(time_c)+" )");
  param.append("&time_d=").append(time_d);
}



int pos = 0, pageSize = 10, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
count = GoodsDetails.count(teasession._strCommunity,sql.toString());

sql.append(" order by time_s desc ");

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<title>进货统计</title>
</head>
<body id="bodynone">
  <h1>进货统计</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<h2>查询</h2>
  <form action="?" name="form1" method="POST">
  <input type="hidden" name="id" value="<%=request.getParameter("id")%>" >
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>进货单:</td>
    <td><input type="text" name="paids" value="<%if(paids!=null)out.print(paids);%>"> </td>
      <td>商品名称:</td>
      <td><input type="text" name="goodsname" value="<%if(goodsname!=null)out.print(goodsname);%>"></td>
      <td>进货日期:</td>
      <td>
       从&nbsp;
        <input id="time_c" name="time_c" size="7"  value="<%if(time_c!=null)out.print(time_c);%>" readonly="readonly">
        <img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_c');" />
        &nbsp;到&nbsp;
        <input id="time_d" name="time_d" size="7"  value="<%if(time_d!=null)out.print(time_d);%>" readonly="readonly">
        <img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_d');" />

</td>
<td><input type="submit" value="汇总"/></td>
  </tr>
</table>
<h2>列表(&nbsp;<%=count%>&nbsp;)</h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td nowrap>进货单</td>
      <td nowrap>条形码或编号</td>
      <td nowrap>进货商品</td>
      <td nowrap>进货日期</td>
      <td nowrap>进货单价</td>
      <td nowrap>进货数量</td>
      <td nowrap>进货金额</td>
    </tr>
    <%

      java.util.Enumeration e = GoodsDetails.find(teasession._strCommunity,sql.toString(),pos,pageSize);
    if(!e.hasMoreElements())
    {
      out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
    }

    while(e.hasMoreElements())
    {
      int gdid = ((Integer)e.nextElement()).intValue();
      GoodsDetails gdobj = GoodsDetails.find(gdid);
      String paid = gdobj.getPaid();
      Paidinfull pobj = Paidinfull.find(paid);
      tea.entity.member.Profile p = tea.entity.member.Profile.find(pobj.getMember());
      int nodeid =gdobj.getNode();
      Node nobj = Node.find(nodeid);
        %>
        <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
          <td align="center"><%=paid %></td>
          <td><%=nobj.getNumber() %></td>
          <td><%=nobj.getSubject(teasession._nLanguage) %></td>
          <td align="center"><%=pobj.getTime_sToString()%></td>
          <td align="center"><%=gdobj.getDsupply()%></td>
          <td align="center"><%=gdobj.getQuantity()%></td>
          <td align="center"><%=gdobj.getTotal()%>&nbsp;元</td>
        </tr>
        <%
      }
      %>
      <%if (count > pageSize) {  %>
      <tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
      <%}  %>
      <%
      if(count>0){
      %>
      <tr>
      <td colspan="5">&nbsp;</td>
       <td align="right"><b>合计金额：</b></td>
        <td align="center"><%=GoodsDetails.getTotal(teasession._strCommunity,sql.toString()) %>&nbsp;元</td>
      </tr><%}%>
  </table>

  </form>
  <div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
