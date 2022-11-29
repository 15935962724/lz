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
String time =Duty.GetNowDate();
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
<script>
function LoadWindow1()
{
		  loc_x=document.body.scrollLeft+event.clientX-event.offsetX-100;
 	 loc_y=document.body.scrollTop+event.clientY-event.offsetY+140;
	var sFeatures = "edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:320px;dialogHeight:245px;dialogTop:"+loc_y+"px;dialogLeft:"+loc_x+"px";
	var url = "/jsp/admin/vehicle/NewDepartment1.jsp";
	var aio ="";
	var arr =window.showModalDialog(url,aio,sFeatures);
	if(arr!=null){
		var arr1 = arr.split(",");
			document.all.findingmanid.value=arr1[0];
			document.all.findingman.value = arr1[1];


	}
}
</script>
<h1> 请指定查询条件：</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<form name=form1 METHOD=post  action="/jsp/admin/vehicle/query/search.jsp" >
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

    <tr>
      <td nowrap > 状　　态：</td>
      <td nowrap>
        <select name="type" >
          <option value="0">------</option>
          <option value="1">待批</option>
          <option value="3">已准</option>
          <option value="2">使用中</option>
          <option value="-1">未准</option>
        </select>
      </td>
    </tr>
    <tr>
      <td nowrap > 车 牌 号：</td>
      <td nowrap>
        <select name="vehicle"  size>
        <option value="">------</option>
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
      <td nowrap > 司　　机：</td>
      <td nowrap><input type="text" name="chauffeur" size="11" maxlength="100" ></td>
    </tr>
    <tr>
      <td nowrap > 申请日期：</td>
      <td nowrap>
       <input name="time1" size="7"  value="<%=time %>" readonly><A href="###"><img onclick="showCalendar('form1.time1');" src="/tea/image/public/Calendar2.gif" align="top"/></a> 至
        <input name="time11" size="7"  value="<%=time %>" readonly><A href="###"><img onclick="showCalendar('form1.time11');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
      </td>
    </tr>
    <tr>
      <td nowrap > 用 车 人：</td>
      <td nowrap>
        <input type="text" name="man" size="20" maxlength="100" value="">
      </td>
    </tr>
    <tr>
      <td nowrap > 用车部门：</td>
      <td nowrap>
       		<select name="unit">
       		<option value="">-------</option>
       			<%
       				java.util.Enumeration adme = AdminUnit.findByCommunity(teasession._strCommunity,"");
       				while(adme.hasMoreElements())
					{
                        AdminUnit adobj=(AdminUnit)adme.nextElement();
                        int adid=adobj.getId();
						out.print("<option value="+adid+">");
						out.print(adobj.getName());
						out.print("</option>");
					}
       			 %>
       		</select>
        </td>
    </tr>
    <tr>
      <td nowrap > 起始日期：</td>
      <td nowrap>
       <input name="times1" size="7"  value="<%=time %>" readonly><A href="###"><img onclick="showCalendar('form1.times1');" src="/tea/image/public/Calendar2.gif" align="top"/></a> 至
        <input name="times11" size="7"  value="<%=time %>" readonly><A href="###"><img onclick="showCalendar('form1.times11');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
      </td>
    </tr>
    <tr>
      <td nowrap class="TableContent" width="80"> 结束日期：</td>
      <td nowrap>
       <input name="times2" size="7"  value="<%=time %>" readonly><A href="###"><img onclick="showCalendar('form1.times2');" src="/tea/image/public/Calendar2.gif" align="top"/></a> 至
        <input name="times22" size="7"  value="<%=time %>" readonly><A href="###"><img onclick="showCalendar('form1.times22');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
      </td>
    </tr>
    <tr>
      <td nowrap > 申 请 人：</td>
      <td nowrap>
        <input type="text" name="findingman" size="10"  readonly>&nbsp;
        <input type="button" value='选 择' class="SmallButton" style="height:22px" onClick="LoadWindow1();" title="指定申请人" name="button">
        <input type="hidden" name ="findingmanid" value="">

      </td>
    </tr>
    <tr>
      <td nowrap > 调 度 员：</td>
      <td nowrap>
        <select name="attemper" >
          <option value="">---------</option>
         <%
         	java.util.Enumeration aten =Attemper.findByCommunity(teasession._strCommunity,"");
			while(aten.hasMoreElements())
			{
				String atid = ((String)aten.nextElement()).toString();
				Attemper atobj = Attemper.find(atid);
				String att[] = atobj.getNames().split(",");

				for(int i =0;i<att.length;i++)
				{
				 tea.entity.member.Profile pf_obj=tea.entity.member.Profile.find(att[i]);
					out.print("<option value="+att[i]+">");
					out.print(pf_obj.getLastName(1)+pf_obj.getFirstName(1)+"<br>");
					out.print("</option>");
				}

			}
          %>
        </select>
      </td>
    </tr>
    <tr>
      <td nowrap > 事　　由：</td>
      <td nowrap>
        <input type="text" name="cause" size="30">
      </td>
    </tr>
    <tr>
      <td nowrap > 备　　注：</td>
      <td nowrap>
        <input type="text" name="remark" size="30">
      </td>
    </tr>
    <tr >
      <td colspan="2" nowrap>
        <input type="submit" value="查询" >&nbsp;&nbsp;

        <input type="reset" value="重填" >
      </td>
    </tr>
</table>
</FORM>

</body>
</html>



