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
  StringBuffer sql = new StringBuffer();
  StringBuffer param = new StringBuffer();
  param.append("?id=").append(request.getParameter("id"));

int radioname = 1;
if(teasession.getParameter("radioname")!=null)
{
  radioname = Integer.parseInt(teasession.getParameter("radioname"));
}
param.append("&radioname=").append(radioname);
  // 分店所属区域
  int s1=0,s2=0,csarea=0;
  if(teasession.getParameter("s1")!=null && teasession.getParameter("s1").length()>0)
  {
    s1=Integer.parseInt(teasession.getParameter("s1"));
    sql.append(" and ic.leagueshop in (select id from LeagueShop where province ="+s1+") ");
    param.append("&s1=").append(s1);
  }
  if(teasession.getParameter("s2")!=null && teasession.getParameter("s2").length()>0)
  {
    s2=Integer.parseInt(teasession.getParameter("s2"));
    sql.append(" and ic.leagueshop in (select id from LeagueShop where city ="+s2+") ");
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
      sql.append(" and ic.leagueshop in (select id from LeagueShop where csarea ="+csarea+") ");
      param.append("&csarea=").append(csarea);
    }
  }
  //分店类型
  int lstype =0;
  if(teasession.getParameter("lstype")!=null && teasession.getParameter("lstype").length()>0)
  {
    lstype = Integer.parseInt(teasession.getParameter("lstype"));
    if(lstype>0)
    {
      sql.append(" AND ic.leagueshop in (select id from LeagueShop where lstype ="+lstype+")");
      param.append("&lstype=").append(lstype);
    }
  }
  //分店名称
  String lsname=teasession.getParameter("lsname");
  if(lsname!=null&& lsname.length()>0)
  {
    sql.append(" and ic.leagueshop in (select id from LeagueShop where lsname like "+DbAdapter.cite("%"+lsname+"%")+") ");
    param.append("&lsname=").append(java.net.URLEncoder.encode(lsname,"UTF-8"));
  }
 //商品类别
  int goodstype1 = 0;
  if(teasession.getParameter("goodstype1")!=null && teasession.getParameter("goodstype1").length()>0)
  {
    goodstype1 = Integer.parseInt(teasession.getParameter("goodstype1"));
    if(goodstype1>0){
      sql.append(" and ic.node in (select node from Goods where  goodstype LIKE '%/"+goodstype1+"/%')");
      param.append("&goodstype1=").append(goodstype1);
    }
  }
  int goodstype2 = 0;
  if(teasession.getParameter("goodstype2")!=null && teasession.getParameter("goodstype2").length()>0)
  {
    goodstype2 = Integer.parseInt(teasession.getParameter("goodstype2"));
    if(goodstype2>0){
      sql.append(" and ic.node in (select node from Goods where  goodstype LIKE '%/"+goodstype2+"/%')");
      param.append("&goodstype2=").append(goodstype2);
    }
  }

  //商品编号
  String goodsnumber = teasession.getParameter("goodsnumber");
  if(goodsnumber!=null && goodsnumber.length()>0)
  {
    goodsnumber = goodsnumber.trim();
    sql.append(" and ic.node in (select node from Node where goodsnumber like "+DbAdapter.cite("%"+goodsnumber+"%")+")");
    param.append("&goodsnumber=").append(java.net.URLEncoder.encode(goodsnumber,"UTF-8"));
  }

  //商品名称
  String subject = teasession.getParameter("subject");
  if(subject!=null && subject.length()>0)
  {
    subject = subject.trim();
    sql.append(" and ic.node in (select node from NodeLayer where subject like "+DbAdapter.cite("%"+subject+"%")+")");
    param.append("&subject=").append(java.net.URLEncoder.encode(subject,"UTF-8"));
  }

  int pos = 0, pageSize = 10, count2 = 0,count3 = 0;
  if (request.getParameter("pos") != null) {
    pos = Integer.parseInt(request.getParameter("pos"));
  }
  count2 = ICInventory.count2(sql.toString());
  count3 = ICInventory.count3(sql.toString());
  int root=GoodsType.getRootId(teasession._strCommunity);
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>分店库存统计</title>
</head>

<body onload="f_radio('<%=radioname%>','<%=goodstype1%>','<%=goodstype2%>');">
<script>
function f_radio(igd,a1,a2)
{
  var s1=document.getElementById('show1');
  var s2=document.getElementById('show2');
  if(igd==1)
  {
    s1.style.display='block';
    s2.style.display='none';
  }
  if(igd==2)
  {
    s1.style.display='none';
    s2.style.display='block';
  }
  if(a1>0)
  {
    f_goodstype(a2);
  }
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
function f_excel()
{
  form1.action='/servlet/ExportExcel';
  form1.submit();
}
</script>
  <h1>分店库存统计</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<h2>查询</h2>
  <form action="?" name="form1" method="POST">
  <input type="hidden" name="id" value="<%=request.getParameter("id") %>"/>
  <input type="hidden" name="sql" value="<%=sql.toString()%>">
  <input type="hidden" name="files" value="分店商品库存统计表">
  <input type="hidden" name="act" value="InventorySta">
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
           <td>分店类型:</td>
      <td><select  name="lstype" >
      <option  value="0">请选择分店类别</option>
    <%
    java.util.Enumeration eu = LeagueShopType.findByCommunity(teasession._strCommunity,"",0,Integer.MAX_VALUE);
    for(int i=0;eu.hasMoreElements();i++)
    {
      int idtt= Integer.parseInt(String.valueOf(eu.nextElement()));
      LeagueShopType objty = LeagueShopType.find(idtt);
      out.print("<option value="+idtt);
      if(lstype==idtt)
      {
        out.print(" selected ");
      }
      out.print(">"+objty.getLstypename()+"</option>");
    }
    %>
    </select>　
</td>

    </tr><tr>
     <td>分店名称:</td>
    <td><input type="text" name="lsname" value="<%if(lsname!=null)out.print(lsname);%>"/></td>
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

     </tr>
     <tr>
       <td>条形码或编号:</td>
    <td ><input type="text" name="goodsnumber" value="<%if(goodsnumber!=null)out.print(goodsnumber);%>"/></td>
   <td>商品名称:</td>
    <td ><input type="text" name="subject" value="<%if(subject!=null)out.print(subject);%>"/></td>

</tr>
<tr>
<td>查询类型：</td>
<td>按&nbsp;<input type="radio" name="radioname" value="1" <%if(radioname==1)out.print(" checked=checked ");%>  onclick="window.open('?radioname=1&id=<%=request.getParameter("id")%>','_self');">&nbsp;
  分店&nbsp;<input type="radio" name="radioname" value="2" <%if(radioname==2)out.print(" checked=checked ");%>  onclick="window.open('?radioname=2&id=<%=request.getParameter("id")%>','_self');">&nbsp;商品&nbsp;
</td>
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
if(lstype>0)
{
  out.print("分店类型：&nbsp;");
  LeagueShopType objty = LeagueShopType.find(lstype);
  if(objty.getLstypename()!=null)
  {
    out.print(objty.getLstypename()+"&nbsp;&nbsp;");
  }
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
  out.print("条形码或编号:&nbsp;");
  out.print(goodsnumber+"&nbsp;&nbsp;");
}
if(subject!=null&&subject.length()>0)
{
  out.print("商品名称:&nbsp;");
  out.print(subject+"&nbsp;&nbsp;");
}
  %>
（列表数量为：&nbsp;<%if(radioname==1){out.print(count2);}else if(radioname==2){out.print(count3);}%>&nbsp; ）显示列表如下：</h2>


  <span id ="show1">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td nowrap>分店名称</td>
      <td nowrap>所属区域</td>
      <td nowrap>分店类型</td>
      <td nowrap>库存</td>
      <td nowrap>操作</td>
    </tr>
     <%
    java.util.Enumeration e = ICInventory.findLeagueshop(" ic.leagueshop ",sql.toString(),pos,pageSize);
    if(!e.hasMoreElements())
    {
      out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
    }
    while(e.hasMoreElements()){
      int leid =((Integer)e.nextElement()).intValue();
      LeagueShop leobj =LeagueShop.find(leid);
      Card card1 = Card.find(leobj.getProvince());
      Card card2 = Card.find(leobj.getCity());
      LeagueShopType objty = LeagueShopType.find(leobj.getLstype());
      leobj.setTotalQuantity(ICInventory.getLeQuantity("leagueshop",leid));

    %>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td ><%=leobj.getLsname()%></td>
      <td ><%=LeagueShop.CSAREA[leobj.getCsarea()]%>&nbsp;<%if(card1.getAddress()!=null)out.print(card1.getAddress());%>&nbsp;<%if(card2.getAddress()!=null)out.print(card2.getAddress());%></td>
      <td><%if(objty.getLstypename()!=null)out.print(objty.getLstypename()); %></td>
      <td><%=leobj.getTotalquantity()%></td>
    <td align="center"><input type="button" value="查看详细" onclick="window.open('/jsp/leagueshop/InventoryStaShow.jsp?leid=<%=leid%>&nexturl=<%=nexturl%>','_self');"/></td>
    </tr>
    <%} %>
    <%if(count2>0){ %>
    <tr>
      <td colspan="2"></td>
      <td align="right"><b>总计：</b></td>
      <td><%=ICInventory.getLeTotal(sql.toString())%></td>
    </tr>
    <%}
    if (count2 > pageSize) {  %>
    <tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count2,pageSize)%>    </td> </tr>
    <%}  %>
  </table>
  </span>
  <span id="show2" style="display:none;">
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
   <tr id="tableonetr">
     <td nowrap>条形码或编号</td>
     <td nowrap>商品名称</td>
     <td nowrap>商品类别</td>
     <td nowrap>库存</td>
     <td nowrap>操作</td>
   </tr>
    <%
    java.util.Enumeration e2 = ICInventory.findLeagueshop(" ic.node ",sql.toString(),pos,pageSize);
    if(!e2.hasMoreElements())
    {
      out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
    }
    while(e2.hasMoreElements()){
      int nid =((Integer)e2.nextElement()).intValue();
      Node nobj = Node.find(nid);
      Goods gobj = Goods.find(nid);
      String gts[] =  gobj.getGoodstype().split("/");
      StringBuffer sp = new StringBuffer();
      for(int index=2;index<gts.length;index++)
      {
        GoodsType gtobj=GoodsType.find(Integer.parseInt(gts[index]));
        sp.append(gtobj.getName(teasession._nLanguage)+"&nbsp;&nbsp;");
      }
    %>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td align="center"><%=nobj.getNumber()%></td>
      <td><%=nobj.getSubject(teasession._nLanguage)%></td>
      <td align="center"><%=sp.toString() %></td>
      <td align="center"><%=ICInventory.getLeQuantity("node",nid)%></td>
    <td align="center"><input type="button" value="查看详细" onclick="window.open('/jsp/leagueshop/InventoryStaShow.jsp?nid=<%=nid%>&nexturl=<%=nexturl%>','_self');"/></td>
    </tr>
    <%} %>
        <%if(count3>0){ %>
    <tr>
      <td colspan="2"></td>
      <td align="center"><b>总计：</b></td>
      <td align="center"><%=ICInventory.getLeTotal(sql.toString())%></td>
    </tr>
    <%}if (count3 > pageSize) {  %>
    <tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count3,pageSize)%>    </td> </tr>
    <%}  %>
  </table>
  </span>

  <br>
<input type="button" value="导出Excel表" onclick="f_excel();"/>
  </form>
  <div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
