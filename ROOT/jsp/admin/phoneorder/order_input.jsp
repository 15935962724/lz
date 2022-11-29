<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.db.*" %>
<%@page import="tea.ui.*" %>
<%@ page  import="tea.resource.Resource"  %>
<%@page import ="tea.entity.member.*" %>
<%@page import="java.math.BigDecimal"%>
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

Date d = new Date();


java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

String act = request.getParameter("act");
String code = request.getParameter("code");//福利卡查询的卡号name值
String flcode = request.getParameter("flcode");
if(request.getParameter("biaoshi")!=null)
	flcode = code;
String sku = request.getParameter("sku");
String _strId=teasession.getParameter("id");
String nodes = request.getParameter("nodes");


String goodstype=teasession.getParameter("goodstype");//一类

String goodstype2=request.getParameter("goodstype2");//二类

String goodstype4= request.getParameter("goodstype4");//品牌


tea.resource.Resource r=new tea.resource.Resource();






StringBuffer param=new StringBuffer();
param.append("?community=").append(teasession._strCommunity);
param.append("&id=").append(_strId);

  StringBuffer sql=new StringBuffer(" WHERE n.community="+DbAdapter.cite(teasession._strCommunity)+"   and b.commodity=c.commodity AND n.node=g.node and g.node=c.goods");
  StringBuffer from=new StringBuffer(" FROM Node n,Goods g,Commodity c,BuyPrice b");
int g1 = 0;
//产品编号
String suk =request.getParameter("suk");
if(suk!=null && suk.length()>0)
{
	sql.append(" and c.sku like"+DbAdapter.cite("%"+suk+"%"));
	param.append("&sku=").append(suk);
}
//产品名称
String cpname = request.getParameter("cpname");
if(cpname!=null && cpname.length()>0)
{
	from.append(" ,NodeLayer nl");
	sql.append(" and n.node=nl.node and nl.subject like "+DbAdapter.cite("%"+cpname+"%"));
	param.append("&cpname=").append(cpname);
}
//货号
String serialnumber = request.getParameter("serialnumber");
if(serialnumber!=null && serialnumber.length()>0)
{
	sql.append(" and c.serialnumber like "+DbAdapter.cite("%"+serialnumber+"%"));
}
//产品价格

String PriceLow = request.getParameter("PriceLow");
if(PriceLow!=null && PriceLow.length()>0)
{
	BigDecimal price1 = new BigDecimal(PriceLow);
	sql.append(" and price >"+price1);

}
String PriceHigh = request.getParameter("PriceHigh");
if(PriceHigh!=null && PriceHigh.length()>0)
{
	BigDecimal price2 = new BigDecimal(PriceHigh);
	sql.append(" and price <"+price2);
}

//类别查询
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

 //品牌
 if(goodstype4!=null && goodstype4.length()>0)
 {
 	sql.append(" AND g.goodstype LIKE '/").append(root1).append("/").append(goodstype).append("/").append(goodstype2).append("/%'").append(" and brand like "+DbAdapter.cite("%"+goodstype4+"%")+"");
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

sql.append(" ORDER BY ").append(order).append(" ").append(desc);






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

<body id="bodynone">

<script>

//福利卡查询判断
function query1()
{

	if(form1.code.value=='')
	{
		alert("请您输入卡号");
		return false;
	}

	if (isNaN(document.form1.code.value))
		{
			alert("输入出错，不能输入除数字以外的字符!");
			document.form1.code.focus();
			return false;
		}
	//member.style.display = '';

	//member.innerHTML = '<table width="100%"><tr><td bgcolor="lightyellow" onclick="javascript:stop_query1();" title="点击此行停止查询">正在进行查询，请稍候...</td></tr></table>';
	//str = "/jsp/admin/phoneorder/query1.jsp?code="+form1.code.value;
	//document.frames["hiddenframe"].location.replace(str);
}
//产品查询判断
function query2()
{

	if(form1_gs.sku.value=='' && form1_gs.cpname.value=='' && form1_gs.goodstype.value=='' && form1_gs.goodstype2.value=='' && form1_gs.goodstype4.value=='' && form1_gs.serialnumber.value=='' && form1_gs.PriceLow.value=='' && form1_gs.PriceHigh.value=='')
	{
		alert("请您选择查询条件");
		return false;
    }

	//产品编号
	if (isNaN(document.form1_gs.sku.value))
	{
		alert("输入出错，不能输入除数字以外的字符!");
		document.form1_gs.sku.focus();
	    return false;
	}
	//价格范围
	if (isNaN(document.form1_gs.PriceLow.value))
	{
		alert("输入出错，不能输入除数字以外的字符!");
		document.form1_gs.PriceLow.focus();
	    return false;
	}
	if (isNaN(document.form1_gs.PriceHigh.value))
	{
		alert("输入出错，不能输入除数字以外的字符!");
		document.form1_gs.PriceHigh.focus();
	    return false;
	}


}
//类别
function showDetail()
{

	var goodstype = form1_gs.goodstype.value;


	currentPos = "show";
	send_request("/jsp/admin/phoneorder/order_input_ajax.jsp?goodstype="+goodstype);
	//form1_gs.bradn.value=form1_gs.goodstype.value;

}
function showDetail2()
{

	var goodstype2 = form1_gs.goodstype2.value;
	currentPos = "show2";
	send_request("/jsp/admin/phoneorder/order_input_ajax.jsp?goodstype2="+goodstype2);


}

//添加到购物车的判断
function before_submit()
{
	//福利卡卡号

	if(form3.code.value=="")
	{
		alert("福利卡卡号不能为空!");
		 return false;
	}
	if (isNaN(document.form3.code.value))
		{
			alert("输入出错，不能输入除数字以外的字符!");
			document.form3.code.focus();
		    return false;
		}

	//产品编号
	if(form3.sku.value=='')
	{
		alert("产品条形码不能为空!");
		 return false;
	}
	if (isNaN(document.form3.sku.value))
	{
		alert("输入出错，不能输入除数字以外的字符!");
		document.form3.sku.focus();
	    return false;
	}
	//购买数量
	if(form3.number.value=='')
	{
		alert("购买数量不能为空!");
		 return false;
	}
	if (isNaN(document.form3.number.value))
	{
		alert("输入出错，不能输入除数字以外的字符!");
		document.form3.number.focus();
	    return false;
	}

}
//隐藏表单
function showorhide1()
{
	mem_que.style.display=(mem_que.style.display=='')?'none':'';
}
function showorhide2()
{
	pro_que.style.display=(pro_que.style.display=='')?'none':'';

}


</script>

<h1>订单录入</h1>
<div id="head6"><img height="6" alt=""></div>

<!-- 福利卡号查询 -->
<form action="<%=request.getRequestURL() %>" method="post" name="form1"  onsubmit="return query1();">
<input type=hidden name ="act" value="query1">
<input type=hidden name="sku" value="<%=sku %>">
<input type=hidden name="nodes" value="<%=nodes %>">

        <div align="center"><a href="javascript:showorhide1();"><font color="#0000FF"><br>福利卡号查询 </font></a></div>
        <hr>
<div id="mem_que">
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
          <tr>
            <td>&nbsp;&nbsp; 福利卡卡号：</td>
            <td><input name="code" type="text" size="25" maxlength="25" value="<%if(code!=null && code.length()>0 && !code.equals("null"))out.print(code); %>"></td>
              <td   colspan="4"> <input type="submit" name="Submit1" value="点击此处进行查询" >  </td>
          </tr>
    </table>
</div>
</form>

<%
//福利卡查询
if("query1".equals(act))
{
 %>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">


  <TR id="tableonetr">
    <td>福利卡卡号</td>
</tr>

  <%
  Enumeration e= StoredValue.find(teasession._strCommunity," and 发卡类型 ='福利卡' and kh like "+DbAdapter.cite("%"+code+"%"),0,Integer.MAX_VALUE);


  if(!e.hasMoreElements())
  {
  	out.print("<tr><td>没有查询到您的卡号，请重新输入</td></tr>");
  }
  while(e.hasMoreElements()){
  	String codekh = ((String)e.nextElement());
	StoredValue svobj = StoredValue.find(codekh);
   %>
     <tr>
     <td><a href="/jsp/admin/phoneorder/order_input.jsp?sku=<%=sku %>&nodes=<%=nodes %>&code=<%=code %>&flcode=<%=svobj.getCode() %>"><%=svobj.getCode() %></a></td>
     </tr>


<%
 	}
	out.print("</table>");
	}
 %>
<!-- 产品查询 -->

<form action="<%=request.getRequestURL() %>" method="post" name=form1_gs id="form1_gs" onsubmit="return query2();">
<input type=hidden name ="act" value="query2">
<input type=hidden name="code" value=<%=code %>>
<input type=hidden name="flcode" value="<%=flcode %>">
        <div align="center"><a href="javascript:showorhide2();"><font color="#0000FF"><br>产品查询 </font> </a> </div>
        <hr><div id ="pro_que">
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
          <tr>
          <!--   <td>&nbsp;&nbsp; 产品编号：<br></td>
            <td><input name="sku" value="<%if(sku!=null&& !sku.equals("null"))out.print(sku); %>" type="text" size="25" maxlength="25"><br></td>-->
            <td > <div align="left"> 产品名称：</div>
              <br></td>
            <td  ><input name="cpname" value="<%if(cpname!=null)out.print(cpname); %>" type="text" id="MbBianhao2" size="20" maxlength="50"><br></td>
          </tr>

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
<td id = "show"> <select name="goodstype2"> <option value="">----------</option></select></td>
<td id = "show2"> 品牌:<select name="goodstype4"> <option value="">----------</option></select></td>
</tr>

          <tr>
            <td  >&nbsp;&nbsp;货号： <br></td>
            <td  ><input name="serialnumber" value="<%if(serialnumber!=null)out.print(serialnumber); %>" type="text" id="MbAddr22" size="25"><br></td>
            <td  >价格范围：<br></td>
            <td  ><input name="PriceLow" value="<%if(PriceLow!=null)out.print(PriceLow); %>" type="text" size="6" maxlength="25">
                -
                <input name="PriceHigh" type="text" value="<%if(PriceHigh!=null)out.print(PriceHigh); %>" size="6" maxlength="25"><br></td>
          </tr>
          <tr align="center">
            <td   colspan="4"><input type="submit" name="Submit2" value="填写任一条件后点击此处进行查询" >
            <br></td>
          </tr>
        </table></div>
</form>


<%
//产品查询
if("query2".equals(act))
{


%>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <TR id="tableonetr">
    <td>产品条形码</td>
    <td>产品名称</td>
    <td>计量单位</td>
    <td>规格</td>
    <td>价格</td>
    <td>产品状态</td>

</tr>

<%
DbAdapter db=new DbAdapter();
count=  db.getInt("SELECT DISTINCT COUNT( n.node ) "+from.toString()+sql.toString());
  db.executeQuery("SELECT DISTINCT n.node "+from.toString()+sql.toString());


try
{


  //for (int index = 0; index < pos + pageSize && db.next(); index++)
  if(count==0)
  {
  	out.print("<tr><td>没有查询到符合的产品，请重新查找</td></tr>");
  }
  for (int index = 0; db.next(); index++)
  {
    if (index >= pos)
    {
      int id=db.getInt(1);
      Node node=Node.find(id);
      String subject=node.getSubject(teasession._nLanguage);
      Goods g=Goods.find(id);
       Commodity obj = Commodity.find_goods(id);
       BuyPrice bp = BuyPrice.find(obj.getCommodity(),1);
 String value = (g.isStatus() ? "有货" : "无货");
 %>




      <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
        <td ><a href="/jsp/admin/phoneorder/order_input.jsp?code=<%=code %>&flcode=<%=flcode%>&sku=<%=obj.getSKU() %>&nodes=<%=id %>"><%=obj.getSKU() %></a></td>
        <td><%=node.getSubject(teasession._nLanguage) %></td>
        <td><%=g.getMeasure(teasession._nLanguage) %></td>
        <td><%=g.getSpec(teasession._nLanguage) %></td>
        <td><%=bp.getPrice()%></td>
        <td><%=value%></td>

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

</table>
<%

	}
 %>


<hr>
<!--  ///////////录入   -->
<form action="/servlet/EditOrderInput" method="post" name=form3  onsubmit="return before_submit();">
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
         <input type=hidden name="node" value="<%=nodes %>">
         <input type=hidden name="act" value="order_input">

    <tr>
      <td   align="right" width="28%">订单状态：<br></td>
      <td   width="1%">&nbsp; <br></td>
      <td   width="71%"><font color="#FF0000">录入</font> <br></td>
    </tr>

    <tr>
      <td   align="right" width="28%"> 福利卡号：<br></td>
      <td   width="1%">&nbsp; <br></td>
      <td   width="71%"> <input name="code" type="text" value="<%if(flcode!=null && flcode.length()>0 && !flcode.equals("null"))out.print(flcode); %>" size="20" maxlength="50">
        <font color="#FF0000">*</font> <br></td>
    </tr>

    <tr>
      <td   align="right" width="28%">产品条形码：<br></td>
      <td   width="1%">&nbsp; <br></td>
      <td   width="71%"> <input name="sku" type="text" value="<%if(sku!=null && !sku.equals("null"))out.print(sku);%>" size="20" maxlength="25">
        <font color="#FF0000">*</font> <br></td>
    </tr>
    <tr>
      <td   align="right" width="28%">产品数量：<br></td>
      <td   width="1%">&nbsp; <br></td>
      <td   width="71%"> <input name="number" value="1" type="text" size="20" maxlength="25">
        <font color="#FF0000">*</font> <br></td>
    </tr>

    <tr>
      <td   align="right" height="17" width="28%">订单时间：<br></td>
      <td   height="17" width="1%">&nbsp; <br></td>
      <td   height="17" width="71%"> <input type="text" name="dtime" size="20" value="<%out.print(sdf.format(d)); %>" readonly="true">
      <br></td>
    </tr>
    <tr>
      <td   align="right" width="28%">录入员：<br></td>
      <td   width="1%">&nbsp; <br></td>
      <td   width="71%"><%
      	Profile pobj = Profile.find(teasession._rv.toString());
      	out.print(pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage));

       %>

       <br></td>
    </tr>


  </table>
   <div align="center">
      <input type="submit" name="Submit" value="填写完后提交"> &nbsp;
       <input type="reset" name="reset" value="全部重写"> &nbsp;
      <input type="button" name="gogo" value="查看已录入的记录" onclick="window.open('/jsp/admin/phoneorder/order_list.jsp?code=<%=flcode %>&url=<%= request.getRequestURL() %>','_self');">
 </div>
</form>

<p>
  <IFRAME height=0 id="hiddenframe" name="hiddenframe" src="#" width=0></IFRAME>
</p>
<p>
  <IFRAME height=0 src="#" width=0></IFRAME>
</p>
<p>
  <IFRAME height=0 src="#" width=0></IFRAME>
</p>
<p>
  <IFRAME height=0 src="#" width=0></IFRAME>
</p>
<p>
  <IFRAME height=0 src="#" width=0></IFRAME>
</p>
<p>
  <IFRAME height=0 src="#" width=0></IFRAME>
</p>
<p>
  <IFRAME height=0 src="#" width=0></IFRAME>
</p>

</body>
</html>
