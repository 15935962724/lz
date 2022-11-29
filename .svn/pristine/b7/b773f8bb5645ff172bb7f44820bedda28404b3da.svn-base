<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %>
<%@page  import="tea.entity.node.*" %><%@page  import="tea.entity.site.*" %><%@ page import="java.util.*" %><%@ page import="java.io.*" %>
<%@ page import="tea.ui.*" %><%@ page import="tea.html.*" %>
<%@ page import="tea.htmlx.*"%>
<%

request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);

if (teasession._rv == null) {
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}

String community=teasession._strCommunity;
StringBuffer sql = new StringBuffer(" and type = 55 and hidden = 0 and community= "+DbAdapter.cite(teasession._strCommunity));
StringBuffer param = new StringBuffer();
param.append("?id=").append(request.getParameter("id"));
param.append("&community=").append(teasession._strCommunity);

String subject = teasession.getParameter("subject");
if(subject!=null && subject.length()>0)
{
  subject = subject.trim();
  sql.append(" AND node in (SELECT node FROM NodeLayer WHERE subject LIKE "+DbAdapter.cite("%"+subject+"%")+")");
  param.append("&subject = ").append(java.net.URLEncoder.encode(subject,"UTF-8"));
}

int pos = 0, pageSize = 10, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}

count = Node.count(sql.toString());
sql.append(" order by time desc ");


%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<script>
window.name='tar';

function f_x(igd)
{
	window.returnValue=igd;
	window.close();
}
</script>
<h1>演出查询</h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <h2>查询</h2>
<form name="form1" action="?" method="GET" target="tar">
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
  <input type="hidden" name="id" value="<%=request.getParameter("id")%>" >
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td>演出名称:</td>
      <td><input type="text" name="subject" value="<%if(subject!=null)out.print(subject);%>"/></td>

      <td><input type="submit" value="查询"/></td>
    </tr>
  </table>


 
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td nowrap >序号</td>
      <TD nowrap>演出名称</TD>
    </tr>
 

 <% 

    java.util.Enumeration  e =Node.find(sql.toString(),pos,pageSize);
    if(!e.hasMoreElements())
    {
      out.print("<tr><td colspan=10 align=center>暂无演出信息</td></tr>");
    }

    for(int i =1;e.hasMoreElements();i++)
    {
      int nid =((Integer)e.nextElement()).intValue();
      Node nobj = Node.find(nid);

      // hobj.setQuantity(hobj.getQuantity()+1);
      %>
      <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" onclick="f_x('<%=nid %>');" title="点击可以选中演出"  style="cursor:pointer">
        <td width="1"><%=i+pos %></td>
        <td><%=nobj.getSubject(teasession._nLanguage)%></td>       
      </tr>
      <%} %>
      <%if (count > pageSize) {  %>
      <tr><td colspan="10" id="tdpage"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td>  </tr>
      <%
      out.print("<script>document.getElementById('go').style.display='none';</script>");
      }  %>
  </table>
  <br>

  <input type="button" value="关闭"  onClick="javascript:window.close();">

  </form>
  <div id="head6"><img height="6" src="about:blank"></div>
  
<script>
var as=document.getElementById("tdpage");
if(as)
{ 
  as=as.getElementsByTagName("A");

  for(var i=0;i<as.length;i++)
  {
    as[i].setAttribute("target","tar");
  }
}
</script>

</body>
</html>

