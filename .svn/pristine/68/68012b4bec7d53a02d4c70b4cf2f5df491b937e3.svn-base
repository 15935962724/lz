<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="tea.ui.*,tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.admin.*"%>
<!--Community的包-->
<jsp:useBean id="sms" scope="page" class="tea.entity.node.Sms"/>
<%
  request.setCharacterEncoding("UTF-8");
  TeaSession teasession = new TeaSession(request);

  if (teasession._rv._strR == null) {
    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode + "&nexturl=" + java.net.URLEncoder.encode(request.getRequestURI() + "?" + request.getQueryString(), "UTF-8"));
    return;
  }

  String father = request.getParameter("father");
  int node = Integer.parseInt(teasession.getParameter("node"));
  StringBuffer sql = new StringBuffer(" and  father ="+node);
  StringBuffer param = new StringBuffer("?community=" + teasession._strCommunity);

  int  count = Node.count(sql.toString());
  int pos = 0, pageSize = 10;

  if (request.getParameter("pos") != null) {
    pos = Integer.parseInt(request.getParameter("pos"));
  }

  String nexturl = request.getRequestURI()+"?node="+node;
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script type="text/javascript">
function yn()
{
  if(confirm('是否真的要删除此酒店？'))
  {
    return true;
  }
  return false;
}

function f_edit(gid)
{
  form1.node.value=gid;
  form1.NewNode.value="ON";
  form1.action ="/jsp/type/report/EditReport.jsp";
  form1.submit();
}
function f_edit2(gid)
{
  form1.node.value=gid;
  //form1.NewNode.value='ON';
  form1.action ="/jsp/type/report/EditReport.jsp";
  form1.submit();
}
</script>
</head>
<body id="bodynone">
<h1>酒店新闻</h1>
<form action="?" name="form1" method="POST">
<input type="hidden" name="father" value="<%=father%>"/>
<input type="hidden" name="node" value="<%=node%>"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="NewNode" />
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter" align="left">
  <tr>
    <td nowrap>新闻标题</td>
    <td nowrap>操作</td>
  </tr>
<%
  java.util.Enumeration e = Node.find(sql.toString(),pos,pageSize);
  if (!e.hasMoreElements()) {
    out.print("<tr><td align=center colspan=10>暂无记录</td></tr>");
  }
  while (e.hasMoreElements()) {
    int nod = ((Integer) e.nextElement()).intValue();
    Node obj = Node.find(nod);

%>
  <tr>
    <td>
     <a><%=obj.getSubject(teasession._nLanguage)%></a>
    </td>
    <td>
      <input type="button" value="修改" onclick="f_edit2('<%=nod%>');">
       <input type="button" value="删除" ID="CBDelete" CLASS="CB" onClick="if(confirm('您确认要删除新闻吗？')){window.open('/servlet/DeleteNode?node=<%=nod%>&nexturl=<%=nexturl%>', '_self');this.disabled=true;}">
    </td>
  </tr>
<%}if (count > pageSize) {  %>
    <tr> <td><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
  <%}  %>

   <tr>
    <td colspan="5" align="center">
      <input type="button" value="创建新闻" onclick="f_edit('<%=node%>');">
    </td>
  </tr>
</table>
</form>
</body>
</html>
