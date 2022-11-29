<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.db.*" %>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.site.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.entity.member.Profile" %>
<%@ page import="tea.entity.admin.*" %>
<%
request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

Resource r=new Resource();
r.add("/tea/resource/BBS");


///if(keywords!=null&&keywords.length()>0)
////{
  ////  sql.append(" AND node IN (SELECT node FROM NodeLayer WHERE subject LIKE ").append(DbAdapter.cite("%"+keywords+"%")).append(" OR content LIKE ").append(DbAdapter.cite("%"+keywords+"%")).append(")");
  ////  param.append("&keywords=").append(java.net.URLEncoder.encode(keywords,"UTF-8"));
  ////}

  StringBuffer param=new StringBuffer("?community=").append(teasession._strCommunity);
  StringBuffer sql=new StringBuffer();
int state = -1;
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

    String mem =request.getParameter("mem");
  if(mem!=null && mem.length()>0)
  {
    sql.append(" and member in(select member from profilelayer where firstname like ").append(DbAdapter.cite("%"+mem+"%")).append(")");
    param.append("&mem=").append(java.net.URLEncoder.encode(mem,"UTF-8"));
  }
    String name =request.getParameter("name");
  if(name!=null && name.length()>0)
  {
    sql.append(" and node in (select node from NodeLayer where subject like ").append(DbAdapter.cite("%"+name+"%")).append(")");
    param.append("&name=").append(java.net.URLEncoder.encode(name,"UTF-8"));
  }
    String dnumber =request.getParameter("dnumber");
  if(dnumber!=null && dnumber.length()>0)
  {
    sql.append(" and destine like ").append(DbAdapter.cite("%"+dnumber+"%"));
    param.append("&dnumber=").append(java.net.URLEncoder.encode(dnumber,"UTF-8"));
  }

  String dbuffer =request.getParameter("dbuffer");
  if(dbuffer!=null && dbuffer.length()>0 && !"-1".equals(dbuffer))
  {
    sql.append(" and state=").append(dbuffer);
    param.append("&dbuffer=").append(java.net.URLEncoder.encode(dbuffer,"UTF-8"));
  }
  String timek = request.getParameter("timek");
  if(timek!=null && (timek=timek.trim()).length()>0)
  {
    sql.append(" and destinedate>=").append(" ").append(DbAdapter.cite(timek));
    param.append("&destinedate=").append(timek);
  }
  String timej = request.getParameter("timej");
  if(timej!=null &&(timej=timej.trim()).length()>0)
  {
    sql.append(" and destinedate<").append(" ").append(DbAdapter.cite(timej));
    param.append("&destinedate=").append(timej);
  }

  int count=Destine.count(teasession._strCommunity,sql.toString());
  int pos=0;
  int pageSize=20;
  if(teasession.getParameter("Pos")!=null)
  {
    pos=Integer.parseInt(teasession.getParameter("Pos"));
  }

  String o=request.getParameter("o");
  if(o==null)
  {
    o="destinedate";
  }
  boolean a=Boolean.parseBoolean(request.getParameter("a"));
  sql.append(" ORDER BY ").append(o).append(" ").append(a?"DESC":"ASC");
  param.append("&o=").append(o).append("&a=").append(a);
  //sql.append(" ORDER BY destinedate desc  ");

  %><html>
  <head>
    <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>

  </head>
  <body id="bodynone">
  <script type="">
  function f_kind()
  {
    form1.act.value="kind";
    form1.action='/servlet/EditDestine';
    form1.submit();
  }
  function f_order(v)
  {
    var a=form1.a.value=="true";
    if(form1.o.value==v)
    {
      form1.a.value=!a;
    }else
    {
      form1.o.value=v;
    }
    form1.action="?";
    form1.submit();
  }

  </script>
  <h1><%=r.getString(teasession._nLanguage, "订单管理")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>
    <form action="?" method="get" name="form1">
    <input type=hidden name="act" />
    <input type="hidden" name="o" VALUE="<%=o%>">
    <input type="hidden" name="a" VALUE="<%=a%>">
    <input type="hidden" name="id" value="<%=request.getParameter("id")%>">
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <td colspan="2">
          会员名称：<input type="text" name="mem" value="<%if(mem!=null)out.print(mem);%>" /></td>
          <td colspan="2">酒店名称：<input type="text" name="name" value="<%if(name!=null)out.print(name);%>" /></td>
            <td colspan="2">订单编号：<input type="text" name="dnumber" value="<%if(dnumber!=null)out.print(dnumber);%>" /></td>
              <tr><td colspan="2" > 订单时间：从
                <input name="timek" size="7"  value="<%if(timek!=null)out.print(timek);%>"><A href="###"><img onClick="showCalendar('form1.timek');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
                到
                <input name="timej" size="7"  value="<%if(timej!=null)out.print(timej);%>"><A href="###"><img onClick="showCalendar('form1.timej');" src="/tea/image/public/Calendar2.gif" align="top"/></a></td>
                <td colspan="2">
                  订单状态：<select name="dbuffer">
                  <option value="-1">全部</option>
                  <%
  for (int i = 0; i < Destine.STATE.length; i++) {
    out.print("<option value=" + i);
    if (state == i)
    out.print("  selected");
    out.print(">" + Destine.STATE[i]);
    out.print("</option>");
  }
  %>
                  </select>&nbsp;&nbsp;
                  　　　　<td colspan="2"><input type="submit"  value="查询"/></td>

              </tr>
    </table>
    <h2><%=r.getString(teasession._nLanguage, "列表")%></h2>

    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr id="tableonetr">
        <td align="center" nowrap><a href="javascript:f_order('member');">订单会员</a>
        <%
        if(o.equals("member"))
        {
          if(a)
          out.print("↓");
          else
          out.print("↑");
        }
        %>
        </td>
        <td nowrap><a href="javascript:f_order('node');">所定酒店</a>
        <%
        if(o.equals("node"))
        {
          if(a)
          out.print("↓");
          else
          out.print("↑");
        }
        %>
        </td>
        <td nowrap><a href="javascript:f_order('destine');"> 订单编号</a><%
        if(o.equals("destine"))
        {
          if(a)
          out.print("↓");
          else
          out.print("↑");
        }
        %></td>
        <td nowrap><a href="javascript:f_order('destinedate');">订单日期</a> <%
        if(o.equals("destinedate"))
        {
          if(a)
          out.print("↓");
          else
          out.print("↑");
        }
        %></td>
        <td nowrap><a href="javascript:f_order('state');"> 订单状态</a><%
        if(o.equals("state"))
        {
          if(a)
          out.print("↓");
          else
          out.print("↑");
        }
        %></td>
        <td>操作</td>
      </tr>
      <%
      java.util.Enumeration e = Destine.find(teasession._strCommunity,sql.toString(),pos,pageSize);
      if(!e.hasMoreElements())
      {
        out.print("<tr><td align=center colspan=4>暂无记录</td></tr>");
      }
      while(e.hasMoreElements())
      {
        int id =((Integer)e.nextElement()).intValue();
        Destine d = Destine.find(id);
        Node n = Node.find(d.getNode());
        Profile p = Profile.find(d.getMember());
        %>
        <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
          <td align="center" ><a href="/jsp/registration/ProfileView.jsp?member=<%=java.net.URLEncoder.encode(p.getMember(),"UTF-8")%>"><%=p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage) %></a></td>
          <td><a href="/jsp/registration/HostelView.jsp?node=<%=n._nNode%>"><%=n.getSubject(teasession._nLanguage)%></a></td>
          <td><a href="/jsp/registration/DestineView.jsp?node=<%=n._nNode%>&destine=<%=d.getDestine()%>&roomprice=<%=d.getRoomprice()%>"><%=id %></a></td>
          <td ><%=d.getDestinedateToString()%></td>
          <td><%=Destine.STATE[d.getState()]%>

          </td>
          <td>
          <%
          if(Destine.STATE[d.getState()].equals("未受理")){
            %>
            <input type="button" value="催办" onclick="javascript:window.location.href='/jsp/registration/adddestineinfo.jsp?node=<%=n._nNode%>&name=<%=n.getSubject(teasession._nLanguage)%>&destine=<%=d.getDestine()%>'"/>
            　　<input type="button" value="修改订单" onclick="javascript:window.location.href='/jsp/registration/editorder.jsp?destine=<%=id%>&language=<%=teasession._nLanguage%>&nexturl=<%=request.getRequestURI()%>?<%=request.getQueryString()%>'"/>
            <%
            }else{
              %>
              　　　　&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="修改订单" onclick="javascript:window.location.href='/jsp/registration/editorder.jsp?destine=<%=id%>&language=<%=teasession._nLanguage%>&nexturl=<%=request.getRequestURI()%>?<%=request.getQueryString()%>'"/><%} %></td>
        </tr>
        <%
        }if(count>pageSize){
          %>
          <tr>
            <td align="center" colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage, request.getRequestURI()+param.toString() + "&Pos=", pos, count,pageSize)%></td>
          </tr><%} %>
    </table>
    <input type="hidden" name="sql" value="<%=sql.toString()%>" />
    <input id="excel_table" name="" type="button" value="导出Excel表格" onClick="f_kind();" >
    </form>
    <div id="head6"><img height="6" src="about:blank"></div>
      <div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
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
