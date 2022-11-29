<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter" %><%@page import="tea.resource.Resource" %><%@page import="tea.entity.eon.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.ui.TeaSession" %><%@ page import="tea.entity.league.*" %>
<%@page import="tea.entity.admin.erp.semi.*" %><%@ page import="java.util.*"%><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


StringBuffer param=new StringBuffer("?node="+teasession._nNode);
StringBuffer sql=new StringBuffer("");

String goodsnumber = "",subject="",spec="";
if(teasession.getParameter("goodsnumber")!=null && teasession.getParameter("goodsnumber").length()>0)
{
  goodsnumber=teasession.getParameter("goodsnumber");
  sql.append(" and goodsnumber=").append(DbAdapter.cite(goodsnumber));
  param.append("&goodsnumber=").append(DbAdapter.cite(goodsnumber));
}
if(teasession.getParameter("subject")!=null && teasession.getParameter("subject").length()>0)
{
  subject=teasession.getParameter("subject");
  sql.append(" and subject=").append(DbAdapter.cite(subject));
  param.append("&subject=").append(DbAdapter.cite(subject));
}
if(teasession.getParameter("spec")!=null && teasession.getParameter("spec").length()>0)
{
  spec=teasession.getParameter("spec");
  sql.append(" and spec=").append(DbAdapter.cite(spec));
  param.append("&spec=").append(DbAdapter.cite(spec));
}
int count=0;
int pos=0;
int pageSize=10;
if( teasession.getParameter("pos")!=null)
{
  pos=Integer.parseInt(  teasession.getParameter("pos"));
}
count =SemiGoods.count(teasession._strCommunity,sql.toString());
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"/>
<META HTTP-EQUIV="Expires" CONTENT="0"/>
<body>
<script type="text/javascript">
window.name='tar';
function f_button(igd)
{
  window.returnValue=igd;
  window.close();
}
</script>
<h1>选择半成品</h1>
<br>
<h2>查询</h2>
<form name="form1" action="?" method="GET" target="tar">
<input type="hidden" name="act"/>
<input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td nowrap>商品编号：&nbsp;<input type="text" name="goodsnumber" value="<%if(goodsnumber!=null)out.print(goodsnumber);%>"/></td>
      <td nowrap>商品名称：&nbsp;<input type="text" name="subject" value="<%if(subject!=null)out.print(subject);%>"/></td>
  </tr>
  <tr>
    <td nowrap>商品规格：&nbsp;<input type="text" name="spec" value="<%if(spec!=null)out.print(spec);%>"/></td>
      <td><input type="submit" value="查询"/></td>
  </tr>
</table>
<h2>列表( <span id=spancount>0</span> )</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
      <td nowrap>商品编号</td>
      <td nowrap>商品名称</td>
      <td nowrap>规格型号</td>
      <td nowrap>单位</td>
      <td nowrap>备注</td>
  </tr>
  <%
  DbAdapter dbadapter=new DbAdapter();
  try
  {
    Enumeration eu = SemiGoods.findByCommunity(teasession._strCommunity,sql.toString(),pos,10);
    if(!eu.hasMoreElements())
    {
      %><tr><td colspan="5">暂无信息</td></tr><%
    }
    for(int i=0;eu.hasMoreElements();i++)
    {
      int sgid = Integer.parseInt(String.valueOf(eu.nextElement()));
      SemiGoods sgobj = SemiGoods.find(sgid);
      %>
      <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" title="点击选择商品"  onclick="f_button('<%=sgid%>');"  style=cursor:pointer>
        <td nowrap="nowrap"><%=sgobj.getGoodsnumber()%></td>
        <td nowrap="nowrap"><%=sgobj.getSubject()%></td>
        <td nowrap="nowrap"><%=sgobj.getSpec()%></td>
        <td nowrap="nowrap"><%=sgobj.getMeasure()%></td>
        <td nowrap="nowrap"><%=sgobj.getInfo()%></td>
      </tr>
      <%
      }
    }catch(Exception e)
    {
      e.printStackTrace();
    }finally
    {
      dbadapter.close();
    }
    %>
    <%if (count > pageSize) { %>
    <tr> <td colspan="10" id="tdpage"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
    <%
    out.print("<script>document.getElementById('go').style.display='none';</script>");
  }  %>
  </table>
  <br>
  <input type="button" value="关闭"  onClick="javascript:window.close();">
</form>
<br>

<script type="">spancount.innerHTML="<%=count%>";
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
