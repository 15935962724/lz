<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.resource.Resource"  %>
<%@page import="java.math.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.net.*"%><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession._strCommunity;
String nexturl =request.getRequestURI()+"?"+request.getContextPath();
Resource r=new Resource();
r=r.add("/tea/resource/Workreport").add("/tea/ui/member/offer/Offers").add("/tea/ui/member/offer/ShoppingCarts").add("/tea/ui/member/Glance");
StringBuffer sql=new StringBuffer();
StringBuffer param=new StringBuffer();
param.append("?community=").append(community);
String _strId=(request.getParameter("id"));
param.append("&id=").append(_strId);


String goodsnumber = teasession.getParameter("goodsnumber");
if(goodsnumber!=null && goodsnumber.length()>0)
{
  sql.append(" AND goods IN (SELECT node FROM Node WHERE goodsnumber LIKE "+DbAdapter.cite("%"+goodsnumber+"%")+" )");
  param.append("&goodsnumber=").append(java.net.URLEncoder.encode(goodsnumber,"UTF-8"));
}

String subject = teasession.getParameter("subject");
if(subject!=null && subject.length()>0)
{
  DbAdapter db = new DbAdapter();
  StringBuffer sp =new StringBuffer("/");
  try
  {
     db.executeQuery("SELECT node FROM Node WHERE node IN (SELECT node FROM NodeLayer WHERE subject LIKE "+db.cite("%"+subject+"%")+" )");
     while(db.next())
     {
       sp.append(db.getInt(1)).append("/");
     }
  }finally
  {
    db.close();
  } //AND (a )
  if(sp.toString().split("/").length-1>1)
  {
    sql.append(" AND (");
    for(int i =1;i<sp.toString().split("/").length;i++)
    {
      sql.append(" goods = ").append(Integer.parseInt(sp.toString().split("/")[i]));
      if(sp.toString().split("/").length-1!=i)
      {
        sql.append(" or ");
      }
    }
    sql.append(")");
  }else
  {
    sql.append(" AND goods = 0");
  }
  param.append("&subject=").append(java.net.URLEncoder.encode(subject,"UTF-8"));
}

int workproject = 0;
if(teasession.getParameter("workproject")!=null && teasession.getParameter("workproject").length()>0)
{
  workproject = Integer.parseInt(teasession.getParameter("workproject"));
  if(workproject>0){
    sql.append(" AND workproject =").append(workproject);
    param.append("&workproject=").append(workproject);
  }
}

String time_c = teasession.getParameter("time_c");
if(time_c!=null && time_c.length()>0)
{
  sql.append(" AND buytime >=").append(DbAdapter.cite(time_c));
  param.append("&time_c=").append(time_c);
}
String time_d = teasession.getParameter("time_d");
if(time_d!=null && time_d.length()>0)
{
  sql.append(" AND buytime <=").append(DbAdapter.cite(time_d));
  param.append("&time_d=").append(time_d);
}

int pos=0,size=10;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}

param.append("&pos=");

int count=SalesRecord.count(teasession._strCommunity,sql.toString());

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>
<script>
function f_edit(igd)
{
  form1.srid.value = igd;
  form1.action="/jsp/admin/workreport/EditSalesRecord.jsp";
  form1.submit();
}
function f_delete(igd)
{
  if(confirm('您确定要删除此内容吗？')){
    form1.srid.value= igd;
    form1.act.value= 'delete';
    form1.action = "/servlet/EditSalesRecord";
    form1.submit();
  }
}
</script>
<!--选择会员-->
<h1><%=r.getString(teasession._nLanguage,"销售记录管理")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<form name="form1" METHOD="GET" action="?" onSubmit="">
<input type=hidden name="community" value="<%=community%>"/>
<input type=hidden name="nexturl" value="<%=nexturl%>"/>
<input type=hidden name="srid" value=""/>
<input type="hidden" name="act" value="delete"/>
<input type=hidden name="id" value="<%=request.getParameter("id")%>"/>


<h2><%=r.getString(teasession._nLanguage,"查询")%></h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
 <td><%=r.getString(teasession._nLanguage,"商品编号")%>：</td>
  <td><input name="goodsnumber" type="text" value="<%if(goodsnumber!=null)out.print(goodsnumber);%>" /></td>
  <td><%=r.getString(teasession._nLanguage,"商品名称")%>：</td>
  <td><input name="subject" type="text" value="<%if(subject!=null)out.print(subject);%>" /></td>
    </tr>
  <tr>
 <td><%=r.getString(teasession._nLanguage,"客户或项目")%>：</td>
 <td><select name="workproject" >
   <option value="0">-------------</option>
<%
java.util.Enumeration we=Workproject.find(teasession._strCommunity,"",0,Integer.MAX_VALUE);
while(we.hasMoreElements())
{
  int woid=((Integer)we.nextElement()).intValue();
  Workproject obj=Workproject.find(woid);
  out.print("<option value="+woid);
  if(woid==workproject){
    out.print(" SELECTED ");
  }
  out.print(" >"+obj.getName(teasession._nLanguage));
}
%>
</select>
  <input type="button" value="..." onClick="window.open('/jsp/admin/workreport/Workprojects_3.jsp?community=<%=teasession._strCommunity%>&fieldname=form1.workproject','','height=500,width=500,left=200,top=100,scrollbars=yes,toolbar=no,status=no,menubar=no,location=no,resizable=yes');"/>
</td>
<td>购买日期：</td>
<td>&nbsp;
      从&nbsp;<input name="time_c" size="7"  value="<%if(time_c!=null)out.print(time_c);%>"><A href="###"><img onclick="showCalendar('form1.time_c');" src="/tea/image/public/Calendar2.gif" align="top"/></a>&nbsp;
        到&nbsp;<input name="time_d" size="7"  value="<%if(time_d!=null)out.print(time_d);%>"><A href="###"><img onclick="showCalendar('form1.time_d');" src="/tea/image/public/Calendar2.gif" align="top"/></a>&nbsp;</td>
<td><input type="submit" value="<%=r.getString(teasession._nLanguage,"查询")%>"  onclick=""></td>
</tr>
</table>


<h2><%=r.getString(teasession._nLanguage,"销售记录列表")+" ("+count+")"%></h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr ID=tableonetr>
    <td nowrap><%=r.getString(teasession._nLanguage,"商品编号")%></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"商品名称")%></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"客户信息")%></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"购买日期")%></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"购买数量")%></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"操作")%></td>
  </tr>
<%
   java.util.Enumeration e = SalesRecord.find(teasession._strCommunity,sql.toString(),pos,size);
   if(!e.hasMoreElements())
   {
     out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
   }
   while(e.hasMoreElements()){
     int srid = ((Integer)e.nextElement()).intValue();
     SalesRecord srobj = SalesRecord.find(srid);
     Node nobj = Node.find(srobj.getGoods());
     Goods gobj = Goods.find(srobj.getGoods());
     Workproject wobj = Workproject.find(srobj.getWorkproject());

   %>
   <tr onMouseOver=bgColor='#BCD1E9'; onMouseOut=bgColor=''; style="cursor:hand;">
     <td ><%=nobj.getNumber()%></td>
     <td ><%=nobj.getSubject(teasession._nLanguage)%></td>
     <td ><%=wobj.getName(teasession._nLanguage) %></td>
     <td align="center"><%=srobj.getBuytimeToString()%></td>
     <td align="center"><%=srobj.getSquantity() %></td>
     <td align="center"><a href="#" onclick="f_edit('<%=srid%>');">  <img alt="" src="/tea/image/public/icon_edit.gif" title="编辑" />

</a>&nbsp;<a href="#" onclick="f_delete('<%=srid%>');"> <img alt="" src="/tea/image/public/del.gif" title="删除" /></a> </td>
   </tr>
   <%}%>
<%if(count>size){ %>
<tr><td colspan="5" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString(),pos,count,size)%></td></tr>
<%}%>
</table>
</form>
<br>
<input type="button" value="添加销售记录" onclick="window.open('/jsp/admin/workreport/EditSalesRecord.jsp?nexturl=<%=nexturl%>','_self');">

<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>


