<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.photography.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.html.*"%>
<%@page import="tea.db.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.resource.*"%><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%@page import="java.net.URLEncoder"%><%@page import="tea.entity.Entity"%>

<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);
Resource r=new Resource("/tea/resource/Photography");

if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String nexturl = teasession.getParameter("nexturl");
 

int count =  Node.countPhotography(teasession._strCommunity,"  and n.type = 94  and n.rcreator ="+DbAdapter.cite(teasession._rv.toString()));
//out.print("<script  language='javascript'>"); 
//
//out.print("alert('您的作品已经上传成功,感谢您的参与。\\n\\n您还可以上传"+(20-count)+"幅作品。');");
//out.print("history.go(-2);"); 
out.print(r.getString(teasession._nLanguage,"135838925")+(20-count)+r.getString(teasession._nLanguage,"559573914")+"。<br>");
out.print(r.getString(teasession._nLanguage,"926356832")+"。<br>"); 
if(count<20){
	out.print("<input type=button value="+r.getString(teasession._nLanguage,"757145412")+"   onclick=f_on();>");
}else
{ 
	out.print(r.getString(teasession._nLanguage,"953705423"));
}

out.print("<input type=button value="+r.getString(teasession._nLanguage,"365139969")+"   onClick=window.parent.location='"+nexturl+"'; >"); 

%>
<style>
*{ font-size:12px;line-height:20px;}
input {width:70px;height:20px;margin:5px;}
</style>
<form name="form1" action="/html/folder/<%=teasession.getParameter("phonode")%>-<%=teasession._nLanguage%>.htm" method="post">
<input type="hidden" name="phonode" value="<%=teasession.getParameter("phonode")%>"/>
<input type="hidden" name="NewNode" value="ON"/>
<input type="hidden" name="Type" value="-1"/>
<input type="hidden" name="node" value="<%=teasession.getParameter("editnode")%>"/>
<input type="hidden" name="add-1-5-6-7" value="-1-2-3-4-5-6"/>
<input type="hidden" name="editnode" value="<%=teasession.getParameter("editnode")%>"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>

</form>

<script>
	function f_on()
    {
        if(window.parent.length>0){
        	//form1.submit(); 
        	window.parent.location='/html/folder/<%=teasession.getParameter("phonode")%>-<%=teasession._nLanguage%>.htm?NewNode=ON&Type=-1&node=<%=teasession.getParameter("editnode")%>&add-1-5-6-7=-1-2-3-4-5-6&phonode=<%=teasession.getParameter("phonode")%>&editnode=<%=teasession.getParameter("editnode")%>&nexturl=<%=nexturl%>';
        }
         
    } 
</script>
