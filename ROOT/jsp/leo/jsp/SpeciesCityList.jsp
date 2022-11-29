<%@page import="tea.entity.node.Node"%>
<%@page import="tea.entity.node.Reserve"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page
	import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.util.Card"%>
<%
	Http h = new Http(request, response);
	int node = h.getInt("node");
	Node n = Node.find(node);

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

	Map<Integer, String> map = new HashMap<Integer, String>();
	DbAdapter db = new DbAdapter();
	try {
		java.sql.ResultSet rs = db
				.executeQuery(
						"SELECT distinct city FROM reserve WHERE node IN (SELECT node FROM node WHERE hidden = 0) ORDER BY city",
						0, Integer.MAX_VALUE);
		while (rs.next()) {
			int i = 1;
			int cityNum = rs.getInt(i++);
			String city = Card.find(cityNum).toString();
			map.put(cityNum, city);
		}
		rs.close();
	} finally {
		db.close();
	}
%>

		<script src="/tea/mt.js" type="text/javascript"></script>
		<script src="/tea/city.js" type="text/javascript"></script>
<div class="reserveList">
<div class="title"><span>保护区物种</span><div class="search"><form name="form1" action="/html/papc/folder/13113595-1.htm" method="post">
			<table cellspacing="0" cellpadding="0" border="0">
				<tr>
					<td>
					    <select name="type">
					      <option value="ranimal">动物</option>
					      <option value="rplant">植物</option>
					    </select>
						<input type="text" name="rname" onblur="if (value ==''){value='保护区名称....'}"  onfocus="if (value =='保护区名称....'){value =''}; " value="保护区名称...." />
						<input type="text" name="name" onblur="if (value ==''){value='物种名称....'}"  onfocus="if (value =='物种名称....'){value =''}; " value="物种名称...." />
					</td>
					<td class="th">
						<input type="submit" value="查询" />
					</td>
				</tr>
			</table>
		</form></div></div>
<div class="list">
<ul>
		
	<%
		Object[] key = map.keySet().toArray();
		Arrays.sort(key);
		for (int j = 0; j < key.length; j++) {
			out.print("<li><a href='/html/papc/folder/13113593-1.htm?city="
					+ key[j] + "'>" + map.get(key[j]) + "\t</a></li>");
		}
	%>
</ul>
</div>

</div>