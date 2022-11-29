<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.erp.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.admin.erp.semi.*" %>
<%@include file="/jsp/include/Canlendar4.jsp" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String nexturl = request.getRequestURI()+"?"+request.getContextPath();

int ids =0;
if(teasession.getParameter("ids")!=null && teasession.getParameter("ids").length()>0)
{
  ids = Integer.parseInt(teasession.getParameter("ids"));
}

SemiGoods sgobj = SemiGoods.find(ids);
//out.print(request.getRequestURI()+"?"+request.getContextPath());
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
  <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"/>
  <META HTTP-EQUIV="Expires" CONTENT="0"/>
  <script type="">
  function find_sub()
  {
    if(form1.goodsnumber.value=="")
    {
      alert("商品编号不能为空，请重新填写！");
      return false;
    }
    if(form1.subject.value=="")
    {
      alert("商品名称不能为空，请重新填写！");
      return false;
    }
    if(form1.spec.value=="")
    {
      alert("商品规格不能为空，请重新填写！");
      return false;
    }
//    if(form1.measure.value=="")
//    {
//      alert("单位不能为空，请重新填写！");
//      return false;
//    }
//    if(form1.supply.value=="")
//    {
//      alert("进价不能为空，请重新填写！");
//      return false;
//    }
  }
  </script>
  <body>
  <h1>半成品管理</h1>
  <form name="form1" action="/servlet/EditSemiGoods" method="POST" >
  <input type="hidden" name="nexturl" value="<%=nexturl%>"/>
  <input type="hidden" name="ids" value="<%=ids%>"/>
  <input type="hidden" name="act" value="EditSemiGoodsadd"/>
  <input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>
  <h2>半成品管理</h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
      <td nowrap align="right">商品编号：&nbsp;</td><td><input type="text" name="goodsnumber" value="<%if(sgobj.getGoodsnumber()!=null)out.print(sgobj.getGoodsnumber());%>"/></td>
    </tr>
    <tr>
      <td nowrap align="right">商品名称：&nbsp;</td><td><input type="text" name="subject" value="<%if(sgobj.getSubject()!=null)out.print(sgobj.getSubject());%>"/></td>
    </tr>
     <tr>
      <td nowrap align="right">商品规格：&nbsp;</td><td><input type="text" name="spec" value="<%if(sgobj.getSpec()!=null)out.print(sgobj.getSpec());%>"/></td>
    </tr>
      <tr>
      <td nowrap align="right">商品单位：&nbsp;</td><td><input type="text" name="measure" value="<%if(sgobj.getMeasure()!=null)out.print(sgobj.getMeasure());%>"/></td>
    </tr>
     <tr>
      <td nowrap align="right">备注：&nbsp;</td><td><textarea name="info" cols="18" rows="3"><%if(sgobj.getInfo()!=null)out.print(sgobj.getInfo());%></textarea></td>
    </tr>
    <tr>
      <td nowrap colspan="2" align="center"><input type="submit" value="提交" onclick="return find_sub()"/></td>
    </tr>
  </table>
  </form>
  </body>
</html>
