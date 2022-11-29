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
Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");
StringBuffer param = new StringBuffer("?community=").append(teasession._strCommunity);
StringBuffer sql = new StringBuffer("   and n.rcreator=" + DbAdapter.cite(teasession._rv.toString()));


Citypopedom cobj = Citypopedom.find(teasession._rv.toString());
java.util.Enumeration ae = AdminUsrRole.find(teasession._strCommunity," and member ="+DbAdapter.cite(teasession._rv.toString())+" and role like "+DbAdapter.cite("%/"+5+"/%"),0,Integer.MAX_VALUE);
if(ae.hasMoreElements()){
  if(cobj.getCityid()==null )
  {
    response.sendError(403);
    return;
  }
  sql.append(" and d.node in (select node from Hostel where  ");
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
int nameid = 0;
if (request.getParameter("nameid") != null && request.getParameter("nameid").length() > 0) {
  nameid = Integer.parseInt(request.getParameter("nameid"));
}
if (nameid != 0) {
  sql.append(" and d.node= ").append(" ").append(nameid);
  param.append("nameid=").append(nameid);
}

String destineNum = request.getParameter("destineNum");
if (destineNum != null && destineNum.length() > 0) {
  sql.append(" and d.destine like "+DbAdapter.cite("%"+destineNum+"%"));
  param.append("&destineNum=").append(destineNum);
}
String humanname = request.getParameter("humanname");
if (humanname != null && humanname.length() > 0) {
  sql.append(" and d.destine in(select destine from destinelayer where linkmanname like ").append(DbAdapter.cite("%"+humanname+"%")).append(")");
  param.append("&humanname=").append(humanname);
}
String linkmanname = request.getParameter("linkmanname");
if (linkmanname != null && linkmanname.length() > 0) {
  sql.append(" and d.destine in(select destine from destinelayer where humanname like ").append(DbAdapter.cite("%"+linkmanname+"%")).append(")");
  param.append("&linkmanname=").append(linkmanname);
}

String hostelname = request.getParameter("hostelname");
if (hostelname != null && hostelname.length() > 0) {
  sql.append(" and d.node in(select node from nodelayer where subject like ").append(DbAdapter.cite("%"+hostelname+"%")).append(")");
  param.append("&hostelname=").append(hostelname);
}

String timek = request.getParameter("timek");
if (timek != null && (timek = timek.trim()).length() > 0) {
  sql.append(" and d.destinedate>=").append(" ").append(DbAdapter.cite(timek));
  param.append("&destinedate=").append(timek);
}
String timej = request.getParameter("timej");
if (timej != null && (timej = timej.trim()).length() > 0) {
  sql.append(" and d.destinedate<").append(" ").append(DbAdapter.cite(timej));
  param.append("&destinedate=").append(timej);
}
int state = -1;
if (request.getParameter("state") != null && request.getParameter("state").length() > 0) {
  state = Integer.parseInt(request.getParameter("state"));
}
if (state != -1) {
  sql.append(" and d.state=").append(state);
  param.append("&state=").append(state);
}
int count = Destine.countBy(teasession._strCommunity, sql.toString());
int count0 = Destine.countBuffer(teasession._strCommunity,0,sql.toString());
int count1 = Destine.countBuffer(teasession._strCommunity,1,sql.toString());
int count2 = Destine.countBuffer(teasession._strCommunity,2,sql.toString());
int count3 = Destine.countBuffer(teasession._strCommunity,3,sql.toString());
int count4 = Destine.countBuffer(teasession._strCommunity,4,sql.toString());
int count5 = Destine.countBuffer(teasession._strCommunity,5,sql.toString());
int pos = 0;
int pageSize = 20;
if (teasession.getParameter("Pos") != null) {
  pos = Integer.parseInt(teasession.getParameter("Pos"));
}
sql.append(" ORDER BY destinedate desc  ");
%>
<html>
  <head>
    <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
    <script src="/tea/tea.js" type="text/javascript"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body id="bodynone">
  <div id="tablebgnone" class="register">
    <h1>订单查询</h1>
    <div id="head6">
      <img height="6" src="about:blank" alt="">
    </div>
    <FORM name="form1" METHOD="POST" action="">
      <input type="hidden" name="destine" value="">
      <input type="hidden" name="nexturl" value="<%=request.getRequestURL()%>"/>
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
      <td>订单编号：<input type="text" name="destineNum" value="<%if(destineNum!=null)out.print(destineNum);%>"/></td>
      <td align="center">预订人：<input type="text" name="humanname" value="<%if(humanname!=null)out.print(humanname);%>"/></td>
      <td>旅客姓名：<input type="text" name="linkmanname" value="<%if(linkmanname!=null)out.print(linkmanname);%>"/></td>
      </tr>
        <tr>
          <td>酒店名称：<input type="text" name="hostelname" value="<%if(hostelname!=null)out.print(hostelname);%>"/>
            <%-- <select name="nameid">
              <option value="0">--------</option>
              <%
              java.util.Enumeration jde = Hostel.find("  and member=" + DbAdapter.cite(teasession._rv.toString()), 0, Integer.MAX_VALUE);
              for (int i = 0; jde.hasMoreElements(); i++) {
                int id = ((Integer) jde.nextElement()).intValue();
                Hostel h = Hostel.find(id);
                Node n = Node.find(h.getNode());
                if (!n.isHidden()) {
                  out.print("<option value=" + id);
                  if (nameid == id)
                  out.print("  selected");
                  out.print(">" + n.getSubject(teasession._nLanguage));
                  out.print("</option>");
                }
              }
              %>
              </select>--%>

          </td><td>
              订单时间：从
              <input name="timek" size="7" value="<%if(timek!=null)out.print(timek);%>">
              <A href="###">
                <img onClick="showCalendar('form1.timek');" src="/tea/image/public/Calendar2.gif" align="top"/>
</a>
到：
<input name="timej" size="7" value="<%if(timej!=null)out.print(timej);%>">
<A href="###">
  <img onClick="showCalendar('form1.timej');" src="/tea/image/public/Calendar2.gif" align="top"/>
</a></td><td>
订单状态：<select name="state">
  <option value="-1">-------</option>
  <%
  for (int i = 0; i < Destine.STATE.length; i++) {
    out.print("<option value=" + i);
    if (state == i)
    out.print("  selected");
    out.print(">" + Destine.STATE[i]);
    out.print("</option>");
  }
  %>
  </select>

          </td>
        </tr>
        <tr><td colspan="3" align="center"> <input type="submit" value=" GO "/></td>
        </tr>
      </table>
      <h1>订单状态统计</h1>
      <table id="tablecenter">
        <tr>
          <td>　</td>
          <td>总计</td>
          <td>未受理</td>
          <td>已受理</td>
          <td>入住正常</td>
          <td>LESSSHOW</td>
          <td>延住</td>
          <td>NOSHOW</td>
        </tr>
        <tr>
          <td>订单数</td>
          <td><%=count %></td>
          <td><%=count0 %></td>
          <td><%=count1 %></td>
          <td><%=count2 %></td>
          <td><%=count3 %></td>
          <td><%=count4 %></td>
          <td><%=count5 %></td>
        </tr>
      </table>
      <h1>订单列表</h1>
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr id="tableonetr">
          <td>NO.</td>
          <td nowrap>订单号</td>
          <td nowrap>预订人</td>
          <td nowrap>酒店</td>
          <td nowrap>旅客姓名</td>
          <td nowrap>房间数</td>
          <td nowrap>订单时间</td>
          <td nowrap>入住时间</td>
          <td nowrap>离店时间</td>
          <td nowrap>订单状态</td>
        </tr>
        <%int q = 1;
        java.util.Enumeration e = Destine.findBy(teasession._strCommunity, sql.toString(), pos, pageSize);
        if (!e.hasMoreElements()) {
          out.print("<tr><td align=center colspan=10>暂无记录</td></tr>");
        }
        while (e.hasMoreElements()) {
          int id = ((Integer) e.nextElement()).intValue();
          Destine d = Destine.find(id);
          Node n = Node.find(d.getNode());
          Hostel h = Hostel.find(d.getNode(), teasession._nLanguage);
          %>
          <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
            <td><%=q %></td>
            <td nowrap>
              <a href="/jsp/registration/DestineView.jsp?node=<%=n._nNode%>&destine=<%=d.getDestine()%>&roomprice=<%=d.getRoomprice()%>"><%=id%>        </a>
            </td>
            <td nowrap><%=d.getLinkmanname(teasession._nLanguage)%></td>
            <td nowrap>
              <a href="/jsp/registration/HostelView.jsp?node=<%=n._nNode%>"><%=n.getSubject(teasession._nLanguage) %>        </a>
            </td>
            <td nowrap><%=d.getHumanname(teasession._nLanguage)%></td>
            <td nowrap><%=d.getRoomcount()%></td>
            <td nowrap><%=d.getDestinedateToString() %>      </td>
            <td nowrap><%=d.getKipdateToString()%></td>
            <td nowrap><%=d.getLeavedateToString() %></td>
            <td nowrap><%=Destine.STATE[d.getState()]%>      </td>
          </tr>
          <%q++;} if (count > pageSize) {  %>
          <tr>
            <td>&nbsp;</td>
            <td align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage, request.getRequestURI()+param.toString() + "&Pos=", pos, count,pageSize)%>      </td>
          </tr>
          <%}  %>
      </table>
    </FORM>
    <div id="language"><%=new Languages(teasession._nLanguage,request)%>  </div>
    <script language="JavaScript">
    anole('',1,'#F2F2F2','#DEEEDB','','');
    </script>
    </body>
</html>
</html>
