<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="java.util.*" %>
<%@page import="java.net.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.db.*" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.entity.member.*" %>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

//////////////////////////////////管理员可以查询指定日期，指定用户上传的商品列表及数量//////////////////////////////

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?Node="+teasession._nNode+"&nexturl="+request.getRequestURI()+"?"+request.getQueryString());
  return;
}

String referer=request.getHeader("referer");
/*
if(referer==null)
{
  response.sendError(403);
  return;
}
*/



String _strId=teasession.getParameter("id");

String goods=teasession.getParameter("goods");
String goodstype=teasession.getParameter("goodstype");
String goodstype2=teasession.getParameter("goodstype2");
String brand=teasession.getParameter("brand");
String price1=teasession.getParameter("price1");
String price2=teasession.getParameter("price2");
String q=teasession.getParameter("q");
Resource r=new Resource();

String supplier=teasession.getParameter("supplier");
String serialnumber=teasession.getParameter("serialnumber");
String member=teasession.getParameter("member");

String f=teasession.getParameter("f");
String t=teasession.getParameter("t");

int root=GoodsType.getRootId(teasession._strCommunity);

StringBuffer param=new StringBuffer();
param.append("?community=").append(teasession._strCommunity);
param.append("&id=").append(_strId);
StringBuffer sql=new StringBuffer(" WHERE n.community="+DbAdapter.cite(teasession._strCommunity)+" AND n.node=g.node AND g.node=c.goods and c.commodity=bp.commodity");

StringBuffer from=new StringBuffer(" FROM Node n,Goods g,Commodity c,BuyPrice bp");

//货号
if(serialnumber!=null&&serialnumber.length()>0)
{
	sql.append(" and c.serialnumber like "+DbAdapter.cite("%"+serialnumber+"%"));
	param.append("&serialnumber=").append(serialnumber);
}
if(member!=null&&member.length()>0)
{
  sql.append(" AND n.rcreator=").append(DbAdapter.cite(member)).append(" AND n.vcreator=").append(DbAdapter.cite(member));
  param.append("&member=").append(URLEncoder.encode(member,"UTF-8"));
}
   String number = teasession.getParameter("number");
   if(number!=null && number.length()>0)
   {
     sql.append(" AND n.goodsnumber LIKE ").append(DbAdapter.cite("%"+number+"%"));
     param.append("&number=").append(java.net.URLEncoder.encode(number,"UTF-8"));
   }
if(f!=null&&(f=f.trim()).length()>0)
{
  sql.append(" AND n.time>=").append(DbAdapter.cite(f));
  param.append("&f=").append(URLEncoder.encode(f,"UTF-8"));
}
if(t!=null&&(t=t.trim()).length()>0)
{
  sql.append(" AND n.time<").append(DbAdapter.cite(t));
  param.append("&t=").append(URLEncoder.encode(t,"UTF-8"));
}

if(goods!=null&&goods.length()>0)
{
  sql.append(" AND n.node LIKE ").append(DbAdapter.cite("%"+goods+"%"));
  param.append("&node=").append(goods);
}
//类别
if(goodstype!=null&&goodstype.length()>0)
{
	sql.append(" AND g.goodstype LIKE '/").append(root).append("/").append(goodstype).append("/%'");
  param.append("&goodstype=").append(goodstype);
}
if(goodstype2!=null&&goodstype2.length()>0)
{
	sql.append(" AND g.goodstype LIKE '/").append(root).append("/").append(goodstype).append("/").append(goodstype2).append("/%'");
  param.append("&goodstype=").append(goodstype2);
}


if(brand!=null&&brand.length()>0)
{
  sql.append(" AND g.brand=").append(brand);
  param.append("&brand=").append(brand);
}

//价格
if((price1!=null&&price1.length()>0)||(price2!=null&&price2.length()>0))
{

 // sql.append(" AND c.node=bp.node AND c.goods=g.node");
  if((price1!=null&&price1.length()>0))
  {
    sql.append(" AND bp.price>=").append(price1);
    param.append("&price1=").append(price1);
  }
  if(price2!=null&&price2.length()>0)
  {
    sql.append(" AND bp.price<").append(price2);
    param.append("&price2=").append(price2);
  }
}
//关键字
if(q!=null&&q.length()>0)
{
 sql.append(" and n.node = nl.node");
  from.append(",NodeLayer nl");
  sql.append(" and nl.subject like "+DbAdapter.cite("%"+q+"%"));
  param.append("&q=").append(URLEncoder.encode(q,"UTF-8"));
}
int count=0;
int pos=0;
int pageSize=25;
if(teasession.getParameter("Pos")!=null)
{
  pos=Integer.parseInt(teasession.getParameter("Pos"));
}

String order=request.getParameter("order");
if(order==null)
order="n.node";
param.append("&order=").append(order);

String desc=request.getParameter("desc");
if(desc==null)
desc="desc";
param.append("&desc=").append(desc);



//System.out.println();
String nexturl=URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"utf-8");
Community communitys=Community.find(teasession._strCommunity);



%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
</head>
<script>
function inputFloat(obj)
{
	if(obj.value!=''){
		var regNum =/^\+?[1-9][0-9]*$/;
	
		if(!regNum.test(obj.value))  //如果是数字返回true，其它返回false
		{
			alert("请输入数值");
			obj.value='';
			return false;
		}
	}

}
</script>
<body id="bodynone">

<script src="<%=communitys.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></script>


<h1>产品监管</h1>
<div id="head6"><img height="6" alt=""></div>

<form name="form1" action="?" method="get">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=_strId%>"/>

<h2>查询</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
<td>节点：<input type="text" name="goods" size="10" value="<%if(goods!=null)out.print(goods);%>">
<td nowrap>货号：<input name="serialnumber" size="10" value="<%if(serialnumber!=null)out.print(serialnumber);%>" ></td>
<td nowrap>价格：<input name="price1" type="text" size="5" value="<%if(price1!=null)out.print(price1);%>" onblur="inputFloat(this);">-<input name="price2" type="text" size="5" value="<%if(price2!=null)out.print(price2);%>" onblur="inputFloat(this);"></td>
<td nowrap>关键字：<input name="q" type="text" size="10" value="<%if(q!=null)out.print(q);%>" ></td>
</tr>
<tr>

    <td> 类别：
<%
int brands=Brand.findByNode(teasession._nNode);
 
StringBuffer sb=new StringBuffer();
StringBuffer sb2=new StringBuffer("new Array(");
StringBuffer sb3=new StringBuffer("new Array(");
out.print("<select name=goodstype onchange=\"change_gt(this.value);\" ><option value=\"\">------------------");
//int root=GoodsType.getRootId(teasession._strCommunity);
java.util.Enumeration e=GoodsType.findByFather(root);
while(e.hasMoreElements())
{
  GoodsType obj=(GoodsType) e.nextElement();
  out.print("<option value="+obj.getGoodstype());
  String brandlist=obj.getBrand();
  if((goodstype==null&&brandlist.indexOf("/"+brands+"/")!=-1)||String.valueOf(obj.getGoodstype()).equals(goodstype))
  {
    out.print(" SELECTED ");
  }
  sb2.append("new Array('").append(obj.getGoodstype()).append("','").append(brandlist);

  out.print(">"+obj.getName(teasession._nLanguage));

  sb.append("case ").append(obj.getGoodstype()).append(":");
  java.util.Enumeration e2=GoodsType.findByFather(obj.getGoodstype());
  while(e2.hasMoreElements())
  {
    obj=(GoodsType) e2.nextElement();
    sb.append("op2[op2.length]=new Option('").append(obj.getName(teasession._nLanguage)).append("','").append(obj.getGoodstype()).append("');");
    brandlist=obj.getBrand();
    if(goodstype2==null&&brandlist.indexOf("/"+brands+"/")!=-1)
    goodstype2=String.valueOf(obj.getGoodstype());

	sb2.append(brandlist);
    sb3.append("new Array('").append(obj.getGoodstype()).append("','").append(obj.getBrandlist()).append("'),\r\n");
  }
  sb.append("break;\r\n");
  sb2.append("'),\r\n");
}
sb2.append("new Array(0,''));");
sb3.append("new Array(0,''));");
out.print("</select><select name=goodstype2 onchange=\"change_gt2(this.value);\" ><option value=\"\">------------------</select>");

%></td>



        <td>品牌：<select name="brand" style="width:100">
          <option value="" >---------------------------</option>
          <%
          java.util.Enumeration enumer54313=Brand.findByCommunity(teasession._strCommunity,"",0,Integer.MAX_VALUE);
          while(enumer54313.hasMoreElements())
          {
            int id=((Integer)enumer54313.nextElement()).intValue();
            Brand obj=Brand.find(id);
            out.print("<option value="+obj.getBrand());
            if(String.valueOf(id).equals(brand))
            out.print(" SELECTED ");
            out.print(" >"+obj.getName(teasession._nLanguage));
          }%>
        </select><input type="button" value="..." onclick="window.open('/jsp/type/brand/DialogBrand.jsp?community=<%=teasession._strCommunity%>&field=form1.brand','','height=500,width=550,scrollbars=yes');"/>
        </td>
          <td nowrap>供应商：<select name="supplier" style="width:120"><option value="" >---------------------------</option>
        <%
        Enumeration e_s=Supplier.findByCommunity(teasession._strCommunity);
        while(e_s.hasMoreElements())
        {
          int id=((Integer)e_s.nextElement()).intValue();
          Supplier obj=Supplier.find(id);
          out.print("<option value="+id);
          if(String.valueOf(id).equals(supplier))
          out.print(" SELECTED ");
          out.print(" >"+obj.getName(teasession._nLanguage));
        }
        %></select></td>
        <td nowrap>创建者：<select name="member" style="width:120"><option value="" >-----------------------------</option>
        <%
        DbAdapter db=new DbAdapter();
        try
        {
          db.executeQuery("SELECT rcreator,COUNT(*) FROM Node WHERE community="+DbAdapter.cite(teasession._strCommunity)+" AND type=34 GROUP BY rcreator");
          while(db.next())
          {
            String str=db.getString(1);
            int co=db.getInt(2);
            out.print("<option value="+str);
            if(str.equals(member))
            out.print(" SELECTED ");
            out.print(" >"+str+" ( "+co+" )");
          }
        }finally
        {
          db.close();
        }
        %></select></td>
</tr>
<tr>
        <td colspan="2">时间：
         从&nbsp;
        <input id="f" name="f" size="7"  value="<%if(f!=null)out.print(f);%>"  style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.f');"> 
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('form1.f');" />
        &nbsp;到&nbsp;
        <input id="t" name="t" size="7"  value="<%if(t!=null)out.print(t);%>"  style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.t');" >
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"   style="cursor:pointer" onclick="new Calendar().show('form1.t');" />
        
     
       
        </td>

 <td nowrap>商品编号：<input name="number" size="10" value="<%if(number!=null)out.print(number);%>" ></td>
        <td><input type="submit" value="搜索"></td></tr>
</table>

</form>
<br>
<script>

function change_gt(v)
{
  var op2=form1.goodstype2.options;
  while(op2.length>1)op2[1]=null;
  switch(parseInt(v))
  {
   <%=sb.toString()%>
  }
 // change_brand(v,1);
}
var gt=form1.goodstype;
change_gt(gt.value);
<%
if(goodstype2!=null&&goodstype2.length()>0)
  out.print("form1.goodstype2.value="+goodstype2+";");
%>

function change_gt2(v)
{
  //if(v!="")
 // change_brand(v,2);
 // else
//  change_brand(gt.value,1);
}
	function sub()
	{
		if(confirm('你确定要删除所有的商品吗？'))
		{
			return true;
		}else
		{
			return false;
		}
	}
</script>
<h2>列表 ( <span id=spancount>0</span> )
<input type="button" onClick="window.open('/jsp/type/goods/newgoods/SelectGoodsType_1.jsp?jump=2&nocreate=0&NewNode=ON&Node=<%=teasession._nNode%>&community=<%=teasession._strCommunity%>&nexturl=<%=nexturl%>','_self');" value="<%=r.getString(teasession._nLanguage,"CBNew")%>"/>
<input type="button" id="shangjia" value="<%=r.getString(teasession._nLanguage,"上架")%>" onClick="window.open('/jsp/type/goods/EditGoodsTime.jsp?act=bat&community=<%=teasession._strCommunity%>&nexturl=<%=nexturl%>','_self');"/>


<input type="submit" value="<%=r.getString(teasession._nLanguage,"全部-删除")%>" >
</h2>
<form name=form_d action="/jsp/type/goods/9000_GoodsAllListDetele.jsp" method="post" onSubmit="return sub();">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<input type=hidden name="deletesql" value="<%=from.toString()+sql.toString() %>">
<input type=hidden name="nexturl" value="<%=nexturl %>">
  <TR id="tableonetr">
    <td width="1">&nbsp;</td>
    <td>商品编号</td>
    <td>商品名称</td>
    <td>类型</td>
    <td>品牌</td>
    <td>人气</td>
    <td>时间</td>
    <td>商品创建人</td>
    <td>&nbsp;</td>
</tr>
<%

db=new DbAdapter();



try
{

  count=  db.getInt("SELECT DISTINCT COUNT( n.node ) "+from.toString()+sql.toString());

  sql.append(" ORDER BY ").append(order).append(" ").append(desc);

  db.executeQuery("SELECT DISTINCT n.node "+from.toString()+sql.toString());
//out.print("SELECT DISTINCT n.node "+from.toString()+sql.toString());
  for(int index = 0; index < pos + pageSize && db.next(); index++)
  {

    if (index >= pos)
    {
      int id=db.getInt(1);
      Node node=Node.find(id);
      String subject=node.getSubject(teasession._nLanguage);

      Goods g=Goods.find(id);
      Profile probj = Profile.find(  node.getCreator().toString());


      %>
      <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
        <td width="1"><%=index+1%></td>
        <td><%=node.getNumber() %></td>
        <td>
          <A href="/servlet/Goods?Node=<%=id%>" ><%=subject%></A>
        </td>
        <td><%=Node.find(node.getFather()).getSubject(teasession._nLanguage)%></td>
        <td>&nbsp;<%
        Brand b=null;
        if(g.getBrand()>0&&(b=Brand.find(g.getBrand())).isExists())
        {
          if(b.getNode()>0)
          out.print("<a target=_blank href=/servlet/Node?Node="+b.getNode()+">");
          out.print(b.getName(teasession._nLanguage)+"</a>");
        }
        %></td>
        <td><%=node.getClick()%></td>
        <td><%=node.getTimeToString()%></td>
        <td><%= probj.getLastName(teasession._nLanguage)+probj.getFirstName(teasession._nLanguage)%></td>
         <td>
         <%
         	if(teasession._strCommunity.equals("9000gw"))
         	{
          %>
          <input type="button" value="<%=r.getString(teasession._nLanguage,"CBEdit")%>" onClick="window.open('/jsp/type/goods/EditGoods.jsp?Node=<%=id%>&nexturl=<%=nexturl%>&brand=<%=b.getBrand() %>','_self');"/>
         <%
         	}else{
          %>
         <input type="button" value="<%=r.getString(teasession._nLanguage,"CBEdit")%>" onClick="window.open('/jsp/type/goods/newgoods/EditGoods_1.jsp?jump=2&brand=<%=g.getBrand()%>&Node=<%=id%>&nexturl=<%=nexturl%>','_self');"/>

         <%
         	}
          %>
         <input type="button" id="shangjia" value="<%=r.getString(teasession._nLanguage,"上架")%>" onClick="window.open('/jsp/type/goods/EditGoodsTime.jsp?Node=<%=id%>&nexturl=<%=nexturl%>','_self');"/>
         <input type="button" value="<%=r.getString(teasession._nLanguage,"CBDelete")%>" onClick="if(confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>')){window.open('/servlet/DeleteNode?Node=<%=id%>&nexturl=<%=nexturl%>', '_self')};"/>
         </td>
      </tr>
      <%
      }
    }
}catch(Exception ex)
{
  ex.printStackTrace();
}finally
{
  db.close();
}

%>
</table>
<%=new tea.htmlx.FPNL(teasession._nLanguage, request.getRequestURI()+param.toString() + "&Pos=", pos, count)%>

<div id="head6"><img height="6" alt=""></div>

<script src="<%=communitys.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></script>

</from>

<script>spancount.innerHTML="<%=count%>";</script>
</body>
</html>
