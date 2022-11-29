<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.Date" %>
<%@ page  import="java.util.Calendar"%>
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

String time2 = teasession.getParameter("time2");
int unit = Integer.parseInt(teasession.getParameter("unit"));
int arrclass = Integer.parseInt(teasession.getParameter("arrclass"));
int id = Integer.parseInt(teasession.getParameter("id"));



RankClass raobj = RankClass.find(arrclass);//获得用户属于什么班

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
<%
	DutyClass obj = DutyClass.find(id);
	tea.entity.member.Profile pf_obj=tea.entity.member.Profile.find(obj.getMember());//得到的用户的姓名
 %>
<h1>上下班登记修改 - <%=pf_obj.getLastName(1)+pf_obj.getFirstName(1) %> -  [<%=time2 %>]</h1>

<div id="head6"><img height="6" src="about:blank"></div>
注意：输入的时间格式要形如 12:12，不填写则代表未登记
　  <br />
<form name=form1 METHOD=get  action="/servlet/EditRankclass">
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
   <input type="hidden" value="<%=id %>" name="ranid">
    <input type="hidden" value="<%=time2 %>" name="time2">
     <input type="hidden" value="<%=unit %>" name="unit">
      <input type="hidden" value="<%=arrclass %>" name="arrclass">
     <tr id="tableonetr">
         <td nowrap>上班 (<%=raobj.getEnrol1() %>)</td>
         <td nowrap>下班 (<%=raobj.getEnrol2() %>)</td>
         <td nowrap>上班 (<%=raobj.getEnrol3() %>)</td>
          <td nowrap>下班 (<%=raobj.getEnrol4() %>)</td>

          <%
          		if(raobj.getEnrol5()!=null && raobj.getEnrol5().length()>0)
          		{
           %>
           <td nowrap>上班 (<%=raobj.getEnrol5() %>)</td>
           <%
           		}
           		if(raobj.getEnrol6()!=null && raobj.getEnrol6().length()>0)
          		{
            %>
            <td nowrap>下班 (<%=raobj.getEnrol6() %>)</td>
            <%
            	}
             %>
       </tr>
       <tr>
       <td nowrap> <input name="b1" value="<%if(obj.getBinday1()!=null){out.print(obj.getBinday1().toString().substring(10,16));} %>"  size="8"></td>
       <td nowrap><input name="b2" value="<%if(obj.getBinday2()!=null){out.print(obj.getBinday2().toString().substring(10,16));} %>"  size="8"></td>
       <td nowrap><input name="b3" value="<%if(obj.getBinday3()!=null){out.print(obj.getBinday3().toString().substring(10,16));} %>"  size="8"></td>
       <td nowrap><input name="b4" value="<%if(obj.getBinday4()!=null){out.print(obj.getBinday4().toString().substring(10,16));} %>"  size="8"></td>

       <%
          		if(raobj.getEnrol5()!=null && raobj.getEnrol5().length()>0)
          		{
           %>
           <td nowrap><input name="b5" value="<%if(obj.getBinday5()!=null){out.print(obj.getBinday5().toString().substring(10,16));} %>"  size="8"></td>
           <%
           		}
           		if(raobj.getEnrol6()!=null && raobj.getEnrol6().length()>0)
          		{
            %>
            <td nowrap><input name="b6" value="<%if(obj.getBinday6()!=null){out.print(obj.getBinday6().toString().substring(10,16));} %>"  size="8"></td>
            <%
            	}
             %>

       </tr>



</table>
<br>
<input type="submit"value="保存" >
<input type="button" class="BigButton" value="返回" onClick="location='/jsp/admin/manage/inquire2.jsp?time2=<%=time2 %>&unit=<%=unit  %>&arrclass=<%=arrclass %>';"><br>

</form>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>



