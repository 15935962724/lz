<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter" %><%@page import="tea.resource.Resource" %><%@page import="tea.entity.eon.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.ui.TeaSession" %><%@ page import="tea.entity.league.*" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


StringBuffer param=new StringBuffer("?node="+teasession._nNode);
StringBuffer sql=new StringBuffer(" WHERE n.community="+tea.db.DbAdapter.cite(teasession._strCommunity)+" AND n.node=g.node AND g.node=c.goods ");
StringBuffer from=new StringBuffer(" FROM Node n,Goods g,Commodity c");

//type 如果为0 则价格进货价 如果为1 是供货价格
int type = 0;
if(teasession.getParameter("type")!=null&&teasession.getParameter("type").length()>0)
{
  type = Integer.parseInt(teasession.getParameter("type"));
}
// 供货商

int supplname = 0;
if(teasession.getParameter("supplname")!=null&&teasession.getParameter("supplname").length()>0)
{
  supplname = Integer.parseInt(teasession.getParameter("supplname"));
}
param.append("&supplname=").append(supplname);
param.append("&type=").append(type);


//int supplnamehidden=0;
//if(teasession.getParameter("supplnamehidden")!=null && teasession.getParameter("supplnamehidden").length()>0)
//{
//  supplnamehidden = Integer.parseInt(teasession.getParameter("supplnamehidden"));
//  if(supplnamehidden>0)
//  {
//    LeagueShop lsobj = LeagueShop.find(supplnamehidden);
//    LeagueShopType lstobj = LeagueShopType.find(lsobj.getLstype());
//    StringBuffer sp = new StringBuffer();
//    if(lstobj.getBrands().split("/").length-1>=1)
//    {
//      sp.append("  brand =").append(lstobj.getBrands().split("/")[1]);
//    }
//    if(lstobj.getBrands().split("/").length-1>=2)
//    {
//      sp.append(" or brand =").append(lstobj.getBrands().split("/")[2]).append(")");
//    }
//
//
//    sql.append(" AND g.node in (SELECT node FROM  Goods where "+sp.toString()+")");
//    param.append("&supplnamehidden=").append(supplnamehidden);
//  }
//
//}
String number = teasession.getParameter("number");
if(number!=null && number.length()>0)
{
  sql.append(" AND n.goodsnumber Like ").append(DbAdapter.cite("%"+number+"%"));
  param.append("&number=").append(java.net.URLEncoder.encode(number,"UTF-8"));
}
String subject = teasession.getParameter("subject");
if(subject!=null && subject.length()>0)
{
  sql.append(" AND n.node in (SELECT node FROM Nodelayer WHERE subject LIKE '%"+subject+"%')");
  param.append("&subject=").append(java.net.URLEncoder.encode(subject,"UTF-8"));
}
String spec = teasession.getParameter("spec");
if(spec!=null && spec.length()>0)
{
  sql.append(" AND g.spec LIKE '%"+spec+"%' ");
  param.append("&spec=").append(java.net.URLEncoder.encode(spec,"UTF-8"));
}

int brand =0;
if(teasession.getParameter("brand")!=null && teasession.getParameter("brand").length()>0)
{
  brand = Integer.parseInt(teasession.getParameter("brand"));
  sql.append(" AND g.brand = ").append(brand);
  param.append("&brand=").append(brand);
}

int goodstype1 = 0;
if(teasession.getParameter("goodstype1")!=null && teasession.getParameter("goodstype1").length()>0)
{
  goodstype1 = Integer.parseInt(teasession.getParameter("goodstype1"));
  if(goodstype1>0){
    sql.append(" AND g.goodstype LIKE '%/"+goodstype1+"/%' ");
    param.append("&goodstype1=").append(goodstype1);
  }
}
int goodstype2 = 0;
if(teasession.getParameter("goodstype2")!=null && teasession.getParameter("goodstype2").length()>0)
{
  goodstype2 = Integer.parseInt(teasession.getParameter("goodstype2"));
  if(goodstype2>0){
    sql.append(" AND g.goodstype LIKE '%/"+goodstype2+"/%' ");
    param.append("&goodstype2=").append(goodstype2);
  }
}



int root=GoodsType.getRootId(teasession._strCommunity);

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">

<body  <%if(goodstype1>0){out.print("onload=\"f_goodstype("+goodstype2+");\"");}%>>
<script type="text/javascript">
window.name='tar';

function f_button(igd)
{
  window.returnValue=igd;
  window.close();
}
function f_goodstype(igd)
{
     sendx("/jsp/erp/Goods_ajax.jsp?goodstype2="+igd+"&act=goodstype&father="+form1.goodstype1.value,
     function(data)
     {
       document.getElementById('show').innerHTML=data;
     }
     );
}
</script>

<h1>选择商品</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<h2>查询</h2>
<form name="form1" action="?" method="GET" target="tar">
<input type="hidden" name="type" value="<%=type%>"/>
<input type="hidden" name="supplname" value="<%=supplname%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
  <td nowrap>条形码或编号：&nbsp;<input type="text" name="number" value="<%if(number!=null)out.print(number);%>"/></td>
    <td nowrap>商品名称：&nbsp;<input type="text" name="subject" value="<%if(subject!=null)out.print(subject);%>"/></td>
    <td nowrap>商品类别：&nbsp;
          <select name="goodstype1" onchange="f_goodstype('0');">
            <option value="0">请选择一级类别</option>
            <%
            java.util.Enumeration ge = GoodsType.findByFather(root);
            while(ge.hasMoreElements())
            {
              GoodsType gobj = (GoodsType)ge.nextElement();
              out.print("<option value="+gobj.getGoodstype());
              if(goodstype1==gobj.getGoodstype())
              {
                out.print(" SELECTED");
              }
              out.print(">"+gobj.getName(teasession._nLanguage));
              out.print("</option>");
            }
            %>
            </select>
            <span id="show">
              <select name="goodstype2">
                <option value="">请选择二级类别</option>
              </select>
            </span>
        </td>

  </tr>
  <tr>
    <td nowrap>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;商品规格：&nbsp;<input type="text" name="spec" value="<%if(spec!=null)out.print(spec);%>"/></td>
    <td nowrap>商品品牌：&nbsp;
     <select name="brand">
     <option value="">-----</option>
     <%
       java.util.Enumeration be = Brand.findByCommunity(teasession._strCommunity,"",0,Integer.MAX_VALUE);
        while(be.hasMoreElements())
        {
          int bradnid = ((Integer)be.nextElement()).intValue();
           Brand bobj = Brand.find(bradnid);
           out.print("<option value="+bradnid);
           if(brand==bradnid)
           {
             out.print(" selected");
           }
           out.print(">"+bobj.getName(teasession._nLanguage));
           out.print("</option>");
        }
     %>
    </select>
    </td>
    <td><input type="submit" value="查询"/></td>
  </tr>
</table>

<h2>列表( <span id=spancount>0</span> )</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
   <td  width="1"></td><!-- <input type="checkbox" name="checkall" onclick="CheckAll('checkname','checkall');">-->
    <td nowrap>条形码或编号</td>
    <td nowrap>商品名称</td>
    <td nowrap>规格型号</td>
    <td nowrap>品牌</td>
    <td nowrap>单位</td>
    <%if(type==1){%>
     <td nowrap>供货价</td>
    <%} else{%>
    <td nowrap>进货价</td>
    <%}%>
  </tr>
  <%


  int count=0;
  int pos=0;
  int pageSize=10;
  if( teasession.getParameter("pos")!=null)
  {
    pos=Integer.parseInt(  teasession.getParameter("pos"));
  }

  DbAdapter dbadapter=new DbAdapter();
  try
  {
    sql.append(" and  c.supplier=").append(supplname);
    count= dbadapter.getInt("SELECT  count(DISTINCT(n.node))  "+from.toString()+sql.toString());
    dbadapter.executeQuery("SELECT DISTINCT n.node "+from.toString()+sql.toString());
    

 
    int is = 1;

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
        Goods g=Goods.find(id);
        Commodity cobj = Commodity.find(Commodity.getCommodity(supplname,id)); 
        BuyPrice bpobj = BuyPrice.find(Commodity.getCommodity(supplname,id),1);
  	  Brand b=Brand.find(g.getBrand());
  %>

  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" title="点击选择商品"  onclick="f_button('<%=id%>');"  style=cursor:pointer>
    <td width="1"><%=is+pos %></td>
      <td nowrap><%=node.getNumber() %></td><!--条形码或编号-->
      <td nowrap><%=node.getSubject(teasession._nLanguage) %> </td><!--商品名称-->
      <td nowrap><%=g.getSpec(teasession._nLanguage) %></td><!--规格型号-->
      <td nowrap><%=b.getName(teasession._nLanguage)    %></td>
      <td nowrap><%=g.getMeasure(teasession._nLanguage)%></td><!--单位-->
      <td nowrap><% if(type==1){if(bpobj.getSupply()!=null)out.print(bpobj.getSupply());}else if(type==0) {if(bpobj.getList()!=null)out.print(bpobj.getList());}%></td><!--进价-->
  </tr>
  <%
  is++;
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
  <%if (count > pageSize) { %>
   <tr> <td colspan="10" id="tdpage"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
  <%
 out.print("<script>document.getElementById('go').style.display='none';</script>");
}  %>
</table>
<br>
<input type="button" value="关闭"  onClick="javascript:window.close();">
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
<script>spancount.innerHTML="<%=count%>";
var as=document.getElementById("tdpage");
if(as)
{
  as=as.getElementsByTagName("A");

  for(var i=0;i<as.length;i++)
  {
    as[i].setAttribute("target","tar");
  }
}

</script>
</body>
</html>
