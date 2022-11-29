<%@page import="tea.entity.westrac.EventaccoMember"%>
<%@page import="tea.entity.westrac.Eventregistration"%>
<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.node.Event"%>
<%@page import="tea.entity.node.Node"%>
<%@page import="tea.entity.admin.AdminRole"%>
<%@page import="tea.entity.admin.AdminUnit"%>
<%@page import="tea.entity.admin.AdminUsrRole"%>
<%@page import="java.net.URLEncoder"%> 
<%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.volunteer.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="java.io.*" %>
<%@page import="java.util.*"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);



if(teasession._rv==null)
{ 
	out.println("您还没有登录，请登录");
	response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
	return;
}
tea.entity.site.Community community=tea.entity.site.Community.find(teasession._strCommunity);
String nexturl =  request.getRequestURI()+"?"+request.getQueryString();

Event eobj = Event.find(teasession._nNode,teasession._nLanguage);

int eid= 0;
if(teasession.getParameter("eid")!=null && teasession.getParameter("eid").length()>0)
{
	eid = Integer.parseInt(teasession.getParameter("eid"));	
}

EventaccoMember emobj = EventaccoMember.find(eid);
Eventregistration regobj = Eventregistration.find(emobj.getEregid());
Profile pobj = Profile.find(regobj.getMember());



%>
<html>
<head>
<base target="_ajax">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<script src="/tea/city2.js" type="text/javascript"></script>
<script type="text/javascript">
window.name='_ajax';
function f_sub()
{

	form1.submit();
	
}


</script> 
</head>
 
<body topmargin="0" leftmargin="0" marginheight="0" marginwidth="0" scroll="yes">

<h1>编辑随行人员信息</h1>

<form name="form1" method="post" action="/servlet/EditEvent"  target="_ajax" >
<input type="hidden" name="node" value="<%=teasession._nNode%>">
<input type="hidden" name="nexturl" value="<%=nexturl%>">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
 
<input type="hidden" name="act" value="WestracEventEditAccompMember">
<input type="hidden" name="eid" value="<%=eid %>">



      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
		
		      
		     <tr>
		     
			      <td align="right" nowrap="nowrap">姓名：</td>
			      <td><input type="text"   class="edit_input" name="acconame" value="<%=Entity.getNULL(emobj.getAcconame()) %>"></td>
			   </tr>
			      <tr>
			      <td align="right" nowrap="nowrap">性别：</td><td><select name="accogender">
			        	<option value="0" <%if(emobj.getSex()==0){out.println(" selected ");} %>>男</option>
			        	<option value="1" <%if(emobj.getSex()==1){out.println(" selected ");} %>>女</option>
			        </select></td>
			    </tr>
			   <tr>  
		         <td align="right" nowrap="nowrap">关系： </td>
		         <td><select name="accorel"> 
		         	
		         	<%
		         		for(int i=0;i<Eventregistration.ACCOREL_TYPE.length;i++)
		         		{
		         			out.println("<option value= "+i);
		         			if(emobj.getAccorel()==i)
		         			{
		         				out.println(" selected "); 
		         			}
		         			out.println(">"+Eventregistration.ACCOREL_TYPE[i]);
		         			out.println("</option>");
		         		}
		         	%>
		         </select></td>
			    
		    </tr>
		    
		 
			  
		      <tr>
			      <td align="right"  nowrap="nowrap">身份证号：</td>
			      <td colspan="10"> <input type="text" name="accocode" value="<%=Entity.getNULL(emobj.getCadr()) %>" maxlength="18"></td>
			      
		        
		    </tr>
		
		    
		    </table>
      	
    
    

  <br>
  <center>
  <INPUT TYPE=button name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="确定" onclick="f_sub();">&nbsp;
 
  <input type="button" value="关闭"  onClick="javascript:window.close();">

</center></form>

</body>
</html>

