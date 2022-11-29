<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.htmlx.*,tea.entity.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*,tea.entity.member.*" %>
<%@ page import="tea.entity.site.*,tea.entity.node.*" %>
<%@ page import="tea.entity.member.Profile" %>
<%@ page import="tea.db.*" %>
<jsp:useBean id="sms" scope="page" class="tea.entity.node.Sms" />
<%
 request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");

Community community=Community.find(teasession._strCommunity);

  StringBuffer param=new StringBuffer("?community=").append(teasession._strCommunity);
  StringBuffer sql=new StringBuffer();


   int count=Destine.countMember(sql.toString());
  int pos=0;
  int pageSize=20;
  if(teasession.getParameter("Pos")!=null)
  {
    pos=Integer.parseInt(teasession.getParameter("Pos"));
  }
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script language="javascript" src="/tea/CssJs/AreaCityData_zh_CN.js"></script>
<script language="javascript" src="/tea/CssJs/AreaCityData<%=Common.CHATSET[teasession._nLanguage]%>.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body id="bodynone" >
<script type="">
function f_kind()
{
  form1.act.value="membership";
  form1.action='/servlet/EditDestine';
  form1.submit();
}
</script>
<div id="jspbefore" style="display:none">
<%=community.getJspBefore(teasession._nLanguage)%>
</div>
<div id="tablebgnone" class="register">
<h1><%=r.getString(teasession._nLanguage, "统计会员情况")%></h1>
<h2><%=r.getString(teasession._nLanguage,"列表")%></h2>
<div id="head6"><img height="6" src="about:blank" alt=""></div>
  <FORM name="form1" METHOD="POST" ACTION="">
  <input type="hidden" name="act"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter" >
   <tr id="tableonetr">
  <td>会员</td><td>登陆次数</td><td>下订单数</td><td>已受理订单数</td>
  </tr>
  <%
   java.util.Enumeration e = Destine.findmember(teasession._strCommunity,sql.toString(),pos,pageSize);
   while(e.hasMoreElements())
   {
     String mem = e.nextElement().toString();
     int logs =  Log.count(mem,1);     //1 是登陆状态
     int orders = Destine.countByMember(teasession._strCommunity,mem,"");
     int has = Destine.countByMember(teasession._strCommunity,mem," AND dstate = "+1);
   %>
 <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
   <td><%=mem%></td>
   <td><%=logs%></td>
   <td><%=orders%></td>
   <td><%=has %></td>
 </tr>
  <%
  }if(count>pageSize){
    %>
    <tr>
      <td>&nbsp;</td>
      <td align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage, request.getRequestURI()+param.toString() + "&Pos=", pos, count,pageSize)%></td>
    </tr><%} %>

  </table>
  <input type="hidden" name="sql" value="<%=sql.toString()%>"/>
   <input type="button" id="excel_table" value="<%=r.getString(teasession._nLanguage, "导出成 EXCEL 表格")%>" onClick="f_kind();"/>
  </FORM>
<div id="head6"><img height="6" src="about:blank" alt=""></div>
</div>
<div id="jspafter" style="display:none">
<%=community.getJspAfter(teasession._nLanguage)%>
</div>
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
