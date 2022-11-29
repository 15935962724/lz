<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter" %><%@page import="tea.resource.Resource" %><%@page import="tea.entity.admin.erp.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.ui.TeaSession" %><%@ page import="tea.entity.league.*" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}




StringBuffer param=new StringBuffer("?node="+teasession._nNode);
StringBuffer sql=new StringBuffer();



int supplnamehidden =0;

if(teasession.getParameter("supplnamehidden")!=null && teasession.getParameter("supplnamehidden").length()>0)
{
  supplnamehidden=Integer.parseInt(teasession.getParameter("supplnamehidden"));
}

if(supplnamehidden>0)
{
  sql.append(" AND p.supplname ="+supplnamehidden);
  param.append("&supplnamehidden=").append(supplnamehidden);
}
int waridname = 0;
if(teasession.getParameter("waridname")!=null && teasession.getParameter("waridname").length()>0)
{
  waridname=Integer.parseInt(teasession.getParameter("waridname"));
}
System.out.println(waridname);

if(waridname>0)
{
  sql.append(" AND p.waridname ="+waridname);
  param.append("&waridname=").append(waridname);
}
String goodsnumber = teasession.getParameter("goodsnumber");
if(goodsnumber!=null && goodsnumber.length()>0)
{
  sql.append(" AND gd.node in (SELECT node FROM Node WHERE goodsnumber LIKE '%"+goodsnumber+"%')");
  param.append("&goodsnumber=").append(java.net.URLEncoder.encode(goodsnumber,"UTF-8"));
}
String subject = teasession.getParameter("subject");
if(subject!=null && subject.length()>0)
{
  sql.append(" AND gd.node  in (SELECT node FROM Nodelayer WHERE subject LIKE '%"+subject+"%')");
  param.append("&subject=").append(java.net.URLEncoder.encode(subject,"UTF-8"));
}
String spec = teasession.getParameter("spec");
if(spec!=null && spec.length()>0)
{
  sql.append(" AND gd.node  in (SELECT node FROM Goods WHERE  spec LIKE '%"+spec+"%' )");
  param.append("&spec=").append(java.net.URLEncoder.encode(spec,"UTF-8"));
}

int brand =0;
if(teasession.getParameter("brand")!=null && teasession.getParameter("brand").length()>0)
{
  brand = Integer.parseInt(teasession.getParameter("brand"));
  sql.append(" AND gd.node  in (SELECT node FROM Goods WHERE  brand ="+brand+" )");
  param.append("&brand=").append(brand);
}

int goodstype1 = 0;
if(teasession.getParameter("goodstype1")!=null && teasession.getParameter("goodstype1").length()>0)
{
  goodstype1 = Integer.parseInt(teasession.getParameter("goodstype1"));
  if(goodstype1>0){
    sql.append(" AND gd.node  in (SELECT node FROM Goods WHERE   goodstype LIKE '%/"+goodstype1+"/%' )");
    param.append("&goodstype1=").append(goodstype1);
  }
}
int goodstype2 = 0;
if(teasession.getParameter("goodstype2")!=null && teasession.getParameter("goodstype2").length()>0)
{
  goodstype2 = Integer.parseInt(teasession.getParameter("goodstype2"));
  if(goodstype2>0){
    sql.append(" AND gd.node  in (SELECT node FROM Goods WHERE   goodstype LIKE '%/"+goodstype2+"/%' )");
    param.append("&goodstype2=").append(goodstype2);
  }
}




  int count=0;
  int pos=0;
  int pageSize=10;
  if( teasession.getParameter("pos")!=null)
  {
    pos=Integer.parseInt(  teasession.getParameter("pos"));
  }
count = GoodsDetails.countpai(teasession._strCommunity,sql.toString());
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

     sendx("/jsp/erp/Goods_ajax.jsp?act=goodstype&father="+form1.goodstype1.value+"&goodstype2="+igd,
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

<form name="form1" action="?" method="GET" target="tar">
<input type="hidden" name="waridname" value="<%=waridname%>">


<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td nowrap>条形码或编号：&nbsp;<input type="text" name="goodsnumber" value="<%if(goodsnumber!=null)out.print(goodsnumber);%>"/></td>
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

<h2>列表( <span id=spancount><%=count %></span> )</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
   <td nowrap width="1">&nbsp;</td><!-- <input type="checkbox" name="checkall" onclick="CheckAll('checkname','checkall');">-->
   <td nowrap>销售单号</td>
    <td nowrap>条形码或编号</td>
    <td nowrap>商品名称</td>
    <td nowrap>规格型号</td>
    <td nowrap>品牌</td>
    <td nowrap>进货价</td>
  </tr>
  <%

int is = 1;


java.util.Enumeration e = GoodsDetails.findPai(teasession._strCommunity,sql.toString(),pos,pageSize);

   if(!e.hasMoreElements())
   {

       out.print("<tr><td colspan=10 align=center>暂无您查询的商品!</td></tr>");
   }

while(e.hasMoreElements())
{
  int gdid = ((Integer)e.nextElement()).intValue();
  GoodsDetails  gdobj = GoodsDetails.find(gdid);
  int nodeid = gdobj.getNode();
  Node node=Node.find(nodeid);
  Goods g=Goods.find(nodeid);
  Commodity cobj = Commodity.find_goods(nodeid);
  BuyPrice bpobj = BuyPrice.find(cobj.getCommodity(),1);
 Inventory iobj = Inventory.find(Inventory.getInvid(gdobj.getCommunity(),nodeid,waridname));

  %>

  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" title="点击选择商品"  onclick="f_button('<%=gdobj.getPaid()%>');"  style=cursor:pointer>
    <td width="1"><%=is %></td>
    <td nowrap><%=gdobj.getPaid()%></td>
    <td nowrap><%=node.getNumber() %></td>
    <td nowrap><%=node.getSubject(teasession._nLanguage) %> </td>
    <td nowrap><%=g.getSpec(teasession._nLanguage) %></td>
    <td nowrap><%
    Brand b=null;
    if(g.getBrand()>0&&(b=Brand.find(g.getBrand())).isExists())
    {
      if(b.getNode()>0)
      out.print(b.getName(teasession._nLanguage));
    }
    %></td>
    <td nowrap><%=gdobj.getSupply()%></td>
  </tr>
  <%
is++;
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
<script>
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
