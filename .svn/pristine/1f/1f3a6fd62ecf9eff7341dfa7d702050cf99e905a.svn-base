<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.admin.*" %>
<%@ page import="java.util.*" %><%@ page import="java.math.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect(request.getContextPath()+"/servlet/StartLogin?Node="+teasession._nNode);
  return;
}
Resource r=new Resource("/tea/ui/member/node/Nodes");
tea.entity.site.Community community=tea.entity.site.Community.find(teasession._strCommunity);
 String s = request.getParameter("pos");
 int pos = s == null ? 0 : Integer.parseInt(s);

 String _strType = request.getParameter("type");

 int type = _strType == null ? 0 : Integer.parseInt(_strType);

String nexurl = request.getRequestURL().toString();
%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Expires" content="0">
<style type="text/css">
<!--
* {
	margin:0;
	padding:0;
	border:0;
	}

-->
</style>
</head>
<body>

<script type="text/javascript">
function selectAll(form,check)
{
  for(index=0;index<form.nodes.length;index++)
  {
    if(form.nodes[index].type=='checkbox')
    {
      form.nodes[index].checked=check.checked;
    }
  }
}

function fonsubmit_goodslist(obj)
{
  if(obj.checked)
  return true;
  for(var i=0;i<obj.length;i++)
  {
    if(obj[i].checked)
    {
      return true;
    }
  }
  alert('请您选中要删除的商品.');
  return false;
}
</script>

<div id="jspbefore" style="display:none">
<script>if(top.location==self.location)jspbefore.style.display='';</script>
<%=community.getJspBefore(teasession._nLanguage)%>
</div>
<div id="collect">
<form name = "form1" action="/servlet/DeleteFavorite" onSubmit="return fonsubmit_goodslist(this)" >
<input type=hidden name = nexurl value="<%=nexurl %>">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<caption>
	<span class="cap">我的收藏</span>
</caption>
<%
String goodstype = "";
if(request.getParameter("goodstype")!=null)
	goodstype = request.getParameter("goodstype");


out.print("<div id=\"lmnav\"><ul>");
Enumeration e=GoodsType.findByFather(GoodsType.getRootId(teasession._strCommunity));
while(e.hasMoreElements())
{
	GoodsType _gt=(GoodsType)e.nextElement();
	int id=_gt.getGoodstype();

    out.print("<li");
  //  if(goodstype==id||gt.getFather()==id||GoodsType.find(gt.getFather()).getFather()==id)
    //{
     // out.print("CurrentlyGoodsType");
   // }
	out.print("><a href=\"?goodstype="+id+"\" ><span>"+_gt.getName(teasession._nLanguage)+"</span></a></li>");
}
out.print("</ul></div>");
if(type==0)
{

  for(;type<Node.NODE_TYPE.length;type++)
  {

    out.print(toHtml(teasession,type,r,pos,goodstype,nexurl));
  }
}else
{
  out.print(toHtml(teasession,type,r,pos,goodstype,nexurl));

}


%>
<tr id="coll-di">
	<td align="left" colspan="6"><input type="CHECKBOX" onClick="selectAll(form1,this)" value="0">全选 &nbsp;
		<input class="cb3" type="submit" name="submit1" value="删除"> &nbsp;
		<input class="cb4" type="button" name="submit2" value="清空" onClick="window.open('/servlet/DeleteFavorite?nexurl=<%=nexurl %>&submit2=submit2', '_self')")>
	</td>
</tr>
</table>
</form>
</div>

<br>
  <div id="head6"><img height="6" alt="" src="about:blank"></div>
  <div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
<%!
private String toHtml(TeaSession teasession,int type,Resource r,int pos,String goodstype,String nexurl)throws Exception
{
 StringBuffer param=new StringBuffer();

param.append("?community=").append(teasession._strCommunity);
	 int count = Favorite.countNodes(teasession._strCommunity,teasession._rv,type,goodstype);
	//Enumeration e =
	 if(count>0)
	 {
		 StringBuffer html=new StringBuffer();
		 html.append("<tr><th>&nbsp;</th>");
		 html.append("<th>商品图片</th>");
		 html.append("<th>商品名称</th>");
		 html.append("<th>商品货号</th>");
		 html.append("<th>商品价格</th>");
		 html.append("<th>操作</th></tr>");

		java.util.Enumeration enumeration = Favorite.findNodes_sc(teasession._strCommunity,teasession._rv,type, pos, 5,goodstype);
		if(! enumeration.hasMoreElements())
		{
			html.append("<tr><td>暂无商品</td></tr>");
		}
		 while( enumeration.hasMoreElements() )
		 {
		   int k = ((Integer)enumeration.nextElement()).intValue();
		   Node obj=Node.find(k);


		     Commodity c = Commodity.find(obj._nNode, Commodity.findSupplierByGoods(obj._nNode));
			 Goods gobj=Goods.find(obj._nNode);

                           tea.entity.node.BuyPrice bobj = tea.entity.node.BuyPrice.find( c.getCommodity(), 1);

       Brand brd=Brand.find(gobj.getBrand());
		   if(obj.getCreator()!=null)
		   {

			html.append("<tr onMouseOver=\"javascript:this.bgColor='#BCD1E9'\" onMouseOut=\"javascript:this.bgColor=''\">");
			html.append("<td><input class=\"ckb1\" type=\"checkbox\" name=nodes value= "+k+" /></td>");
			html.append("<td> <img src='"+gobj.getSmallpicture(teasession._nLanguage));
			html.append("' width='80' height='80'/></td><td><span id='sname'><a href=/servlet/Node?Node="+obj._nNode);
			html.append("&Language="+teasession._nLanguage);
			html.append(">"+obj.getSubject(teasession._nLanguage)+"</a></span>");
			html.append("<br/><span id='ppai'>品牌：&nbsp;"+brd.getName()+"</span>");
			//html.append("<br/><span id='ppai'>规格：&nbsp;"+TradeItem.findBySpec(obj._nNode)+"</span>");
			//html.append("&nbsp;&nbsp;<span id='ppai'>颜色：&nbsp;"+TradeItem.findByColor(obj._nNode)+"</span>");
			html.append("</td><td>"+c.getSerialNumber());
			html.append("</td><td><scan class=\"comjg\">￥"+bobj.getPrice());
			html.append("</span></td><td>"+new tea.html.Button(1, "cb1", "CBDelete", r.getString(teasession._nLanguage, "立即购买"), "{window.open('/servlet/Node?Node=" + k + "', '_self');}"));
			html.append("&nbsp;&nbsp;"+new tea.html.Button(1, "cb2", "CBDelete", r.getString(teasession._nLanguage, "CBDelete"), "if(confirm('你真想删除这个吗? ')){window.open('/servlet/DeleteFavorite?delete=delete&nexurl="+nexurl+"&Node=" + k + "', '_self');}"));
			html.append("</td></tr>");

		   }
		 }
		//html.append("<tr><td>");
		//html.append("&nbsp;&nbsp;"+new tea.html.Button(1, "CB", "CBDelete", r.getString(teasession._nLanguage, "CBDelete"), "if(confirm('" + r.getString(teasession._nLanguage, "ConfirmDelete") + "')){window.open('/servlet/DeleteFavorite?nexurl="+nexurl+"', '_self');}"));
		//html.append("<td>");
		html.append("<td>"+new tea.htmlx.FPNL(teasession._nLanguage,param.toString()+"&pos=",pos,count,5)+"</td></tr>");
		//html.append("我的收藏<br><hr><br>");
		// if(html.length()>0)
		// {
			// html.insert(0,"<tr><td><h2>"+r.getString(teasession._nLanguage,Node.NODE_TYPE[type])+" ( "+count+" )</h2></td></tr>");
		// }
		 return html.toString();
	 }
	 return "";
}

%>

<div id="jspafter" style="display:none">
<script>if(top.location==self.location)jspafter.style.display='';</script>
<%=community.getJspAfter(teasession._nLanguage)%>
</div>


<script>
if(top.location==self.location)
{
  jspbefore.style.display='';
  jspafter.style.display='';
}
</script>
