<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.photography.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.html.*"%>
<%@page import="tea.db.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.resource.*"%><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%@page import="java.net.URLEncoder"%><%@page import="tea.entity.Entity"%>

<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);


String member = teasession.getParameter("member");

Resource r=new Resource("/tea/resource/Photography");
String nexturl = request.getRequestURL() + "?node="+teasession._nNode+ request.getContextPath();

StringBuffer sql = new StringBuffer(" and n.audit =1 and n.type = 94 ");
StringBuffer param = new StringBuffer();
param.append("?node=").append(teasession._nNode);
if(member!=null && member.length()>0)
{ 
	sql.append(" and n.rcreator="+DbAdapter.cite(member));
	param.append("&member=").append(URLEncoder.encode(member,"UTF-8"));
}

int pos = 0, pageSize =20, count = 0;


count = Node.countPhotography(teasession._strCommunity,sql.toString());

if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}



%>

<script src="/tea/mt.js" type="text/javascript"></script>  

<script>
function f_vote(igd,d,l)
{
	sendx("/servlet/EditPhotography?act=edivote&node="+igd+"&1-11111111-1111111111111-a="+d,
		function(data)
		{
			alert(data);	
			//window.open('/html/photography/'+igd+'-'+l+'.htm','_self');
			window.open(location.href,'_self');
		}
	);
}
	  		
</script>

<form action="?" name="form1" method="POST"  >

<input type="hidden" name ="phonode" value="<%=teasession.getParameter("phonode") %>"/>
<input type="hidden" name ="editnode" value="<%=teasession.getParameter("editnode") %>"/>
<input type="hidden" name="nexturl" value="<%=nexturl %>"/>
<input type="hidden" name="node" value="<%=teasession.getParameter("editnode") %>"/>



  <table border="0" align="left" cellpadding="0" cellspacing="7" id="tablemy">
   
	    
    
    <%

    	Enumeration e = Node.findPhotography(teasession._strCommunity,sql.toString(),pos,pageSize);
        int i = 1;
    	while(e.hasMoreElements())
    	{
    		if(i%4==1)
    		{
    			out.print("  <tr id=tablemytr>");
    		}
    		
    		int nid = ((Integer)e.nextElement()).intValue();
    		Node nobj = Node.find(nid);
    		Photography pobj =  Photography.find(nid);

    		Profile pfobj = Profile.find(nobj.getCreator().toString());
    		
    		
    		
    		java.text.SimpleDateFormat sdf3 = new java.text.SimpleDateFormat("yyyyMMddHHmmss");
			//String value="<input type=button value="+r.getString(teasession._nLanguage,"Vote")+" onclick=window.open('/servlet/EditPhotography?act=edivote&node="+nid+"&1-11111111-1111111111111-a="+sdf3.format(new Date())+"','_self');>"; 
			  String value="<input type=button   style=cursor:pointer value="+r.getString(teasession._nLanguage,"Vote")+" onclick=f_vote('"+nid+"','"+sdf3.format(new Date())+"','"+teasession._nLanguage+"');> ";
    		out.print("<td width=155>");
    		
	    	out.print("<div id=pro_img><a   style=cursor:pointer href=/html/photography/"+nid+"-"+teasession._nLanguage+".htm><img width=\"120\" src=\""+pobj.getAbbpicpath(teasession._nLanguage) +"\"></a></div>");
	    	out.print("<div id=pro_vote><a   style=cursor:pointer href=/html/photography/"+nid+"-"+teasession._nLanguage+".htm>"+nobj.getSubject(teasession._nLanguage)+"</a></div>");
	    	out.print("<div id=pro_button>"+value+"&nbsp;<input style=cursor:pointer type=button value="+r.getString(teasession._nLanguage,"Talkbacks")+" onclick=window.open('/jsp/talkback/Talkbacks.jsp?node="+nid+"','_blank'); ></div>");
	    	//onclick=window.open('/html/folder/"+teasession.getParameter("phonode")+"-"+teasession._nLanguage+".htm?node="+nid+"&editnode="+teasession.getParameter("editnode")+"&phonode="+teasession.getParameter("phonode")+"&nexturl="+URLEncoder.encode(nexturl,"UTF-8")+"','_self');
	    	out.print("</td>");
	    	if(i%4==0)
	    	{
	    		out.print("  </tr>");
	    	}
			i++;
	  	} 

    	%>
    	
     <%if (count > pageSize) {  %>
      <tr> <td colspan="20"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
      <%}  %>
  </table>

</form>

