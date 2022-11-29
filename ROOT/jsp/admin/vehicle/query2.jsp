<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%> 
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>

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
int maid = 0;
if(teasession.getParameter("maid")!=null && teasession.getParameter("maid").length()>0)
	maid = Integer.parseInt(teasession.getParameter("maid"));
int vehicle=0, vtype=0;
Date times =null;
String cause=null, man=null, remark=null;
float charge =0;
if(maid>0)
{
	Maintenance maobj = Maintenance.find(maid);
	vehicle = maobj.getVehicle();
	times = maobj.getTimes();
	vtype = maobj.getVtype();
	cause = maobj.getCause();
	man = maobj.getMan();
	charge = maobj.getCharge();
	remark = maobj.getRemark();
}	

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

<script>
	function sub()
	{
		if(form1.vehicle.value==0)
		{
			alert("请选择车辆!");
			return false;
		}
		
	}
</script>
<body>
<form name=form1 METHOD=post  action="/servlet/EditMaintenance" onsubmit="return sub(this);">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<input type="hidden" name="maid" value="<%=maid %>">
	 <tr>
      <td nowrap > 车 牌 号：</td>
      <td nowrap  colspan="3" >
        <select name="vehicle" >
          <option value="0" >---------</option>
            <%
         	java.util.Enumeration maen = Manage.findByCommunity(teasession._strCommunity,"");
         	while(maen.hasMoreElements())
         	{
         		int maid1 = ((Integer)maen.nextElement()).intValue();
         		Manage maobj1 = Manage.find(maid1);
         		out.print("<option value="+maid1);
         		if(vehicle==maid1)
         			out.print(" SELECTED");
         		out.print(">"+maobj1.getVehicle());
         		out.print("</option>");
         	}
          %>
        </select>
      </td>
    </tr>
    <tr>
      <td nowrap > 维护日期：</td>
      <td nowrap>  <input name="times" size="7"  value="<%if(times!=null){out.print(times);}else {out.print(Duty.GetNowDate());} %>" readonly><A href="###"><img onclick="showCalendar('form1.times');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
        </td>
      <td nowrap > 维护类型：</td>
      <td nowrap>
        <SELECT name="vtype" >

          <option value="1" <%if(vtype==1)out.print("SELECTED"); %>>维修</option>
          <option value="2" <%if(vtype==2)out.print("SELECTED"); %>>加油</option>
          <option value="3" <%if(vtype==3)out.print("SELECTED"); %>>洗车</option>
          <option value="4" <%if(vtype==4)out.print("SELECTED"); %>>年检</option>
          <option value="5" <%if(vtype==5)out.print("SELECTED"); %>>其它</option>
        </SELECT>
      </td>
    </tr>
    <tr>
      <td nowrap > 维护原因：</td>
      <td nowrap colspan="3">
        <textarea name="cause" cols="60" rows="2"><%if(cause!=null)out.print(cause); %></textarea>
      </td>
    </tr>
    <tr>
      <td nowrap > 经 办 人：</td>
      <td nowrap>
        <input type="text" name="man" size="12" maxlength="100"  value="<%if(man!=null)out.print(man); %>">
      </td>
      <td nowrap  width="80"> 维护费用：</td>
      <td nowrap width="130">
        <input type="text" name="charge" size="12" maxlength="25"  value="<%if(charge!=0)out.print(charge); %>">&nbsp;元
      </td>
    </tr>
    <tr>
      <td nowrap  width="80"> 备　　注：</td>
      <td nowrap colspan="3">
        <textarea name="remark"  cols="60" rows="2"><%if(remark!=null)out.print(remark); %></textarea>
      </td>
    </tr>
    <tr >
      <td nowrap colspan="4" align="center">
        
        <input type="submit" value="保存" >&nbsp;&nbsp;
        <input type="reset" value="重填" >&nbsp;&nbsp;
      </td>
    </tr>
</TABLE>
</FORM>


</body>
</html>



