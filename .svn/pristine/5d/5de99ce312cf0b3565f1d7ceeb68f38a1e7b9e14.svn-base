<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.ui.TeaSession" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.entity.site.*" %><%@page import="java.util.*"%><% request.setCharacterEncoding("UTF-8");

int action=0,classmap=0;
try
{
  action=Integer.parseInt(request.getParameter("action"));
  classmap=Integer.parseInt(request.getParameter("classmap"));
}catch(NumberFormatException ex)
{
  out.print("action参数:点击“对比选中商品”,转到的节点号.  必须有.<br>");
  out.print("classmap参数:点击“分类”,转到的节点号.  必须有.");
  return;
}

TeaSession teasession=new TeaSession(request);

int root=GoodsType.getRootId(teasession._strCommunity);

//Community community=Community.find(teasession._strCommunity);
//out.print(community.getJspBefore(teasession._nLanguage));


%>
<!-- 9000分类导航 -->

<%
Enumeration e=GoodsType.findByFather(root);
while(e.hasMoreElements())
{
	GoodsType gt=(GoodsType)e.nextElement();
	int id=gt.getGoodstype();
	out.print("<div id=fonf><a href=/jsp/type/goods/9000_GoodsTypeList2.jsp?community="+teasession._strCommunity+"&goodstype="+id+"&Language="+teasession._nLanguage+"&classmap="+classmap+"&action="+action+" onmouseout=\"f_mout();\" onmouseover=\"f_mover("+id+");\">"+gt.getName(teasession._nLanguage)+"</a><div class=CategoryListInlineSepLevel1><ul>");

	Enumeration e2=GoodsType.findByFather(id);
	for(int i=0;i<10&&e2.hasMoreElements();i++)
	{
		gt=(GoodsType)e2.nextElement();
		out.print("<li><a href=/jsp/type/goods/9000_GoodsTypeList2.jsp?community="+teasession._strCommunity+"&goodstype="+gt.getGoodstype()+"&Language="+teasession._nLanguage+"&classmap="+classmap+"&action="+action+" onmouseout=\"f_mout();\" onmouseover=\"f_mover("+gt.getGoodstype()+");\">"+gt.getName(teasession._nLanguage)+"</a></li>");
	}
	out.print("<li><a href=/jsp/type/goods/9000_GoodsTypeList2.jsp?community="+teasession._strCommunity+"&goodstype="+id+"&Language="+teasession._nLanguage+"&classmap="+classmap+"&action="+action+" >更多...</a></li>");
	out.print("</ul></div></div>");
}
%>
<script>
var timeid=new Array();
function f_mout()
{
  for(var i=0;i<5;i++)
  {
	if(i<4)
	{
	  	timeid[i]=setTimeout("d.style.filter='Alpha(Opacity="+(100-((i+1)*20))+")';",i*200);
	}else
	{
		timeid[i]=setTimeout("d.style.display='none'; document.getElementById('iframea').src='about:blank';",1000);
	}
  }
}
function f_mover(p)
{
  for(var i=0;i<5;i++)
  {
	clearTimeout(timeid[i]);
  }
  d.style.filter='Alpha(Opacity=100)';
  if(p)
  {
    d.style.left=event.clientX+document.body.scrollLeft+5;
    d.style.top=event.clientY+document.body.scrollTop+5;

	var url="/jsp/type/goods/9000_BrandList.jsp?goodstype="+p+"&community=<%=teasession._strCommunity%>";
	var iframea=document.getElementById('iframea');
	//if(iframea.src!=url)
	{
	  iframea.src=url;
	}
  }
  d.style.display='';
}
</script>
<div id=d style="position:absolute; filter:Alpha(Opacity=100); width:150px; height:150px; background-color:#FF0000; display:none;" onmouseout="f_mout();" onmouseover="f_mover();">
<iframe id=iframea src="about:blank" frameborder="0"></iframe>
</div>

<%
//out.print(community.getJspAfter(teasession._nLanguage));
%>
