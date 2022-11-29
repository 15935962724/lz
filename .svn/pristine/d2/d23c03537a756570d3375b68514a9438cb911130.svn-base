<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.erp.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.util.*" %>
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
StringBuffer sql2=new StringBuffer();
param.append("?id=").append(request.getParameter("id"));

//所属区域
int s1=0,s2=0,csarea=0;
if(teasession.getParameter("s1")!=null && teasession.getParameter("s1").length()>0)
{
  s1=Integer.parseInt(teasession.getParameter("s1"));
  sql.append("  and  ls.province=").append(s1);
  sql2.append("  and  ls.province=").append(s1);
  param.append("&s1=").append(s1);
}
if(teasession.getParameter("s2")!=null && teasession.getParameter("s2").length()>0)
{
  s2=Integer.parseInt(teasession.getParameter("s2"));
  sql.append("  and  ls.city=").append(s2);
  sql2.append("  and  ls.city=").append(s2);
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
    sql.append("  and  ls.csarea=").append(csarea);
    sql2.append("  and  ls.csarea=").append(csarea);
    param.append("&csarea=").append(csarea);
  }
}

//分店类型
int Lstype =0;
if(teasession.getParameter("Lstype")!=null && teasession.getParameter("Lstype").length()>0)
{
  Lstype = Integer.parseInt(teasession.getParameter("Lstype"));
  if(Lstype>0)
  {
    sql.append(" AND ls.Lstype = ").append(Lstype);
    param.append("&Lstype=").append(Lstype);
  }
}
//分店名称
 String lsname=teasession.getParameter("lsname");
if(lsname!=null&& lsname.length()>0)
{
  sql.append(" AND ls.lsname LIKE  "+DbAdapter.cite("%"+lsname+"%"));
  param.append("&lsname=").append(java.net.URLEncoder.encode(lsname,"UTF-8"));
}
int pos = 0, pageSize = 10, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
count = LeagueShop.count2(teasession._strCommunity,sql.toString());
sql.append(" group   by   ls.id ");
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>分店销售情况统计</title>
</head>
<body id="bodynone">
<script>
    function f_excel()
    {
      form1.action='/servlet/ExportExcel';
      form1.submit();
    }
</script>
  <h1>分店销售情况统计</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<h2>查询</h2>
<form accept="?" name="form1"  method="POST">
 <input type="hidden" name="id" value="<%=request.getParameter("id") %>"/>
 <input type="hidden" name="sql" value="<%=sql.toString()%>">
<input type="hidden" name="files" value="分店销售情况统计表">
<input type="hidden" name="act" value="SalesStatistics">
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
   <td><select  name="Lstype" ><option  value="0">请选择分店类型</option>
    <%
   java.util.Enumeration eu = LeagueShopType.findByCommunity(teasession._strCommunity,"",0,Integer.MAX_VALUE);
    for(int i=0;eu.hasMoreElements();i++)
    {
      int idtt= Integer.parseInt(String.valueOf(eu.nextElement()));
      LeagueShopType objty = LeagueShopType.find(idtt);
      out.print("<option value="+idtt);
      if(Lstype==idtt)
      {
        out.print(" selected ");
      }
      out.print(">"+objty.getLstypename()+"</option>");
    }
    %>
    </select>　
</td>

    </tr>
    <tr>
    <td>分店名称:</td>
   <td><input type="text" name="lsname" value="<%if(lsname!=null)out.print(lsname);%>"/></td>
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
if(Lstype>0)
{
  out.print("分店类型：&nbsp;");
  LeagueShopType objty = LeagueShopType.find(Lstype);
  if(objty.getLstypename()!=null)
  {
    out.print(objty.getLstypename()+"&nbsp;&nbsp;");
  }
}

if(lsname!=null && lsname.length()>0)
{
  out.print("分店名称：&nbsp;");
  out.print(lsname+"&nbsp;");
}
  %>
（列表数量为：&nbsp;<%=count%>&nbsp; ）显示列表如下：</h2>

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">

      <td nowrap>分店名称</td>
      <td nowrap>所属区域</td>
      <td nowrap>分店类型</td>
      <td nowrap>会员总数</td>
      <td nowrap>会员消费笔数</td>
      <td nowrap>非会员消费笔数</td>
      <td nowrap>会员消费金额</td>
      <td nowrap>非会员消费金额</td>
      <td nowrap>操作</td>
    </tr>
    <%


    java.util.Enumeration e = LeagueShop.find(teasession._strCommunity,sql.toString(),pos,pageSize);
    if(!e.hasMoreElements())
    {
      out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
    }
       while(e.hasMoreElements()){
         int lsid = ((Integer)e.nextElement()).intValue();
         LeagueShop leobj = LeagueShop.find(lsid);
         Card card1 = Card.find(leobj.getProvince());
         Card card2 = Card.find(leobj.getCity());
         LeagueShopType objty = LeagueShopType.find(leobj.getLstype());
    %>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">

      <td><%=leobj.getLsname() %></td>
      <td><%=LeagueShop.CSAREA[leobj.getCsarea()]%>&nbsp;<%if(card1.getAddress()!=null)out.print(card1.getAddress());%>&nbsp;<%if(card2.getAddress()!=null)out.print(card2.getAddress());%></td>
      <td><%if(objty.getLstypename()!=null)out.print(objty.getLstypename()); %></td>
      <td align="center"><%=ICSalesList.getMemberTotal(lsid,"  and ic.icard!=''") %></td>
      <td align="center"><%=ICSalesList.getSQLB(lsid,"count(distinct(ic.icsales)) "," and ics.icard!=''") %></td>
      <td align="center"><%=ICSalesList.getSQLB(lsid,"count(distinct(ic.icsales))"," and ics.icard is null ") %></td>
      <td align="center"><%if(ICSalesList.getJiE(lsid,""," and ics.icard!=''") !=null)out.print(ICSalesList.getJiE(lsid,""," and ics.icard!=''") );%>&nbsp;元</td>
      <td align="center"><%if(ICSalesList.getJiE(lsid,""," and ics.icard  is null ") !=null){out.print(ICSalesList.getJiE(lsid,""," and ics.icard  is null ") );}else{out.print("0");}%>&nbsp;元</td>
      <td align="center"><input type="button" value="查看详细" onclick="window.open('/jsp/leagueshop/SalesStatisticsShow.jsp?lsid=<%=lsid%>&nexturl=<%=nexturl%>','_self');"/></td>
    </tr>
   <%}%>
   <%if(count>0){ %>
   <tr>
     <td colspan="2"></td>
     <td align="center"><b>总计：</b></td>
     <td align="center"><%=LeagueShop.getMemberTotal("  and ic.icard!=''"+sql2.toString()) %></td>
     <td align="center"><%=LeagueShop.getSQLB("count(distinct(ic.icsales)) "," and ics.icard!=''"+sql2.toString()) %>&nbsp;笔</td>
     <td align="center"><%=LeagueShop.getSQLB("count(distinct(ic.icsales))"," and ics.icard is null "+sql2.toString()) %>&nbsp;笔</td>
     <td align="center"><%=LeagueShop.getJiE("sum(ic.price) "," and ics.icard!=''"+sql2.toString()) %>&nbsp;元</td>
     <td align="center"><%=LeagueShop.getJiE("sum(ic.price) "," and ics.icard  is null "+sql2.toString()) %>&nbsp;元</td>
   </tr>
     <%}if (count > pageSize) {  %>
      <tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
      <%}  %>
  </table>
  <br>
<input type="button" value="导出Excel表" onclick="f_excel();"/>
  </form>
  <div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
