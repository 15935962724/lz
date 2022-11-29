<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter" %><%@page import="tea.resource.Resource" %><%@page import="tea.entity.admin.erp.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.ui.TeaSession" %><%@page import="tea.entity.admin.erp.*" %><%@page import="tea.entity.league.*" %><%@page import="tea.entity.util.*" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
if (teasession._rv == null) {
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}

StringBuffer sql=new StringBuffer(" AND lsstatic = 0 AND id IN(SELECT supplname FROM Paidinfull WHERE quantity!=0 and type > 1 ) ");
StringBuffer param=new StringBuffer();
param.append("?id=").append(request.getParameter("id"));

String nexturl = request.getRequestURI()+"?"+request.getContextPath();
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
String lsname=teasession.getParameter("lsname");
if(lsname!=null&& lsname.length()>0)
{
  sql.append(" AND lsname LIKE  "+DbAdapter.cite("%"+lsname+"%"));
  param.append("&lsname=").append(java.net.URLEncoder.encode(lsname,"UTF-8"));
}
int Lstype =0;
if(teasession.getParameter("Lstype")!=null && teasession.getParameter("Lstype").length()>0)
{
  Lstype = Integer.parseInt(teasession.getParameter("Lstype"));
  if(Lstype>0)
  {
    sql.append(" AND Lstype = ").append(Lstype);
    param.append("&Lstype=").append(Lstype);
  }
}
int goodstype1 = 0;
int goodstype2=0;
if(teasession.getParameter("goodstype1")!=null && teasession.getParameter("goodstype1").length()>0)
{
  goodstype1 = Integer.parseInt(teasession.getParameter("goodstype1"));
  int type = goodstype1;

  if(teasession.getParameter("goodstype2")!=null && teasession.getParameter("goodstype2").length()>0)
  {
    goodstype2 = Integer.parseInt(teasession.getParameter("goodstype2"));
  }
  if(goodstype2>0)
  {
    type = goodstype2;
  }
  if(type>0)
  {
    DbAdapter db = new DbAdapter();
    DbAdapter db2 = new DbAdapter();
    try
    {
      int i = 1,cou = 0;
      db.executeQuery("select  distinct(p.supplname) from GoodsDetails g,Paidinfull p where g.paid=p.purchase AND g.node in(SELECT node FROM Goods WHERE   goodstype LIKE '%/"+type+"/%' )");
      db2.executeQuery("select  count(distinct(p.supplname)) from GoodsDetails g,Paidinfull p where g.paid=p.purchase AND g.node in(SELECT node FROM Goods WHERE   goodstype LIKE '%/"+type+"/%' )");
      if(db2.next())
      {
        cou=db2.getInt(1);
      }
      if(cou>0)//说明有记录
      {
        sql.append(" AND (");
      }
      while(db.next())
      {
          sql.append(" id =").append(db.getInt(1));
          if(i!=cou)
          {
            sql.append(" or");
          }
        i++;
      }
      if(cou>0)//说明有记录
      {
        sql.append(" )");
      }else
      {
        sql.append(" AND id=0 ");
      }
    }finally
    {
      db.close();
      db2.close();
    }

  }
  param.append("&goodstype1=").append(goodstype1);
  param.append("&goodstype2=").append(goodstype2);
}

String subject = teasession.getParameter("subject");
if(subject!=null && subject.length()>0)
{
    DbAdapter db3 = new DbAdapter();
    DbAdapter db4 = new DbAdapter();
  try
    {
      int i = 1,cou = 0;
      db3.executeQuery("select  distinct(p.supplname)  from GoodsDetails g,Paidinfull p,Node n where g.paid=p.purchase AND n.node=g.node AND g.node in(select node from Node where node in(select node from NodeLayer where subject like '%"+subject+"%' ))");
      db4.executeQuery("select  count(distinct(p.supplname))  from GoodsDetails g,Paidinfull p,Node n where g.paid=p.purchase AND n.node=g.node AND g.node in(select node from Node where node in(select node from NodeLayer where subject like '%"+subject+"%' ))");
      if(db4.next())
      {
        cou=db4.getInt(1);
      }
      if(cou>0)//说明有记录
      {
        sql.append(" AND (");
      }
      while(db3.next())
      {
          sql.append(" id =").append(db3.getInt(1));
          if(i!=cou)
          {
            sql.append(" or");
          }
        i++;
      }
      if(cou>0)//说明有记录
      {
        sql.append(" )");
      }else
      {
        sql.append(" AND id=0 ");
      }
    }finally
    {
      db3.close();
      db4.close();
    }
      param.append("&subject=").append(java.net.URLEncoder.encode(subject,"UTF-8"));
}

String time_c = teasession.getParameter("time_c");
if(time_c!=null && time_c.length()>0)
{
  sql.append(" AND id IN (select supplname from Paidinfull where  time_s >= "+DbAdapter.cite(time_c)+") ");
  param.append("&time_c=").append(time_c);
}
String time_d = teasession.getParameter("time_d");
if(time_d!=null && time_d.length()>0)
{
  sql.append(" AND id IN (select supplname from Paidinfull where  time_s <="+DbAdapter.cite(time_d)+") ");
  param.append("&time_d=").append(time_d);
}

int pos = 0, pageSize = 10, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
count = LeagueShop.count(teasession._strCommunity,sql.toString());
int root=GoodsType.getRootId(teasession._strCommunity);
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<script type="text/javascript" language="javascript" src="/tea/Calendar.js"></script>

<title>销售统计</title>
</head>

<body  <%if(goodstype1>0){out.print("onload=\"f_goodstype("+goodstype2+");\"");}%>>
<script>
function f_goodstype(igd)
{
     sendx("/jsp/erp/Goods_ajax.jsp?id="+form1.id.value+"&act=goodstype&father="+form1.goodstype1.value+"&goodstype2="+igd,
     function(data)
     {
       document.getElementById('show').innerHTML=data;
     }
     );
}
</script>
<h1>销售统计</h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <h2>查询</h2>
  <form action="?" name="form1" method="POST">
 <input type="hidden" name="id" value="<%=request.getParameter("id") %>"/>
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
        <td>加盟店名称:</td>
        <td><input type="text" name="lsname" value="<%if(lsname!=null)out.print(lsname);%>"/></td>
        </tr>
        <tr>
        <td>加盟店类型:</td>
<td><select  name="Lstype" ><option  value="0">请选择加盟店类别</option>
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

     <td nowrap>商品类别：&nbsp;</td>
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
      <td>商品名称:</td>
      <td><input type="text" name="subject" value="<%if(subject!=null)out.print(subject);%>"/></td>
      <td>销售日期:</td>
      <td>

        从&nbsp;
        <input id="time_c" name="time_c" size="7"  value="<%if(time_c!=null)out.print(time_c);%>" readonly="readonly">
        <img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_c');" />
        &nbsp;到&nbsp;
        <input id="time_d" name="time_d" size="7"  value="<%if(time_d!=null)out.print(time_d);%>" readonly="readonly">
        <img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_d');" />


</td>

<td><input type="submit" value="汇总"/></td>
    </tr>

  </table>

  <h2>列表(&nbsp;<%=count%>&nbsp;)</h2>

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td nowrap>加盟店名称</td>
      <td nowrap>所属区域</td>
      <td nowrap>加盟店类型</td>
      <td nowrap>销售数量</td>
      <td nowrap>销售金额</td>
      <td nowrap>退货数量</td>
      <td nowrap>退货金额</td>
      <td nowrap>操作</td>
    </tr>
    <%
    java.util.Enumeration e = LeagueShop.findByCommunity(teasession._strCommunity,sql.toString(),pos,pageSize);
    if(!e.hasMoreElements())
    {
      out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
    }
    while(e.hasMoreElements())
    {
      int leid =((Integer)e.nextElement()).intValue();
      LeagueShop leobj = LeagueShop.find(leid);
      Card card1 = Card.find(leobj.getProvince());
      Card card2 = Card.find(leobj.getCity());
      LeagueShopType objty = LeagueShopType.find(leobj.getLstype());


    %>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td><%=leobj.getLsname()%></td>
      <td><%=LeagueShop.CSAREA[leobj.getCsarea()]%>&nbsp;<%if(card1.getAddress()!=null)out.print(card1.getAddress());%>&nbsp;<%if(card2.getAddress()!=null)out.print(card2.getAddress());%></td>
      <td><%if(objty.getLstypename()!=null)out.print(objty.getLstypename()); %></td>
      <td ><%=Paidinfull.getShuLiang(teasession._strCommunity,leid) %></td>
      <td><%=Paidinfull.getJinE(teasession._strCommunity,leid).setScale(2,4)%>元</td>
      <td ><%=ReturnedShop.getReturnQuantity(teasession._strCommunity,leid) %></td>
      <td><%=ReturnedShop.getAmount(teasession._strCommunity,leid)%>元</td>
      <td><input type="button" value="查看详细" onclick="window.open('/jsp/erp/SaleDetail.jsp?leid=<%=leid%>&nexturl=<%=nexturl%>','_self');"/></td>
    </tr>
    <%} %>
      <%if (count > pageSize) {  %>
      <tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
      <%}  %>
  </table>

  </form>
  <div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
