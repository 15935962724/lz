<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.node.*"%>
<jsp:useBean id="sms" scope="page" class="tea.entity.node.Sms"/>
<%
  request.setCharacterEncoding("UTF-8");
  TeaSession teasession = new TeaSession(request);
  if (teasession._rv._strV == null) {
    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode + "&nexturl=" + java.net.URLEncoder.encode(request.getRequestURI() + "?" + request.getQueryString(), "UTF-8"));
    return;
  }
  String father = teasession.getParameter("father");
  Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");
  int pos = 0, count = 0, pageSize = 10;
  StringBuffer sql = new StringBuffer(" AND state=0");

Citypopedom cobj = Citypopedom.find(teasession._rv.toString());

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
  String strid = request.getParameter("id");
  StringBuffer param = new StringBuffer("?id=").append(strid);
  teasession._strCommunity = "jiudian";

//  count = Destine.countHO("select count(*) from (SELECT  distinct node FROM Destine WHERE community=" + DbAdapter.cite(teasession._strCommunity) + " AND state=0 )as a;");
  count = Destine.countTj2(sql.toString());
  if (request.getParameter("pos") != null && request.getParameter("pos").length() > 0) {
  pos = Integer.parseInt(request.getParameter("pos"));
  }


%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body id="bodynone">
<input type="hidden" name="id" value="<%=strid%>"/>
<div id="tablebgnone" class="register">
  <h1>    酒店管理 </h1>
  <div id="head6">
    <img height="6" src="about:blank" alt="">
  </div>
  <FORM name="form1" METHOD="POST" action="">
  <input type="hidden" name="destine" value="">
  <input type="hidden" name="nexturl" value="<%=request.getRequestURL()%>"/>
  <input type="hidden" name="father" value="<%=father%>"/>
  <h2>酒店管理( <%=count%> )</h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr  id="tableonetr">
      <td nowrap>酒店名称</td>
      <td nowrap>待处理的订单数</td>
      <td nowrap>操作</td>
    </tr>
  <%
    java.util.Enumeration e = Destine.findTj(teasession._strCommunity, sql.toString(), pos, pageSize);
    if (!e.hasMoreElements()) {
    out.print("<tr><td align=center colspan=10>暂无记录</td></tr>");
  }
    while (e.hasMoreElements()) {
      int node = ((Integer) e.nextElement()).intValue();
      Node obj = Node.find(node);
      int count1 = Destine.countTj("AND state=0 AND node=" + obj._nNode);
  %>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td>
        <a href="/jsp/registration/HostelView.jsp?node=<%=obj._nNode%>"><%=obj.getSubject(teasession._nLanguage)%> </a>
      </td>
      <td><%=count1%>      </td>
      <td>
        <a href="/jsp/registration/manageorders.jsp">订单管理</a>
        &nbsp;&nbsp;
        <a href="/jsp/registration/Hostels.jsp?father=<%=father%>">酒店信息管理</a>
        &nbsp;&nbsp;<%
        java.util.Enumeration n = Node.find(" and father ="+node,0,Integer.MAX_VALUE);
         int idn =0;
        while(n.hasMoreElements())
        {
           idn =((Integer)n.nextElement()).intValue();
        }
         %>
        <a href="/jsp/registration/newsmanager.jsp?node=<%=idn%>">新闻管理</a>
      </td>
    </tr>
  <%} if (count > pageSize) {  %>
    <tr>
      <td colspan="6"><%=new tea.htmlx.FPNL(1,param.toString()+"&pos=",pos,count,pageSize)%>      </td>
    </tr>
  <%}  %>
  </table>
  </FORM>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%>  </div>
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
</html>
