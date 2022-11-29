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
	
	StringBuffer par=new StringBuffer("?type="+type+"&rname="+h.enc(rnameSerach));
	int pos=h.getInt("pos");
	
	int sum = 0;
	int size=h.getInt("size",20);
	Map<String, String> map = new HashMap<String, String>();
	StringBuffer htmls = new StringBuffer();
	DbAdapter db = new DbAdapter();
	java.sql.ResultSet rs = null;
	String sql = "select node,species1 from "+type+" where rname is not null and rname like '"+rnameSerach+"'";
	String sqlCount = "select count(species1) from "+type+" where rname is not null and rname like '"+rnameSerach+"'";
	try {
		rs = db.executeQuery(sqlCount,0, Integer.MAX_VALUE);
		while (rs.next()) {
			int i = 1;
			int count = rs.getInt(i++);
			sum = count;
		}
		rs = db.executeQuery(sql, pos , 32);
		htmls.append("<ul>");
		while (rs.next()) {
			int i = 1;
			int no=rs.getInt(i++);
			String species1 = rs.getString(i++);
			//String href = "/jsp/leo/jsp/SpeciesListByInfo.jsp"+par.toString()+"&species1="+species1;
			String href="/html/papc/category/13113876-1.htm?type="+type+"&node="+no;
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
         <script src="/tea/jquery.js" type="text/javascript"></script>

<div class="title"><span>保护区物种</span></div>
<div class="search1">
<form name="form1" action="/xhtml/papc/folder/13113595-1.htm" method="post" >
			<table cellspacing="0" cellpadding="0" border="0" class="tab2">
				<tr>
					<td>
						<input type="text" value="" class="text"/>
					</td>

					<td class="th">
						<input type="submit" value="查询" class="sub"/>
					</td>
				</tr>
			</table>
		</form>

</div>
		<% 
			if(sum < 1) out.print("<div>暂无记录!</div>"); 
			else {
		%>
		<div class="list">
			<%=htmls.toString() %>
		</div>
		<%
			}
		if( sum > 20 ) out.print("<div id=\"PageNum\">"+new tea.htmlx.FPNL(h.language, par.toString()+"&pos=", pos, sum,size)+"</div>");
		%>
<script>var as=document.getElementById('PageNum').getElementsByTagName('A');for(var i=0;i<as.length;i++){if(/\d/.test(as[i].innerHTML))as[i].style.display='none';}</script>

