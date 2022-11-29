<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page import="tea.entity.node.*" %>
<%@page import="java.net.URLEncoder"%>
<%@page import="tea.entity.admin.*" %>
<% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

if("delete".equals(request.getParameter("act")))
{
	String node_che = request.getParameter("node_che");
	Goodscon.delete(Integer.parseInt(node_che), session.getId());
	return;
}

if("all".equals(request.getParameter("act")))
{
	DbAdapter db = new DbAdapter();
	try
	{
		db.executeUpdate("delete from  Goodscon where  sessionid = "+db.cite(session.getId()));
	}finally
	{
		db.close();
	}
}
String nodes[]=request.getParameterValues("nodes");
tea.entity.site.Community community=tea.entity.site.Community.find(teasession._strCommunity);
if(nodes==null)
{
  %>

  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<div id="jspbefore" style="display:none">
<script>if(top.location==self.location)jspbefore.style.display='';</script>
<%=community.getJspBefore(teasession._nLanguage)%>
</div>
<DIV id="duibiye">
 <b> 对比列表已清空</b><br><br>
您可以继续挑选商品，进行对比，<A href="javascript:window.close();" >点击这里关闭窗口</A></div>
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
  <%

  return;
}
%>



<%
StringBuffer sb[]=new StringBuffer[20];
for(int index=0;index<sb.length;index++)
{
  sb[index]=new StringBuffer();
}
StringBuffer remove=new StringBuffer("<th nowrap><A href="+request.getRequestURI()+"?node="+teasession._nNode+"&act=all>全部移除</A></th>");
java.util.List list = Goodscon.getList(session.getId());
for(int index=0;index<list.size();index++)
{
	
  int node_id=(Integer)list.get(index);
  Node node_obj=Node.find(node_id);
  Goods goods_obj=Goods.find(node_id);
  int brand_id=goods_obj.getBrand();
  int cc=Commodity.findSupplierByGoods(node_obj._nNode);
    BuyPrice bobj = BuyPrice.find(cc, 1);
  Supplier obj2=Supplier.find(cc);
  Node n = Node.find(goods_obj.getCompany());

  sb[0].append("<td id=GoodsCompare_Smallpicture ><A href=/servlet/Goods?node="+node_id+" ><img width=80 height=80 src="+goods_obj.getSmallpicture(teasession._nLanguage)+" ></A></td>");
  sb[1].append("<td id=GoodsCompare_Subject ><A href=/servlet/Goods?node="+node_id+" >"+node_obj.getSubject(teasession._nLanguage)+"</A></td>");
  sb[2].append("<td id=GoodsCompare_Price >"+n.getSubject(teasession._nLanguage) +"</td>");
  //sb[3].append("<td id=GoodsCompare_Brand >&nbsp;");
 // if(brand_id>0)
 // {
    //Brand brand_obj=Brand.find(brand_id);
    //sb[3].append(brand_obj.getName(teasession._nLanguage));
  //}
  sb[3].append("<td id=GoodsCompare_Spec >");
  if(goods_obj.getSpec(teasession._nLanguage)!=null && goods_obj.getSpec(teasession._nLanguage).length()>0)
     sb[3].append(goods_obj.getSpec(teasession._nLanguage));
  else
       sb[3].append("暂无记录");
  sb[3].append("</td>");
    sb[4].append("<td  >");
  if(bobj.getList()!=null )
     sb[4].append(bobj.getList());
  else
       sb[4].append("暂无记录");
  sb[4].append("</td>");
  //sb[4].append("<td>"+bobj.getList()+"</td>");
  remove.append("<th id=GoodsCompare_Remove ><a href=\"javascript:fremove("+index+","+node_id+");\" >移除</A></th>");
}

%>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<div id="jspbefore" style="display:none">
<script>if(top.location==self.location)jspbefore.style.display='';</script>
<%=community.getJspBefore(teasession._nLanguage)%>
</div>
<div id="duibi">
<div id="dbbiao">商品对比</div>
<table border="0" cellpadding="0" cellspacing="0" id=GoodsCompare_Table>
  <tr id="comparedel"><%=remove.toString()%></tr>
  <tr>
    <th>图片</th><%=sb[0].toString()%>
  </tr>
  <tr>
    <th>名称</th><%=sb[1].toString()%>
  </tr>
  <tr>
    <th>供应商</th><%=sb[2].toString()%>
  </tr>

  <tr>
    <th>规格</th><%=sb[3].toString()%>
  </tr>
   <tr>
    <th>标价</th><%=sb[4].toString()%>
  </tr>


<%

Goods goods_0_obj=Goods.find(Integer.parseInt(nodes[0]));
String goodstype_0=goods_0_obj.getGoodstype();
if(goodstype_0!=null)
{
  String gts[]=goodstype_0.split("/");

  for(int index=1;index<gts.length;index++)
  {
    java.util.Enumeration enumeration=Attribute.findByGoodstype(Integer.parseInt(gts[index]));
    int id=0;
    while(enumeration.hasMoreElements())
    {
      id=((Integer)enumeration.nextElement()).intValue();
      Attribute obj=Attribute.find(id);

      String type=obj.getTypes();
      StringBuffer attr_sb=new StringBuffer();
      for(int attr_index=0;attr_index<nodes.length;attr_index++)
      {
        int node_id=Integer.parseInt(nodes[attr_index]);

        String value=AttributeValue.find(node_id,id).getAttrvalue(teasession._nLanguage);

        attr_sb.append("<td id=GoodsCompare_"+id+" >");
        if(value!=null&&value.length()>0)
        {
        	if ("img".equals(type))
        	{
        		attr_sb.append("<img src="+value+" >");
        	} else if ("file".equals(type))
        	{
        		String uri=URLEncoder.encode(value,"UTF-8");
        		attr_sb.append("<a href=/jsp/include/DownFile.jsp?uri="+uri+"&name="+uri+">下载</a>");
        	} else
        	{
        		attr_sb.append(value);
        	}
        }
      }
      out.print("<tr><th id=GoodsCompare_"+id+">");
      out.print(obj.getName(teasession._nLanguage));
      out.print(attr_sb.toString());
    }
  }
}



%>

  <tr id="comparedel"><%=remove.toString()%></tr>

</table>
</div>
<script type="">
//如果对比项没有内容,则隐藏
var tab=document.getElementById('GoodsCompare_Table');
for(var i=tab.rows.length-1;i>=0;i--)
{
  for(var j=tab.rows[i].cells.length-1;j>0;j--)
  {
    if(tab.rows[i].cells[j].innerHTML!="")
	{
	  break;
	}else
    if(j==1)
	{
	  tab.rows[i].style.display="none";
	}
  }
}
function fremove(id,igd)
{
  id++;
  for(var i=0;i<tab.rows.length;i++)
  {
    tab.rows[i].cells[id].style.display="none";
  }
  currentPos = "sid";
  send_request("?act=delete&node_che="+igd); 

}
</script>
<span id ="sid"></span>
<script language="javascript" src="/tea/load.js"  type="text/javascript"></script>
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


