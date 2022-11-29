<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.admin.orthonline.*"%>
<%@page import="java.util.Date"%>
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

StringBuffer sql = new StringBuffer(" AND member!='' AND community =").append(DbAdapter.cite(teasession.getParameter("community")));
StringBuffer param = new StringBuffer();
param.append("?id=").append(request.getParameter("id"));
param.append("&community=").append(teasession.getParameter("community"));
String members =teasession._rv.toString();
Doctoradmin daobjs = Doctoradmin.find(Doctoradmin.isMemberDaid(teasession._strCommunity,members));
//sql.append(" AND  member not in (select member from Doctoradmin)");

//用户的省
 //二级用户
 if(daobjs.getDatype()==367)
 {
   sql.append(" AND member in (select member from Doctoradmin where sheng = "+daobjs.getSheng()+")  ");

 }
if(daobjs.getDatype()==368)//说明是三级用户 只能修改四级的用户
{
  sql.append(" AND member in (select member from Doctoradmin where sheng = "+daobjs.getSheng()+")  ");
  sql.append(" AND member in (select member from Doctoradmin where shi = "+daobjs.getShi()+")  ");
  sql.append(" AND member in (select member from Doctoradmin where datype = 369)  ");
 // sql.append(" AND datype=").append(369);
}
//医院名称
String member = teasession.getParameter("member");
if(member!=null && member.length()>0)
{
  member = member.trim();
  sql.append(" AND member LIKE ").append(DbAdapter.cite("%"+member+"%"));
  param.append("&member=").append(java.net.URLEncoder.encode(member,"UTF-8"));
}



int pos = 0, pageSize = 10, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
count = Profile.count(sql.toString());

%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>医院列表</title>
</head>
<body id="bodynone">
<script>
window.name='tar';
function f_button(igd)
{
  window.returnValue=igd;
  window.close();
}
</script>
<h1>查找医院</h1>
<div id="head6"><img height="6" src="about:blank"></div>
 <h2>查询</h2>
   <form action="?" name="form1"  method="GET" target="tar"><!--/servlet/EditDoctor-->
   <input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>
   <input type="hidden" name="community" value="<%=teasession.getParameter("community")%>"/>
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
   <tr>
     <td>用户名:</td>
     <td><input type="text" name="member" value="<%if(member!=null)out.print(member);%>"/></td>
     <td><input type="submit" value="查找"/></td>
   </tr>
 </table>

<h2>列表&nbsp;(&nbsp;共有用户<%=count%>个&nbsp;)</h2>


  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td nowrap>序号</td>
      <td nowrap>用户名</td>
      <td nowrap>用户姓名</td>
    </tr>
<%
java.util.Enumeration  e = Profile.find(sql.toString(),pos,pageSize);
if(!e.hasMoreElements())
{
  out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
}
 for(int i =1;e.hasMoreElements();i++)
 {
   String m = ((String)e.nextElement()).intern();
   Profile pobj= Profile.find(m);
   String sp = "/"+m+"/"+pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage)+"/"+pobj.getPassword()+"/";
%>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" title="点击,选择医院"  onclick="f_button('<%=sp%>');"  style=cursor:pointer>
<td><%=i +pos%></td>
<td><%=m%></td>
<td><%=pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage)%></td>
</tr>
<%} %>
<%if (count > pageSize) {  %>
<tr> <td colspan="10"  id="tdpage"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
<%
 out.print("<script>document.getElementById('go').style.display='none';</script>");
}  %>
  </table>


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
<br>
  <input type="button" value="关闭"  onClick="javascript:window.close();">
</body>
</html>
