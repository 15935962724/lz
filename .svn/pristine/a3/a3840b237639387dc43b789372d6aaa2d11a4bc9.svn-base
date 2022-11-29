<%@page contentType="text/html; charset=UTF-8"%><%@page
	import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.node.*"%>
<%

Http h=new Http(request,response);
String types = h.get("type","1");
String order1 = h.get("order1","");
String family = h.get("family","");
String name = h.get("name","");

StringBuffer sqlList=new StringBuffer();
sqlList.append("select node,name from animal where type = "+types);
StringBuffer sqlCount=new StringBuffer();
sqlCount.append("select count(name) from animal where type = "+types);
StringBuffer par=new StringBuffer("?");

if(order1.length()>0)
{
  sqlList.append(" AND order1 LIKE '%"+order1+"%'");
  sqlCount.append(" AND order1 LIKE '%"+order1+"%'");
  par.append("&order1="+h.enc(order1));
}
if(family.length()>0)
{
  sqlList.append(" AND family LIKE '%"+family+"%'");
  sqlCount.append(" AND family LIKE '%"+family+"%'");
  par.append("&family="+h.enc(family));
}
if(name.length()>0)
{
  sqlList.append(" AND name LIKE '%"+name+"%'");
  sqlCount.append(" AND name LIKE '%"+name+"%'");
  par.append("&name="+h.enc(name));
}

DbAdapter db = new DbAdapter();

par.append("type="+types);
int pos=h.getInt("pos");
par.append("&pos=");
int sum = 0;
int count = 0;
java.sql.ResultSet rs = null;
StringBuffer sbra = new StringBuffer("<ul>");
try {
	rs = db.executeQuery( "select count(node) from animal", 0, Integer.MAX_VALUE);
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
		String node = rs.getString(i++);
		String f = rs.getString(i++);
		sbra.append("<li><a href=\"/xhtml/papc/animal/"+node+"-1.htm\" >"+f+"</a></li>");
		
	}
	rs.close();
} catch (Exception e) {
	e.printStackTrace();
} finally {
	db.close();
}
sbra.append("</ul>");
%>
	<script>
window.onload=function(){
	changSelect('<%=types %>','');
	};
</script>
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
			动物的物种总数（<%=count %>）
		</h2>
		<hr/>--%>
		<div class="search1"><form name="form1" action="/html/papc/category/13113866-1.htm" method="post" >
			<table cellspacing="0" cellpadding="0" border="0" class="tab1">
				<tr>
					<td class="th">物种：</td>
                
					<td colspan="2">
						<select name="wz" id="wz" onChange="onlink();"> 
					  		<option value="1" selected="" >动物</option>
					  		<option value="2" >植物</option>
					  	</select>
					</td>
                </tr>
                <tr>
					<td class="th">种类：</td>
					<td colspan="2">
						<select name="type" id="type" onChange="onsub(this.value);"> 
					  		<option value="1" <%="1".equals(types) ? "selected=\"\"" : "" %>>兽类</option>
					  		<option value="2" <%="2".equals(types) ? "selected=\"\"" : "" %>>鸟类</option>
					  	</select>
					</td>
                </tr>
                <tr>
					<td class="th">目名称：</td>
					<td colspan="2">
						<select name="order1" id="order1" onChange="changSelect('',this.value);" >
							<option value="">不限</option>
					  	</select>
					</td>
                </tr>
                <tr>
					<td class="th">科名称：</td>
					<td colspan="2">
						<select name="family" id="family">
							<option value="">不限</option>
					  	</select>
					</td>
                </tr>
                <tr>
					<td class="th">物种名称：</td>
					<td>
						<input type="text" name="name" id="name" value="<%=name %>"/>
					</td>
					<td class="th1">
						<input type="submit" class="sub" value="查询"/>
					</td>
				</tr>
			</table>
		</form>
        </div>
		<%--<h2>
			搜索到的动物相关物种总数（<%=sum %>）
		</h2>--%>
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

<script>
function onlink(){
	window.location.href = "/xhtml/papc/category/13113856-1.htm";
}
function onsub(v){
	window.location.href = "/xhtml/papc/category/13113866-1.htm?type="+v;
}
function changSelect(t,o){
	if("" == t){
		t = $("#type").val();
	}
	var od = '<%=order1%>';
	$.ajax({
		type:'post',
		url:'/jsp/leo/jsp/animalLeo.jsp',
		data:{type:t,order1:o},
		dataType:'html',
		success:function(msg){
			if("" == o){
				$("#order1").empty();
				$("#order1").append(msg);
				$("<option value='' >不限</option>").appendTo("#order1");
				o = od;
				if("" != od){
					changSelect(t,od);
				}
			}else{
				$("#family").empty();
				$("#family").append(msg);
				$("<option value='' >不限</option>").appendTo("#family");
			}

			$("#order1").attr("value",o);
			$("#family").attr("value",'<%=family%>');
		}
	})
}
</script>
