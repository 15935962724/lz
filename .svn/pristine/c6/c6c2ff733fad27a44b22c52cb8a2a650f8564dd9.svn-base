<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="java.util.*"%>
<%@page import="tea.entity.admin.*" %>
<%
  request.setCharacterEncoding("UTF-8");
  TeaSession teasession = new TeaSession(request);

  StringBuffer param=new StringBuffer("?community=").append(teasession._strCommunity);
  StringBuffer sql=new StringBuffer(" and node in (select node from node where Hidden =0) ");

  int id = 0;
  if(request.getParameter("id")!=null && request.getParameter("id").length()>0)
     id = Integer.parseInt(request.getParameter("id"));
 param.append("&id=").append(id);


  int city = 0;
  if(request.getParameter("city")!=null && request.getParameter("city").length()>0)
    city = Integer.parseInt(teasession.getParameter("city"));
  if(city>0)
  {
    sql.append(" and city =").append(" ").append(city);
    param.append("&city=").append(city);
  }
   int borough =0;
    if(request.getParameter("borough")!=null && request.getParameter("borough").length()>0)
    borough = Integer.parseInt(teasession.getParameter("borough"));
  if(borough>0)
  {
    sql.append(" and borough = ").append(" ").append(borough);
    param.append("&borough=").append(borough);
  }
  int starclass =0;
  if(teasession.getParameter("starclass")!=null && teasession.getParameter("starclass").length()>0)
  {
    starclass = Integer.parseInt(teasession.getParameter("starclass"));
  }
  if(starclass!=0)
  {
    sql.append(" and starClass =").append(" ").append(starclass);
    param.append("&starclass=").append(starclass);
  }
  int price = 0;
  if(teasession.getParameter("price")!=null && teasession.getParameter("price").length()>0)
  {
    price = Integer.parseInt(teasession.getParameter("price"));
  }
  if (price > 0) {
   if (price > 200 && price <= 600) {
    sql.append(" AND price>=" + (price - 200) + "AND price<=" + price);
  }
  if (price > 600 && price <= 1000) {
    sql.append(" AND price>=" + (price - 400) + "AND price<=" + price);
  }
    if (price <= 200) {
      sql.append(" AND price>=" + (price - 100) + "AND price<=" + price);
    }
    if(price > 1000)
    {
      sql.append(" and price >").append(price);
    }
    param.append("&price="+price);
  }

  String jdname = teasession.getParameter("jdname");
  if(jdname!=null && jdname.length()>0)
  {
    sql.append(" and name like ").append(" ").append(DbAdapter.cite("%"+jdname+"%"));
    param.append("&jdname=").append(java.net.URLEncoder.encode(jdname,"UTF-8"));
  }

int count=Hostel.count(sql.toString());
int pos=0;
int pageSize=10;
if(teasession.getParameter("Pos")!=null)
{
  pos=Integer.parseInt(teasession.getParameter("Pos"));
}
sql.append(" order by price asc");
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script language="javascript" src="/tea/CssJs/AreaCityData_zh_CN.js" type=""></script>
<title>search</title>
</head>
<body bgcolor="#ffffff">
<h1>  查询酒店的结果(<%=count %> )
</h1>
<form action="?" method="POST" name="form1">
<input type="hidden" name="id" value="<%=id%>" />
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter" align="left">
  <tr>
    <td nowrap>酒店名字</td>
    <td nowrap>酒店所在城市</td>
    <td nowrap>酒店星级</td>
    <td nowrap>酒店价格</td>
    <td nowrap>操作</td>
  </tr>
<%
  String[] str = { "无要求", "☆", "☆☆", "☆☆☆", "☆☆☆☆", "☆☆☆☆☆"};
  java.util.Enumeration e = Hostel.find(sql.toString(),pos,pageSize);
  if(!e.hasMoreElements())
  {
    out.print("<tr><td align=center colspan=4>暂无记录</td></tr>");
  }
  while (e.hasMoreElements()) {
    int nodeid=((Integer)e.nextElement()).intValue();
    Hostel obj = Hostel.find(nodeid,teasession._nLanguage);
    Node n = Node.find(nodeid);
    City cobj =City.find(obj.getCity());
   // if(!n.isHidden()){
      %>
      <tr>
        <td><a href="/jsp/registration/HostelView.jsp?node=<%=n._nNode%>"><%=obj.getName()%></a></td>
        <td><%=cobj.getCityname()%></td>
        <td><%
         if(obj.getStarClass() == 0){
  out.print("无");
  }
        for(int i=1; i <=10;i++){
 if(obj.getStarClass() == i){
    out.print("<img src=/tea/image/star/level"+i+".gif>");
 }
      }%></td>
        <td><%=obj.getPrice()%> </td>
        <td> <input value=预定 type=button onClick="window.open('/jsp/registration/EditDestine2.jsp?node=<%=obj.getNode()%>')" ></td>
      </tr>
      <%
     // }
       }if(count>pageSize){
       %>
       <tr>

         <td colspan="5" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage, request.getRequestURI()+param.toString() + "&Pos=", pos, count,pageSize)%></td>
       </tr><%} %>
  <tr>
    <td align="center" colspan="5">
    <input type=button value="返回" onClick="javascript:history.back()">
    </td>
  </tr>
</table>
</form>
</body>
</html>
