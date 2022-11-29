<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
	response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
	return;
}

String _strId=request.getParameter("id");

if(request.getParameter("delete")!=null)
{
  String nodes[]=request.getParameterValues("Nodes");
  if(nodes!=null)
  for(int index=0;index<nodes.length;index++)
  {
    Node obj = Node.find(Integer.parseInt(nodes[index]));
    obj.delete(teasession._nLanguage);
  }
  response.sendRedirect("/jsp/type/bbs/BBSManage.jsp?node="+teasession._nNode);
  return;
}else
if(request.getParameter("parktop")!=null)
{
  String nodes[]=request.getParameterValues("Nodes");
  if(nodes!=null)
  for(int index=0;index<nodes.length;index++)
  {
    BBS obj = BBS.find(Integer.parseInt(nodes[index]),teasession._nLanguage);
    obj.setParktop(!obj.isParktop());
  }
  response.sendRedirect("/jsp/type/bbs/BBSManage.jsp?node="+teasession._nNode);
  return;
}else
if(request.getParameter("quintessence")!=null)
{
  String nodes[]=request.getParameterValues("Nodes");
  if(nodes!=null)
  for(int index=0;index<nodes.length;index++)
  {
    BBS obj = BBS.find(Integer.parseInt(nodes[index]),teasession._nLanguage);
    obj.setQuintessence(!obj.isQuintessence());
  }
  response.sendRedirect("/jsp/type/bbs/BBSManage.jsp?node="+teasession._nNode);
  return;
}

Resource r=new Resource();
r.add("/tea/resource/BBS");

String father=request.getParameter("father");
String from=request.getParameter("from");
String to=request.getParameter("to");
String creator=request.getParameter("creator");
String keywords=request.getParameter("keywords");
int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}

StringBuffer param=new StringBuffer();
param.append("?community=").append(teasession._strCommunity);
param.append("&id=").append(_strId);

StringBuffer sql=new StringBuffer();
sql.append(" AND community=").append(DbAdapter.cite(teasession._strCommunity));

if(father!=null&&father.length()>0)
{
  sql.append(" AND father=").append(father);
  param.append("&father=").append(father);
}
if(from!=null&&from.length()>0)
{
  sql.append(" AND time>=").append(DbAdapter.cite(from));
  param.append("&from=").append(from);
}
if(to!=null&&to.length()>0)
{
  sql.append(" AND time<").append(DbAdapter.cite(to));
  param.append("&to=").append(to);
}
if(creator!=null&&creator.length()>0)
{
  sql.append(" AND vcreator LIKE ").append(DbAdapter.cite("%"+creator+"%"));
  param.append("&creator=").append(java.net.URLEncoder.encode(creator,"UTF-8"));
}
if(keywords!=null&&keywords.length()>0)
{
  sql.append(" AND node IN (SELECT node FROM NodeLayer WHERE subject LIKE ").append(DbAdapter.cite("%"+keywords+"%")).append(" OR content LIKE ").append(DbAdapter.cite("%"+keywords+"%")).append(")");
  param.append("&keywords=").append(java.net.URLEncoder.encode(keywords,"UTF-8"));
}
param.append("&pos=");




%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<script type="">
function fclick(obj)
{
  var node=0;
  if(obj.length)
  for(var index=0;index<obj.length;index++)
  {
    if(obj[index].checked)
    {
      node=obj[index].value;
      break;
    }
  }else
  {
    node=obj.value;
  }
  if(node==0)
  {
    alert('<%=r.getString(teasession._nLanguage,"InvalidSelect")%>');
  }else
  {
    window.open("/jsp/type/bbs/BBSReplyManage.jsp?node="+node,"_self");
  }
}
</script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "用户统计")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<h2><%=r.getString(teasession._nLanguage, "列表")%></h2>
<form action="?" method="get" name="form2">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=_strId%>"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td >会员</td>
      <td >登录次数</td>
      <td>下订单数</td>
      <td>已受理订单数</td>


     </tr>
 <tr>
         <td ><a href="详情">会员1</a></td>
      <td >10</td>
      <td>5</td>
      <td >4</td>

      </tr>

       <tr>
         <td ><a href="详情">会员2</a></td>
      <td >10</td>
      <td>5</td>
      <td >4</td>

      </tr>
  </table>
  <input name="" onclick="fclick(form2.Nodes);" type="button" value="导出Excel表格">
 </form>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
