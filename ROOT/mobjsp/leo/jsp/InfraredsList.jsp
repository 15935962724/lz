<%@page contentType="text/html; charset=UTF-8"%><%@page
	import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.util.Card"%>
<%
	Map<Integer,String> map = new HashMap<Integer,String>();
	DbAdapter db = new DbAdapter();
	StringBuffer htmls = new StringBuffer();
	try {
		java.sql.ResultSet rs = db
				.executeQuery(
						"SELECT min(node),bhqname,COUNT(bhqname) FROM infrared WHERE pstime IS NOT NULL AND wzname!='' GROUP BY bhqname",
						0, Integer.MAX_VALUE);
		htmls.append("<ul>");
		while (rs.next()) {
			int i = 1;
			int node = rs.getInt(i++);
			String bhqname = rs.getString(i++);
			int priceNums = rs.getInt(i++);
			String href = "/xhtml/papc/folder/13100959-1.htm?node="+node;
			htmls.append("<li><span><a title='"+bhqname+"' href='"+href+"'>"+bhqname+"("+priceNums+")</a></span></li>");
		}
		htmls.append("</ul>");
		rs.close();
	} finally {
		db.close(); 
	}
%>

<div class="title"><span>红外相机数据库</span></div>
<div class="search1">
		<form name="form1" action="/xhtml/papc/folder/13100959-1.htm" method="post">
			<table cellspacing="0" cellpadding="0" border="0" class="tab2">
				<tr>
					<td class="th">保护区名称：</td>
					<td colspan="2">
						<input name="bhqname" value="" class="text"/>
					</td>
                </tr>
                <tr>
					<td class="th">物种名称：</td>
					<td>
						<input name="wzname" value="" class="text1" />
					</td>
					<td class="th"><input type="submit" value="查询" class="sub" /></td>
				</tr>
			</table>
		</form>
        </div>
        <div class="list">
		<%=htmls.toString() %>
        </div>

