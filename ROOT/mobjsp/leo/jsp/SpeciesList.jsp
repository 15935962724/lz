<%@page contentType="text/html; charset=UTF-8"%><%@page
	import="java.util.*"%>
	<%@ page import="java.net.URLDecoder"%>
	<%@ page import="java.net.URLEncoder"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.util.Card"%>
<%
	Http h = new Http(request, response);
	int node = h.getInt("node");
	Node n = Node.find(node);
	int cityid = h.getInt("city");
	String rnameBySearch = h.get("rname","");
	Map<String, String> map = new HashMap<String, String>();
	DbAdapter db = new DbAdapter();
	java.sql.ResultSet rs = null;
	String sqlrp = "select rname,count(rname) from rplant where rname is not null and  reserve in (select node from reserve where city = "+cityid+") group by rname";
	String sqlra = "select rname,count(rname) from ranimal where rname is not null and  reserve in (select node from reserve where city = "+cityid+") group by rname";
	String sqlrpBySearch = "select rname,count(rname) from rplant where rname is not null and rname like '%"+rnameBySearch+"%' group by rname";
	String sqlraBySearch = "select rname,count(rname) from ranimal where rname is not null and rname like '%"+rnameBySearch+"%' group by rname";
	if("".equals(rnameBySearch) || null == rnameBySearch){
		try {
			rs = db
					.executeQuery(sqlrp,0, Integer.MAX_VALUE);
			while (rs.next()) {
				int i = 1;
				String rname = rs.getString(i++);
				int count = rs.getInt(i++);
				map.put(rname,"<a href=\"/xhtml/papc/folder/13113595-1.htm?type=rplant&rname="+rname+"\">植物["+count+"]</a>,"+
						"动物[0]");
			}
			rs = db
					.executeQuery(sqlra, 0 , Integer.MAX_VALUE);
			while (rs.next()) {
				int i = 1;
				String rname = rs.getString(i++);
				int count = rs.getInt(i++);
				if(map.containsKey(rname)){
					String value = map.get(rname).replaceFirst("动物\\[0\\]","<a href=\"/xhtml/papc/folder/13113595-1.htm?type=ranimal&rname="+rname+"\">动物["+count+"]</a>");
					map.put(rname,value);
				}else{
					map.put(rname,"植物[0],"+
							"<a href=\"/xhtml/papc/folder/13113595-1.htm?type=ranimal&rname="+rname+"\">动物["+count+"]</a>");
				}
			}
	
			rs.close();
		} finally {
			db.close();
		}
	}else{
		try {
			rs = db
					.executeQuery(sqlrpBySearch,0, Integer.MAX_VALUE);
			while (rs.next()) {
				int i = 1;
				String rname = rs.getString(i++);
				int count = rs.getInt(i++);
				map.put(rname,"<a href=\"/xhtml/papc/folder/13113595-1.htm?type=rplant&rname="+URLEncoder.encode(rname)+"\">植物["+count+"]</a>,"+
						"动物[0]");
			}
			rs = db
					.executeQuery(sqlraBySearch, 0 , Integer.MAX_VALUE);
			while (rs.next()) {
				int i = 1;
				String rname = rs.getString(i++);
				int count = rs.getInt(i++);
				if(map.containsKey(rname)){
					String value = map.get(rname).replaceFirst("动物\\[0\\]","<a href=\"/xhtml/papc/folder/13113595-1.htm?type=ranimal&rname="+URLEncoder.encode(rname)+"\">动物["+count+"]</a>");
					map.put(rname,value);
				}else{
					map.put(rname,"植物[0],"+
							"<a href=\"/xhtml/papc/folder/13113595-1.htm?type=ranimal&rname="+URLEncoder.encode(rname)+"\">动物["+count+"]</a>");
				}
			}
	
			rs.close();
		} finally {
			db.close();
		}
	}
	StringBuffer par=new StringBuffer("?city="+cityid);
	int pos=h.getInt("pos");
	par.append("&pos=");
	int sum = 0;
	if(null != map && !map.isEmpty()){
		sum = map.size();	
	}
	
%>

		<script src="/tea/mt.js" type="text/javascript"></script>
		<script src="/tea/city.js" type="text/javascript"></script>
        <script src="/tea/jquery.js" type="text/javascript"></script>


<div class="title"><span>保护区物种</span></div>
<div class="search1">
<form name="form1" action="/xhtml/papc/folder/13113595-1.htm?" method="post">
			<table cellspacing="0" cellpadding="0" border="0" class="tab2">
				<tr>
					<td>
						<input type="text" name="rname" class="text" value="<%=rnameBySearch %>" />	
					</td>
					<td class="th">
						<input type="submit" value="查询" class="sub" />
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
<ul>
		
	<%
		Object[] key = map.keySet().toArray();
		Arrays.sort(key);
		for (int j = pos; j < sum; j++) {
			if(j == (pos+1)*20)break;
			else out.print("<li>" + key[j] +" : "+ map.get(key[j]) + "</li>");
		}
	%>
</ul>
</div>
<%
	}
if( sum > 20 ) out.print("<div id=\"PageNum\">"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20)+"</div>");
%>
<script>var as=document.getElementById('PageNum').getElementsByTagName('A');for(var i=0;i<as.length;i++){if(/\d/.test(as[i].innerHTML))as[i].style.display='none';}</script>
