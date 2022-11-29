<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%> 
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="java.io.*" %>

<%
request.setCharacterEncoding("UTF-8");


response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String community=teasession._strCommunity;
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
<form name=form1 METHOD=post  action="/jsp/admin/vehicle/see.jsp" onsubmit="return sub(this);">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	 <tr>
      <td colspan="2" nowrap>请指定查询条件：
      </td>
    </tr>
    <tr>
      <td nowrap > 车 牌 号：</td>
      <td nowrap>
        <select name="vehicle" >
          <option value="0">----------</option>
           <%
         	java.util.Enumeration maen = Manage.findByCommunity(teasession._strCommunity,"");
         	while(maen.hasMoreElements())
         	{
         		int maid = ((Integer)maen.nextElement()).intValue();
         		Manage maobj = Manage.find(maid);
         		out.print("<option value="+maid);
         		out.print(">"+maobj.getVehicle());
         		out.print("</option>");
         	}
          %>
        </select>
      </td>
    </tr>
    <tr>
      <td nowrap > 维护日期：</td>
      <td nowrap>
      <%
      		
       %>
       <input name="timek" size="7"  value="<%=Duty.GetNowDate() %>" readonly><A href="###"><img onclick="showCalendar('form1.timek');" src="/tea/image/public/Calendar2.gif" align="top"/></a> 至
        <input name="timej" size="7"  value="<%=Duty.GetNowDate() %>" readonly><A href="###"><img onclick="showCalendar('form1.timej');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
      </td>
    </tr>
    <tr>
      <td nowrap > 维护类型：</td>
      <td nowrap>
        <SELECT name="vtype"  >
          <option value="0">-------</option>
          <option value="1">维修</option>
          <option value="2">加油</option>
          <option value="3">洗车</option>
          <option value="4">年检</option>
          <option value="5">其它</option>
        </SELECT>
      </td>
    </tr>
    <tr>
      <td nowrap > 维护原因：</td>
      <td nowrap>
        <input type="text" name="cause" size="30" maxlength="200"  value="">
      </td>
    </tr>
    <tr>
      <td nowrap > 经 办 人：</td>
      <td nowrap>
        <input type="text" name="man" size="10" maxlength="200"  value="">
      </td>
    </tr>
    <tr>
      <td nowrap > 维护费用：</td>
      <td nowrap>
        <input type="text" name="charge1" size="10" maxlength="200"  value=""> 至
        <input type="text" name="charge2" size="10" maxlength="200"  value="">
      </td>
    </tr>
    <tr>
      <td nowrap > 备　　注：</td>
      <td nowrap>
        <input type="text" name="remark" size="30" maxlength="200"  value="">
      </td>
    </tr>
    <tr align="center" >
      <td colspan="2" nowrap>
        <input type="submit" value="查询" >&nbsp;&nbsp;
        <input type="reset" value="重填" >
      </td>
    </tr>
</TABLE>
</FORM>


</body>
</html>



