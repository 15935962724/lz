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
  String act = request.getParameter("act");
  int father = 0;
  if (request.getParameter("father") != null && request.getParameter("father").length() > 0)
    father = Integer.parseInt(request.getParameter("father"));
  StringBuffer param = new StringBuffer("?community=").append(teasession._strCommunity);
  StringBuffer sql = new StringBuffer(" and father =").append(father);
  param.append("&father=").append(father);
  int cid = 0;
  if (request.getParameter("cid") != null && request.getParameter("cid").length() > 0) {
    cid = Integer.parseInt(request.getParameter("cid"));
  }
  City cc = City.find(cid);
  String nexturl = request.getParameter("nexturl");
  String cityname = request.getParameter("cityname");
  String cn = null;
  if ("amend".equals(act)) {
    cn = cc.getCityname();
  }
  if (cityname != null && cityname.length() > 0) {
    if (cid > 0) {
      cc.set(father, cityname);
    }
    else {
      City.create(father, cityname, teasession._rv.toString(), teasession._strCommunity);
    }
    response.sendRedirect(nexturl + "?father=" + father);
    return;
  }
  if ("delete".equals(act)) {
    cc.delete();
    //   response.sendRedirect(nexturl);
    //   return;
  }
  int count = City.count(teasession._strCommunity, sql.toString());
  int pos = 0;
  int pageSize = 20;
  if (teasession.getParameter("Pos") != null) {
    pos = Integer.parseInt(teasession.getParameter("Pos"));
  }
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body id="bodynone">
<script type="">
function f_delete()
{
   if(confirm('您确定要删除吗？'))
   {
      return true;
   }else
   {
     return false;
   }
}
</script>
<div id="tablebgnone" class="register">
  <h1>省/城市</h1>
  <div id="head6">
    <img height="6" src="about:blank" alt="">
  </div>
  <FORM name="form1" METHOD="POST" action="?">
  <input type="hidden" name="act" value="pagerange">
  <input type="hidden" name="cid" value="<%=cid%>"/>
  <input type="hidden" name="father" value="<%=father%>"/>
  <input type="hidden" name="nexturl" value="<%=request.getRequestURL()%>"/>
  <table>
    <tr>
      <td> 省/城市名称：
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="text" name="cityname" value="<%if(cn!=null)out.print(cn);%>"/>
        <input type="submit" value="添加"/>
      </td>
    </tr>
  </table>
  </FORM>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <th nowrap colspan="10" align="center">省/城市列表</th>
    </tr>
    <tr id="tablecenter">
      <th nowrap>名称</th>
      <td nowrap>操作</td>
    </tr>
  <%
    java.util.Enumeration e = City.find(teasession._strCommunity, sql.toString(), pos, pageSize);
    if (!e.hasMoreElements()) {
      out.print("<tr><td align=center colspan=10>暂无记录</td></tr>");
    }
    while (e.hasMoreElements()) {
      int id = ((Integer) e.nextElement()).intValue();
      City c = City.find(id);
  %>
    <tr>
      <td><%=c.getCityname()%></td>
      <td>
        <a href="?cid=<%=id%>&act=amend&father=<%=father%>">修改</a>
        <a href="?act=delete&cid=<%=id%>&father=<%=father%>" onclick="return f_delete();">删除</a>
      </td>
    </tr>
  <%} if (count > pageSize) { %>
    <tr>
      <td>&nbsp;</td>
      <td align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage, request.getRequestURI()+param.toString() + "&Pos=", pos, count,pageSize)%>      </td>
    </tr>
  <%} %>
    <tr>
      <td colspan="10" align="center">
        <a href="/jsp/registration/pagerange.jsp">返回上一级</a>
      </td>
    </tr>
  </table>
</body>
</html>
</html>
