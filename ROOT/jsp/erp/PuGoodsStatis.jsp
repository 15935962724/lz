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

StringBuffer sql = new StringBuffer("and p.flowtype =4 ");
StringBuffer param = new StringBuffer();
param.append("?id=").append(request.getParameter("id"));


//条形码或编号
String goodsnumber = teasession.getParameter("goodsnumber");
if(goodsnumber!=null && goodsnumber.length()>0)
{
  goodsnumber = goodsnumber.trim();
  sql.append(" and gd.node in (select node from Node where goodsnumber like "+DbAdapter.cite("%"+goodsnumber+"%")+")");
  param.append("&goodsnumber=").append(goodsnumber);
}

//商品名称
String subject = teasession.getParameter("subject");
if(subject!=null && subject.length()>0)
{
  subject = subject.trim();
  sql.append(" and gd.node in (select node from NodeLayer where subject like "+DbAdapter.cite("%"+subject+"%")+")");
  param.append("&subject=").append(java.net.URLEncoder.encode(subject,"UTF-8"));
}
//商品类别
int goodstype1 = 0;
if(teasession.getParameter("goodstype1")!=null && teasession.getParameter("goodstype1").length()>0)
{
  goodstype1 = Integer.parseInt(teasession.getParameter("goodstype1"));
  if(goodstype1>0){
    sql.append(" and gd.node in (select node from Goods where  goodstype LIKE '%/"+goodstype1+"/%')");
    param.append("&goodstype1=").append(goodstype1);
  }
}
int goodstype2 = 0;
if(teasession.getParameter("goodstype2")!=null && teasession.getParameter("goodstype2").length()>0)
{
  goodstype2 = Integer.parseInt(teasession.getParameter("goodstype2"));
  if(goodstype2>0){
     sql.append(" and gd.node in (select node from Goods where  goodstype LIKE '%/"+goodstype2+"/%')");
    param.append("&goodstype2=").append(goodstype2);
  }
}

//销售日期
String time_c = teasession.getParameter("time_c");
if(time_c!=null && time_c.length()>0)
{
  sql.append(" AND p.time_s >=").append(DbAdapter.cite(time_c));
  param.append("&time_c=").append(time_c);
}
String time_d = teasession.getParameter("time_d");
if(time_d!=null && time_d.length()>0)
{
  sql.append(" AND p.time_s <=").append(DbAdapter.cite(time_d));
  param.append("&time_d=").append(time_d);
}


int pos = 0, pageSize = 10, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
count = GoodsDetails.countNode(teasession._strCommunity,"Purchase",sql.toString());
int root=GoodsType.getRootId(teasession._strCommunity);

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<title>采购单商品销售情况统计</title>
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
  <h1>采购单商品销售情况统计</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<h2>查询</h2>
  <form action="?" name="form1" method="POST">
  <input type="hidden" name="id" value="<%=request.getParameter("id") %>"/>
  <input type="hidden" name="sql" value="<%=sql.toString()%>">
  <input type="hidden" name="files" value="采购单商品销售情况统计">
  <input type="hidden" name="act" value="PuGoodsStatis">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>

    <td>条形码或编号:</td>
    <td ><input type="text" name="goodsnumber" value="<%if(goodsnumber!=null)out.print(goodsnumber);%>"/></td>
      <td>商品名称:</td>
      <td ><input type="text" name="subject" value="<%if(subject!=null)out.print(subject);%>"/></td>
  </tr>

  <tr>
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
    <td>采购日期:</td>
    <td>

        从&nbsp;
        <input id="time_c" name="time_c" size="7"  value="<%if(time_c!=null)out.print(time_c);%>" readonly="readonly">
        <img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_c');" />
        &nbsp;到&nbsp;
        <input id="time_d" name="time_d" size="7"  value="<%if(time_d!=null)out.print(time_d);%>" readonly="readonly">
        <img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_d');" />
    </td>

    <td><input type="submit" value="查询"/></td>
  </tr>

</table>

<h2><%


if(subject!=null&&subject.length()>0)
{
  out.print("商品名称:&nbsp;");
  out.print(subject+"&nbsp;&nbsp;");
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

if(time_c!=null&&time_c.length()>0)
{
  out.print("采购日期:&nbsp;");
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
    <td  nowrap align="center">序号</td>
      <td nowrap>条形码或编号</td>
      <td nowrap>商品名称</td>
      <td nowrap>商品类别</td>
      <td nowrap>商品品牌</td>
      <td nowrap>消费数量</td>
      <td nowrap>消费金额</td>
      <td nowrap>操作</td>
    </tr>
    <%
       java.util.Enumeration e = GoodsDetails.findPurNode(teasession._strCommunity,"Purchase",sql.toString(),pos,pageSize);// ICSalesList.findNo(sql.toString(),pos,pageSize);
       if(!e.hasMoreElements())
       {
         out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
       }
       for(int i=1;e.hasMoreElements();i++){
        int  nid = ((Integer)e.nextElement()).intValue();

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
    <td width="1"><%=i+pos%></td>
      <td><%=nobj.getNumber() %></td>
      <td><%=nobj.getSubject(teasession._nLanguage)%></td>
       <td><%=sp.toString() %></td>
       <td><%
       Brand b=null;
       if(gobj.getBrand()>0&&(b=Brand.find(gobj.getBrand())).isExists())
       {
         if(b.getNode()>0)
         out.print(b.getName(teasession._nLanguage));
       }
       %></td>
      <td><%=GoodsDetails.countQuantity(teasession._strCommunity,"Purchase","and gd.node ="+nid)%></td>
      <td ><%=GoodsDetails.countTotal(teasession._strCommunity,"Purchase","and gd.node ="+nid)%>&nbsp;元</td>
      <td align="center"><input type="button" value="查看详细" onclick="window.open('/jsp/erp/PuGoodsStatisShow.jsp?nid=<%=nid%>&nexturl=<%=nexturl%>','_self');"/></td>
    </tr>
    <%} %>
    <%if(count>0) {%>
    <tr>
      <td colspan="4"></td>
      <td align="right"><b>总计：</b></td>
       <td ><%=GoodsDetails.countQuantity(teasession._strCommunity,"Purchase",sql.toString())%></td>
       <td colspan="2" ><%=GoodsDetails.countTotal(teasession._strCommunity,"Purchase",sql.toString())%>&nbsp;元</td>

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
