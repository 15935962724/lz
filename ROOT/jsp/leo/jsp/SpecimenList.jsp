<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);

StringBuffer sqlList=new StringBuffer(),sqlCount=new StringBuffer();
sqlList.append("select species1,count(species1) from specimen s where 1=1 ");
sqlCount.append("select count(distinct species1) from specimen s where 1=1 ");

StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");

int menuid=h.getInt("id");	//标本库id

String firstlevel=h.get("firstlevel","");
if(firstlevel.length()>0)
{
  sql.append(" AND firstlevel LIKE '%"+firstlevel+"%'");
  par.append("&firstlevel="+h.enc(firstlevel));
}
int reserve=h.getInt("reserve");
if(reserve>0){
	sql.append(" and reserve="+reserve);
	par.append("&reserve="+reserve);
}
String secondlevel=h.get("secondlevel","");
if(secondlevel.length()>0)
{
  sql.append(" AND secondlevel LIKE '%"+secondlevel+"%'");
  par.append("&secondlevel="+h.enc(secondlevel));
}else if("菌物".equals(firstlevel)){
	sql.append(" AND secondlevel is null");
	  par.append("&secondlevel="+h.enc(secondlevel));
}

String species1=h.get("species1","");
if(species1.length()>0)
{
  sql.append(" AND species1 LIKE '%"+species1+"%'");
  par.append("&species1="+h.enc(species1));
}

Date times=h.getDate("times");
if(times!=null)
{
  sql.append(" AND ctime> '"+times+"'");
  par.append("&times="+MT.f(times));
}

Date timee=h.getDate("timee");
if(timee!=null)
{
  sql.append(" AND ctime< '"+timee+"'");
  par.append("&timee="+MT.f(timee));
}

String unit=h.get("unit","");
if(unit.length()>0)
{
  sql.append(" AND unit LIKE '%"+unit+"%'");
  par.append("&unit="+h.enc(unit));
}

String rname=h.get("rname","");
if(rname.length()>0)
{
  sql.append(" AND rname LIKE '%"+rname+"%'");
  par.append("&rname="+h.enc(rname));
}

String cperson=h.get("cperson","");
if(cperson.length()>0)
{
  sql.append(" AND cperson LIKE '%"+cperson+"%'");
  par.append("&cperson="+h.enc(cperson));
}
String csite=h.get("csite","");
if(csite.length()>0)
{
  sql.append(" AND csite LIKE '%"+csite+"%'");
  par.append("&csite="+h.enc(csite));
}
sqlList.append(sql).append(" group by species1");
sqlCount.append(sql);
System.out.print("-----"+sqlList.toString());
int pos=h.getInt("pos");
par.append("&pos=");
int sum = 0;
StringBuffer htmls = new StringBuffer();
DbAdapter db = new DbAdapter();
java.sql.ResultSet rs = null;
try {
	rs = db.executeQuery( sqlList.toString(), pos, 32);
	htmls.append("<ul>");
	while (rs.next()) {
		int i = 1;
		String species1BySql = rs.getString(i++);
		int species1Count = rs.getInt(i++);
		String href = "/html/papc/folder/13113601-1.htm?reserve="+reserve+"&irstlevel="+MT.f(firstlevel)+"&secondlevel="+MT.f(secondlevel)+"&species1="+MT.f(species1BySql)+"&rname="+MT.f(rname)+"&cperson="+MT.f(cperson)+"&csite="+MT.f(csite)+"&unit="+h.enc(unit);
		htmls.append("<li><span ><a title='"+species1BySql+"' href='"+href+"'>"+species1BySql+"("+species1Count+")</a></span></li>");
	}
	htmls.append("</ul>");
	rs = db.executeQuery( sqlCount.toString(), 0, 1);
	while (rs.next()) {
		sum = rs.getInt(1);
	}
	rs.close();
} catch (Exception e) {
	e.printStackTrace();
} finally {
	db.close();
}

%>


<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/jquery-1.3.1.min.js" type="text/javascript"></script>
<script>

window.onload = function(){
	changLevel2('<%=firstlevel %>','<%=secondlevel %>');
	};
</script>
<div class="reserveList">
<div class="title"><span>标本库</span></div>
<!--<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>-->
<form name="form1" action="?" style="width:796px;">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<style>
table#tablecenter tr td{border-right:1px #ccc solid;border-bottom:1px #ccc solid;border-top:none;border-left:None;}
</style>
<%--<table id="tablecenter" cellspacing="0" style="width:796px;" border="0">
<tr>
  <td class="th">一级类别</td>
  <td>
  	<select name="firstlevel" id="firstlevel" onChange="changLevel2(this.value)" style="width:90px;"> 
  		<option value="动物" <%="动物".equals(firstlevel) ? "selected=\"\"" : "" %>>动物</option>
  		<option value="植物" <%="植物".equals(firstlevel) ? "selected=\"\"" : "" %>>植物</option>
  		<option value="菌物" <%="菌物".equals(firstlevel) ? "selected=\"\"" : "" %>>菌物</option>
  	</select>
  </td>
  <td class="th">二级类别</td>
  <td>
  	<select name="secondlevel" id="secondlevel">
  		<option selected="" value="0">---</option>
  	</select>
  </td>
  <td class="th">名称：</td><td><input name="species1" value="<%=species1 %>" style="width:90px;"/></td>
  <td class="th" width="70">保存单位及其标本馆：</td><td><input name="unit" value="<%=unit %>" style="width:123px;"/></td>
  <td style="border-right:None;">&nbsp;</td>
</tr>
<tr>
  <td class="th">保护区：</td><td><input name="rname" value="<%=rname %>" style="width:90px;"/></td>
  <td class="th">采集人：</td><td><input name="cperson" value="<%=cperson %>" style="width:90px;"/></td>
  <td class="th">采集地：</td><td><input name="csite" value="<%=csite %>" style="width:90px;"/></td>
  <td class="th">采集时间：</td><td>起：<input name="times" value="" onClick="mt.date(this)" class="date" style="width:98px;"/><br />止：<input name="timee" value="" onClick="mt.date(this)" class="date" style="width:98px;"/></td>
  <td style="border-right:none;"><input type="submit" value="查询"/></td>
</tr>
</table>--%>
<table id="tablecenter" cellspacing="0" style="width:796px;" border="0">
	<tr>
    	  <td class="th" nowrap="nowrap">一级类别</td>
          <td>
            <select name="firstlevel" id="firstlevel" onChange="changLevel2(this.value)" style="width:96px;"> 
                <option value="">---</option>
                <option value="动物" <%="动物".equals(firstlevel) ? "selected=\"\"" : "" %>>动物</option>
                <option value="植物" <%="植物".equals(firstlevel) ? "selected=\"\"" : "" %>>植物</option>
                <option value="菌物" <%="菌物".equals(firstlevel) ? "selected=\"\"" : "" %>>菌物</option>
            </select>
          </td>
          <td class="th" nowrap="nowrap">二级类别</td>
          <td>
            <select name="secondlevel" id="secondlevel" style="width:96px;">
                <option selected="" value="0">---</option>
            </select>
          </td>
          <td class="th" nowrap="nowrap">名称：</td><td><input name="species1" value="<%=species1 %>" style="width:96px;"/></td>
    </tr>
    <tr>
      
      <td class="th" nowrap="nowrap">保存单位及其标本馆：</td><td><input name="unit" value="<%=unit %>" style="width:96px;"/></td>
      <td class="th" nowrap="nowrap">保护区：</td><td><input name="rname" value="<%=rname %>" style="width:96px;"/></td>
      <td class="th" nowrap="nowrap">采集人：</td><td><input name="cperson" value="<%=cperson %>" style="width:96px;"/></td>
    </tr>
    <tr>
      <td class="th" nowrap="nowrap">采集地：</td><td><input name="csite" value="<%=csite %>" style="width:96px;"/></td>
      <td class="th" nowrap="nowrap">采集时间：</td><td nowrap="nowrap"><input name="times" value="" onClick="mt.date(this)" class="date" style="width:96px;"/>至<input name="timee" value="" onClick="mt.date(this)" class="date" style="width:96px;"/></td><td colspan="2" align="left"><input type="submit" value="查询"/></td>
      </tr>
</table>
</form>

<!--<h2>列表</h2>-->
<% 
	if(sum < 1) out.print("<div>暂无记录!</div>"); 
	else {
%>
<div class="list">
	<%=htmls.toString() %>
</div>
<%
	}
if( sum > 20 ) out.print("<div>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20)+"</div>");
%>
<br/>

<script>

function changLevel2(v,s){
	$.ajax({
		type:'post',
		url:'/jsp/leo/jsp/SpecimensLeo.jsp',
		data:{level:v,level2:s},
		dataType:'html',
		success:function(msg){
			$("#secondlevel").empty();
			$("#secondlevel").append(msg);
		}
	})
}
</script>
</div>
