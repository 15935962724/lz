<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.html.*" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.entity.site.*" %>
<%@page import="java.util.*"%>
<%@page import="tea.entity.member.*" %>
<% 

request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);



%>

	<ul id="xiaoshoupaihang">
<%

	Enumeration e = TradeItem.findByTrade(teasession._strCommunity,0,Integer.MAX_VALUE);
	int i =1;
	
	while(e.hasMoreElements())
	{
		if(i==11)break;
		String node = ((String)e.nextElement());
		
		Goods g = Goods.find(Integer.parseInt(node),teasession._nLanguage);
		Node n = Node.find(Integer.parseInt(node));
		Commodity c = Commodity.find_goods(Integer.parseInt(node));
		BuyPrice b = BuyPrice.find(c.getCommodity(),1);
		String subj =  n.getSubject(teasession._nLanguage);
		if(subj!=null){
%>
  

		<li id="list<%=i%>"><a href="/servlet/Node?Node=<%=node %>&Language=1" title="<%=subj%>"><%if(subj.length()>8)out.print(subj.substring(0,5)+"...");else{out.print(subj);} %></a><span class="price_t">价格:</span><span class="price_v">￥<%=b.getPrice() %></span></li>
	


<%
	i++;
	}
	}	
%>
</ul>
