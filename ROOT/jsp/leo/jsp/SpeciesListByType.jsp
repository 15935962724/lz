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
	if(rnameSerach.equals("保护区名称...."))rnameSerach="";
	String species=h.get("name","");
	if(species.equals("物种名称...."))species="";
	StringBuffer par=new StringBuffer("?type="+type+"&rname="+h.enc(rnameSerach));
	int pos=h.getInt("pos");
	
	int sum = 0;
	int size=h.getInt("size",20);
	Map<String, String> map = new HashMap<String, String>();
	StringBuffer htmls = new StringBuffer();
	DbAdapter db = new DbAdapter();
	java.sql.ResultSet rs = null;
	String sql = "select node,species1 from "+type+" where rname is not null ";
	
	String sqlCount = "select count(species1) from "+type+" where rname is not null ";
	if(rnameSerach.length()>0){
		sql+=" and rname like "+DbAdapter.cite("%"+rnameSerach+"%");
		sqlCount+=" and rname like "+DbAdapter.cite("%"+rnameSerach+"%");
		par.append("&name="+species);
	}
	if(species.length()>0){
		sql+=" and species1 like "+DbAdapter.cite("%"+species+"%");
		sqlCount+=" and species1 like "+DbAdapter.cite("%"+species+"%");
		par.append("&name="+species);
	}
	if(species.length()>0){
		sql+=" and species1 like "+DbAdapter.cite("%"+species+"%");
		sqlCount+=" and species1 like "+DbAdapter.cite("%"+species+"%");
		par.append("&name="+species);
	}
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
<div class="reserveList">
<div class="title"><span>保护区物种</span><div class="search"><form name="form1" action="/html/papc/folder/13113595-1.htm" method="get" >
			<table cellspacing="0" cellpadding="0" border="0">
				<tr>
					<td>
					<select name="type">
					      <option value="ranimal" <%=type=="ranimal"?"selected":"" %>>动物</option>
					      <option value="rplant" <%=type=="rplant"?"selected":"" %>>植物</option>
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
		<% 
			if(sum < 1) out.print("<div>暂无记录!</div>"); 
			else {
		%>
		<div class="list">
			<%=htmls.toString() %>
		</div>
		<%
			}
		if( sum > 20 ) out.print("<div>"+new tea.htmlx.FPNL(h.language, par.toString()+"&pos=", pos, sum,size)+"</div>");
		%>

</div>