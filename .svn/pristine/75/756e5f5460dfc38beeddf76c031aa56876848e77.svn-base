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

int id = 0;
if(teasession.getParameter("id")!=null){
	id= Integer.parseInt(teasession.getParameter("id"));
}
RankClass obj = RankClass.find(id);
String rankclass=null,enrol1=null,duty1=null,enrol2=null,duty2=null,enrol3=null,duty3=null,enrol4=null,duty4=null,enrol5=null,duty5=null,enrol6=null,duty6=null;
if(id>0)
{
	rankclass = obj.getRankClass();
	enrol1  = obj.getEnrol1();
	duty1 = obj.getDuty1();
	enrol2  = obj.getEnrol2();
	duty2 = obj.getDuty2();
	enrol3  = obj.getEnrol3();
	duty3 = obj.getDuty3();
	enrol4  = obj.getEnrol4();
	duty4 = obj.getDuty4();
	enrol5  = obj.getEnrol5();
	duty5 = obj.getDuty5();
	enrol6  = obj.getEnrol6();
	duty6 = obj.getDuty6();
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
<body>

<h1>新建上下班时间</h1>

<div id="head6"><img height="6" src="about:blank"></div>
<b>说明：上下班登记时间范围在 0:00:00 至 23:59:59 之间，请按时间顺序指定</b>
<br />
<br />
<form name=form1 METHOD=post  action="/servlet/EditRankclass">

   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
   <input type="hidden" name="id" value="<%= id%>">
     <tr id="tableonetr">
    	 <td nowrap>排班类型说明：</td>
         <td nowrap><input type="text" name="rankclass" value="<%if(rankclass!=null)out.print(rankclass); %>" size="25" maxlength="100" ></td>
     </tr>
      <tr id="tableonetr">
    	 <td nowrap>第1次登记:</td>
         <td nowrap>
         	<input type="text" name="enrol1" value="<%if(enrol1!=null)out.print(enrol1); %>" size="8" maxlength="8" >
         	<select name="duty1"><option value="1" <%if(duty1!=null){if(duty1.equals("1"))out.print("SELECTED");} %>>上班</option><option value="2" <%if(duty1!=null){if(duty1.equals("2"))out.print("SELECTED"); }%>>下班</option></select>
         </td>
     </tr>
     <tr id="tableonetr">
    	 <td nowrap>第2次登记:</td>
         <td nowrap>
         	<input type="text" name="enrol2" value="<%if(enrol2!=null)out.print(enrol2); %>" size="8" maxlength="8" >
         	<select name="duty2"><option value="1" <%if(duty2!=null){if(duty2.equals("1"))out.print("SELECTED"); }%>>上班</option><option value="2" <%if(duty2!=null){if(duty2.equals("2"))out.print("SELECTED"); }%>>下班</option></select>
         </td>
     </tr>
     <tr id="tableonetr">
    	 <td nowrap>第3次登记:</td>
         <td nowrap>
         	<input type="text" name="enrol3" value="<%if(enrol3!=null)out.print(enrol3); %>" size="8" maxlength="8" >
         	<select name="duty3"><option value="1" <%if(duty3!=null){if(duty3.equals("1"))out.print("SELECTED");} %>>上班</option><option value="2" <%if(duty3!=null){if(duty3.equals("2"))out.print("SELECTED");} %>>下班</option></select>
         </td>
     </tr>
     <tr id="tableonetr">
    	 <td nowrap>第4次登记:</td>
         <td nowrap>
         	<input type="text" name="enrol4" value="<%if(enrol4!=null)out.print(enrol4); %>" size="8" maxlength="8" >
         	<select name="duty4"><option value="1" <%if(duty4!=null){if(duty4.equals("1"))out.print("SELECTED");} %>>上班</option><option value="2" <%if(duty4!=null){if(duty4.equals("2"))out.print("SELECTED"); }%>>下班</option></select>
         </td>
     </tr>
     <tr id="tableonetr">
    	 <td nowrap>第5次登记:</td>
         <td nowrap>
         	<input type="text" name="enrol5" value="<%if(enrol5!=null)out.print(enrol5); %>" size="8" maxlength="8" >
         	<select name="duty5"><option value="1" <%if(duty5!=null){if(duty5.equals("1"))out.print("SELECTED"); }%>>上班</option><option value="2" <%if(duty5!=null){if(duty5.equals("2"))out.print("SELECTED");} %>>下班</option></select>
         </td>
     </tr>
     <tr id="tableonetr">
    	 <td nowrap>第6次登记:</td>
         <td nowrap>
         	<input type="text" name="enrol6" value="<%if(enrol6!=null)out.print(enrol6); %>" size="8" maxlength="8" >
         	<select name="duty6"><option value="1" <%if(duty6!=null){if(duty6.equals("1"))out.print("SELECTED");} %>>上班</option><option value="2" <%if(duty6!=null){if(duty6.equals("2"))out.print("SELECTED");} %>>下班</option></select>
         </td>
     </tr>
     <tr id="tableonetr">
    	 <td nowrap colspan="2"><input type="submit" value=" 确定">&nbsp;<input type="button" value="返回" onClick="history.back();"></td>
        
     </tr>
     
</table>
</form>


<div id="head6"><img height="6" src="about:blank"></div>

</body>
</html>



