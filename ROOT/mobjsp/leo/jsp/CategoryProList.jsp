<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<%@page contentType="text/html; charset=UTF-8"%><%@page
	import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.util.Card"%>
<%
	Http h = new Http(request, response);
	int node = h.getInt("node");
	Node n = Node.find(node);
    int nums=0;
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
						"SELECT city,sum(1) FROM reserve WHERE node IN (SELECT node FROM node WHERE hidden = 0) and city>0 group by city order by city",
						0, Integer.MAX_VALUE);
		
		while (rs.next()) {
			int i = 1;
			int cityNum = rs.getInt(i++);
			int num=rs.getInt(i++);
			nums+=num;
			String city = Card.find(cityNum).toString();
			map.put(cityNum, city+"("+num+")");
		}
		rs.close();
	} finally {
		db.close();
	}
%>
		<script src="/tea/mt.js" type="text/javascript"></script>
		<script src="/tea/city.js" type="text/javascript"></script>
        <script src="/tea/jquery.js" type="text/javascript"></script>
<div class="reserveList">
<div class="title">
<span>保护区名录</span>
<div class="search">
<form name="form1" action="/xhtml/papc/folder/13100755-1.htm" method="post">
			<table cellspacing="0" cellpadding="0" border="0" class="tab1">
				<tr>
					<td class="th">
						类型：
					</td>
					<td>
						<select name="type"><%=h.options(Reserve.RESERVE_TYPE, t.type)%></select>
					</td>
					<td class="th">
						级别：
					</td>
					<td>
						<select name="level"><%=h.options(Reserve.LEVEL_TYPE, t.level)%></select>
					</td>
					<td class="th">
						省份：
					</td>
					<td>
						<script>mt.city('city',null,null,"<%=t.city%>")</script>
					</td>
					<td class="th">
						<input type="submit" value="查询" />
					</td>
				</tr>
			</table>
		</form>
        </div>
        <div class="arrangement" style="text-align:right;padding-right:20px;">
        <a href="/xhtml/papc/folder/946895-1.htm" target="_blank" style="color:#228C00;font-weight:bold;">地球模式</a>
        </div>
        </div>
<div class="list">
<span>共有<%=nums %>个保护区</span>
<ul>
		
	<%
		Object[] key = map.keySet().toArray();
		Arrays.sort(key);
		for (int j = 0; j < key.length; j++) {
			out.print("<li><a href='/xhtml/papc/folder/13100755-1.htm?city="
					+ key[j] + "'>" + map.get(key[j]) + "\t</a></li>");
		}
	%>
</ul>
</div>

</div>