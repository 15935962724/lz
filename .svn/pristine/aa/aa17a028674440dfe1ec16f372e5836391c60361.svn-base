<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.node.*"%>
<jsp:useBean id="sms" scope="page" class="tea.entity.node.Sms"/>
<%request.setCharacterEncoding("UTF-8");
  TeaSession teasession = new TeaSession(request);
  Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");
  StringBuffer param = new StringBuffer("?community=").append(teasession._strCommunity);
  StringBuffer sql = new StringBuffer(" and father=0");
String act = request.getParameter("act");

int cid = 0;
if(request.getParameter("cid")!=null && request.getParameter("cid").length()>0)
{
  cid = Integer.parseInt(request.getParameter("cid"));
}
City cc = City.find(cid);
String nexturl = request.getParameter("nexturl");
String cityname =request.getParameter("cityname");
String cn = null;
if("amend".equals(act))
{
  cn = cc.getCityname();
}

 if(cityname!=null && cityname.length()>0)
 {
   if(cid>0)
   {
     cc.set(0,cityname);
   }else
   {
        City.create(0,cityname,teasession._rv.toString(),teasession._strCommunity);
   }

   response.sendRedirect(nexturl);
   return;
 }
 if("delete".equals(act))
 {
   cc.delete();
   cc.delete(cid);
//   response.sendRedirect(nexturl);
//   return;
 }
  int count = City.count(teasession._strCommunity,sql.toString());
  int pos = 0;
  int pageSize =30;
  if (teasession.getParameter("Pos") != null) {
    pos = Integer.parseInt(teasession.getParameter("Pos"));
  }
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body id="bodynone">
<script type="">
function f_delete()
{
   if(confirm('确实要删除吗？'))
   {
      return true;
   }else
   {
     return false;
   }
}
</script>
<div id="tablebgnone" class="register">
  <h1>省/城市</h1>
  <div id="head6">
    <img height="6" src="about:blank" alt="">
  </div>
  <FORM name="form1" METHOD="POST" action="?">
  <input type="hidden" name="act" value="pagerange">
  <input type="hidden" name="cid" value="<%=cid%>" />
     <input type="hidden" name="id" value="<%=request.getParameter("id")%>">
  <input type="hidden" name="nexturl" value="<%=request.getRequestURL()%>"/>
  <table>
    <tr>
      <td>省/城市名称：
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="text" name="cityname" value="<%if(cn!=null)out.print(cn);%>"/>
        <input type="submit" value="添加"/>
      </td>
    </tr>
  </table>
  </FORM>
      <h2>省/城市列表</h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td nowrap>名称</td>
      <td nowrap>操作</td>
    </tr>
    <%
    java.util.Enumeration e = City.find(teasession._strCommunity,sql.toString(),pos,pageSize);
    if(!e.hasMoreElements())
    {
      out.print("<tr><td align=center colspan=10>暂无记录</td></tr>");
    }
    while(e.hasMoreElements())
    {
      int id = ((Integer)e.nextElement()).intValue();
      City c = City.find(id);
      %>
      <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
        <td>
          <%=c.getCityname()%>
        </td>
        <td>
          <a href="/jsp/registration/secondregion.jsp?father=<%=id%>&act=erji">二级区域</a>
          <a href="/jsp/registration/pagerange.jsp?cid=<%=id%>&act=amend">修改</a>
          <a href="/jsp/registration/pagerange.jsp?act=delete&cid=<%=id%>" onClick="return f_delete();">删除</a>
        </td>
      </tr>
       <%} if (count > pageSize) {  %>
    <tr>
      <td>&nbsp;</td>
      <td align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage, request.getRequestURI()+param.toString() + "&Pos=", pos, count,pageSize)%> </td>
    </tr>
  <%}%>
  </table>
    <script language="JavaScript">
 anole('',1,'#F2F2F2','#DEEEDB','','');
  /*tr_tableid, // table id
  num_header_offset,// 表头行数
  str_odd_color, // 奇数行的颜色
  str_even_color,// 偶数行的颜色
  str_mover_color, // 鼠标经过行的颜色
  str_onclick_color // 选中行的颜色
  */
  </script>
</body>
</html>
</html>
