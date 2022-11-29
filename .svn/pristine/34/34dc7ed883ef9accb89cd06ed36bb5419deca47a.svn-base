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
  <td>会员</td><td>登陆次数</td><td>下订单数</td><td>已受理订单数</td><td>消费金额总计(元)</td>
  </tr>

  <%
 //  java.util.Enumeration e = Destine.findmember(teasession._strCommunity,sql.toString(),pos,pageSize);
 String sqlm="select d.member,sum(money) as m,count(d.destine) from Destine as d  left join expenserecord as e on e.destine=d.destine group by d.member order by m desc";
  DbAdapter db1=new DbAdapter();
  db1.executeQuery(sqlm);
 DbAdapter db=new DbAdapter();
 float money=0;
   String sql2=null;
  // while(db1.next())
   for (int k = 0; k < pos +pageSize&& db1.next(); k++)
  {if (k<pos) continue;
     String mem=db1.getString(1);
     money=db1.getFloat(2);
      int orders=db1.getInt(3);
      int logs =  Log.count(mem,1);
       int has = Destine.countByMember(teasession._strCommunity,mem," AND state = "+1);
     /*
     String mem = e.nextElement().toString();
     sql2="select sum(money) from expenserecord where destine in(select destine  from destine where member="+DbAdapter.cite(mem) +")";
      //1 是登陆状态
     int orders = Destine.countByMember(teasession._strCommunity,mem,"");
     int has = Destine.countByMember(teasession._strCommunity,mem," AND state = "+1);
   //  System.out.println(sql2);
     db.executeQuery(sql2);
     if(db.next()){
       money=db.getFloat(1);
     }*/
   %>
 <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
   <td><%=mem%></td>
   <td><%=logs%></td>
   <td><%=orders%></td>
   <td><%=has %></td>
   <td><%=money%></td>
 </tr>
  <%
  }if(count>pageSize){
    %>
    <tr>
      <td align="center" colspan="5"><%=new tea.htmlx.FPNL(teasession._nLanguage, request.getRequestURI()+param.toString() + "&Pos=", pos, count,pageSize)%></td>
    </tr><%}
    db1.close();
    %>

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
  </script>
</body>
</html>
