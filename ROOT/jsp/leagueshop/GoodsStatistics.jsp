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


//所属区域
int s1=0,s2=0,csarea=0;
if(teasession.getParameter("s1")!=null && teasession.getParameter("s1").length()>0)
{
  s1=Integer.parseInt(teasession.getParameter("s1"));
  sql.append("  and  province=").append(s1);
  param.append("&s1=").append(s1);
}
if(teasession.getParameter("s2")!=null && teasession.getParameter("s2").length()>0)
{
  s2=Integer.parseInt(teasession.getParameter("s2"));
  sql.append("  and  city=").append(s2);
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
    sql.append("  and  csarea=").append(csarea);
    param.append("&csarea=").append(csarea);
  }
}
//分店名称
 String lsname=teasession.getParameter("lsname");
if(lsname!=null&& lsname.length()>0)
{
  sql.append(" AND lsname LIKE  "+DbAdapter.cite("%"+lsname+"%"));
  param.append("&lsname=").append(java.net.URLEncoder.encode(lsname,"UTF-8"));
}
//商品类别
int goodstype1 = 0;
if(teasession.getParameter("goodstype1")!=null && teasession.getParameter("goodstype1").length()>0)
{
  goodstype1 = Integer.parseInt(teasession.getParameter("goodstype1"));
  if(goodstype1>0){
    sql.append(" and n.node in (select node from Goods where  goodstype LIKE '%/"+goodstype1+"/%')");
    param.append("&goodstype1=").append(goodstype1);
  }
}
int goodstype2 = 0;
if(teasession.getParameter("goodstype2")!=null && teasession.getParameter("goodstype2").length()>0)
{
  goodstype2 = Integer.parseInt(teasession.getParameter("goodstype2"));
  if(goodstype2>0){
     sql.append(" and n.node in (select node from Goods where  goodstype LIKE '%/"+goodstype2+"/%')");
    param.append("&goodstype2=").append(goodstype2);
  }
}
//商品名称
String subject = teasession.getParameter("subject");
if(subject!=null && subject.length()>0)
{
  subject = subject.trim();
  sql.append(" and n.node in (select node from NodeLayer where subject like "+DbAdapter.cite("%"+subject+"%")+")");
  param.append("&subject=").append(java.net.URLEncoder.encode(subject,"UTF-8"));
}
//销售日期
String time_c = teasession.getParameter("time_c");
if(time_c!=null && time_c.length()>0)
{
  sql.append(" AND ic.time >=").append(DbAdapter.cite(time_c));
  param.append("&time_c=").append(time_c);
}
String time_d = teasession.getParameter("time_d");
if(time_d!=null && time_d.length()>0)
{
  sql.append(" AND ic.time <=").append(DbAdapter.cite(time_d));
  param.append("&time_d=").append(time_d);
}
//分店类型
int lstype =0;
if(teasession.getParameter("lstype")!=null && teasession.getParameter("lstype").length()>0)
{
  lstype = Integer.parseInt(teasession.getParameter("lstype"));
  if(lstype>0)
  {
    sql.append(" AND lstype = ").append(lstype);
    param.append("&lstype=").append(lstype);
  }
}

int pos = 0, pageSize = 10, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
count = ICSalesList.count2(sql.toString());
int root=GoodsType.getRootId(teasession._strCommunity);

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<title>分店商品销售情况统计</title>
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
  <h1>分店商品销售情况统计</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<h2>查询</h2>
  <form action="?" name="form1" method="POST">
  <input type="hidden" name="id" value="<%=request.getParameter("id") %>"/>
  <input type="hidden" name="sql" value="<%=sql.toString()%>">
  <input type="hidden" name="files" value="分店商品销售情况统计表">
  <input type="hidden" name="act" value="GoodsStatistics">
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
     </tr><tr>
    <td>销售日期:</td>
     <td>

      从&nbsp;
        <input id="time_c" name="time_c" size="7"  value="<%if(time_c!=null)out.print(time_c);%>" readonly="readonly">
        <img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_c');" />
        &nbsp;到&nbsp;
        <input id="time_d" name="time_d" size="7"  value="<%if(time_d!=null)out.print(time_d);%>" readonly="readonly">
        <img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_d');" />

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
  out.print("商品名称:&nbsp;");
  out.print(subject+"&nbsp;&nbsp;");
}
if(time_c!=null&&time_c.length()>0)
{
  out.print("销售日期:&nbsp;");
  out.print("从&nbsp;"+time_c);

}
if(time_d!=null&&time_d.length()>0)
{
  out.print("到&nbsp;"+time_d);
}


  %>
（列表数量为：&nbsp;<%=count%>&nbsp; ）显示列表如下：</h2>

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td nowrap>条形码或编号</td>
      <td nowrap>商品名称</td>
      <td nowrap>商品类别</td>
      <td nowrap>商品品牌</td>
      <td nowrap>消费数量</td>
      <td nowrap>消费金额</td>
      <td nowrap>操作</td>
    </tr>
    <%
       java.util.Enumeration e = ICSalesList.findNo(sql.toString(),pos,pageSize);
       if(!e.hasMoreElements())
       {
         out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
       }
       while(e.hasMoreElements()){
        String nuid = ((String)e.nextElement());
         int nid = Node.findNumber(teasession._strCommunity,nuid);
         Node nobj = Node.find(nid);
         Goods gobj = Goods.find(nid);
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
      <td align="center"><%=nuid %></td>
      <td><%=nobj.getSubject(teasession._nLanguage)%></td>
       <td align="center"><%=sp.toString() %></td>
       <td align="center"><%
       Brand b=null;
       if(gobj.getBrand()>0&&(b=Brand.find(gobj.getBrand())).isExists())
       {
         if(b.getNode()>0)
         out.print(b.getName(teasession._nLanguage));
       }
       %></td>
      <td align="center"><%=ICSalesList.getNoTotal(nuid) %></td>
      <td align="center"><%=ICSalesList.getPriceTotal(nuid)%>&nbsp;元</td>
      <td align="center"><input type="button" value="查看详细" onclick="window.open('/jsp/leagueshop/GoodsStatisticsShow.jsp?nuid=<%=nuid%>&nexturl=<%=nexturl%>','_self');"/></td>
    </tr>
    <%} %>
    <%if(count>0) {%>
    <tr>
      <td colspan="3"></td>
      <td align="center"><b>总计：</b></td>
       <td align="center"><%=ICSalesList.getZNoTotal(sql.toString())%></td>
       <td align="center"><%=ICSalesList.getZPriceTotal(sql.toString())%>&nbsp;元</td>
       <td align="center">&nbsp;</td>
    </tr>
     <%}
     if (count > pageSize) {  %>
      <tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
      <%}  %>
  </table>
  <br>
<input type="button" value="导出Excel表"  onclick="f_excel();">
  </form>
  <div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
