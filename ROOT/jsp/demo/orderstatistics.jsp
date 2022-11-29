<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.ui.TeaSession"%>
<%
  request.setCharacterEncoding("UTF-8");
  TeaSession teasession = new TeaSession(request);
  if (teasession._rv == null) {
    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode + "&nexturl=" + java.net.URLEncoder.encode(request.getRequestURI() + "?" + request.getQueryString(), "UTF-8"));
    return;
  }
  StringBuffer param = new StringBuffer("?community=").append(teasession._strCommunity);
  StringBuffer sql = new StringBuffer();
  Citypopedom cobj = Citypopedom.find(teasession._rv.toString());
  java.util.Enumeration ae = AdminUsrRole.find(teasession._strCommunity, " and member =" + DbAdapter.cite(teasession._rv.toString()) + " and role like " + DbAdapter.cite("%/" + 5 + "/%"), 0, Integer.MAX_VALUE);
  if (ae.hasMoreElements()) {
    if (cobj.getCityid() == null) {
      response.sendError(403);
      return;
    }
    sql.append(" and node in (select node from Hostel where  ");
    String cm[] = cobj.getCityid().split("/");
    for (int i = 1; i < cm.length; i++) {
      if (cobj.getCityid() != null) {
        sql.append(" city = ").append(Integer.parseInt(cm[i]));
      }
      if (cm.length - 1 > i)
        sql.append(" or ");
    }
    sql.append(" )");
  }
//  int nameid = 0;
//  if (request.getParameter("nameid") != null && request.getParameter("nameid").length() > 0) {
//    nameid = Integer.parseInt(request.getParameter("nameid"));
//  }
//  if (nameid != 0) {
//    sql.append(" and node= ").append(" ").append(nameid);
//    param.append("nameid=").append(nameid);
//  }
String nameid = request.getParameter("nameid");
  if (nameid != null && nameid.length() > 0) {
    sql.append(" and node in(select node from hostel where name like '%").append(nameid).append("%')");
    param.append("&nameid=").append(nameid);
  }
//  String timek = request.getParameter("timek");
//  if (timek != null && (timek = timek.trim()).length() > 0) {
//    sql.append(" and destinedate>=").append(" ").append(DbAdapter.cite(timek));
//    param.append("&destinedate=").append(timek);
//  }
//  String timej = request.getParameter("timej");
//  if (timej != null && (timej = timej.trim()).length() > 0) {
//    sql.append(" and destinedate<").append(" ").append(DbAdapter.cite(timej));
//    param.append("&destinedate=").append(timej);
//  }
//  String member = request.getParameter("member");
//  if (member != null && member.length() > 0) {
//    sql.append("  and member like ").append(" ").append(DbAdapter.cite("%" + member + "%"));
//    param.append("&member=").append(member);
//  }
  int count = Destine.countTj2(sql.toString());
  int pos = 0;
  int pageSize = 20;
  if (teasession.getParameter("Pos") != null) {
    pos = Integer.parseInt(teasession.getParameter("Pos"));
  }
  // sql.append(" ORDER BY destinedate desc  ");
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
</head>
<body id="bodynone">
<script type="">
function f_kind()
{
  form1.act.value="orderstatistics";
  form1.action='/servlet/EditDestine';
  form1.submit();
}
</script>
<h1>订单统计</h1>
<div id="head6">
  <img height="6" src="about:blank">
</div>
<h2>查询</h2>
<form action="?" method="get" name="form1">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <input type=hidden name="act"/>
  <input type="hidden" name="id" value="<%=request.getParameter("id")%>">
  <tr>
    <td nowrap align="center">      酒店名称:<input type="text" name="nameid" value="<%if(nameid!=null)out.print(nameid);%>"/>
      <%--<select name="nameid">
        <option value="0">-------</option>
      <%
        java.util.Enumeration jde = Hostel.find("", 0, Integer.MAX_VALUE);
        for (int i = 0; jde.hasMoreElements(); i++) {
          int jdid = ((Integer) jde.nextElement()).intValue();
          Hostel h = Hostel.find(jdid);
          Node n = Node.find(h.getNode());
          if (!n.isHidden()) {
            out.print("<option value=" + jdid);
            if (nameid == jdid)
              out.print("  selected");
            out.print(">" + n.getSubject(teasession._nLanguage));
            out.print("</option>");
          }
        }
      %>
      </select>
      订单时间：从
      <input name="timek" size="7" value="<%if(timek!=null)out.print(timek);%>">
      <A href="###">
        <img onClick="showCalendar('form1.timek');" src="/tea/image/public/Calendar2.gif" align="top"/>
      </a>
      到：
      <input name="timej" size="7" value="<%if(timej!=null)out.print(timej);%>">
      <A href="###">
        <img onClick="showCalendar('form1.timej');" src="/tea/image/public/Calendar2.gif" align="top"/>
      </a>
      会员ID:
      <input type="text" name="member" value="<%if(member!=null)out.print(member);%>">--%>
      <input value="查询" type="submit"/>
    </td>
  </tr>
</table>
<h2>列表</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td>所定酒店</td>
    <td>订单总数</td>
    <td>已受理数</td>
    <td>未受理数</td>
    <td>过期订单数</td>
  </tr>
<%
  java.util.Enumeration e = Destine.findTj(teasession._strCommunity, sql.toString(), pos, pageSize);
  if (!e.hasMoreElements()) {
    out.print("<tr><td align=center colspan=10>暂无记录</td></tr>");
  }
  int dingdan = 0, yshouli = 0, wshouli = 0, gshouli = 0;
  while (e.hasMoreElements()) {
    int id = ((Integer) e.nextElement()).intValue();
    //Destine d = Destine.find(id);
    Node n = Node.find(id);
    dingdan = Destine.countTj(" and node=" + id);
    yshouli = Destine.countTj("  and node=" + id + " and state=1");
    wshouli = Destine.countTj(" and node=" + id + " and state=0");
    gshouli = Destine.countTj(" and node=" + id + " and (state=2 or state=3 )");
%>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td>
      <a href="/jsp/registration/HostelView.jsp?node=<%=n._nNode%>"><%=n.getSubject(teasession._nLanguage)%>      </a>
    </td>
    <td><%=dingdan%>    </td>
    <td><%=yshouli%>    </td>
    <td><%=wshouli%>    </td>
    <td><%=gshouli%>    </td>
  </tr>
<%} if (count > pageSize) {%>
  <tr>
    <td>&nbsp;</td>
    <td align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage, request.getRequestURI()+param.toString() + "&Pos=", pos, count,pageSize)%>    </td>
  </tr>
<%}%>
</table>
<input type="hidden" name="sql" value="<%=sql.toString()%>"/>
<input name="" id="excel_table" onClick="f_kind();" type="button" value="导出Excel表格">
</form>
<div id="head6">
  <img height="6" src="about:blank">
</div>
<script language="JavaScript">
 anole('',1,'#F2F2F2','#DEEEDB','','');
  </script>
</body>
</html>
