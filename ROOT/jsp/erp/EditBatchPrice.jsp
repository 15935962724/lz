<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.eon.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.text.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.league.*" %>
<%@page import="tea.entity.admin.erp.*" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String nexturl = teasession.getParameter("nexturl");

int bpid = 0;
if(teasession.getParameter("bpid")!=null && teasession.getParameter("bpid").length()>0)
{
  bpid = Integer.parseInt(teasession.getParameter("bpid"));
}
BatchPrice bpobj2 = BatchPrice.find(bpid);
Node nobj2 = Node.find(bpobj2.getNode());

StringBuffer sql=new StringBuffer();
StringBuffer param=new StringBuffer("?community="+teasession._strCommunity);

param.append("&nexturl=").append(java.net.URLEncoder.encode(nexturl,"UTF-8"));

//默认是什么记录不显示，只有搜索条件了 才能显示记录
boolean f = false;
//商品编号
String goodsnumber = teasession.getParameter("goodsnumber");
if(nobj2.getNumber()!=null&&nobj2.getNumber().length()>0)
{
  goodsnumber = nobj2.getNumber();
}
if(goodsnumber!=null && goodsnumber.length()>0)
{
  goodsnumber = goodsnumber.trim();
  sql.append(" AND  n.goodsnumber LIKE ").append(DbAdapter.cite("%"+goodsnumber+"%"));
  param.append("&goodsnumber=").append(goodsnumber);
  f=true;
}
//商品名称
String subject = teasession.getParameter("subject");
if(nobj2.getSubject(teasession._nLanguage)!=null&&nobj2.getSubject(teasession._nLanguage).length()>0)
{
  subject = nobj2.getSubject(teasession._nLanguage);
}
if(subject!=null && subject.length()>0)
{
  subject = subject.trim();
  sql.append(" AND nl.subject LIKE ").append(DbAdapter.cite("%"+subject+"%"));
  param.append("&subject=").append(java.net.URLEncoder.encode(subject,"UTF-8"));
    f=true;
}

//商品类别
int goodstype1 = 0;
if(teasession.getParameter("goodstype1")!=null && teasession.getParameter("goodstype1").length()>0)
{
  goodstype1 = Integer.parseInt(teasession.getParameter("goodstype1"));
  if(goodstype1>0){
    sql.append(" AND g.goodstype LIKE '%/"+goodstype1+"/%' ");
    param.append("&goodstype1=").append(goodstype1);
      f=true;
  }
}
int goodstype2 = 0;
if(teasession.getParameter("goodstype2")!=null && teasession.getParameter("goodstype2").length()>0)
{
  goodstype2 = Integer.parseInt(teasession.getParameter("goodstype2"));
  if(goodstype2>0){
    sql.append(" AND g.goodstype LIKE '%/"+goodstype2+"/%' ");
    param.append("&goodstype2=").append(goodstype2);
    f=true;
  }
}
//商品品牌
int brand =0;
if(teasession.getParameter("brand")!=null && teasession.getParameter("brand").length()>0)
{
  brand = Integer.parseInt(teasession.getParameter("brand"));
  sql.append(" AND g.brand = ").append(brand);
  param.append("&brand=").append(brand);
    f=true;
}
//修改价格
float bapr = 100;
if(bpobj2.getDiscount()>0)
{
   bapr = bpobj2.getDiscount();
}
if(teasession.getParameter("bapr")!=null && teasession.getParameter("bapr").length()>0)
{
  bapr = Float.parseFloat(teasession.getParameter("bapr"));
  param.append("&bapr=").append(bapr);
}
//加盟店
int joinhidden = 0;
String joinname="";
if(bpobj2.getJoinname()>0)
{
  joinhidden=bpobj2.getJoinname();
}
if(teasession.getParameter("joinhidden")!=null && teasession.getParameter("joinhidden").length()>0)
{
  joinhidden = Integer.parseInt(teasession.getParameter("joinhidden"));
}
if(joinhidden>0)
{
  LeagueShop lsobj = LeagueShop.find(joinhidden);
  joinname = lsobj.getLsname();
  param.append("&joinhidden=").append(joinhidden);
}


param.append("&f=").append(f);

if(!f)
{
  sql.append(" and n.node=0 ");
}

int pos = 0, pageSize = 10, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}

count = Node.count(teasession._strCommunity,sql.toString());
sql.append(" ORDER BY n.time DESC ");

int root=GoodsType.getRootId(teasession._strCommunity);
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>批量处理加盟店销售价</title>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<body bgcolor="#ffffff" >
<script type="">
function f_c()
{
  rs = window.showModalDialog('/jsp/erp/LookClient.jsp',self,'edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:857px;dialogHeight:605px;');
  if(rs!=null){
    form1.joinhidden.value= rs.split('/')[1];
    form1.joinname.value= rs.split('/')[2];
  }
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
function f_submit()
{
  if(form1.joinhidden.value==0)
  {
    alert('请选择加盟店');
    form1.joinname.focus();
    return false;
  }
  form1.action='/servlet/EditBatchPrice';
  form1.submit();
}

</script>
<h1>批量处理加盟店销售价</h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <form action="?" name="form1" method="POST">
  <input type="hidden" name="joinhidden" value="<%=joinhidden%>">
    <input type="hidden" name="nexturl" value="<%=nexturl%>">
    <input type="hidden" name="act" value="EditBatchPrice"/>
    <input type="hidden" name="sql" value="<%=sql%>">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td>加盟店</td>
      <td><input type="text" name="joinname" value="<%if(joinname!=null && joinname.length()>0)out.print(joinname);%>"/>&nbsp;&nbsp;<input type="button" value="查询加盟店" onclick="f_c();" > </td>
        <td>商品类别</td>
        <td>
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
    <td>条形码或编号：</td>
    <td><input type="text" name="goodsnumber" value="<%if(goodsnumber!=null)out.print(goodsnumber);%>"/></td>
    <td>商品名称：</td>
    <td><input type="text" name="subject" value="<%if(subject!=null)out.print(subject);%>"/></td>
  </tr>
   <tr>
    <td>商品品牌：</td>
    <td>
      <select name="brand">
        <option value="">请选择商品品牌</option>
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
    <td colspan="2"><input type="submit" value="查询"/></td>
  </tr>
    <tr>
      <td>批处理修改价格:</td>
      <td><input type="text" name="bapr" value="<%=bapr%>" size=3/>&nbsp;%</td>
      <td colspan="2"><input type="submit" value="批处理提交"> </td>
    </tr>
  </table>
<h2>查询列表&nbsp;&nbsp;共查询出&nbsp;<font color="#000000" size="3"><%=count%></font>&nbsp;条记录</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

  <tr id="tableonetr">
    <td align="center" nowrap>序号</td>
    <td align="center" nowrap>条形码或编号</td>
    <td align="center" nowrap>商品名称</td>
    <td align="center" nowrap>商品品牌</td>
    <td align="center" nowrap>销售价格</td>
    <td align="center" nowrap>修改为</td>
  </tr>
  <%
 java.util.Enumeration  e = Node.find(teasession._strCommunity,sql.toString(),pos,Integer.MAX_VALUE);
if(!e.hasMoreElements())
{
  out.print("<tr><td colspan=10 align=center>请选择上面的搜索条件</td></tr>");
}
for(int i = 1;e.hasMoreElements();i++){
  int nid = ((Integer)e.nextElement()).intValue();
  Node nobj=Node.find(nid);
  Goods gobj=Goods.find(nid);
  String gts[] =  gobj.getGoodstype().split("/");
  StringBuffer sp = new StringBuffer();
  for(int index=2;index<gts.length;index++)
  {
    GoodsType gtobj=GoodsType.find(Integer.parseInt(gts[index]));
    sp.append(gtobj.getName(teasession._nLanguage)+"&nbsp;&nbsp;");
  }
  Commodity cobj = Commodity.find_goods(nid);
  BuyPrice bpobj = BuyPrice.find(cobj.getCommodity(),1);
  %>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td align="center" width="1"><%=i %></td>
    <td><%=nobj.getNumber() %></td>
    <td><%=nobj.getSubject(teasession._nLanguage)%></td>
    <td>&nbsp;<%
    Brand b=null;
    if(gobj.getBrand()>0&&(b=Brand.find(gobj.getBrand())).isExists())
    {
      if(b.getNode()>0)
     // out.print("<a target=_blank href=/servlet/Node?node="+b.getNode()+">");
      out.print(b.getName(teasession._nLanguage));
    //  out.print("</a>");
    }
    %></td>
    <td><%=bpobj.getPrice()%></td>
    <td><input type="text" name="price<%=nid%>" value="<%=bpobj.getPrice().multiply(new java.math.BigDecimal(bapr)).multiply(new java.math.BigDecimal("0.01")).setScale(2,4)%>" size="4"> </td>
  <%}%>
   <!-- <%if (count > pageSize) {  %>
  <tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
  <%}  %>-->
</table>
<br />

  <input type="button" value="批处理销售价格" onclick="f_submit();">
  &nbsp;
  <input type="button" value="返回" onclick="window.open('/jsp/erp/BatchPrice.jsp','_self');"/>
  </form>
<div id="head6"><img height="6" src="about:blank"></div>

</body>
</html>
