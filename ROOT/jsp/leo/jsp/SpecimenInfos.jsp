<%@page import="tea.entity.MT"%>
<%@page import="tea.entity.Http"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page
	import="java.util.*"%>
<%@page import="tea.db.*"%>
<%

Http h=new Http(request,response);

StringBuffer sqlList=new StringBuffer(),sqlCount=new StringBuffer();
sqlList.append("select node,species1,snumber,ctime from specimen where 1=1 ");
sqlCount.append("select count(species1) from specimen where 1=1 ");

StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");

int menuid=h.getInt("id");	//标本库id

String firstlevel=h.get("firstlevel","");
if(firstlevel.length()>0)
{
  sql.append(" AND firstlevel LIKE '%"+firstlevel+"%'");
  par.append("&firstlevel="+h.enc(firstlevel));
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
int reserve=h.getInt("reserve");
if(reserve>0){
	sql.append(" and reserve="+reserve);
	par.append("&reserve="+reserve);
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
sqlList.append(sql);
sqlCount.append(sql);

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
		String node = rs.getString(i++);
		String species1BySql = rs.getString(i++);
		String s = rs.getString(i++);
		Date ctime = rs.getDate(i++);
		if(s==null)s="";
		String ss=s.length()>0?"["+s+"]":"["+MT.f(ctime)+"]";
		//以下连接修改为线上标本详细信息页面。
		String href = "/html/papc/folder/"+node+"-1.htm";
		htmls.append("<li><span ><a title='"+species1BySql+"' href='"+href+"'>"+species1BySql+ss+"</a></span></li>");
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
<div class="reserveList">
<div class="title"><span>标本库列表页</span></div>
	
		<!--<div id="head6">
			<img height="6" src="about:blank">
		</div>-->
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
		if( sum > 32 ) out.print("<div>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,32)+"</div>");
		%>
</div>