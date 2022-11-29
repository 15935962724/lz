<%@page contentType="text/html; charset=UTF-8"%><%@page
	import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.util.Card"%>
<%
	Http h = new Http(request, response);
	int nodeInt = h.getInt("node");
	Node n = Node.find(nodeInt);
	int pos = h.getInt("pos");
	Reserve t = null;
	String subject = null, content = null, picture = null;
	if (n.getType() == 1) {
		t = new Reserve(0, h.language);
	} else {
		subject = n.getSubject(h.language);
		content = n.getText(h.language);
		picture = n.getPicture(h.language);

		t = Reserve.find(h.node, h.language);
	}
%>
<div class="reserveList">
<div class="title"><span>保护区名录</span><div class="arrangement" style="text-align:right;padding-right:20px;">
</div></div>

		<%
			int city = h.getInt("city");
			int type = h.getInt("type");
			int level = h.getInt("level");
			StringBuffer par = new StringBuffer("?");
			StringBuffer sql = new StringBuffer("");
			if (city > 0) {
				sql.append(" AND city = " + city);
				par.append("&city="+city);
			}
			if (type > 0) {
				sql.append(" AND type = " + type);
				par.append("&type="+type);
			}
			if (level > 0) {
				sql.append(" AND level = " + level);
				par.append("&level="+level);
			}
			StringBuffer htmls = new StringBuffer("");
			int sum = Reserve.count(sql.toString()+ " AND node IN (SELECT node FROM node WHERE hidden = 0)");
			DbAdapter db = new DbAdapter();
			try {
				java.sql.ResultSet rs = db
						.executeQuery(
								"SELECT node FROM reserve WHERE 1=1 "
										+ sql.toString()
										+ " AND node IN (SELECT node FROM node WHERE hidden = 0) ORDER BY node",
								pos, 32);
				htmls.append("<div class='list' id='target'><ul>");
				while (rs.next()) {
					int i = 1;
					int node = rs.getInt(i++);
					Node n2 = Node.find(node);
					htmls.append("<li><a href='/xhtml/"+h.community+"/reserve/"+node+"-1.htm'>"+n2.getSubject(h.language)+"</a></li>");
				}
				if(sum>32){
					htmls.append("<li id='PageNum'>"+new tea.htmlx.FPNL(h.language,par.toString()+"&pos=",pos,sum,32));
				}
				htmls.append("</ul></div>");
				rs.close();
			} finally {
				db.close();
			}
		%>
        
		<%=htmls.toString() %>
        <script> var as=document.getElementById('PageNum').getElementsByTagName('A'); for(var i=0;i<as.length;i++){if(/\d/.test(as[i].innerHTML))as[i].style.display='none';} </script>
</div>