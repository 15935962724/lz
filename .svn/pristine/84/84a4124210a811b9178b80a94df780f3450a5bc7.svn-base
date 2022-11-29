<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.member.Profile"%>
<%
  request.setCharacterEncoding("UTF-8");
  TeaSession teasession = new TeaSession(request);

  Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");

  String act = request.getParameter("act");
  String memberid = request.getParameter("memberid");
  String nexturl = request.getParameter("nexturl");

  if("sp".equals(act))
  {
    Caller cobj = Caller.find(memberid);
    cobj.set(1);
    response.sendRedirect(nexturl);
    return ;
  }
   if("qx".equals(act))
  {
    Caller cobj = Caller.find(memberid);
    cobj.set(0);
    response.sendRedirect(nexturl);
    return ;
  }
  StringBuffer param = new StringBuffer("?community=").append(teasession._strCommunity);
  StringBuffer sql = new StringBuffer(" and type =0 ");
  String role = teasession.getParameter("role");
  param.append("&role=").append(role);

 StringBuffer param2 = new StringBuffer("?community=").append(teasession._strCommunity);
  StringBuffer sql2 = new StringBuffer(" and type <> 0");
  param2.append("&role=").append(role);
  int pos = 0, count = 0,size=5;
  if (request.getParameter("pos") != null) {
    pos = Integer.parseInt(request.getParameter("pos"));
  }
  count = Caller.count(sql.toString());

String cname = request.getParameter("cname");
if (cname != null && cname.length() > 0) {
  sql2.append(" AND Caller.member in(select member from profilelayer where firstname like " + DbAdapter.cite("%" + cname + "%")).append(")");
  param2.append("&cname=").append(java.net.URLEncoder.encode(cname, "UTF-8"));
}
String cmember = request.getParameter("cmember");
if (cmember != null && cmember.length() > 0) {
sql2.append(" AND Caller.member like " + DbAdapter.cite("%" + cmember + "%"));
  param2.append("&cmember=").append(cmember);
}
String site = request.getParameter("site");
if (site != null && site.length() > 0) {
  sql2.append(" AND Caller.site like " + DbAdapter.cite("%" + site + "%"));
  param2.append("&site=").append(java.net.URLEncoder.encode(site, "UTF-8"));
}
String type = request.getParameter("type");
if (type != null && type.length() > 0 && !("-1".equals(type))) {
sql2.append(" AND Caller.type="+type);
  param2.append("&type=").append(type);
}

  int pos2 = 0, count2 = 0,size2=10;
  if (request.getParameter("pos2") != null) {
    pos2 = Integer.parseInt(request.getParameter("pos2"));
  }
  count2 = Caller.count(sql2.toString());
sql2.append(" order by regdate desc");
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <script type="text/javascript">
  function f_sp(igd)
  {
    if(confirm('您确实要执行操作吗！'))
    {
      form1.memberid.value=igd;
      form1.act.value="sp";
      form1.action='?';
      form1.submit();
    }
  }
  function f_qx(igd)
  {
    if(confirm('您确实要执行操作吗！'))
    {
      form1.memberid.value=igd;
      form1.act.value="qx";
      form1.action='?';
      form1.submit();
    }
  }
  function qx(mem){
  if(confirm('确定取消该话务员？')){
     window.location.href='/jsp/registration/cancaller.jsp?member='+mem;
  }
  }
  </script>
</head>
<body id="bodynone">
<div id="tablebgnone" class="register">
  <h1>话务员审核</h1>
  <div id="head6">
    <img height="6" src="about:blank" alt="">
  </div>
  <FORM name="form1" METHOD="POST" action="?">
  <input type="hidden" name="act">
  <input type="hidden" name="memberid"/>
  <input type="hidden" name="nexturl" value="<%=request.getRequestURL()%>">
  <input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>
  <h2>待审核话务员&nbsp;<%=count%></h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td nowrap>姓名</td>
      <td nowrap>登陆ID</td>
      <td nowrap>坐席号</td>
<td>状态</td>
      <td nowrap>操作</td>
    </tr>
  <%
    java.util.Enumeration ce = Caller.find(sql.toString(), pos, size);
    if (!ce.hasMoreElements()) {
      out.print("<tr><td align=center colspan=10>暂无记录</td></tr>");
    }
    while (ce.hasMoreElements()) {
      String member = ((String) ce.nextElement());
      Caller obj = Caller.find(member);
      Profile profile = Profile.find(obj.getMember());
  %>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td><%=profile.getFirstName(teasession._nLanguage)%>      </td>
      <td><a href="/jsp/registration/CallerView.jsp?member=<%=java.net.URLEncoder.encode(obj.getMember(),"UTF-8")%>"><%=obj.getMember()%>      </a></td>
      <td><%=obj.getSite()%>      </td>
<td>未审核</td>
      <td>
        <input type="button" value="审批" onClick="f_sp('<%=member%>')"/>
      </td>
    </tr>
  <%} if(count>size){ %>
  <tr>
     <td colspan="5" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage, request.getRequestURI()+param.toString() + "&pos=", pos, count,size)%>       </td>
  </tr><%
  } %>
  </table>

  <h2>已审核话务员&nbsp;<%=count2%></h2>
  <table id="tablecenter">
  <tr>
 <td> 姓名：<input type="text" name="cname" value="<%if(cname!=null)out.print(cname);%>"/>&nbsp;&nbsp;&nbsp;
      登陆ID：<input type="text" name="cmember" value="<%if(cmember!=null)out.print(cmember);%>"/>&nbsp;&nbsp;&nbsp;
      坐席号：<input type="text" name="site" value="<%if(site!=null)out.print(site);%>"/>&nbsp;&nbsp;&nbsp;
      状态：
              <select name="type" >
              <option value="-1">全部</option>
              <option value="1">已审核</option>
              <option value="3">已取消</option>
              </select>
              &nbsp;&nbsp;&nbsp;&nbsp;
              <input type="submit" value=" GO "/>
            </td>
  </tr>
  </table>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td nowrap>姓名</td>
      <td nowrap>登陆ID</td>
      <td nowrap>坐席号</td>
      <td>状态</td>
      <td nowrap>操作</td>

    </tr>
  <%
    java.util.Enumeration ce2 = Caller.find(sql2.toString(), pos2, size2);
    if (!ce2.hasMoreElements()) {
      out.print("<tr><td align=center colspan=10>暂无记录</td></tr>");
    }
    while (ce2.hasMoreElements()) {
      String member2 = ((String) ce2.nextElement());
      Caller obj2 = Caller.find(member2);
      Profile profile2 = Profile.find(obj2.getMember());
  %>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td><%=profile2.getFirstName(teasession._nLanguage)%>      </td>
      <td><a href="/jsp/registration/CallerView.jsp?member=<%=java.net.URLEncoder.encode(obj2.getMember(),"UTF-8")%>"><%=obj2.getMember()%>      </a></td>
      <td><%=obj2.getSite()%>      </td>
<td>
<%if(obj2.getType()== 1){
  out.print("已审核");
}else{
  out.print("已取消");
}
  %>
</td>
      <td>
      <%if(obj2.getType()== 1){%>
        <input type="button" value="取消" onClick="qx('<%=member2%>')"/><%} %>
      </td>
    </tr>
  <%} if(count2>size2){ %>
  <tr>
   <td colspan="5" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage, request.getRequestURI()+param.toString() + "&pos2=", pos2, count2,size2)%>       </td>
  </tr><%
  } %>

  </table>
  </FORM>
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
