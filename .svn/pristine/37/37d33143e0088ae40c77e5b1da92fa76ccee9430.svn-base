<%@page contentType="text/html; charset=UTF-8"%><%@page
	import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.node.*"%>
<%

Http h=new Http(request,response);

String types = h.get("type","1");
StringBuffer sqlList=new StringBuffer();
sqlList.append("select family1,count(family1) from plant group by family1");
StringBuffer sqlCount=new StringBuffer();
sqlCount.append("select count(distinct family1) from plant");
DbAdapter db = new DbAdapter();
StringBuffer par=new StringBuffer("?");
int pos=h.getInt("pos");
par.append("&pos=");
int sum = 0;
int count = 0;
java.sql.ResultSet rs = null;
StringBuffer sbra = new StringBuffer("<ul>");
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
	rs = db.executeQuery( sqlList.toString(), pos, 16);
	while (rs.next()) {
		int i = 1;
		String f = rs.getString(i++);
		int n = rs.getInt(i++);
		String href="/xhtml/papc/category/13113871-1.htm?family1="+f;
		sbra.append("<li><a href=\""+href+"\" >"+f+"("+n+") </a></li>");
		//sbra.append("<li><a href=\"plantSerachList.jsp\" >"+f+"("+n+") </a></li>");
		
	}
	rs.close();
} catch (Exception e) {
	e.printStackTrace();
} finally {
	db.close();
}
sbra.append("</ul>");
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
		</h2>--%>
		<div class="search1"><form name="form1" action="/xhtml/papc/category/13113871-1.htm" method="post" onSubmit="return checkSub();">
			<table cellspacing="0" cellpadding="0" border="0" class="tab1">
				<tr>
					<td class="th">物种：	</td>
					<td colspan="2">
						<select name="wz" id="wz" onChange="onlink();"> 
					  		<option value="1" selected="" >植物</option>
					  		<option value="2" >动物</option>
					  	</select>
					</td>
                 </tr>
                 <tr>
					<td class="th">科目名：</td>
					<td colspan="2">
						<input type="text" name="family1" id="family1" value="">
					</td>
                 </tr>
                 <tr>
					<td class="th">物种名：</td>
					<td>
						<input type="text" name="species1" id="species1" value="">
					</td>
					<td class="th1">
						<input type="submit" class="sub" value="查询"/>
					</td>
				</tr>
			</table>
		</form>
        </div>
		<% 
		if(sum < 1) out.print("<div class=\"jl\">暂无记录!</div>"); 
		else {
		%>
		<div class="list">
			<%=sbra.toString() %>
		</div>
		<%
			}
		if( sum > 16 ) out.print("<div id=\"PageNum\">"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,16)+"</div>");
		%>
<script> var as=document.getElementById('PageNum').getElementsByTagName('A'); for(var i=0;i<as.length;i++){if(/\d/.test(as[i].innerHTML))as[i].style.display='none';} </script>
<br/>
<script type="text/javascript">
function onlink(){
	window.location.href = "/xhtml/papc/folder/13113661-1.htm";
}
function checkSub(){
	var family1 = $("#family1").val();
	var species1 = $("#species1").val();

	if(family1 == "" && species1 == ""){
		alert("请填写查询条件！");
		return false;
	}else return true;
}
</script>

