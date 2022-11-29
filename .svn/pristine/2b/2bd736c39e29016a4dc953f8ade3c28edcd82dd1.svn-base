<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.resource.*"%>
<%@page import="java.util.*"%>
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

if("g1".equals(teasession.getParameter("act")))
{
  int goodstype = 0;
  if(teasession.getParameter("goodstype")!=null && teasession.getParameter("goodstype").length()>0)
  {
    goodstype = Integer.parseInt(teasession.getParameter("goodstype"));
  }

  String goodstype1  = teasession.getParameter("goodstype1");
 int goodstype2= 0;

 if(teasession.getParameter("goodstype2")!=null && teasession.getParameter("goodstype2").length()>0)
 {
   goodstype2 = Integer.parseInt(teasession.getParameter("goodstype2"));
 }

  out.print("<select name=goodstype2>");
  out.print("<option value =0>------------</option>");
  if(Integer.parseInt(goodstype1)>0){
    for(Enumeration enumeration = GoodsType.findByFather(Integer.parseInt(goodstype1)); enumeration.hasMoreElements(); )
    {
      GoodsType node = (GoodsType)enumeration.nextElement();
      int j=node.getGoodstype();

      out.print("<option value="+j);
      if(goodstype2==j)
      {
        out.print(" SELECTED");
      }
      out.print(">"+node.getName(teasession._nLanguage));
      out.print("</option>");

    }
    out.print("</select>");
  }
  return;
}

int supplier=Integer.parseInt(request.getParameter("supplier"));
int brand=Integer.parseInt(request.getParameter("brand"));
SupplierBrandDiscounts obj=SupplierBrandDiscounts.find(supplier,brand);

String nexturl=request.getParameter("nexturl");

if("POST".equals(request.getMethod()))
{
  String act=request.getParameter("act");
  int goodstype1=0;
  int goodstype2=0;
  if(teasession.getParameter("goodstype1")!=null && teasession.getParameter("goodstype1").length()>0)
  {
    goodstype1 = Integer.parseInt(teasession.getParameter("goodstype1"));
  }


  if(teasession.getParameter("goodstype2")!=null && teasession.getParameter("goodstype2").length()>0)
  {
    goodstype2 = Integer.parseInt(teasession.getParameter("goodstype2"));
  }

  int floor = 0;
  if(teasession.getParameter("floor")!=null && teasession.getParameter("floor").length()>0)
  {
    floor = Integer.parseInt(teasession.getParameter("floor"));
  }
  String nodename = teasession.getParameter("nodename");
  if("delete".equals(act))
  {
  	obj.delete();

  }else
  {
	float discounts=Float.parseFloat(request.getParameter("discounts"));
	Date starttime=SupplierBrandDiscounts.sdf.parse(request.getParameter("startYear")+"-"+request.getParameter("startMonth")+"-"+request.getParameter("startDay"));
	Date stoptime=SupplierBrandDiscounts.sdf.parse(request.getParameter("stopYear")+"-"+request.getParameter("stopMonth")+"-"+request.getParameter("stopDay"));

	obj.set(discounts,starttime,stoptime,teasession._rv._strV,goodstype1,floor,goodstype2,nodename);
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

</head>
<body onload="f_g1(<%=obj.getGoodstype2()%>);">
<script>

function f_submit(form1)
{
  if(!(parseFloat(form1.discounts.value)>0))
  {
    alert("必须大于0.");
    form1.discounts.focus();
    return false;
  }
  return true;
}
  function f_g1(igd)
  {
    sendx("?act=g1&goodstype2="+igd+"&goodstype1="+form1.goodstype1.value,
    function(data)
    {
      document.getElementById('show').innerHTML=data;
    }
    );
  }
  function f_node()
  {
   var rs = window.showModalDialog('/jsp/type/brand/BrandGoods.jsp','self','edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:857px;dialogHeight:605px;');
   if(rs!=null)
   {
     form1.nodename.value= form1.nodename.value+rs+";"
   }
  }
</script>

<h1><%=r.getString(teasession._nLanguage, "CBEditBuy")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<form name="form1" method="POST" action="?" onSubmit="return(submitText(this.supplier,'<%=r.getString(teasession._nLanguage, "无效-供应商")%>') && submitText(this.brand,'<%=r.getString(teasession._nLanguage, "无效-品牌")%>') && submitFloat(this.discounts,'无效-折扣') && f_submit(this) );">
<input type='hidden' name="commodity" value="<%=teasession._strCommunity%>">
<input type='hidden' name="id" value="<%=_strId%>">
<input type='hidden' name="nexturl" value="<%=nexturl%>">

<table cellspacing="0" cellpadding="0" border="0" id="tablecenter">
  <tr><td>供应商</td>
    <td><select name="supplier" ><option value="" >----------</option>
        <%
        Enumeration e_s=Supplier.findByCommunity(teasession._strCommunity);
        while(e_s.hasMoreElements())
        {
          int id=((Integer)e_s.nextElement()).intValue();
          Supplier s=Supplier.find(id);
          out.print("<option value="+id);
          if(id==supplier)
          out.print(" SELECTED ");
          out.print(" >"+s.getName(teasession._nLanguage));
        }
        %>
        </select>
  </td>
</tr>
  <tr><td>品牌</td>
    <td><select name="brand" ><option value="" >----------</option>
        <%
        Enumeration e_b=Brand.findByCommunity(teasession._strCommunity,"",0,Integer.MAX_VALUE);
        while(e_b.hasMoreElements())
        {
          int id=((Integer)e_b.nextElement()).intValue();
          Brand b=Brand.find(id);
          out.print("<option value="+id);
          if(id==brand)
          out.print(" SELECTED ");
          out.print(" >"+b.getName(teasession._nLanguage));
        }
        %>
        </select><input type="button" value="..." onclick="window.open('/jsp/type/brand/DialogBrand.jsp?community=<%=teasession._strCommunity%>&field=form1.brand','','height=500,width=550,scrollbars=yes');"/>
  </td>
</tr>
 <tr>
    <td><%=r.getString(teasession._nLanguage, "商品类别")%>:</td>
    <td>

      <select name="goodstype1" onchange="f_g1('0');">
        <option value="0">-------------</option>
        <%

        int rootid=GoodsType.getRootId(teasession._strCommunity);
        for(Enumeration enumeration = GoodsType.findByFather(rootid); enumeration.hasMoreElements(); )
        {
          GoodsType node = (GoodsType)enumeration.nextElement();
          int j=node.getGoodstype();
          out.print("<option value="+j);
          if(obj.getGoodstype()==j)
          {
            out.print(" SELECTED");
          }
          out.print(">"+node.getName(teasession._nLanguage));
          out.print("</option>");
        }
        %>
        </select>
        <span id="show">
          <select name="goodstype2"><option value="0">------------</option></select>
        </span>


    </td>
  </tr>
   <tr>
    <td><%=r.getString(teasession._nLanguage, "消费额度")%>:</td>
    <td><input type="text" name="floor" value="<%if(obj.getFloor()>0)out.print(obj.getFloor());%>" size="5">&nbsp;元</td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "开始日期")%>:</td>
    <td><%=new tea.htmlx.TimeSelection("start", obj.getStartTime())%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "截止日期")%>:</td>
    <td><%=new tea.htmlx.TimeSelection("stop", obj.getStopTime())%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "OurPrice")%>:</td>
    <td><input type="TEXT" name=discounts size=6 value="<%=obj.getDiscounts()%>" onkeypress="inputFloat();">折</td>
  </tr>
</table>
<table cellspacing="0" cellpadding="0" border="0" id="tablecenter">
<tr>
<td>具体打折商品：</td>
<td><textarea cols="40" rows="3" name="nodename"><%if(obj.getNodename()!=null)out.print(obj.getNodename());%></textarea>&nbsp;<input type="button" value="查找商品" onclick="f_node();"></td>
</tr>
</table>
<input type="submit" value="<%=r.getString(teasession._nLanguage, "Submit")%>">
<input type="reset" value="重置">
<input type="button" value="返回" onclick="window.open('<%=nexturl%>','_self');">
</form>


<div id="head6"><img height="6" src="about:blank"></div>
<table cellspacing="0" cellpadding="0" border="0" id="tablecenter">
<tr><td>注:</td></tr>
<tr><td>请在"<%=r.getString(teasession._nLanguage, "OurPrice")%>"中,直接输入折数,如:打9折,请输入9。</td></tr>
</table>

<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
