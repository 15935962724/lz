<%@page contentType="text/html;charset=UTF-8" %><%@include file="/jsp/Header.jsp"%>
<%
String community=request.getParameter("community");
if(community==null)
community=node.getCommunity();




tea.entity.member.SClient sc=tea.entity.member.SClient.find(community,teasession._rv._strV);

int count=0;
java.math.BigDecimal money=null ;
tea.db.DbAdapter dbadapter = new tea.db.DbAdapter();

        try
        {
            dbadapter.executeQuery("SELECT COUNT(*),SUM(cash+ABS(subtract)) FROM SOrder,Node WHERE Node.community="+dbadapter.cite(community)+" AND Node.node=SOrder.node AND status=3 AND Node.rcreator LIKE "+dbadapter.cite(teasession._rv._strV));
            while (dbadapter.next())
            {
              count=dbadapter.getInt(1);
              money=dbadapter.getBigDecimal(2,2);
            }
        } catch (Exception exception1)
        {
           exception1.printStackTrace();
        } finally
        {
            dbadapter.close();
        }
%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="">
function flen(obj,text)
{
  if(obj.value<1||obj.value>1000)
  {
    alert(text);
    obj.focus();
    return false;
  }
  return true;
}
</script>
</head>

<body onload="">
<h1>会员中心</h1>
<div id="head6"><img height="6" alt=""></div>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td>余额</td>
<td><%=(sc.getPrice()==null?new java.math.BigDecimal("0"):sc.getPrice())%></td>
</tr><tr><td>积分:</td>
<td><%=sc.getPoint()%></td>
</tr>
<tr>
  <td>累计消费次数</td>
  <td><A href="/jsp/type/sorder/SOrder.jsp" ><%=count%></A>&nbsp;</td>
</tr>
<tr>
  <td>累计消费金额</td>
  <td><%=(money==null?new java.math.BigDecimal("0"):money)%></td>
</tr>
<tr>
  <td>最后消费时间</td>
  <td><%=sc.getLastTimeToString()%></td>
</tr>
<tr>
  <td>上次登陆时间</td>
  <td><!-- tea.entity.member.Log.getLastTimeByR(teasession._rv) -->&nbsp;</td>
</tr>

</table>



<div id="head6"><img height="6" alt=""></div>
</body>
</html>

