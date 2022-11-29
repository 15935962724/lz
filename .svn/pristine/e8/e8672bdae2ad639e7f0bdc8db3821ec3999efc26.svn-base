<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.ui.TeaSession" %><%@ page import="tea.html.*" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.entity.site.*" %><%@page import="java.util.*"%><% request.setCharacterEncoding("UTF-8");

int action=0,classmap=0;
try
{
  action=Integer.parseInt(request.getParameter("action"));
  classmap=Integer.parseInt(request.getParameter("classmap"));
}catch(NumberFormatException ex)
{
  out.print("action参数:点击\"对比选中商品\",转到的节点号.  必须有.<br>");
  out.print("classmap参数:点击\"分类\",转到的节点号.  必须有.<br>");
  return;
}
int goodstype=0;
try
{
	goodstype=Integer.parseInt(request.getParameter("goodstype"));
}catch(NumberFormatException ex)
{
  out.print("goodstype参数: 必须有.");
  return;
}

GoodsType gt=GoodsType.find(goodstype);

TeaSession teasession=new TeaSession(request);

Community community=Community.find(teasession._strCommunity);
out.print(community.getJspBefore(teasession._nLanguage));


%>
<!-- 9000分类导航的二级页 -->
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<div><LI><div id="path">　当前位置：<%=getAncestor(teasession._strCommunity,goodstype,classmap,action,teasession._nLanguage)%></div></LI></div>
<div id="typelist2">
<%
Enumeration e=GoodsType.findByFather(goodstype);
while(e.hasMoreElements())
{
	gt=(GoodsType)e.nextElement();
	int id=gt.getGoodstype();
	
	out.print("<li><a href=?community="+teasession._strCommunity+"&Language="+teasession._nLanguage+"&goodstype="+id+"&classmap="+classmap+"&action="+action+" >"+gt.getName(teasession._nLanguage)+"</a></li>");
	/*
	Enumeration e2=GoodsType.findByFather(id);
	while(e2.hasMoreElements())
	{
		id=((Integer)e2.nextElement()).intValue();
		gt=GoodsType.find(id);
		out.print("<li><a href=/servlet/Node?node="+action+"&Language="+teasession._nLanguage+"&classmap="+classmap+"&action="+action+" >"+gt.getName(teasession._nLanguage)+"</a></li>");
	}
	out.print("</div></div>");
	*/
}
%>
</div>
<jsp:include flush="true" page="/jsp/type/goods/9000_GoodsList.jsp">
<jsp:param name="community" value="<%=teasession._strCommunity%>"/>
<jsp:param name="action" value="<%=action%>"/>
</jsp:include>


<%
out.print(community.getJspAfter(teasession._nLanguage));
%><%!

public String getAncestor(String community,int goodstype,int node,int action,int language) throws Exception
{
		GoodsType gt=GoodsType.find(goodstype);
		if(gt.getFather()>0)
		{
		  Anchor anchor = new Anchor("?community=" + community + "&goodstype="+goodstype+"&Language=" + language+"&classmap="+node+"&action="+action, new Text(gt.getName(language)));
		  return getAncestor(community,gt.getFather(),node,action,language) + ">" + anchor;
		}else
		{
			  Anchor anchor = new Anchor("/servlet/Node?community=" + community + "&node="+node+"&Language=" + language, new Text(gt.getName(language)));
			  return ">" + anchor;
		}
}
%>
