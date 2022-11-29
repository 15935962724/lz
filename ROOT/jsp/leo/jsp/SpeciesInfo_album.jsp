<%@page import="tea.resource.Common"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page
	import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.util.Card"%>
<%
	Http h = new Http(request, response);
	Node n = Node.find(h.node);
	String type = h.get("type","ranimal");
	//String rnameSerach = h.get("rname","");
	//String species1Search = h.get("species1");
	
	StringBuffer htmls = new StringBuffer();
	DbAdapter db = new DbAdapter();
	java.sql.ResultSet rs = null;
	String sql = "select * from "+type+" where node="+h.node;
	int node1=0;
	int father=0;
	try {
		rs = db.executeQuery(sql, 0 , 1);
		htmls.append("<table>");
		while (rs.next()) {
			if("rplant".equals(type)){
				node1=rs.getInt("node");
				father=Node.find(node1).getFather();
				String species1 = rs.getString("species1");
				String species0 = rs.getString("species0");
				String family1 = rs.getString("family1");
				String family0 = rs.getString("family0");
				String genus = rs.getString("genus");
				String mutation = rs.getString("mutation");
				String mutationauthor = rs.getString("mutationauthor");
				if(mutation.equals("null")){mutation="";}
				if(mutationauthor.equals("null")){mutationauthor="";}
				htmls.append(
					"<tr>"+
						"<td class=\"text_right\">种名(中):</td><td><span id=\"species1\">"+MT.f(species1)+"</span></td>"+
						"<td class=\"text_right\">种名(英):</td><td><span id=\"species0\">"+MT.f(species0)+"</span></td>"+
					"</tr>"+
					"<tr>"+
						"<td class=\"text_right\">科名(中):</td><td><span id=\"family1\">"+MT.f(family1)+"</span></td>"+
						"<td class=\"text_right\">科名(英):</td><td><span id=\"family0\">"+MT.f(family0)+"</span></td>"+
					"</tr>"+
					"<tr>"+
						"<td class=\"text_right\">属名:</td><td><span id=\"genus\">"+MT.f(genus)+"</span></td>"+
						"<td class=\"text_right\">种下名称:</td><td><span id=\"mutation\">"+MT.f(mutation)+"</span></td>"+
					"</tr>"+
					"<tr>"+
						"<td class=\"text_right\">命名人:</td><td><span id=\"mutationauthor\">"+MT.f(mutationauthor)+"</span></td>"+"<td>&nbsp;</td><td>&nbsp;</td>"+
					"</tr>"
				);
			}else{
				node1=rs.getInt("node");
				father=Node.find(node1).getFather();
				String rname = rs.getString("rname");
				String genus = rs.getString("genus");
				String species0 = rs.getString("species0");
				String species1 = rs.getString("species1");
				String family0 = rs.getString("family0");
				String family1 = rs.getString("family1");
				String order0 = rs.getString("order0");
				String order1 = rs.getString("order1");
				String distribution = rs.getString("distribution");
				String morphology = rs.getString("morphology");
				String host = rs.getString("host");
				String reference = rs.getString("reference");
				htmls.append(
					"<tr>"+
						"<td class=\"text_right\">种名(中):</td><td><span id=\"species1\">"+MT.f(species1)+"</span></td>"+
						"<td class=\"text_right\">种名(英):</td><td><span id=\"species0\">"+MT.f(species0)+"</span></td>"+
					"</tr>"+
					"<tr>"+
						"<td class=\"text_right\">科名(中):</td><td><span id=\"family1\">"+MT.f(family1)+"</span></td>"+
						"<td class=\"text_right\">科名(英):</td><td><span id=\"family0\">"+MT.f(family0)+"</span></td>"+
					"</tr>"+
					"<tr>"+
						"<td class=\"text_right\">目名(中):</td><td><span id=\"order1\">"+MT.f(order1)+"</span></td>"+
						"<td class=\"text_right\">目名(英):</td><td><span id=\"order0\">"+MT.f(order0)+"</span></td>"+
					"</tr>"+
					"<tr>"+
						"<td class=\"text_right\">属名:</td><td><span id=\"genus\">"+MT.f(genus)+"</span></td>"+
						"<td class=\"text_right\">保护区:</td><td><span id=\"rname\">"+MT.f(rname)+"</span></td>"+
					"</tr>"+
					"<tr>"+
				    "<td class=\"text_right\" >参考文献:</td><td colspan='3'><span id=\"reference\">"+MT.f(reference)+"</span></td>"+
					"</tr>"+
					
					"<tr>"+
				    "<td class=\"text_right\" >寄主:</td><td colspan='3'><span id=\"host\">"+MT.f(host).replace("寄主:", "").replace("寄主", "")+"</span></td>"+
					"</tr>"+
					"<tr>"+
				    "<td class=\"text_right\" >分布:</td><td colspan='3'><span id=\"distribution\">"+MT.f(distribution).replace("分布:", "").replace("分布", "")+"</span></td>"+
					"</tr>"+
					"<tr>"+
				    "<td class=\"text_right\" >形态特征:</td><td colspan='3'><span id=\"morphology\">"+MT.f(morphology).replace("形态特征:", "").replace("形态特征", "")+"</span></td>"+
			        "</tr>"
					
				);
			}
		}
		htmls.append("</table>");
		rs.close();
	} finally {
		db.close();
	}
	
%>

		<script src="/tea/mt.js" type="text/javascript"></script>
		<script src="/tea/city.js" type="text/javascript"></script>
<div class="reserveList">


		<div class="list">
			<%=htmls.toString() %>
		</div>

</div>




