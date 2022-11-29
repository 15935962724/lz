<%@page contentType="text/html;charset=UTF-8"  %>
<%@page import="java.io.*" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.ui.*"%>
<%@page import="tea.db.*"%>
<%@page import="java.util.*"%>
<%@page import="tea.htmlx.*"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLConnection"%>
<%
	response.setHeader("Expires", "0");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");

	TeaSession teasession = new TeaSession(request);
	if (teasession._rv == null) {
		response.sendRedirect("/servlet/StartLogin?node="
				+ teasession._nNode + "&nexturl="
				+ request.getRequestURI() + "?"
				+ request.getQueryString());
		return;
	}
	String nexturl = request.getRequestURI();

	Resource r=new Resource("/tea/resource/Photography");

	String menuid = request.getParameter("id");

	Community c = Community.find(teasession._strCommunity);

	StringBuilder sql = new StringBuilder();
	StringBuilder param = new StringBuilder();
	
	param.append("?node=").append(teasession._nNode);
	param.append("&id=").append(menuid);

	sql.append(" AND node IN(SELECT node FROM Node WHERE path LIKE '/"+ c.getNode() + "/%')");

	
	sql.append(" and hidden = 1");
	
	
	
	  sql.append(" AND audittime >=").append(DbAdapter.cite(Entity.sdf.format(new Date())+" 00:00"));
	  sql.append(" AND audittime <=").append(DbAdapter.cite(Entity.sdf.format(new Date())+" 23:59"));
	
	
	

	int pos = 0, size = 15, count = 0;
	count = Talkback.count(sql.toString());
	
	
	
	if (request.getParameter("pos") != null) {
		pos = Integer.parseInt(request.getParameter("pos"));
	}
	

	sql.append(" ORDER BY talkback DESC");
%>








<form name="form1" action="?" >




<h2>
<%=r.getString(teasession._nLanguage, "9457093840")%>&nbsp;(&nbsp;<%=java.text.MessageFormat.format(r.getString(teasession._nLanguage,"0532592166"),new String[] {String.valueOf(count)}) %>)&nbsp;
</h2>


<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
   
    <td nowrap><%=r.getString(teasession._nLanguage,"8568761478") %></td>

    <td nowrap><%=r.getString(teasession._nLanguage, "Title")%></td>
    <td nowrap><%=r.getString(teasession._nLanguage, "2376792532")%></td>
    <td nowrap><%=r.getString(teasession._nLanguage, "6948521657")%></td>
  </tr>
<%


	Enumeration e = Talkback.find(sql.toString(), pos, size);
	if (!e.hasMoreElements()) {
		out.print("<tr><td colspan='20' align='center'>"+r.getString(teasession._nLanguage,"5663756403")+"</td></tr>");
	}
	for (int i = 1; e.hasMoreElements(); i++) {
		int tkid = ((Integer) e.nextElement()).intValue();
		Talkback obj = Talkback.find(tkid);
		int nodeid = obj.getNode();
	
		String subject = obj.getSubject(teasession._nLanguage);
		String trtext = obj.getContent(teasession._nLanguage);
		int contr = TalkbackReply.countByTalkback(tkid);

%>

	   <tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>

		   <td nowrap><%=i+pos%></td>
		   
		    <td nowrap><%=Node.find(nodeid).getAnchor(teasession._nLanguage,"_blank",null,Integer.MAX_VALUE)%></td>
		<td nowrap>
		
		 <%
			    	if(trtext!=null && trtext.length()>0){
			    		trtext=Report.getHtml2(trtext);
			    		if(trtext.length()>25){
			    			out.print("<textarea style=display:none id=content_"+tkid+" >"+trtext+"</textarea><a href=\"javascript:var obj=window.open('','','height=250,width=500,left=400,top=300,scrollbars=yes,toolbar=no,status=no,menubar=no,location=no,resizable=yes');obj.document.write(document.getElementById('content_"+tkid+"').value);\" >"+trtext.replaceAll("&nbsp;","").substring(0,25)+"...</a>");//&#39;
			    		}else{
			    			out.print(trtext);
			    		} 
			    	}
			    %>
		</td>
		    
		    <td nowrap><%=contr%></td>
		   
		</tr>
    <%
    	}
    %>
     
<%
     	if (count > size) {
     %>
      <tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage, nexturl+ param.toString() + "&pos=", pos, count, size)%>    </td> </tr>
<%
	}
%>


</table>

</form>

