<%@page import="tea.entity.util.Lucene"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.node.Book"%>
<%@page import="tea.entity.MT"%>
<%@page import="tea.entity.Http"%>
<%@page import="tea.entity.node.Node"%>
<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="/tea/view.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<%
	Http h = new Http(request, response);
   int no= h.getInt("node", 14010168);
   int father=Book.find(no).getType();
    
	int pos = h.getInt("pos", 0);
	int size = h.getInt("size", 10);
	StringBuffer sql = new StringBuffer(), par = new StringBuffer(
			"?1=1");
	sql.append(" AND b.type="+father+" and b.node!="+no);
	sql.append(" AND n.type=12 and hidden=0 AND finished=1");
	int recommended = h.getInt("recommended", 0);
	if(recommended>0){
		sql.append(" and n.recommended=1");
	}

	int sum = Node.count(sql.toString());
	
	sql.append(" order by n.click desc");
	
	
%>


<!--<div class="right_con">-->
	<%
	if(sum<1){
		out.print("<div class='msg'>暂无记录</div>");
	}else{%>
	<%
		Enumeration e = Node.find(sql.toString(), pos, size);
		for (int i = 0; e.hasMoreElements(); i++) {
			int node = ((Integer) e.nextElement()).intValue();
			Node n = Node.find(node);
			Book b = Book.find(node);
			if (b != null) {
				String name = MT.f(n.getSubject(h.language), 16);
				//String url="/html/"+n.getCommunity()+"/book/"+node+"-"+h.language+".htm";
				String url = "/html/jskxcbs/folder/14011316-1.htm?node="
						+ node;
	%>
	<div class="right_con02">
		<div class="left">
			<span id="BookIDbigpicture"><a href="<%=url%>"> <img border="0" src="<%=b.getSmallPicture(h.language) %>" /></a></span>
		</div>
		<div class="center">
            	<span id="BookIDsubject">
                	<a href="<%=url%>"><%=n.getSubject(h.language)%></a>
                </span>
                <span id="Book"><%=MT.f(Lucene.t(n.getText(h.language)),60)%></span>
		</div>
 	</div>
	<%
		}
		}
		if (sum > size&&size==10)
			out.print("<div class='fy'>"
					+ new tea.htmlx.FPNL(h.language, par.toString(), pos,
							sum, size) + "</div>");
	%>
    <%
	}
	%>


