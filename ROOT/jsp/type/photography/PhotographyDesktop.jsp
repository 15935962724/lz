<%@page contentType="text/html;charset=UTF-8" %>
<%@ page  import="tea.resource.Resource" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.entity.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="tea.db.DbAdapter" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
Resource r=new Resource("/tea/resource/fun");
r.add("/tea/resource/Photography");

Profile pobj = Profile.find(teasession._rv.toString());



tea.entity.site.Community c = tea.entity.site.Community.find(teasession._strCommunity);

StringBuilder sql = new StringBuilder(" and hidden = 0 "); 

StringBuffer sql2 = new StringBuffer(" and audit =0 and n.path like "+DbAdapter.cite("%/"+teasession._nNode+"/%")+" and n.type = 94 ");

sql.append(" AND node IN(SELECT node FROM Node WHERE path LIKE '/"
		+ c.getNode() + "/%')");
int count = Talkback.count(sql.toString());
int count2 = Node.countPhotography(teasession._strCommunity,sql2.toString());

%>
 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>
<body>
<style type="text/css">
<!--
       *{margin:0;padding:0;}
       body{text-align:left;}
       #winpop,#winpop2 { width:201px;height:117px;position:absolute; right:0; bottom:0; margin:0; padding:1px; overflow:hidden; display:none; background:#FFFFFF url(https://ea.cebbank.com/res/ceb/u/1003/100324922.gif) no-repeat left top;}
       #winpop .title,#winpop2 .title2 { width:100%; height:20px; line-height:20px;font-weight:bold; text-align:center; font-size:12px; color:#FFFFFF;padding-top:3px;}
       #winpop .con,#winpop2 .con2 {height:100px;margin:0px;padding-top:25px;line-height:150%;font-weight:bold; font-size:12px; color:#3560ac; text-align:center;}
       .close,.close2 { position:absolute; right:4px; top:-1px; color:#FFFFFF; cursor:pointer}
     // -->
</style>
<table border="0" cellpadding="0" cellspacing="0" id="tableadmin">
  <tr id="tableone">
    <td ><%=teasession._rv.toString() %></td></tr>
   <tr id="tableone"> <td ><%=r.getString(teasession._nLanguage,"5048994756") %></td>
  </tr>
</table>
<h3><%=r.getString(teasession._nLanguage,"2344294318") %></h3>



<table border="0" cellpadding="0" cellspacing="0" id="table_admin">
  <tr id="tableone" class="td01">
    <td ><%=r.getString(teasession._nLanguage,"2592261394") %><%=r.getString(teasession._nLanguage,"2969876073")%>：<%=teasession._rv.toString() %></td>
   </tr>
    <tr id="tableone" class="td02">
    <td ><%=r.getString(teasession._nLanguage,"5477641348") %>：<%=pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage) %></td>
      </tr>
      <!-- 
    <tr id="tableone">
    <td >Email：<%=pobj.getEmail()%></td>
      </tr>
       -->
    <tr id="tableone" class="td03">
    <td ><%=r.getString(teasession._nLanguage,"0702651790")%><%=Entity.sdf.format(new Date()).substring(0,4) %><%=r.getString(teasession._nLanguage,"4408818403") %></td>
      </tr>
    <tr id="tableone" class="td04">
    <td ><%=r.getString(teasession._nLanguage,"8258432616") %>：<%=Entity.sdf2.format(Logs.getLastLogin(teasession._rv.toString())) %></td>
  </tr>
  
  <%


  if(AccessMember.find(teasession._nNode, teasession._rv._strV).getType()!=null && AccessMember.find(teasession._nNode, teasession._rv._strV).getType().indexOf("/94/")!=-1){ 
  	if(count>0){
  %>
   <tr id="tableone" class="td05">
    <td >待处理评论信息：<a href="/jsp/type/photography/TalkbackList.jsp"><span style="color:#f00;"><%=count %></span></a></td>
  </tr>
  <%
  	}
  	if(count2>0){
  %>
   <tr id="tableone" class="td06">
    <td >待处理作品信息：<a href="/jsp/type/photography/Photography.jsp?node=<%=teasession._nNode %>"><span style="color:#f00;"><%=count2 %></span></a></td>
  </tr>
  <%} %>
  <%
  //if(count>0 || count2>0){ 
	 
  %>
  
  <!-- 
	<div id="winpop2">
	 <div class="title2">温馨提示<span class="close2" onClick="tips_pop2()"><img style="margin-top:2px;"  src="https://ea.cebbank.com/res/ceb/u/1003/100324919.jpg"></span></div>
	    <div class="con2">系统信息：<br>
	    <%
	    if(count>0){
	    	out.print("待处理评论信息：<a href=\"/jsp/type/photography/TalkbackList.jsp\">"+count+"</a> ");
	    }
	    out.print("<br>");
	    if(count2>0){
	    	out.print("待处理作品信息：<a href=\"/jsp/type/photography/Photography.jsp?node="+teasession._nNode+"\">"+count2+"</a> ");
	    }
	    %>
	    
	    </div>
	</div>
  -->
  <%
  /*
		      out.print("<script src=\"/jsp/type/photography/window3.js\" type=\"text/javascript\" ></script>");
			  out.print("<script>");
			  out.print("var printbutton=document.getElementById('winpop2');");
			  out.print("printbutton.style.display='none';");
			   out.print("window.onload=function(){document.getElementById('winpop2').style.height='0px';setTimeout(\"tips_pop2()\",800);}");
			  out.print("</script>");
			  
  	}
  */
  
  }
  
  %>

</table>

</body>
</html>



