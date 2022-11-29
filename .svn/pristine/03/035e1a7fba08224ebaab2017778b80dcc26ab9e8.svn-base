<%@page contentType="text/html; charset=UTF-8"%><%@page
	import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.util.Card"%>
<%
	Http h = new Http(request, response);
	int node = h.getInt("node");
	Node n = Node.find(node);
	String type = h.get("type","ranimal");
	String rnameSerach = h.get("rname","");
	String species1Search = h.get("species1","");
	
	StringBuffer par=new StringBuffer("?type="+type+"&rname="+rnameSerach);
	int pos=h.getInt("pos");
	par.append("&pos=");
	int sum = 0;
	
	Map<String, String> map = new HashMap<String, String>();
	StringBuffer htmls = new StringBuffer();
	DbAdapter db = new DbAdapter();
	java.sql.ResultSet rs = null;
	String sql = "select species1 from "+type+" where species1 like '"+species1Search+"' and rname is not null and rname like '"+rnameSerach+"'";
	String sqlCount = "select count(species1) from "+type+" where species1 like '"+species1Search+"' and rname is not null and rname like '"+rnameSerach+"'";
	try {
		rs = db.executeQuery(sqlCount,0, Integer.MAX_VALUE);
		while (rs.next()) {
			int i = 1;
			int count = rs.getInt(i++);
			sum = count;
		}
		rs = db.executeQuery(sql, pos , 20);
		htmls.append("<ul>");
		while (rs.next()) {
			int i = 1;
			String species1 = rs.getString(i++);
			//详情页连接
			String href = "";
			htmls.append("<li><span ><a title='"+species1+"' href='"+href+"'>"+species1+"</a></span></li>");
		}
		htmls.append("</ul>");
		rs.close();
	} finally {
		db.close();
	}
	
%>

		<script src="/tea/mt.js" type="text/javascript"></script>
		<script src="/tea/city.js" type="text/javascript"></script>
<div class="reserveList">
<div class="title"><span>保护区物种</span><div class="search"><form name="form1" action="/xhtml/papc/folder/13100755-1.htm" method="post">
			<table cellspacing="0" cellpadding="0" border="0">
				<tr>
					<td>
						<input type="text" value="" />
					</td>
					<td class="th">
						<input type="submit" value="查询" />
					</td>
				</tr>
			</table>
		</form></div></div>
		<% 
			if(sum < 1) out.print("<div>暂无记录!</div>"); 
			else {
		%>
		<div class="list">
			<%=htmls.toString() %>
		</div>
		<%
			}
		if( sum > 20 ) out.print("<div>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20)+"</div>");
		%>

</div>