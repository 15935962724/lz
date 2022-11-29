<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="java.util.*"%>
<%@page import="java.math.*"%>
<%@page import="tea.ui.*"%>
<%@page import="tea.db.*"%>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?Node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

int brand=Integer.parseInt(request.getParameter("brand"));

Brand b=Brand.find(brand);

String nexturl=request.getParameter("nexturl");
String type=request.getParameter("czlx");

	if(request.getMethod().equals("POST"))
	{
	  float discounts=Float.parseFloat(request.getParameter("discounts"));
	  String options[]=request.getParameterValues("options");
	  DbAdapter db=new DbAdapter();
	  try
	  {
	    db.executeQuery("SELECT c.commodity,bp.currency FROM BuyPrice bp,Commodity c,Goods g WHERE g.brand="+brand+" AND g.node=c.goods AND c.commodity=bp.commodity");
	    while(db.next())
	    {
	      int commodity=db.getInt(1);
	      int currency=db.getInt(2);
	      System.out.println("价格批修:"+commodity+":"+currency+"\t折:"+discounts+"brand="+brand+"type="+type);
	      BuyPrice bp=BuyPrice.find(commodity,currency);
	      BigDecimal list=bp.getList();
	      BigDecimal price=bp.getPrice();
	      for(int i=0;i<options.length;i++)
	      {
	        if("list".equals(options[i]))
	        {
	          //list = list.multiply(new BigDecimal(discounts).divide(new BigDecimal(10))).setScale(2, 4);
	              if(type.equals("add")){

	          list=list.add(new BigDecimal(discounts)).setScale(2,4);

	          }else if(type.equals("reduce")){
	            list=list.subtract(new BigDecimal(discounts)).setScale(2,4);
	          }
	        }else if("price".equals(options[i]))
	        {
	          //price = price.multiply(new BigDecimal(discounts).divide(new BigDecimal(10))).setScale(2, 4);
	          if(type.equals("add")){

	          price=price.add(new BigDecimal(discounts)).setScale(2,4);

	          }else if(type.equals("reduce")){
	            price=price.subtract(new BigDecimal(discounts)).setScale(2,4);
	          }
	        }
	      }
	      bp.set(list,price);
	    }
	  }finally
	  {
	    db.close();
	  }

	  response.sendRedirect("/jsp/info/Succeed.jsp?nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8"));
	  return;
	}


Resource r = new Resource();
r.add("/tea/ui/node/type/buy/EditBuyPrice");

String _strId=request.getParameter("id");

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script>
function f_submit(obj)
{
	var v=parseFloat(obj.value);
	if(v>0)
	{
	}else
	{
		alert("必须大于0");
		obj.focus();
		return false;
	}
    if(document.getElementById("tp").value=""||document.getElementById("tp").value==null){
        alert("请选择操作类型.");
		return false;
    }
	if(!form1.options[0].checked&&!form1.options[1].checked)
	{
		alert("必须选择一项.");
		return false;
	}
	return true;
}

</script>
</head>
<body onLoad="form1.discounts.focus();">
<h1><%=r.getString(teasession._nLanguage, "批量修改价格")+" ( "+b.getName(teasession._nLanguage)+" )"%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<form name="form1" method="POST" action="?" onSubmit="return(confirm('确认修改?')&&submitFloat(form1.discounts,'<%=r.getString(teasession._nLanguage, "无效-折扣")%>')&&f_submit(form1.discounts));">
<input type='hidden' name="commodity" value="<%=teasession._strCommunity%>">
<input type='hidden' name="id" value="<%=_strId%>">
<input type='hidden' name="brand" value="<%=brand%>">
<input type='hidden' name="nexturl" value="<%=nexturl%>">

<table cellspacing="0" cellpadding="0" border="0" id="tablecenter">
  <tr>
    <td>类型</td>
    <td>
      <select name="czlx" id="type">
         <option value="">----</option>
         <option value="add">+</option>
         <option value="reduce">-</option>
      </select>
    </td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "价格")%>:</td>
    <td><input type="TEXT" name=discounts size=6 value="0.00" onKeyPress="inputFloat();"></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "选项")%>:</td>
    <td><input name="options" type="checkbox" value="list">销售价
	<input name="options" type="checkbox" value="price">会员价</td>
  </tr>
</table>
<input type="submit" value="<%=r.getString(teasession._nLanguage, "Submit")%>">
<input type="reset" value="重置">
<input type="button" value="返回" onClick="window.open('<%=nexturl%>','_self');">
</form>

<div id="head6"><img height="6" src="about:blank"></div>

<table cellspacing="0" cellpadding="0" border="0" id="tablecenter">
<tr><td>注:</td></tr>
<tr><td>1.请在"价格框"中直接输入,请先选择加减</td></tr>
</table>


  <div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
