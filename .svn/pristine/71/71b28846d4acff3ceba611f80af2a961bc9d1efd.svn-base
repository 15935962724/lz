<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.erp.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.admin.erp.*" %>
<%@page import="tea.entity.league.*" %>
<%@page import="tea.entity.util.*" %>
<%
  request.setCharacterEncoding("UTF-8");

  TeaSession teasession = new TeaSession(request);
  if (teasession._rv == null) {
    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
    return;
  }
  String nexturl = request.getRequestURI()+"?"+request.getContextPath();
  StringBuffer sql = new StringBuffer("  AND quantity <=5 ");
  StringBuffer param = new StringBuffer();
  param.append("?id=").append(request.getParameter("id"));

  // 分店所属区域
  int s1=0,s2=0,csarea=0;
  if(teasession.getParameter("s1")!=null && teasession.getParameter("s1").length()>0)
  {
    s1=Integer.parseInt(teasession.getParameter("s1"));
    sql.append(" and leagueshop in (select id from LeagueShop where province ="+s1+") ");
    param.append("&s1=").append(s1);
  }
  if(teasession.getParameter("s2")!=null && teasession.getParameter("s2").length()>0)
  {
    s2=Integer.parseInt(teasession.getParameter("s2"));
    sql.append(" and leagueshop in (select id from LeagueShop where city ="+s2+") ");
    param.append("&s2=").append(s2);
  }
  if(teasession.getParameter("csarea")!=null && teasession.getParameter("csarea").length()>0)
  {
    csarea=Integer.parseInt(teasession.getParameter("csarea"));
    if(csarea==0)
    {

    }
    else
    {
      sql.append(" and leagueshop in (select id from LeagueShop where csarea ="+csarea+") ");
      param.append("&csarea=").append(csarea);
    }
  }
  //分店名称
  String lsname=teasession.getParameter("lsname");
  if(lsname!=null&& lsname.length()>0)
  {
    sql.append(" and leagueshop in (select id from LeagueShop where lsname like "+DbAdapter.cite("%"+lsname+"%")+") ");
    param.append("&lsname=").append(java.net.URLEncoder.encode(lsname,"UTF-8"));
  }

  //商品类别
  int goodstype1 = 0;
  if(teasession.getParameter("goodstype1")!=null && teasession.getParameter("goodstype1").length()>0)
  {
    goodstype1 = Integer.parseInt(teasession.getParameter("goodstype1"));
    if(goodstype1>0){
      sql.append(" and node in (select node from Goods where  goodstype LIKE '%/"+goodstype1+"/%')");
      param.append("&goodstype1=").append(goodstype1);
    }
  }
  int goodstype2 = 0;
  if(teasession.getParameter("goodstype2")!=null && teasession.getParameter("goodstype2").length()>0)
  {
    goodstype2 = Integer.parseInt(teasession.getParameter("goodstype2"));
    if(goodstype2>0){
      sql.append(" and node in (select node from Goods where  goodstype LIKE '%/"+goodstype2+"/%')");
      param.append("&goodstype2=").append(goodstype2);
    }
  }
  //商品名称
  String subject = teasession.getParameter("subject");
  if(subject!=null && subject.length()>0)
  {
    subject = subject.trim();
    sql.append(" and node in (select node from NodeLayer where subject like "+DbAdapter.cite("%"+subject+"%")+")");
    param.append("&subject=").append(java.net.URLEncoder.encode(subject,"UTF-8"));
  }

  int pos = 0, pageSize = 10, count = 0;
  if (request.getParameter("pos") != null) {
    pos = Integer.parseInt(request.getParameter("pos"));
  }
  count = ICInventory.count(sql.toString());
int root=GoodsType.getRootId(teasession._strCommunity);
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>分店库存预警</title>
</head>
<body  <%if(goodstype1>0){out.print("onload=\"f_goodstype("+goodstype2+");\"");}%>>
<script>
function f_goodstype(igd)
{
  sendx("/jsp/erp/Goods_ajax.jsp?goodstype2="+igd+"&act=goodstype&father="+form1.goodstype1.value,
  function(data)
  {
    document.getElementById('show').innerHTML=data;
  }
  );
}
function f_excel()
{
  form1.action='/servlet/ExportExcel';
  form1.submit();
}

</script>
  <h1>分店库存预警</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<h2>查询</h2>
  <form action="?" name="form1" method="POST">
  <input type="hidden" name="id" value="<%=request.getParameter("id") %>"/>
  <input type="hidden" name="sql" value="<%=sql.toString()%>">
  <input type="hidden" name="files" value="分店商品库存预警表">
  <input type="hidden" name="act" value="InventoryWarning">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>所属区域:</td>
   <td>
         <script src="/tea/card.js" type=""></script>
         <script type="">
         var delcct=new Array();
         function f_area(objcct)
         {
           var rscct=area[parseInt(objcct.value)][1];
           var op=form1.s1.options;
           for(var i=0;i<delcct.length;i++)
           {
             op[op.length]=new Option(delcct[i][0],delcct[i][1]);
           }
           delcct=new Array();
           for(var i=0;i<op.length;i++)
           {
             if(rscct.indexOf(op[i].value)==-1)
             {
               delcct[delcct.length]=new Array(op[i].text,op[i].value);
               op[i--]=null;
             }
           }
         }
         document.write("<select name='csarea' onchange=f_area(this)>");
         for(var i=0;i<area.length;i++)
         {
           document.write("<option value="+i+">"+area[i][0]+"</option>");
         }

         document.write("</select>　");
         selectcard("s1","s2",null,"<%=s2%>");
         if(<%=s1%>>0)
         {
           form1.s1.value='<%=s1%>';
         }
         form1.csarea.value="<%=csarea%>";
         form1.csarea.onchange();
         </script>
         </td>
    <td>分店名称:</td>
    <td colspan="2"><input type="text" name="lsname" value="<%if(lsname!=null)out.print(lsname);%>"/></td>
    </tr><tr>
    <td>商品类别：</td>
    <td>  <select name="goodstype1" onchange="f_goodstype('0');">
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
    <td>商品名称:</td>
     <td colspan="2"><input type="text" name="subject" value="<%if(subject!=null)out.print(subject);%>"/></td>

<td><input type="submit" value="查询"/></td>
  </tr>

</table>
<h2><%
Card card11 = Card.find(s1);
Card card22 = Card.find(s2);
if(csarea>0)
{
  out.print("所在区域：&nbsp;");
  out.print(LeagueShop.CSAREA[csarea]+"&nbsp;");
}
if(s1>0)
{
  out.print(card11.getAddress()+"&nbsp;");
}
if(s2>0)
{
  out.print(card22.getAddress()+"&nbsp;&nbsp;");
}

if(lsname!=null && lsname.length()>0)
{
  out.print("分店名称：&nbsp;");
  out.print(lsname+"&nbsp;&nbsp;");
}
if(goodstype1>0)
{
  out.print("商品类别：&nbsp;");
  out.print(GoodsType.find(goodstype1).getName(teasession._nLanguage)+"&nbsp;&nbsp;");
}
if(goodstype2>0)
{
  out.print(GoodsType.find(goodstype2).getName(teasession._nLanguage)+"&nbsp;&nbsp;");
}
if(subject!=null&&subject.length()>0)
{
  out.print("商品名称:&nbsp;");
  out.print(subject+"&nbsp;&nbsp;");
}
  %>
（列表数量为：&nbsp;<%=count%>&nbsp; ）显示列表如下：</h2>

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td nowrap>商品编号</td>
      <td nowrap>商品名称</td>
      <td nowrap>分店名称</td>
      <td nowrap>所属区域</td>
      <td nowrap>分店类型</td>
      <td nowrap>预警商品数量</td>

    </tr>
    <%
    java.util.Enumeration e = ICInventory.find(sql.toString(),pos,pageSize);
    if(!e.hasMoreElements())
    {
      out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
    }
    while(e.hasMoreElements()){
      int icid =((Integer)e.nextElement()).intValue();
      ICInventory icobj = ICInventory.find(icid);
      Node nobj = Node.find(icobj.getNode());
      LeagueShop leobj =LeagueShop.find(icobj.getLeagueshop());
      Card card1 = Card.find(leobj.getProvince());
      Card card2 = Card.find(leobj.getCity());
      LeagueShopType objty = LeagueShopType.find(leobj.getLstype());
    %>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td align="center"><%=nobj.getNumber() %></td>
      <td><%=nobj.getSubject(teasession._nLanguage) %></td>
      <td align="center"><%=leobj.getLsname() %></td>
      <td align="center"><%=LeagueShop.CSAREA[leobj.getCsarea()]%>&nbsp;<%if(card1.getAddress()!=null)out.print(card1.getAddress());%>&nbsp;<%if(card2.getAddress()!=null)out.print(card2.getAddress());%></td>
      <td align="center"><%if(objty.getLstypename()!=null)out.print(objty.getLstypename()); %></td>
      <td align="center"><%=icobj.getQuantity() %></td>
     <!-- <td align="center"><input type="button" value="查看详细" onclick="window.open('/jsp/leagueshop/InventoryWarningShow.jsp?nexturl=<%=nexturl%>','_self');"/></td>-->
    </tr>
    <%} %>
    <%if (count > pageSize) {  %>
    <tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
    <%}  %>

  </table>
  <br>
<input type="button" value="导出Excel表" onclick="f_excel();"/>
  </form>
  <div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
