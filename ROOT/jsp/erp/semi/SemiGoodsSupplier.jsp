<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.erp.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.admin.erp.*" %>
<%@page import="tea.entity.admin.erp.semi.*" %>
<%@include file="/jsp/include/Canlendar4.jsp" %>
<%@ page import="java.util.*"%>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
StringBuffer sql = new StringBuffer();
StringBuffer param = new StringBuffer();

String nexturl = request.getRequestURI()+"?"+request.getContextPath();

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


int pos = 0, pageSize = 10, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
count =SemiGoods.count(teasession._strCommunity,sql.toString());
param.append("?id=").append(request.getParameter("id"));
//param.append("&nexturl=").append(java.net.URLEncoder.encode(nexturl,"UTF-8"));
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
      <META HTTP-EQUIV="Expires" CONTENT="0">

        <body>
        <h1>半成品关联供应商</h1>
        <form name="form1" action="?" onsubmit="return f_submit();">
        <input type="hidden" name="nexturl" value="<%=nexturl%>"/>

        <input type="hidden" name="act"/>
        <input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>
        <h2>查询</h2>
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
        </form>
        <form action="">
        <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
          <tr id="tableonetr">
            <td  width="1"></td><!-- <input type="checkbox" name="checkall" onclick="CheckAll('checkname','checkall');">-->
              <td nowrap>商品编号</td>
              <td nowrap>商品名称</td>
              <td nowrap>备注</td>
              <td nowrap></td>
          </tr>
          <%
          Enumeration eu = SemiGoods.findByCommunity(teasession._strCommunity,sql.toString(),pos,10);
          if(!eu.hasMoreElements())
          {
            %>
            <tr><td colspan="5">暂无信息</td></tr>
            <%
          }
          for(int i=0;eu.hasMoreElements();i++)
          {
            int sgid = Integer.parseInt(String.valueOf(eu.nextElement()));
            SemiGoods sgobj = SemiGoods.find(sgid);
            %>
            <tr>
             <td nowrap="nowrap"><%=i+1%></td>
              <td nowrap="nowrap"><%=sgobj.getGoodsnumber()%></td>
              <td nowrap="nowrap"><%=sgobj.getSubject()%></td>
              <td nowrap="nowrap"><%=sgobj.getInfo()%></td>
              <td nowrap="nowrap">
               <input type="button"  value="设置供货商" onclick="window.open('/jsp/erp/semi/EditSemiGoodsSupplier.jsp?sgid=<%=sgid%>','_self')"/>
              </td>
            </tr>
            <%
          }
          %>
          <%if (count > pageSize) {  %>
   <tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
  <%}  %>
        </table>
        <br>

        </form>
        </body>
</html>
