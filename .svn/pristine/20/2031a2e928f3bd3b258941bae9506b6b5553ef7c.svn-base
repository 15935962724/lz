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

TeaSession teasession = new TeaSession(request);
if (teasession._rv == null) {
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}

StringBuffer sql = new StringBuffer();
StringBuffer param = new StringBuffer();
param.append("?id=").append(request.getParameter("id"));
param.append("&community=").append(teasession.getParameter("community"));

String members =teasession._rv.toString();
Doctoradmin daobjs = Doctoradmin.find(Doctoradmin.isMemberDaid(teasession._strCommunity,members));

//省
if(daobjs.getSheng()>0)
{
  Provinces pobj1 = Provinces.find(daobjs.getSheng());
  sql.append(" AND provincial = ").append(DbAdapter.cite(pobj1.getProvincity()));
}

//市
if(daobjs.getShi()>0)
{
  Provinces pobj2= Provinces.find(daobjs.getShi());
  sql.append(" AND city = ").append(DbAdapter.cite(pobj2.getProvincity()));
}
//医院名称
String honame = teasession.getParameter("honame");
if(honame!=null && honame.length()>0)
{
  honame = honame.trim();
  sql.append(" AND honame LIKE ").append(DbAdapter.cite("%"+honame+"%"));
  param.append("&honame=").append(java.net.URLEncoder.encode(honame,"UTF-8"));
}

int pos = 0, pageSize = 10, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
count = Hospital.count(sql.toString());


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
     <td>医院名称:</td>
     <td><input type="text" name="honame" value="<%if(honame!=null)out.print(honame);%>"/></td>
     <td><input type="submit" value="查找"/></td>
   </tr>
 </table>

<h2>列表&nbsp;(&nbsp;共有全国医院<%=count%>个&nbsp;)</h2>


  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td nowrap>序号</td>
      <td nowrap>医院名称</td>
      <td nowrap>医院省市</td>
      <td nowrap>医院市县</td>
      <td nowrap>医院等级</td>
    </tr>
<%
java.util.Enumeration  e = Hospital.find(sql.toString(),pos,pageSize);
if(!e.hasMoreElements())
{
  out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
}
 for(int i =1;e.hasMoreElements();i++)
 {
   int hid =((Integer)e.nextElement()).intValue();
   Hospital hobj= Hospital.find(hid);
   String hname = hobj.getHoname();
   if(hobj.getHoname()!=null && hobj.getHoname().length()>0)
   {
     hname= hobj.getHoname().trim();
   }
%>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" title="点击,选择医院"  onclick="f_button('/<%=hid%>/<%=hname%>/');"  style=cursor:pointer>
<td><%=i +pos%></td>
<td><%=hname%></td>
<td><%=hobj.getProvincial()%></td>
<td><%=hobj.getCity()%></td>
<td><%if(hobj.getGrade()!=null && hobj.getGrade().length()>0)out.print(hobj.getGrade().trim());%></td>
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
