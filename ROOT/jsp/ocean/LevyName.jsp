<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.volunteer.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="java.io.*" %>
<%@page import="tea.entity.ocean.*"%>

<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);


int delid=0;
if(teasession.getParameter("delid")!=null && teasession.getParameter("delid").length()>0)
{
  delid =Integer.parseInt(teasession.getParameter("delid"));
  LevyName.delete(delid);
}


StringBuffer param=new StringBuffer();
StringBuffer sql=new StringBuffer();
param.append("?community="+teasession._strCommunity);
String menu_id=(request.getParameter("id"));
if(menu_id!=null&&menu_id.length()>0)
{
  param.append("&id=").append(menu_id);
}
param.append("&id=").append(request.getParameter("id"));

String dolphin ="",bigprincess="",littleprincess="",firstname="",tel="";
if(teasession.getParameter("dolphin")!=null && teasession.getParameter("dolphin").length()>0)
{
  dolphin= teasession.getParameter("dolphin");
  sql.append(" and dolphin =").append(DbAdapter.cite(dolphin));
  param.append("&dolphin=").append(dolphin);
}
if(teasession.getParameter("bigprincess")!=null && teasession.getParameter("bigprincess").length()>0)
{
  bigprincess= teasession.getParameter("bigprincess");
  sql.append(" and bigprincess =").append(DbAdapter.cite(bigprincess));
  param.append("&bigprincess=").append(bigprincess);
}
if(teasession.getParameter("littleprincess")!=null && teasession.getParameter("littleprincess").length()>0)
{
  littleprincess= teasession.getParameter("littleprincess");
  sql.append(" and littleprincess =").append(DbAdapter.cite(littleprincess));
  param.append("&littleprincess=").append(littleprincess);
}
if(teasession.getParameter("firstname")!=null && teasession.getParameter("firstname").length()>0)
{
  firstname= teasession.getParameter("firstname");
  sql.append(" and firstname =").append(DbAdapter.cite(firstname));
  param.append("&firstname=").append(firstname);
}
if(teasession.getParameter("tel")!=null && teasession.getParameter("tel").length()>0)
{
  tel= teasession.getParameter("tel");
  sql.append(" and tel =").append(DbAdapter.cite(tel));
  param.append("&tel=").append(tel);
}
int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
param.append("&pos=").append(pos);


int count=LevyName.count(teasession._strCommunity,sql.toString());
%>
<html>
<head>
<link href="/tea/CssJs/bj-sea.css" rel="stylesheet" type="text/css">
<script type="" >
function f_order(v)
{
  var aq=form1.aq.value=="true";
  if(form1.o.value==v)
  {
    form1.aq.value=!aq;
  }else
  {
    form1.o.value=v;
  }
  form1.action="?";
  form1.submit();
}
</script>
</head>
<body>
<h1>征集名称列表</h1>

<form action="?" method="GET">
<input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>
<table  id="tablecenter">
<tr>
<td>白鲸王子名字：</td><td><input name="dolphin" type="text" value="<%if(dolphin!=null)out.print(dolphin);%>" /></td>
<td>白鲸公主名字：</td><td><input name="bigprincess" type="text" value="<%if(bigprincess!=null)out.print(bigprincess);%>" /></td>
<!-- <td>小公主名字：</td><td><input name="littleprincess" type="text" value="<%if(littleprincess!=null)out.print(littleprincess);%>" /></td>-->
</tr>
<tr>
<td>姓名：</td><td><input name="firstname" type="text" value="<%if(firstname!=null)out.print(firstname);%>" /></td>
<td>联系电话：</td><td><input name="tel" type="text" value="<%if(tel!=null)out.print(tel);%>" /></td><td  colspan="2">
<input type="submit" value="提交" /></td>
</tr>
</table>
</form>
<h2>列表（<%=count%>）</h2>
<form action="/servlet/EditLevyNameExcel" name="form1" METHOD=POST >
<input  type="hidden" value="Levyname" name="act"/>
<input type="hidden" name="sql" value="<%=sql.toString()%>">
<input type="hidden" name="files" value="Levyname">
<input type="hidden" name="count" value="<%=count%>">
<table id="tablecenter">
<tr>
<td>序号</td><td>白鲸王子的名字</td><td>白鲸公主的名字</td>
<!-- <td>小公主的名字</td> -->
<td>姓名</td><td>性别</td><td>身份证</td><td>联系电话</td><td> </td>
</tr>
<%
java.util.Enumeration eu = LevyName.findByCommunity(teasession._strCommunity,sql.toString(),pos,10);
if(!eu.hasMoreElements())
{
  %>
  <tr><td nowrap="nowrap" align="center" colspan="9">暂无信息</td></tr>
  <%
}
for(int i=1;eu.hasMoreElements();i++)
{
  int lid = Integer.parseInt(String.valueOf(eu.nextElement()));
  LevyName lobj = LevyName.find(lid);
  String sex = lobj.getSex()!=0 ? "男" : "女";
  %>
  <tr>
    <td><%=i%></td>
    <td><%if(lobj.getDolphin()!=null)out.print(lobj.getDolphin());%></td>
    <td><%if(lobj.getBigprincess()!=null)out.print(lobj.getBigprincess());%></td>
    <!-- 
    <td><%if(lobj.getLittleprincess()!=null)out.print(lobj.getLittleprincess());%></td>
    
     -->
    <td><%if(lobj.getFirstname()!=null)out.print(lobj.getFirstname());%></td>
    <td><%=sex%></td>
    <td><%if(lobj.getCard()!=null)out.print(lobj.getCard());%></td>
    <td><%if(lobj.getTel()!=null)out.print(lobj.getTel());%></td>
    <td><input type="button" value="编辑"  onclick="window.open('/jsp/ocean/EditLevyname.jsp?ids=<%=lid%>','_self')"/>
    <input name="按钮" type="button" value="删除" onClick="if(confirm('确认删除？')){window.open('/jsp/ocean/LevyName.jsp?delid=<%=lid%>', '_self');this.disabled=true;};" ></td>
  </tr>
  <% 
}
%>
 <tr><td colspan="9"  align="center" style="padding-right:5px;"> <%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,10)%></td></tr>
 <tr><td nowrap="nowrap" align="center" colspan="9"><input type="submit" value="导出" /></td></tr>
</table>
</form>
</body>
</html>
