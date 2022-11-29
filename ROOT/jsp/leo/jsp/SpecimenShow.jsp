<%@page contentType="text/html; charset=UTF-8"%><%@page
	import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.node.*"%>
<%

Http h=new Http(request,response);


StringBuffer sqlList=new StringBuffer();
sqlList.append("select firstlevel,secondlevel,count(species1) from Specimen "+
		" where firstlevel is not null and firstlevel <> '' "+
		" group by firstlevel,secondlevel order by firstlevel");
DbAdapter db = new DbAdapter();
java.sql.ResultSet rs = null;
StringBuffer sbdw = new StringBuffer("<ul><li style='font-size:14px;'>动物</li>");
StringBuffer sbzw = new StringBuffer("<ul><li style='font-size:14px;'>植物</li>");
StringBuffer sbjw = new StringBuffer("<ul><li style='font-size:14px;'>菌物</li>");
try {
	rs = db.executeQuery( sqlList.toString(), 0, Integer.MAX_VALUE);
	while (rs.next()) {
		int i = 1;
		String f = rs.getString(i++);
		String s = rs.getString(i++);
		s = (null==s || "".equals(s)) ? "" : s;
		int n = rs.getInt(i++);
		if("动物".equals(f))
			sbdw.append("<li><a href=\"/html/papc/folder/13113599-1.htm?firstlevel="+f+"&secondlevel="+s+"\">"+s+"("+n+")</a></li>");
		else if("植物".equals(f))
			sbzw.append("<li><a href=\"/html/papc/folder/13113599-1.htm?firstlevel="+f+"&secondlevel="+s+"\">"+s+"("+n+")</a></li>");
		else if("菌物".equals(f))
			sbjw.append("<li><a href=\"/html/papc/folder/13113599-1.htm?firstlevel="+f+"&secondlevel="+s+"\">"+("".equals(s) ? "全部" : s)+"("+n+")</a></li>");
	}
	rs.close();
} catch (Exception e) {
	e.printStackTrace();
} finally {
	db.close();
}
sbdw.append("</ul>");
sbzw.append("</ul>");
sbjw.append("</ul>");
%>

		<link href="/res/<%=h.community%>/cssjs/community.css"
			rel="stylesheet" type="text/css" />
		<script src="/tea/tea.js" type="text/javascript"></script>
		<script src="/tea/mt.js" type="text/javascript"></script>
		<script src="/tea/jquery-1.3.1.min.js" type="text/javascript"></script>


    <div class="reserveList">
<div class="title"><span>标本库</span></div>
		
		<!--<div id="head6">
			<img height="6" src="about:blank">
		</div>
		<h2>
			列表
		</h2>-->
        <div class="list">
			<%=sbdw.toString() %>
			<%=sbzw.toString() %>
			<%=sbjw.toString() %>
        </div>
</div>