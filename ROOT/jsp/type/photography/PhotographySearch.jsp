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
StringBuffer sql = new StringBuffer(" and n.audit = 1 and n.type = 94 ");
StringBuffer param = new StringBuffer();

param.append("&community=").append(teasession._strCommunity);




String phoname = teasession.getParameter("phoname");
if(phoname!=null && phoname.length()>0){
	phoname = phoname.trim();
	sql.append(" AND ( nl.subject like ").append(DbAdapter.cite("%"+phoname+"%")).append(" or nl.content like "+DbAdapter.cite("%"+phoname+"%")+" )");
	param.append("&phoname=").append(URLEncoder.encode(phoname,"UTF-8"));
}

//类型
int photype = -1;
if(teasession.getParameter("photype")!=null && teasession.getParameter("photype").length()>0){
	photype = Integer.parseInt(teasession.getParameter("photype"));
}
if(photype>=0){
	
	sql.append(" AND  p.categories ="+photype);
	param.append("&photype=").append(photype);
}
   

int pos = 0, pageSize = 20, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}

count = Node.countPhotography(teasession._strCommunity,sql.toString());

%>




<form action="?" name="form1" method="GET"  >





<input type="hidden" name="community" value="<%=teasession._strCommunity %>">


  <table border="0" cellpadding="0" cellspacing="7" id="tablemy" >
  
  <tr>
  	<td colspan="4">
  		<table>
  			<tr>
  				<td nowrap>
				  					<input type="text" name="phoname" value="<%=Entity.getNULL(phoname) %>">&nbsp;&nbsp;<select name="photype">
					
					<option value="-1">-<%=r.getString(teasession._nLanguage,"610497756") %>-</option>
							<%
					
							
							java.util.Enumeration e_1 = Node.find(" and father = "+teasession._nNode,0,Integer.MAX_VALUE);
							while(e_1.hasMoreElements()){
								int fnid = ((Integer)e_1.nextElement()).intValue();
								Node fobj = Node.find(fnid);
								out.print("<option value="+fnid);
								if(photype == fnid){
									out.print(" selected ");
								}
								out.print(">"+fobj.getSubject(teasession._nLanguage));
								out.print("</option>"); 
							}
							
							%>
				</select>
  				</td>
  				<td nowrap>
					<%if(teasession._nLanguage==1){ %>
					<input type="image" name="button" id="button" src="/tea/image/zh_Search.jpg" style="border:none"/>
					<%}else if(teasession._nLanguage==0){ %> 
					<input type="image" name="button" id="button" src="/tea/image/en_Search.jpg" style="border:none"/>
					<%} %>
  				</td>
  			</tr>
  		</table>
  	</td>
  </tr>
   
	    <tr><td colspan="4"><%=r.getString(teasession._nLanguage,"125364475")%>&nbsp;<%=count %>&nbsp;<%=r.getString(teasession._nLanguage,"1992069817") %></td></tr>
    
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
			String pname = nobj.getSubject(teasession._nLanguage);
			
			
    		
    		Profile pfobj = Profile.find(nobj.getCreator().toString());
    		
    		out.print("<td valign=\"middle\">");
    		
	    	out.print("<div id=pro_img><a   style=cursor:pointer href=/html/photography/"+nid+"-"+teasession._nLanguage+".htm><img width=\"120\" src=\""+pobj.getAbbpicpath(teasession._nLanguage) +"\"></a></div>");
	    	out.print("<div id=pro_vote><a   style=cursor:pointer href=/html/photography/"+nid+"-"+teasession._nLanguage+".htm>"+pname+"</a></div>");
	    	out.print("<div id=pro_vote>"+r.getString(teasession._nLanguage,"By")+"："+pobj.getByname(teasession._nLanguage)+"</div>");
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

