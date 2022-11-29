<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.member.Profile"%>
<jsp:useBean id="sms" scope="page" class="tea.entity.node.Sms"/>
<%
  request.setCharacterEncoding("UTF-8");
  TeaSession teasession = new TeaSession(request);
  Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");

  StringBuffer param = new StringBuffer("?community=").append(teasession._strCommunity);
  StringBuffer sql = new StringBuffer();

  String role = teasession.getParameter("role");
  param.append("&role=").append(role);
  int pos = 0, count = 0,pageSize=10;
  if (request.getParameter("pos") != null) {
    pos = Integer.parseInt(request.getParameter("pos"));
  }

  String cname = request.getParameter("cname");
if (cname != null && cname.length() > 0) {
  sql.append(" AND Caller.member in(select member from profilelayer where firstname like " + DbAdapter.cite("%" + cname + "%")).append(")");
  param.append("&cname=").append(java.net.URLEncoder.encode(cname, "UTF-8"));
}
String cmember = request.getParameter("cmember");
if (cmember != null && cmember.length() > 0) {
sql.append(" AND Caller.member like " + DbAdapter.cite("%" + cmember + "%"));
  param.append("&cmember=").append(cmember);
}
String site = request.getParameter("site");
if (site != null && site.length() > 0) {
  sql.append(" AND Caller.site like " + DbAdapter.cite("%" + site + "%"));
  param.append("&site=").append(java.net.URLEncoder.encode(site, "UTF-8"));
}

  count = Caller.count(sql.toString());
  sql.append("order by regdate desc");
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
function yesno() {
if(confirm("确定删除此话务员信息?")){
return true;
}else return false;
}
</script>
</head>
<body id="bodynone">
<div id="tablebgnone" class="register">
  <h1>    话务员列表(
<%=count%>    )
  </h1>
  <div id="head6">
    <img height="6" src="about:blank" alt="">
  </div>
  <FORM name="form1" METHOD="POST" action="/jsp/registration/caller.jsp?role=4" <%--action="/jsp/registration/newcaller.jsp?membe=<%=teasession._rv%>"--%>>
  <input type="hidden" name="act">
  <input type="hidden" name="memberid"/>
  <input type="hidden" name="nexturl" value="<%=request.getRequestURL()%>">
  <h2>查询</h2>
  <table id="tablecenter">
  <tr>
 <td> 姓名：<input type="text" name="cname" value="<%if(cname!=null)out.print(cname);%>"/>&nbsp;&nbsp;&nbsp;
      登陆ID：<input type="text" name="cmember" value="<%if(cmember!=null)out.print(cmember);%>"/>&nbsp;&nbsp;&nbsp;
      坐席号：<input type="text" name="site" value="<%if(site!=null)out.print(site);%>"/>&nbsp;&nbsp;&nbsp;
              <input type="submit" value=" GO "/>
            </td>
  </tr>
  </table>
  <h2>列表</h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td nowrap>姓名</td>
      <td nowrap>登陆ID</td>
      <td nowrap>坐席号</td>
      <td nowrap>操作</td>
    </tr>
  <%
    java.util.Enumeration ce = Caller.find(sql.toString(), pos, pageSize);
    if (!ce.hasMoreElements()) {
      out.print("<tr><td align=center colspan=10>暂无记录</td></tr>");
    }
    while (ce.hasMoreElements()) {
      String member = ((String) ce.nextElement());
      Caller obj = Caller.find(member);
      Profile profile = Profile.find(obj.getMember());
  %>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td><%=profile.getFirstName(teasession._nLanguage)%> </td>
      <td><a href="/jsp/registration/CallerView.jsp?member=<%=java.net.URLEncoder.encode(obj.getMember(),"UTF-8")%>"><%=obj.getMember()%>      </a></td>
      <td><%=obj.getSite()%> </td>
      <td>
        <a href="/jsp/registration/auditcaller.jsp?member=<%=java.net.URLEncoder.encode(member,"UTF-8")%>">修改</a>
        <a href="/jsp/registration/deletecaller.jsp?member=<%=java.net.URLEncoder.encode(member,"UTF-8")%>" onClick="return yesno();">删除</a>
      </td>
    </tr>
  <%} if(count>pageSize){ %>
  <tr>
    <td colspan="6" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage, request.getRequestURI()+param.toString() + "&pos=", pos, count,pageSize)%></td>
  </tr><%
  } %>
    <tr>
      <td align="center" colspan="6">
       <a href="/jsp/registration/newcaller.jsp?nexturl=<%=request.getRequestURL()%>&role=<%=role%>"> 创建话务员</a>
      </td>
    </tr>
  </table>
  </FORM>
  <script language="JavaScript">
 anole('',1,'#F2F2F2','#DEEEDB','','');
  </script>
</body>
</html>
