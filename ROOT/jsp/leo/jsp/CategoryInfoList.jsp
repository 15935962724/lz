<%@page import="tea.entity.node.Reserve"%>
<%@page import="tea.entity.node.Node"%>
<%@page import="tea.entity.Http"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page
	import="java.util.*"%>
<%@page import="tea.db.*"%>

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
<div class="title"><span>保护区名录</span><div class="arrangement" style="text-align:right;padding-right:20px;"><a href="/html/papc/folder/946895-1.htm" target="_blank" style="color:#228C00;font-weight:bold;">地球模式</a></div></div>

		<%
			int city = h.getInt("city");
			int type = h.getInt("type");
			int level = h.getInt("level");
			StringBuffer par = new StringBuffer("?");
			StringBuffer sql = new StringBuffer("");
			if (city >= 0) {
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
					htmls.append("<li>"+n2.getAnchor(h.language).toString()+"</li>");
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
</div>