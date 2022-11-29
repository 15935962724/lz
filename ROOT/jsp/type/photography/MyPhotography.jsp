<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.photography.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.html.*"%>
<%@page import="tea.db.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.resource.*"%><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%@page import="java.net.URLEncoder"%><%@page import="tea.entity.Entity"%>

<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);



out.println("<script src=\"/tea/mt.js\" type=\"text/javascript\"></script>  ");

if(teasession._rv == null)
{
	out.println("<script>");
	out.println("window.location.href='/servlet/StartLogin?node="+teasession._nNode+"&language="+teasession._nLanguage+"&nexturl='+location.href;");
	out.println("</script>");
	return; 
}   
 


Resource r=new Resource("/tea/resource/Photography");

String nexturl = request.getRequestURL() + "?node="+teasession._nNode+ request.getContextPath();

StringBuffer sql = new StringBuffer(" and n.rcreator="+DbAdapter.cite(teasession._rv.toString())+" and n.type = 94 ");

 
%>




<script>
 function f_edit(igd)
 {
	
 	 var url = '/html/folder/'+form1.phonode.value+'-<%=teasession._nLanguage%>.htm?node='+igd;
 	 form1.NewNode.value='';
	 form1.Type.value='0';
     form1.target =''; 
 	 form1.action =url;
 	 form1.submit();
 }
 function f_add()
 {
	 var url = '/html/folder/'+form1.phonode.value+'-<%=teasession._nLanguage%>.htm';
	 form1.NewNode.value='O';
	 form1.Type.value='-1';
 	 //form1.target ='_ajax'; 
 	 form1.action =url;
 	 form1.submit();
 	 document.getElementsByName(name).innerHTML
 	
 }
 </script>
 <script src="/tea/lightbox.js" type="text/javascript"></script>
<link href="/tea/lightbox.css" rel="stylesheet" type="text/css" />
<form action="?" name="form1" method="POST"  >

<input type="hidden" name ="phonode" value="<%=teasession.getParameter("phonode") %>"/>
<input type="hidden" name ="editnode" value="<%=teasession.getParameter("editnode") %>"/>
<input type="hidden" name="nexturl" value="<%=nexturl %>"/>
<input type="hidden" name="node" value="<%=teasession.getParameter("editnode") %>"/>
<input type="hidden" name="add-1-5-6-7" value="-1-2-3-4-5-6"/>
<input type="hidden" name="NewNode">
<input type="hidden" name="Type">

  <table border="0" cellpadding="0" cellspacing="7">
   
	    
    
    <%

    	Enumeration e = Node.findPhotography(teasession._strCommunity,sql.toString(),0,20);
        int i = 1;
    	while(e.hasMoreElements())
    	{
    		if(i%4==1)
    		{
    			out.print("  <tr>");
    		}
    		
    		int nid = ((Integer)e.nextElement()).intValue();
    		Node nobj = Node.find(nid);
    		Photography pobj =  Photography.find(nid);

    		Profile pfobj = Profile.find(nobj.getCreator().toString());
    	
    		out.print("<td>");
    	
	    	out.print("<table cellpadding=0 cellspacing=0><tr><td>");
	    	out.print("<a title=\""+nobj.getSubject(teasession._nLanguage)+"\" href=\""+pobj.getPicpath(teasession._nLanguage)+"\" rel=\"lightbox\" >");
	    	out.print("<img width=\"120\" src=\""+pobj.getAbbpicpath(teasession._nLanguage) +"\"  title=\""+nobj.getSubject(teasession._nLanguage)+"\">");
	    	out.print("</a>");
	    	out.print("</td></tr></table>");
	    	out.print("<div id=pro_vote>"+r.getString(teasession._nLanguage,"545980596")+"："+pobj.getVotenumber()+"</div>");
	    	out.print("<div id=pro_button><input type=button value="+r.getString(teasession._nLanguage,"672021869")+" onclick=f_edit('"+nid+"');  ></div>");
	    	//onclick=window.open('/html/folder/"+teasession.getParameter("phonode")+"-"+teasession._nLanguage+".htm?node="+nid+"&editnode="+teasession.getParameter("editnode")+"&phonode="+teasession.getParameter("phonode")+"&nexturl="+URLEncoder.encode(nexturl,"UTF-8")+"','_self');
	    	out.print("</td>");
	    	if(i%4==0)
	    	{
	    		out.print("  </tr>");
	    	}
			i++;
	  	}
    	
    	
    	for(int j =i;j<=20;j++)
    	{

    		if(j%4==1)
    		{
    			out.print("  <tr id=tablemytr>");
    		}
			out.print("<td>");
	    	out.print("<table cellpadding=0 cellspacing=0><tr><td>"+r.getString(teasession._nLanguage,"1498648709")+"</td></tr></table>");
	    	out.print("<div id=pro_up><input type=button value="+r.getString(teasession._nLanguage,"1559578502")+"   onclick=f_add(); ></div>");
	    	//onclick=window.open('/html/folder/"+teasession.getParameter("phonode")+"-"+teasession._nLanguage+".htm?NewNode=ON&Type=-1&node="+teasession.getParameter("editnode")+"&editnode="+teasession.getParameter("editnode")+"&phonode="+teasession.getParameter("phonode")+"&nexturl="+URLEncoder.encode(nexturl,"UTF-8")+"','_self');>
	    	out.print("</td>");
	    	if(j%4==0)
	    	{
	    		out.print("</tr>"); 
	    	}
			
    	}	
    	
    	
    	%>

  </table>

</form>

