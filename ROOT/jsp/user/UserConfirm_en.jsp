<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import = "tea.entity.site.Community" %>
<%@ page import = "tea.entity.node.*" %>
<%@ page import = "tea.entity.member.*" %>
<%@ page import="tea.htmlx.Languages"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import = "tea.resource.Resource" %>
<%@ page import = "tea.entity.admin.orthonline.ProfileOrth" %>
<%@ page import="tea.ui.TeaServlet"%>

<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession = new TeaSession(request);
Resource r = new Resource("/tea/resource/Photography");
 teasession._nLanguage = 0;
Community community = Community.find(teasession._strCommunity);
 
String user = teasession.getParameter("user");
Profile pobj = Profile.find(user);
 session.setAttribute("tea.newemail",pobj.getEmail());
int membertype=0;
if(teasession.getParameter("membertype")!=null && teasession.getParameter("membertype").length()>0 && !"null".equals(teasession.getParameter("membertype")))
{
	membertype = Integer.parseInt(teasession.getParameter("membertype"));
}

if("chongxin".equals(teasession.getParameter("act")))
{
	// tea.service.SendEmaily se = new tea.service.SendEmaily(teasession._strCommunity);
	// ProfileOrth.send(teasession,pobj);
	 tea.entity.admin.mov.MemberOrder.send(teasession, pobj);
	 
	 
	 
}
if("newemail".equals(teasession.getParameter("act")))
{
	 String newemail=request.getParameter("newemail");
	 pobj.setEmail(newemail);
     session.setAttribute("tea.newemail",pobj.getEmail());
	// tea.service.SendEmaily se = new tea.service.SendEmaily(teasession._strCommunity);
	 // ProfileOrth.send(teasession,pobj);
	 
      tea.entity.admin.mov.MemberOrder.send(teasession, pobj);

	 
}

 

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<script>
	function f_submit(m,i)
	{
		 sendx("/jsp/user/UserConfirm_en.jsp?act=chongxin&user="+encodeURIComponent(m)+"&membertype="+i,
         function(data)
         {
             alert("<%=r.getString(teasession._nLanguage,"4657742383")%>.");
         }
         );
	}
	 
	function new_submit(m,i)
	{
		 sendx("/jsp/user/UserConfirm_en.jsp?act=newemail&user="+encodeURIComponent(m)+"&membertype="+i+"&newemail="+frm.newemail.value,
         function(data)
         {
             alert("<%=r.getString(teasession._nLanguage,"4657742383")%>.");
         }
         );
	}
</script>





<style>
.RegProcess{display:none;}
.RegInf #tablecenter td{text-align:left;line-height:25px;}
</style>
<body>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
 <p><%=tea.entity.admin.mov.RegisterInstall.getNavigation(membertype,teasession._nLanguage,"zccg",8) %></p>
<!-- 
<div class="RegProcess"><div class="Process00"><%=r.getString(teasession._nLanguage,"2343345501") %>：</div>
<div class="Process01"><%=r.getString(teasession._nLanguage,"7441298218") %></div>
<div class="Process02" ><%=r.getString(teasession._nLanguage,"0869099137") %></div>
<div class="Process03"><%=r.getString(teasession._nLanguage,"8402885699") %></div>
<div class="Process04" id="ProcessSpecial"><%=r.getString(teasession._nLanguage,"1537182457") %></div></div>
 -->
<div class=RegInf><br><table id="tablecenter">
<tr> 
<td>
 <img src="/res/Home/1007/1007990.png"></td><td><%=r.getString(teasession._nLanguage,"3763030776") %>！<br>
<%=r.getString(teasession._nLanguage,"2662617079")%>&nbsp;<font color="red"><%=pobj.getEmail() %></font>&nbsp;<%=r.getString(teasession._nLanguage,"0286212035") %><br>
<%=r.getString(teasession._nLanguage,"5844253961") %>。 
 </td>
<tr><td><img src="/res/Home/1007/1007991.png"></td><td><%=r.getString(teasession._nLanguage,"3204695093") %><br>
<a href=# onClick="f_submit('<%=user%>','<%=membertype%>');"><%=r.getString(teasession._nLanguage,"8420382097") %></a><br>
<a href=# onclick='document.getElementById("newemail").style.display=""'><%=r.getString(teasession._nLanguage,"5128898938") %></a>
<div id='newemail' style="display:none">
<form name="frm" action="?">
<input type="text" name="newemail" value="" width="50"/>
<a href=# onClick="new_submit('<%=user%>','<%=membertype%>');"><%=r.getString(teasession._nLanguage,"8746225790") %></a>
</form>
 
</td> 
</tr>
</table> <br>
</div>

<br/>
<input type="button" name="dingyue" id="dingyue" onClick="window.location='/'"value="<%=r.getString(teasession._nLanguage,"6941827096") %>" />

<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
</body>

</html>
