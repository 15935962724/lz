<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="java.io.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.net.*" %>
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

//获取 会员是上什么班的
Profile pf_obj=Profile.find(teasession._rv._strV);

RankClass raobj = RankClass.find(pf_obj.getRclass());
if(!raobj.isExists())
{
  response.sendRedirect("/jsp/info/Alert.jsp?info="+URLEncoder.encode("对不起,管理员还没有给你还没有设置'考勤排班类型'.","UTF-8"));
  return;
}
String ip=request.getRemoteAddr();
if(!RankClass.isIp(teasession._strCommunity,ip)&&RankClass.isSip(teasession._strCommunity))
{
  response.sendRedirect("/jsp/info/Alert.jsp?info="+URLEncoder.encode("对不起,您的IP受限制，您不能操作上下班登记.","UTF-8"));
  return;
}

DutyClass obj = DutyClass.findByMember(community,teasession._rv._strV);

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function f_submit(v)
{
  form1.nexturl.value=location;
  form1.act.value=v;
  form1.submit();
}
</script>
</head>
<body id='dutyboy'>


<h1>今日上下班登记(<%=raobj.getRankClass() %>) </h1>
<div id="head6"><img height="6" src="about:blank"></div>


<form name="form1" action="/servlet/EditDutyClass" method="POST">
<input type="hidden" name="community" value="<%=community%>">
<input type="hidden" name="nexturl" >
<input type="hidden" name="act" >

   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
    	 <td nowrap>登记次序</td>
         <td nowrap>登记类型</td>
         <td nowrap>规定时间</td>
         <td nowrap>登记时间</td>
         <td nowrap>操作</td>
    </tr>
   		<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    	<td nowrap>第1次登记</td>
    	<td nowrap>上班登记</td>
    	<td nowrap><%=raobj.getEnrol1() %></td>
    	<td nowrap>
    	<%
    	DateFormat format = new SimpleDateFormat("HH:mm");

    	if(obj.getBinday1()!=null && raobj.isExists()&& raobj.getEnrol1().length()>0)
    	{
    		out.print(obj.getBinday1().toString().substring(10,16));

			Date a = format.parse(raobj.getEnrol1());//规定的时间
			Date b = format.parse(obj.getBinday1().toString().substring(10,16));	//当前时间

			if(a.compareTo(b)==-1)
			{
				out.print("<span id=cdid>迟到</span>");
			}

	    	out.print("</td>");
	    	out.print("<td nowrap>无</td>");
	    }else
	    {
	    	out.print("未登记</td><td nowrap><a href=javascript:f_submit('bookinday1')>上班登记</a></td>");
    	}
	out.print("</tr>");

   if(obj.getBinday1()!=null && raobj.isExists()&& raobj.getEnrol2().length()>0)
   {
     %>
     <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    	<td nowrap>第2次登记</td>
    	<td nowrap>下班登记</td>
    	<td nowrap><%=raobj.getEnrol2() %></td>
    	<td nowrap>
    	<%
    	if(obj.getBinday2()!=null)
    	{
    		out.print(obj.getBinday2().toString().substring(10,16));


       		Date aa2 =format.parse(raobj.getEnrol2());

       		Date bb2 = format.parse(obj.getBinday2().toString().substring(10,16));

       		if(aa2.compareTo(bb2)==1)
			{
				 out.print("<span id=ztid>早退</span>");
			}
	    	out.print("</td>");
	    	out.print("<td nowrap>无</td>");
	    }else
	    {
	    	out.print("未登记</td><td nowrap><a href=javascript:f_submit('bookinday2')>下班登记</a></td>");
		}
 	}

   if(obj.getBinday2()!=null && raobj.isExists()&& raobj.getEnrol3().length()>0)
   {
     %>
     <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    	<td nowrap>第3次登记</td>
    	<td nowrap>上班登记</td>
    	<td nowrap><%=raobj.getEnrol3() %></td>
    	<td nowrap>
    	<%
    	if(obj.getBinday3()!=null)
    	{
    		out.print(obj.getBinday3().toString().substring(10,16));

			Date a3 = format.parse(raobj.getEnrol3());
			Date b3 = format.parse(obj.getBinday3().toString().substring(10,16));
	    	if(a3.compareTo(b3)==-1)
	    	{
	    		out.print("<span id=cdid>迟到</span>");
	    	}
	    	out.print("</td>");
	    	out.print("<td nowrap>无</td>");
	    }else
	    {
		 out.print("未登记</td><td nowrap><a href=javascript:f_submit('bookinday3')>上班登记</a></td>");
		}
 	}

   if(obj.getBinday3()!=null && raobj.getEnrol4().length()>0)
   {
     %>
     <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    	<td nowrap>第4次登记</td>
    	<td nowrap>下班登记</td>
    	<td nowrap><%=raobj.getEnrol4() %></td>
    	<td nowrap>
    	<%
    	if(obj.getBinday4()!=null)
    	{
    		out.print(obj.getBinday4().toString().substring(10,16));

			Date a4 = format.parse(raobj.getEnrol4());
			Date b4 = format.parse(obj.getBinday4().toString().substring(10,16));
	    	if(a4.compareTo(b4)==1)
	    	{
	    		out.print("<span id=ztid>早退</span>");
	    	}
	    	out.print("</td>");
	    	out.print("<td nowrap>无</td>");
	    }else
	    {
    		out.print("未登记</td><td nowrap><a href=javascript:f_submit('bookinday4')>下班登记</a></td>");
		}
   }
%>





<!--/////////////////////////////////////////////////////-->



      <%
   if(obj.getBinday4()!=null && raobj.getEnrol5().length()>0)
   {
     %>
     <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    	<td nowrap>第5次登记</td>
    	<td nowrap>上班登记</td>
    	<td nowrap><%=raobj.getEnrol5() %></td>
    	<td nowrap>
    	<%
    	if(obj.getBinday5()!=null){
    		out.print(obj.getBinday5().toString().substring(10,16));

			Date a5 = format.parse(raobj.getEnrol5());
			Date b5 = format.parse(obj.getBinday5().toString().substring(10,16));
	    	if(a5.compareTo(b5)==-1)
	    	{
	    		out.print("<span id=cdid>迟到</span>");
	    	}
	    	out.print("</td>");
	    	out.print("<td nowrap>无</td>");
	    }else
	    {
	    	out.print("未登记</td><td nowrap><a href=javascript:f_submit('bookinday5')>上班登记</a></td>");
	    }
    }
      %>

 

      <%
   if(obj.getBinday5()!=null && raobj.getEnrol6().length()>0)
   {
     %>
     <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    	<td nowrap>第6次登记</td>
    	<td nowrap>下班登记</td>
    	<td nowrap><%=raobj.getEnrol5() %></td>
    	<td nowrap>
    	<%
    	if(obj.getBinday6()!=null){
    		out.print(obj.getBinday6().toString().substring(10,16));

			Date a6 = format.parse(raobj.getEnrol6());
			Date b6 = format.parse(obj.getBinday6().toString().substring(10,16));
	    	if(a6.compareTo(b6)==1)
	    	{
	    		out.print("<span id=ztid>早退</span>");
	    	}
	    	out.print("</td>");
	    	out.print("<td nowrap>无</td>");
	    }else
	    {
	    	out.print("未登记</td><td nowrap><a href=javascript:f_submit('bookinday5')>上班登记</a></td>");
     	}
     }
%>

</table>

</form>
</body>
</html>


