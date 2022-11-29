<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="tea.ui.*,tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.admin.*"%>
<!--Community的包-->
<jsp:useBean id="sms" scope="page" class="tea.entity.node.Sms"/>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

  request.setCharacterEncoding("UTF-8");
  TeaSession teasession = new TeaSession(request);
  String father = request.getParameter("father");
  if (teasession._rv._strR == null) {
    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode + "&nexturl=" + java.net.URLEncoder.encode(request.getRequestURI() + "?" + request.getQueryString(), "UTF-8"));
    return;
  }

  int pos = 0, pageSize = 10, count = 0;
  StringBuffer sql = new StringBuffer();
  StringBuffer param = new StringBuffer("?community=" + teasession._strCommunity);
  sql.append(" AND member=").append(DbAdapter.cite(teasession._rv._strV.toString()));

  Citypopedom cobj = Citypopedom.find(teasession._rv.toString());
java.util.Enumeration ae = AdminUsrRole.find(teasession._strCommunity," and member ="+DbAdapter.cite(teasession._rv.toString())+" and role like "+DbAdapter.cite("%/"+5+"/%"),0,Integer.MAX_VALUE);
if(ae.hasMoreElements()){
  if(cobj.getCityid()==null )
  {
    response.sendError(403);
    return;
  }
  sql.append(" and node in (select node from Hostel where  ");
  String cm[] = cobj.getCityid().split("/");
  for(int i =1;i<cm.length;i++)
  {
    if(cobj.getCityid()!=null){
      sql.append(" city = ").append(Integer.parseInt(cm[i]));
    }
    if(cm.length-1>i)
    sql.append(" or ");
  }

  sql.append(" )");
}

  if (request.getParameter("pos") != null) {
    pos = Integer.parseInt(request.getParameter("pos"));
  }
  count = Hostel.count(sql.toString());
  String nexturl = request.getRequestURI();
  String hname = request.getParameter("hname");
  if(hname != null){
  sql.append(" and name like '%"+hname+"%'");
  }
  sql.append(" order by node desc ");
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script language="javascript" src="/tea/CssJs/AreaCityData_zh_CN.js" type=""></script>
<script type="text/javascript">
function yn()
{
  if(confirm('是否真的要删除此酒店？'))
  {
    return true;
  }
  return false;
}
</script>
</head>
<body id="bodynone"><div id="tablebgnone" class="register">

<form action="/jsp/registration/Hostels.jsp">
<h1>酒店展示(  <%=count%>  )</h1>
<input type="hidden" name="father" value="<%=father%>"/>
<div style="text-align:left;margin-bottom:5px;"><input type="button" value="创建酒店" onClick="location='/jsp/registration/CreateHostel.jsp?nexturl=<%=nexturl%>&node=<%=father%>&fnode=<%=father%>'"/>　　　　　　　　　　酒店名称：<input type="text" name="hname"/> <input type="submit"  value="查询"/></div>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter" align="left">
  <tr  id="tableonetr">
    <td>酒店名称</td>
    <td>酒店星级</td>
    <td>酒店价格</td>
    <td>编辑</td>
    <td>删除</td>
  </tr>
<%
  java.util.Enumeration e = Hostel.find(sql.toString(), pos, pageSize);
  if (!e.hasMoreElements()) {
    out.print("<tr><td align=center colspan=10>暂无记录</td></tr>");
  }
  while (e.hasMoreElements()) {
    int nod = ((Integer) e.nextElement()).intValue();
    Node node = Node.find(nod);
    Hostel obj = Hostel.find(node._nNode, teasession._nLanguage);
//    String[] str = {
//        "无要求", "☆", "☆☆", "☆☆☆", "☆☆☆☆", "☆☆☆☆☆"};
//    String star = str[obj.getStarClass()];
int star = obj.getStarClass();
%>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td>
      <a href="/jsp/registration/HostelView.jsp?node=<%=node._nNode%>" TARGET="_self"><%=node.getSubject(teasession._nLanguage)%>      </a>
    </td>
    <td><%
  if(star == 0){
  out.print("无要求");
  }
      for(int i=1; i <=10;i++){
 if(star == i){
    out.print("<img src=/tea/image/star/level"+i+".gif>");
 }
      }

    %></td>
    <td><%=obj.getPrice()%></td>
    <td>
      <a href="/jsp/registration/EditHostel.jsp?node=<%=obj.getNode()%>&nexturl=<%=nexturl%>&language=<%=obj.getLanguage()%>">修改</a>
    </td>
    <td>
      <a href="/jsp/registration/deletehostel.jsp?node=<%=obj.getNode()%>&language=<%=obj.getLanguage()%>&fnode=<%=father%>&nexturl=<%=nexturl%>" onClick="return yn();">删除</a>
    </td>
  </tr>
<%}%>

  <tr>
  <%if (count > pageSize) {  %>
    <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td>
  <%}  %>
  </tr>
</table>
</form></div>
  <script language="JavaScript">
 anole('',1,'#F2F2F2','#DEEEDB','','');
  /*tr_tableid, // table id
  num_header_offset,// 表头行数
  str_odd_color, // 奇数行的颜色
  str_even_color,// 偶数行的颜色
  str_mover_color, // 鼠标经过行的颜色
  str_onclick_color // 选中行的颜色
  */
  </script>
</body>
</html>
