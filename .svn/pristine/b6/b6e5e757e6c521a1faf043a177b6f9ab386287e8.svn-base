<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.finance.*" %>
<%@ page import="java.util.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="java.math.BigDecimal" %>
<%@page import="java.io.*" %>
<%@page import="tea.db.*" %>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("progma","no-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires",0);
TeaSession teasession =new TeaSession(request);
String member = teasession._rv._strR;
%>
<html>
<!-- Stock photography -->
<head>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/load.js" type="text/javascript"></SCRIPT>

<style>
h1{color:#333;margin:20px 10px 5px 10px;display: block;width:100%;height:26px;padding-left:30px;vertical-align: middle;line-height: 30px;text-align:left;background:url(/res/bigpic/u/0812/08126036.gif) no-repeat left center;font-size:14px;font-weight:bold;}
#wai{border-left:1px solid #ccc;border-top:1px solid #ccc;margin-top:10px;padding:10px;}
</style>
<title>收/支金额</title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>

<body style="margin:0;">
<div id="wai">
  <h1>收/支金额</h1>
  <form name="form1" action="?" method="POST">
  <table>
    <tr>
      <td>
        收入/支出：
</td>
<td>
  <input id="sr" type="radio" name="sandz" value="2" onclick="oc(this.id);"/><label for="sr">收入</label><br />
  <input id="zc" type="radio" name="sandz" value="1" onclick="oc(this.id);" checked="checked"/><label for="zc">支出</label>
</td>
    </tr>
    <tr>
      <td align="right">
        类别：
      </td>

      <td>
      <div id="k1">
        <select name="kinds" style="width:100px">
        <option value="">-----------</option>
        <%
        Enumeration e = Kinds.find(" and member="+DbAdapter.cite(member)+" and sandz=1",0,100);
        while(e.hasMoreElements())
        {
          int id = ((Integer)e.nextElement()).intValue();
          Kinds k = Kinds.find(id);
          out.print("<option value="+id+">"+k.getKname()+"</option>");
        }
        %>
        </select>
      </div>
      <div id="k2" style="display:none">
        <select name="kinds" style="width:100px">
        <option value="">-----------</option>
        <%
        Enumeration ee = Kinds.find(" and member="+DbAdapter.cite(member)+" and sandz=2",0,100);
        while(ee.hasMoreElements())
        {
          int id = ((Integer)ee.nextElement()).intValue();
          Kinds k = Kinds.find(id);
          out.print("<option value="+id+">"+k.getKname()+"</option>");
        }
        %>
        </select>
        </div>
      </td>
    </tr>
    <tr>
    <td align="right">
    花费：
    </td>
    <td>
      <input style="width:70px" type="text" name="money" value=""/>&nbsp;RMB
    </td>
    </tr>
    <tr>
    <td align="right">
    日期：
    </td>
    <td>
   <input type="TEXT" name="date" readonly="readonly" onclick="new Calendar('2008', '2010', 0,'yyyy-MM-dd').show(this);">
    </td>
    </tr>
    <tr>
      <td colspan="2" align="center">
        <input type="submit" value="添加"/>
        <input type="reset" value="重置"/>
      </td>
    </tr>
  </table>
    </form>
</div>
<script type="">

function oc(obj)
{
  if(obj == 'sr')
  {
    document.getElementById('k2').style.display='';
    document.getElementById('k1').style.display='none';
  }
  if(obj == 'zc')
  {
    document.getElementById('k2').style.display='none';
    document.getElementById('k1').style.display='';
  }
}
</script>
<%@include file="/jsp/include/Canlendar4.jsp" %>
</body>

<!-- Stock photography -->
</html>
