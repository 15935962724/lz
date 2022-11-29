<%@page contentType="text/html; charset=UTF-8"%><%@page
	import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.node.*"%>
<%

Http h=new Http(request,response);
String types = h.get("type","1");

StringBuffer sqlList=new StringBuffer();
sqlList.append("select order1,count(order1) from animal where type = "+types+" group by order1");
StringBuffer sqlCount=new StringBuffer();
sqlCount.append("select count(distinct order1) from animal where type = "+types);
DbAdapter db = new DbAdapter();
StringBuffer par=new StringBuffer("?");
par.append("type="+types);
int pos=h.getInt("pos");
par.append("&pos=");
int sum = 0;
int count = 0;
int sumType = 0;
java.sql.ResultSet rs = null;
StringBuffer sbra = new StringBuffer("<ul>");
try {
	rs = db.executeQuery( "select count(node) from animal", 0, Integer.MAX_VALUE);
	while (rs.next()) {
		int i = 1;
		int n = rs.getInt(i++);
		count = n;
	}
	rs = db.executeQuery( "select count(name) from animal where type = "+types, 0, Integer.MAX_VALUE);
	while (rs.next()) {
		int i = 1;
		int n = rs.getInt(i++);
		sumType = n;
	}
	rs = db.executeQuery( sqlCount.toString(), 0, Integer.MAX_VALUE);
	while (rs.next()) {
		int i = 1;
		int n = rs.getInt(i++);
		sum = n;
	}
	rs = db.executeQuery( sqlList.toString(), pos, 20);
	while (rs.next()) {
		int i = 1;
		String f = rs.getString(i++);
		int n = rs.getInt(i++);
		String href="/html/papc/category/13113861-1.htm?type="+types+"&order1="+f;
		sbra.append("<li><a href=\""+href+"\" >"+f+"("+n+") </a></li>");
		
	}
	rs.close();
} catch (Exception e) {
	e.printStackTrace();
} finally {
	db.close();
}
sbra.append("</ul>");
%>

		<link href="/res/<%=h.community%>/cssjs/community.css"
			rel="stylesheet" type="text/css" />
		<script src="/tea/tea.js" type="text/javascript"></script>
		<script src="/tea/mt.js" type="text/javascript"></script>
		<script src="/tea/jquery-1.3.1.min.js" type="text/javascript"></script>

	<script>
window.onload=function(){
	changSelect('<%=types %>','');
	};
</script>

		<%-- <h1>
			物种名录
		</h1>
		<div id="head6">
			<img height="6" src="about:blank">
		</div>
		<h2>
			动物的物种总数（<%=count %>）
		</h2> --%>

		<div class="search"><form name="form1" action="/html/papc/category/13113866-1.htm" method="post" >
			<table cellspacing="0" cellpadding="0" border="0">
				<tr>
					<td class="th">
						物种：
					</td>
					<td>
						<select name="wz" id="wz" onchange="onlink();"> 
					  		<option value="1" selected="" >动物</option>
					  		<option value="2" >植物</option>
					  	</select>
					</td>
					<td class="th">
						种类：
					</td>
					<td>
						<select name="type" id="type" onchange="onsub(this.value);"> 
					  		<option value="1" <%="1".equals(types) ? "selected=\"\"" : "" %>>兽类</option>
					  		<option value="2" <%="2".equals(types) ? "selected=\"\"" : "" %>>鸟类</option>
					  		<%-- <option value="3" <%="3".equals(types) ? "selected=\"\"" : "" %>>昆虫</option> --%>
					  	</select>
					</td>
					<td class="th">
						目名称：
					</td>
					<td>
						<select name="order1" id="order1" onchange="changSelect('',this.value);" style="width:105px;">
							<option value="">不限</option>
					  	</select>
					</td>
					<td class="th">
						科名称：
					</td>
					<td>
						<select name="family" id="family" style="width:100px;">
							<option value="">不限</option>
					  	</select>
					</td>
					<td class="th">
						物种名称：
					</td>
					<td>
						<input type="text" name="name" id="name" value="" style="width:100px;">
					</td>
					<td class="th">
						<input type="submit" value="查询" style="margin-left:5px;height:24px;" />
					</td>
				</tr>
			</table>
		</form></div>
		<%--<h2>
			<%= "1".equals(types) ? "兽类" : "鸟类" %>物种总数（<%=sumType %>）
		</h2>--%>
		<% 
		if(sum < 1) out.print("<div>暂无记录!</div>"); 
		else {
		%>
		<div class="list">
			<%=sbra.toString() %>
		</div>
		<%
			}
		if( sum > 20 ) out.print("<div>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20)+"</div>");
		%>
<br/>

<script>

function onlink(){
	window.location.href = "/html/papc/category/13113856-1.htm";
}
function onsub(v){
	window.location.href = "/html/papc/folder/13113661-1.htm?type="+v;
}
function changSelect(o,f){
	if("" == o){
		o = $("#type").val();
	}
	$.ajax({
		type:'post',
		url:'/jsp/leo/jsp/animalLeo.jsp',
		data:{type:o,order1:f},
		dataType:'html',
		success:function(msg){
			if("" == f){
				$("#order1").empty();
				$("#order1").append(msg);
				$("<option value='' selected='' >不限</option>").appendTo("#order1");
			}else{
				$("#family").empty();
				$("#family").append(msg);
				$("<option value='' selected='' >不限</option>").appendTo("#family");
			}
		}
	})
}
</script>

