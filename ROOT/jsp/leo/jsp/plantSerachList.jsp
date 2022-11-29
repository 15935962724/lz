<%@page contentType="text/html; charset=UTF-8"%><%@page
	import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.node.*"%>
<%

Http h=new Http(request,response);

StringBuffer sql=new StringBuffer(),par=new StringBuffer("?"),sqlCount=new StringBuffer();
sql.append("select node,species1 from plant where 1=1 ");
sqlCount.append("select count(species1) from plant where 1=1 ");

DbAdapter db = new DbAdapter();
int pos=h.getInt("pos");
int sum = 0;	//查询结果总数。
int count = 0;	//总数

String family1 = h.get("family1","");
String species1 = h.get("species1","");
if(family1.length()>0)
{
  sql.append(" AND family1 LIKE '%"+family1+"%'");
  sqlCount.append(" AND family1 LIKE '%"+family1+"%'");
  par.append("&family1="+h.enc(family1));
}
if(species1.length()>0)
{
  sql.append(" AND species1 LIKE '%"+species1+"%'");
  sqlCount.append(" AND species1 LIKE '%"+species1+"%'");
  par.append("&species1="+h.enc(species1));
}

par.append("&pos=");
java.sql.ResultSet rs = null;
StringBuffer htmlz = new StringBuffer("<ul>");
try {
	rs = db.executeQuery( "select count(node) from plant", 0, Integer.MAX_VALUE);
	while (rs.next()) {
		int i = 1;
		int n = rs.getInt(i++);
		count = n;
	}
	rs = db.executeQuery( sqlCount.toString(), 0, Integer.MAX_VALUE);
	while (rs.next()) {
		int i = 1;
		int n = rs.getInt(i++);
		sum = n;
	}
	rs = db.executeQuery( sql.toString(), pos, 16);
	while (rs.next()) {
		int i = 1;
		String node = rs.getString(i++);
		String f = rs.getString(i++);
		htmlz.append("<li><a href=\"/html/papc/plant/"+node+"-1.htm\" >"+f+" </a></li>");
		
	}
	rs.close();
} catch (Exception e) {
	e.printStackTrace();
} finally {
	db.close();
}
htmlz.append("</ul>");
%>

		<script src="/tea/tea.js" type="text/javascript"></script>
		<script src="/tea/mt.js" type="text/javascript"></script>
		<script src="/tea/jquery-1.3.1.min.js" type="text/javascript"></script>

	
		<%--<h1>
			物种名录
		</h1>
		<div id="head6">
			<img height="6" src="about:blank">
		</div>
		<h2>
			植物的物种总数（<%=count %>）-- 科目列表
		</h2>
		<hr/>--%>
		<div class="search"><form name="form1" action="/html/papc/category/13113871-1.htm" method="post">
			<table cellspacing="0" cellpadding="0" border="0" style="font-size:12px;">
				<tr>
					<td class="th">
						物种：
					</td>
					<td>
						<select name="wz" id="wz" onChange="onlink();"> 
					  		<option value="1" selected="" >植物</option>
					  		<option value="2" >动物</option>
					  	</select>
					</td>
					<td class="th">
						科目名：
					</td>
					<td>
						<input type="text" name="family1" id="family1" value="<%=family1 %>" style="width:100px;">
					</td>
					<td class="th">
						物种名：
					</td>
					<td>
						<input type="text" name="species1" id="species1" value="<%=species1 %>" style="width:100px;">
					</td>
					<td class="th">
						<input type="submit" value="查询" style="height:24px;margin-left:5px;" />
					</td>
				</tr>
			</table>
		</form></div>
		<%--<h2>
			搜索到的植物相关物种总数（<%=sum %>）
		</h2>--%>
		<% 
		if(sum < 1) out.print("<div>暂无记录!</div>"); 
		else {
		%>
		<div class="list">
			<%=htmlz.toString() %>
		</div>
		<%
			}
		if( sum > 16 ) out.print("<div>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,16)+"</div>");
		%>
<br/>
<script type="text/javascript">
function onlink(){
	window.location.href = "/html/papc/folder/13113661-1.htm";
}

</script>

