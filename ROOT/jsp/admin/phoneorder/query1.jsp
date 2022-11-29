<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.db.*" %>
<%@page import="tea.ui.*" %>
<%@ page  import="tea.resource.Resource"  %>
<%@page import ="tea.entity.member.*" %>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");


TeaSession teasession=new TeaSession(request);

%>




<body>
<script>


		//document.getElementById("mydiv").innerHTML;
		document.getElementsByName("mydiv");
		parent.member.innerHTML ="";  


</script>
<div id ="mydiv">aaaaaaaaaaaaaaa</div><div>
<table>
<tr><td>dddddddddddddddddddddd</td></tr>
<% 
//String code = request.getParameter("00240010000");
//Enumeration e= Trade.find(teasession._strCommunity,"",0,Integer.MAX_VALUE);


//while(e.hasMoreElements())
//{
	//String trade = ((String)e.nextElement());
	

	
%>
	<!-- <tr>
		<td id="mem_que"></td>
	</tr> -->
<%
//}

%>
</table>
</div>

</body>