<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page import="tea.ui.*" %>
<%
TeaSession teasession=new TeaSession(request);
%>
<script language="javascript">
	function chaxun()
	{
	var na =formcx.names.value;
		if(formcx.names.value=="")
		{
			alert("请输入要查询的号码!");
			return false;
		}
		for(var i=0;i<na.length;i++)
		{
			na=na.substring(i,i+1);
			if (na<"0" || na>"9")
			{
				alert("请输入正确的号码！");
				return false;
			}
   		 }
		 if(formcx.names.value.length!=11){
		 	alert("您的号码不合法!");
			return false;
		 }

		
	}
</script>

<form name="formcx" action="?" method="post" onsubmit="return chaxun();">
<input type=hidden name=Node value="<%=teasession._nNode%>">
<table>
	<tr>
		<td>请输入您参与活动的手机号码进行查询，小灵通号码前请加010。
<input type="text" name="names" onblur="this.value=this.value.replace(/\D/g,'');" onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;"/><input type="submit" value="查 询"/></td>
	</tr>
<%
String sj = request.getParameter("names");
if(sj!=null&&(sj=sj.trim()).length()>0)
{
out.print("<tr><td>");
  DbAdapter dbadapter = new DbAdapter();
  try
  {
    dbadapter.executeQuery("select col003 from Fm1073 where col001 ="+DbAdapter.cite(sj));
    if(dbadapter.next())
    {
		out.println("恭喜您获得<b>&nbsp;<font color=red>"+dbadapter.getInt(1)+"</font>&nbsp;</b>等奖，您将于近期收到我们的获奖确认短信，请您在手机里保留这条短信，并按照短信中的说明方法领奖。");
	}else
	{
		out.println("感谢参与我们的台庆月活动，很遗憾您没能中奖。请继续支持城市管理广播FM107.3,AM1026。");	
	}
   }catch (Exception exception)
   {
	   exception.printStackTrace();
   } finally 
   {
      dbadapter.close();
   }
   out.print("</td></tr>");
}

%>
	
</table>
</form>


