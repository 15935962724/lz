<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.db.*" %>
<%@page import="tea.ui.*" %>
<%@ page  import="tea.resource.Resource"  %>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");


TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?Node="+teasession._nNode+"&nexturl="+request.getRequestURI()+"?"+request.getQueryString());
  return;
}

String _strId=teasession.getParameter("id");


String goodstype=teasession.getParameter("goodstype");//一类

String goodstype2=request.getParameter("goodstype2");//二类
String goodstype3=request.getParameter("goodstype3");//三类
String goodstype4= request.getParameter("goodstype4");//品牌


tea.resource.Resource r=new tea.resource.Resource();

String supplier=teasession.getParameter("supplier");
String serialnumber=teasession.getParameter("serialnumber");



StringBuffer param=new StringBuffer();
param.append("?community=").append(teasession._strCommunity);
param.append("&id=").append(_strId);

  StringBuffer sql=new StringBuffer(" WHERE n.community="+DbAdapter.cite(teasession._strCommunity)+" AND n.node=g.node  ");
  StringBuffer from=new StringBuffer(" FROM Node n,Goods g");
int g1 = 0;
  int root1=GoodsType.getRootId(teasession._strCommunity);
    if(goodstype!=null&&goodstype.length()>0)//种类查询
  {
  	 g1 = Integer.parseInt(goodstype);
    sql.append(" AND g.goodstype LIKE '/").append(root1).append("/").append(goodstype).append("/%'");
    param.append("&goodstype=").append(goodstype);
  }
  if(goodstype2!=null && goodstype2.length()>0)
  {
  		sql.append(" AND g.goodstype LIKE '/").append(root1).append("/").append(goodstype).append("/").append(goodstype2).append("/%'");
    	param.append("&goodstype2=").append(goodstype2);
  }
 if(goodstype3!=null && goodstype3.length()>0)
  {
  		sql.append(" AND g.goodstype LIKE '/").append(root1).append("/").append(goodstype).append("/").append(goodstype2).append("/").append(goodstype3).append("/%'");
    	param.append("&goodstype3=").append(goodstype3);
  }
 //品牌
 if(goodstype4!=null && goodstype4.length()>0)
 {
 	sql.append(" AND g.goodstype LIKE '/").append(root1).append("/").append(goodstype).append("/").append(goodstype2).append("/").append(goodstype3).append("/%'").append(" and brand like "+DbAdapter.cite("%"+goodstype4+"%")+"");
    param.append("&goodstype4=").append(goodstype4);
 }

  int count=0;
  int pos=0;
  int pageSize=25;
  if(teasession.getParameter("Pos")!=null)
  {
    pos=Integer.parseInt(teasession.getParameter("Pos"));
  }

String order=request.getParameter("order");
if(order==null)
order="n.node";
param.append("&order=").append(order);

String desc=request.getParameter("desc");
if(desc==null)
desc="desc";
param.append("&desc=").append(desc);

//sql.append(" ORDER BY ").append(order).append(" ").append(desc);






String nexturl=java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"utf-8");
Community communitys=Community.find(teasession._strCommunity);



%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script language="javascript" src="/tea/load.js"  type="text/javascript"></script>
</head>
<script language="javascript">
function showDetail()
{

	var goodstype = form1_gs.goodstype.value;


	currentPos = "show";
	send_request("/jsp/type/goods/info_import/kind_ajax.jsp?goodstype="+goodstype);
	//form1_gs.bradn.value=form1_gs.goodstype.value;

}
function showDetail2()
{

	var goodstype2 = form1_gs.goodstype2.value;
	currentPos = "show2";
	send_request("/jsp/type/goods/info_import/kind_ajax.jsp?goodstype2="+goodstype2);


}
function showDetail3()
{

	var goodstype3 = form1_gs.goodstype3.value;
	currentPos = "show3";
	send_request("/jsp/type/goods/info_import/kind_ajax.jsp?goodstype3="+goodstype3);


}
function selectAll(form,check)
{
  for(index=0;index<form.nodeid.length;index++)
  {
    if(form.nodeid[index].type=='checkbox')
    {
      form.nodeid[index].checked=check.checked;
    }
  }
}

</script>
<body id="bodynone">

<div id="jspbefore" style="display:none">
<script>if(top.location==self.location)jspbefore.style.display='';</script>
<%=communitys.getJspBefore(teasession._nLanguage)%>
</div>
<div id="tablebgnone" class="">
<h1>商品导入导出</h1>
<div id="head6"><img height="6" alt=""></div>



<h2>查询</h2>
<form name="form1_gs" action="?" method="get" >
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=_strId%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>

<script src="/res/<%=teasession._strCommunity%>/script/brand_<%=teasession._nLanguage%>.js"></script>

<input type="hidden" name="Node" value="<%=teasession._nNode%>"/>

<table width="100%" border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>

    <td>类别:</td>
 <td>
    <select name="goodstype" onchange="showDetail();">
    <option value="">----------</option>

	<%//商品的一级类别
		int root=GoodsType.getRootId(teasession._strCommunity);
	java.util.Enumeration e=GoodsType.findByFather(root);
	while(e.hasMoreElements())
	{
	  GoodsType obj=(GoodsType) e.nextElement();
	  out.print("<option value="+obj.getGoodstype());
	  if(obj.getGoodstype()==g1)
	  	out.print(" selected");
	  out.print(">"+obj.getName(teasession._nLanguage));
	  out.print("</option>");
	  if(obj.getGoodstype()==g1){
	  		out.print("<script>showDetail();</script>");
	  }
	}

	 %>
 </select>
</td>
<td id = "show"> <select> <option value="">----------</option></select></td>
<td id = "show2"> 品牌:<select> <option value="">----------</option></select></td>



    <td>&nbsp;<input type="submit" value="提交" /></td>
  </tr>
</table>
</form>




<form name="form1" action="/servlet/GwxEditExportExcel" method="POST" >
<h2>列表 ( <span id=spancount>0</span> )</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<input type=hidden name="files" value="importkind">

  <TR id="tableonetr">
    <td width="1">&nbsp;</td>
    <td>商品名称</td>
    <td>类型</td>
    <td>品牌</td>
    <td>人气</td>
    <td>时间</td>

</tr>
<%

DbAdapter db=new DbAdapter();
count=  db.getInt("SELECT DISTINCT COUNT( n.node ) "+from.toString()+sql.toString());
  db.executeQuery("SELECT DISTINCT n.node "+from.toString()+sql.toString());


try
{


  for (int index = 0; index < pos + pageSize && db.next(); index++)
  {
    if (index >= pos)
    {
      int id=db.getInt(1);
      Node node=Node.find(id);
      String subject=node.getSubject(teasession._nLanguage);

      Goods g=Goods.find(id);

      %>
      <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
        <td ><input type="CHECKBOX" name="nodeid"  value="<%=db.getInt(1) %>"></td>
        <td>
          <A href="/servlet/Goods?Node=<%=id%>" ><%=subject%></A>
        </td>
        <td><%=Node.find(node.getFather()).getSubject(teasession._nLanguage)%></td>
        <td>&nbsp;<%
        Brand b=null;
        if(g.getBrand()>0&&(b=Brand.find(g.getBrand())).isExists())
        {
          if(b.getNode()>0)
          out.print("<a target=_blank href=/servlet/Node?Node="+b.getNode()+">");
          out.print(b.getName(teasession._nLanguage)+"</a>");
        }
        %></td>
        <td><%=node.getClick()%></td>
        <td><%=node.getTimeToString()%></td>

      </tr>
      <%
      }
    }

}catch(Exception ex)
{
  ex.printStackTrace();
}finally
{
  db.close();
}

%>
<input type=hidden name="count_" value="<%=from.toString()+sql.toString() %>">
<tr>
<td colspan="2"><input type="CHECKBOX" onclick="selectAll(form1,this)" value="0">全选</td>

</tr>
</table>
</tr>
</table>

<%=new tea.htmlx.FPNL(teasession._nLanguage, request.getRequestURI()+param.toString() + "&Pos=", pos, count)%>
<br>
<input type=submit name="submit1" value=导出选中订单 onClick="return submitCheckbox(form1.nodeid,'请选中要导出的订单');">
<input type=submit name="submit2" value=导出全部 >
</form>
<div id="head6"><img height="6" alt=""></div>
<div id="jspafter" style="display:none">
<script>if(top.location==self.location)jspafter.style.display='';</script>
<%=communitys.getJspAfter(teasession._nLanguage)%>
</div>




<script>spancount.innerHTML="<%=count%>";</script>
</body>
</html>
