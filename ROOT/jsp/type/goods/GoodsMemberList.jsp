<%@page import="tea.entity.admin.GoodsType"%>
<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.db.*" %>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");

response.setHeader("Pragma", "no-cache");


tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+request.getRequestURI()+"?"+request.getQueryString());
  return;
}
String nodetype = teasession.getParameter("nodetype");

String type=teasession.getParameter("type");
String brand=teasession.getParameter("brand");
String price1=teasession.getParameter("price1");
String price2=teasession.getParameter("price2");
String keyword=teasession.getParameter("keyword");
tea.resource.Resource r=new tea.resource.Resource();

String nexturl=java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"utf-8");
Community communitys=Community.find(teasession._strCommunity);
StringBuffer param=new StringBuffer("?node="+teasession._nNode);
  StringBuffer sql=new StringBuffer(" WHERE n.community="+tea.db.DbAdapter.cite(teasession._strCommunity)+" AND n.node=g.node AND n.rcreator="+tea.db.DbAdapter.cite(teasession._rv._strR)+" AND n.vcreator="+tea.db.DbAdapter.cite(teasession._rv._strV));
  StringBuffer from=new StringBuffer(" FROM Node n,Goods g");
  if(type!=null&&type.length()>0)
  {
    sql.append(" AND n.father="+type);
    param.append("&type="+type);
  }
  String goodsnumber = teasession.getParameter("goodsnumber");
  if(goodsnumber!=null && goodsnumber.length()>0)
  {
    sql.append(" AND n.goodsnumber LIKE ").append(DbAdapter.cite("%"+goodsnumber+"%"));
    param.append("&goodsnumber=").append(java.net.URLEncoder.encode(goodsnumber,"UTF-8"));
  }
  if(brand!=null&&brand.length()>0)
  {
    sql.append(" AND g.brand="+brand);
    param.append("&brand="+brand);
  }
  if((price1!=null&&price1.length()>0)||(price2!=null&&price2.length()>0))
  {
    from.append(",BuyPrice bp,Commodity c");
    sql.append(" AND c.node=bp.node AND c.goods=g.node");
    if((price1!=null&&price1.length()>0))
    {
      sql.append(" AND bp.price>="+price1);
      param.append("&price1="+price1);
    }
    if(price2!=null&&price2.length()>0)
    {
      sql.append(" AND g.price<"+price2);
      param.append("&price2="+price2);
    }
  }
  if(keyword!=null&&keyword.length()>0)
  {
    from.append(",NodeLayer nl");
    String keys[]=keyword.split(" ");
    StringBuffer contains=new StringBuffer();
    contains.append("\"" + keys[0] + "\"");
    for(int index=1;index<keys.length;index++)
    {
      contains.append(" OR \"" + keys[index] + "\"");
    }
    sql.append(" AND nl.node=n.node AND (CONTAINS(nl.keywords,N'" + contains.toString() + "') OR CONTAINS(nl.content,N'" + contains.toString() + "'))");
    param.append("&keywords="+keyword);
  }
  int count=0;
  int pos=0;
  int pageSize=25;
  if( teasession.getParameter("Pos")!=null)
  {
    pos=Integer.parseInt(  teasession.getParameter("Pos"));
  }
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<script>
function inputFloat(obj)
{
	if(obj.value!=''){
		var regNum =/^\+?[1-9][0-9]*$/;
	
		if(!regNum.test(obj.value))  //如果是数字返回true，其它返回false
		{
			alert("请输入数值");
			obj.value='';
			return false;
		}
	}

}
</script>
<body id="bodynone">

<script src="<%=communitys.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></script>


<h1>产品管理</h1>
<div id="head6"><img height="6" alt=""></div>
<form action="/jsp/type/goods/GoodsMemberList.jsp" method="get">
<input type="hidden" name="node" value="<%=teasession._nNode%>"/>

<h2>查询</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
<td nowrap>商品编号</td>
<td><input type="text" name="goodsnumber" value="<%if(goodsnumber!=null)out.print(goodsnumber);%>"/></td>

  <td nowrap >类别</td>
  <td><select name="type">
          <option value="" >----------</option>
          <%
          int rootid=GoodsType.getRootId(teasession._strCommunity);
    java.util.Enumeration eg = GoodsType.findByFather(rootid);
    while (eg.hasMoreElements())
    {
      //  int egid = ///((Integer)eg.nextElement()).intValue();
        GoodsType gobj = (GoodsType)eg.nextElement();//GoodsType.find(egid);
        out.print("<option value="+gobj.getGoodstype());
        if(type!=null && type.length()>0)
        {
          int a = Integer.parseInt(type);
          if(a==gobj.getGoodstype())
             out.print("  selected ");
        }
        out.print(">"+gobj.getName(teasession._nLanguage));
        out.print("</opiont>");
    }
%>
        </select></td>
   
  <td nowrap>品牌</td><td><select name="brand">
    <option value="" >----------</option>
    <%
    java.util.Enumeration enumer54313=tea.entity.node.Brand.findByCommunity(teasession._strCommunity,"",0,200);
    while(enumer54313.hasMoreElements())
    {
      int id=((Integer)enumer54313.nextElement()).intValue();
      tea.entity.node.Brand obj=tea.entity.node.Brand.find(id);
      out.print("<option value="+obj.getBrand()+"");
      if(brand!=null && brand.length()>0&&Integer.parseInt(brand)==id)
      {
    	  out.println(" selected ");
      }
      out.print(">");
      out.print(obj.getName(teasession._nLanguage)+"</option>");
      
    }%>
    </select></td>
     </tr>
    <tr>
    <td nowrap>价格</td>
    <td><input name="price1" type="text" size="5" onblur="inputFloat(this);" value="<%if(price1!=null)out.println(price1);%>">-<input name="price2" type="text" size="5" onblur="inputFloat(this);" value="<%if(price2!=null)out.println(price2);%>"></td>
      <td nowrap>关键字</td><td><input name="keyword" type="text" size="10" value="<%if(keyword!=null && keyword.length()>0)out.println(keyword);%>"></td>
        <td><input type="submit" value="搜索"></td></tr>
</table>

</form>
<br>
 

<h2>列表 ( <span id=spancount>0</span> )&nbsp;
<input type="button" onClick="window.open('/jsp/type/goods/SelectGoodsType.jsp?NewNode=ON&nodetype=<%=nodetype %>&node=<%=teasession._nNode%>&community=<%=teasession._strCommunity%>&nexturl=<%=nexturl%>','_self');" value="<%=r.getString(teasession._nLanguage,"CBNew")%>"/>
</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <TR id="tableonetr">
    <td width="1">&nbsp;</td>
    <td>商品编号</td>
    <td>商品名称</td>
    <td>类型</td>
    <td>品牌</td>
    <td>人气</td>
    <td>时间</td>
    <td>&nbsp;</td>
</tr>
<%


DbAdapter dbadapter=new DbAdapter();
try
{
  count=  dbadapter.getInt("SELECT DISTINCT COUNT( n.node ) "+from.toString()+sql.toString());
  dbadapter.executeQuery("SELECT DISTINCT n.node "+from.toString()+sql.toString());
if(count==0)
{
   out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
}

  for (int index = 0; index < pos + pageSize && dbadapter.next(); index++)
  {
    if (index >= pos)
    {
      int id=dbadapter.getInt(1);
      Node node=Node.find(id);
      String subject=node.getSubject(teasession._nLanguage);

      Goods g=Goods.find(id);

      %>
      <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
        <td width="1"><%=index+1%></td>
        <td><%=node.getNumber() %></td>
        <td>
          <A href="/servlet/Goods?node=<%=id%>" ><%=subject%></A>
        </td>
        <td><%=Node.find(node.getFather()).getSubject(teasession._nLanguage)%></td>
        <td>&nbsp;<%
        Brand b=null;
        if(g.getBrand()>0&&(b=Brand.find(g.getBrand())).isExists())
        {
          if(b.getNode()>0)
          out.print("<a target=_blank href=/servlet/Node?node="+b.getNode()+">");
          out.print(b.getName(teasession._nLanguage)+"</a>");
        }
        %></td>
        <td><%=node.getClick()%></td>
        <td><%=node.getTimeToString()%></td>
         <td>
         <input type="button" value="<%=r.getString(teasession._nLanguage,"CBEdit")%>" onClick="window.open('/jsp/type/goods/EditGoods.jsp?node=<%=id%>&nexturl=<%=nexturl%>','_self');"/>
         <input type="button" value="<%=r.getString(teasession._nLanguage,"CBDelete")%>" onClick="if(confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>')){window.open('/servlet/DeleteNode?node=<%=id%>&nexturl=<%=nexturl%>', '_self')};"/>
         </td>
      </tr>
      <%
      }
    }
}catch(Exception e)
{
  e.printStackTrace();
}finally
{
  dbadapter.close();
}

%>
</table>
<%=new tea.htmlx.FPNL(teasession._nLanguage, request.getRequestURI()+param.toString() + "&Pos=", pos, count)%>


<div id="head6"><img height="6" alt=""></div>

<script src="<%=communitys.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></script>


<script>spancount.innerHTML="<%=count%>";</script>
</body>
</html>

