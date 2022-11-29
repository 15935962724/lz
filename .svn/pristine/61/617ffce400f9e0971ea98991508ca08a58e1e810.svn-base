<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.db.*" %>
<%@page import="tea.entity.admin.*" %>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+request.getRequestURI()+"?"+request.getQueryString());
  return;
}

int type = 1;//默认为1
if(teasession.getParameter("type")!=null && teasession.getParameter("type").length()>0)
{
  type = Integer.parseInt(teasession.getParameter("type"));
}
//显示是前台显示还是后天显示 参数默认前台显示 参数为 1 used
int used = 1;
if(teasession.getParameter("used")!=null && teasession.getParameter("used").length()>0)
{
  used = Integer.parseInt(teasession.getParameter("used"));
}

String nodetype = teasession.getParameter("nodetype");
String nexturl = request.getRequestURI()+"?type="+type+"&used="+used+request.getContextPath();
StringBuffer sql = new StringBuffer(" AND type=34 AND hidden = 0");
StringBuffer param = new StringBuffer();
param.append("?id=").append(request.getParameter("id"));
param.append("&type=").append(type);
param.append("&used=").append(used);
param.append("&nodetype=").append(nodetype);
//如果是商品管理 则 列表只能显示当前登录用户添加的商品
if(type == 1)
{
  sql.append(" AND rcreator="+DbAdapter.cite(teasession._rv.toString())+" AND vcreator="+DbAdapter.cite(teasession._rv.toString()));
}
sql.append(" AND  g.used = ").append(used);
//商品编号
String goodsnumber = teasession.getParameter("goodsnumber");
if(goodsnumber!=null && goodsnumber.length()>0)
{
  goodsnumber = goodsnumber.trim();
  sql.append(" AND  n.goodsnumber LIKE ").append(DbAdapter.cite("%"+goodsnumber+"%"));
  param.append("&goodsnumber=").append(goodsnumber);
}

//条形码barcode
String barcode = teasession.getParameter("barcode");
if(barcode!=null && barcode.length()>0)
{
  goodsnumber = goodsnumber.trim();
  sql.append(" AND g.barcode LIKE ").append(DbAdapter.cite("%"+barcode+"%"));
  param.append("&barcode=").append(barcode);
}
//商品名称
String subject = teasession.getParameter("subject");
if(subject!=null && subject.length()>0)
{
  subject = subject.trim();
  sql.append(" AND nl.subject LIKE ").append(DbAdapter.cite("%"+subject+"%"));
  param.append("&subject=").append(java.net.URLEncoder.encode(subject,"UTF-8"));
}

//商品类别
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
//商品品牌
int brand =0;
if(teasession.getParameter("brand")!=null && teasession.getParameter("brand").length()>0)
{
  brand = Integer.parseInt(teasession.getParameter("brand"));
  sql.append(" AND g.brand = ").append(brand);
  param.append("&brand=").append(brand);
}
//录入时间
String time_c = teasession.getParameter("time_c");
if(time_c!=null && time_c.length()>0)
{
  sql.append(" AND time >=").append(DbAdapter.cite(time_c));
  param.append("&time_c=").append(time_c);
}
String time_d = teasession.getParameter("time_d");
if(time_d!=null && time_d.length()>0)
{
  sql.append(" AND time <=").append(DbAdapter.cite(time_d));
  param.append("&time_d=").append(time_d);
}

int pos = 0, pageSize = 30, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}



count = Node.count(teasession._strCommunity,sql.toString());


String o=request.getParameter("o");
if(o==null)
{
  o="n.time";
}
boolean aq=Boolean.parseBoolean(request.getParameter("aq"));
sql.append(" ORDER BY ").append(o).append(" ").append(aq?"DESC":"ASC");
param.append("&o=").append(o).append("&aq=").append(aq);

//sql.append(" ORDER BY n.time DESC ");



int root=GoodsType.getRootId(teasession._strCommunity);

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
</head>

<body  <%if(goodstype1>0){out.print("onload=\"f_goodstype("+goodstype2+");\"");}%>>
<script>
function f_order(v)
  {
    var aq=form1.aq.value=="true";
    if(form1.o.value==v)
    {
      form1.aq.value=!aq;
    }else
    {
      form1.o.value=v;
    }
    form1.action="?";
    form1.submit();
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
//
function CheckAll(){
var checkname=document.getElementsByName("checkall");
var fname=document.getElementsByName("nodeid");
var lname="";
if(checkname[0].checked){
    for(var i=0; i<fname.length; i++){
      fname[i].checked=true;
}
}else{
   for(var i=0; i<fname.length; i++){
      fname[i].checked=false;
   }
}
}
//判断是否选中
function f_check()
{
  var _nodeid="";
  var nodeid = form1.nodeid;
  for(var i=0;i<nodeid.length;i++)
  {
    if(nodeid[i].checked)
    _nodeid=_nodeid+","+nodeid[i].value;
  }
  if(_nodeid=="")
  {
    return false;
  }
  else
  {

    if(_nodeid.indexOf(',')==0)
    {
      _nodeid=right(_nodeid,_nodeid.length-1)
      return true;
    }
  }
}
function right(mainStr,lngLen)
{
  // alert(mainStr.length)
  if (mainStr.length-lngLen>=0 && mainStr.length>=0 && mainStr.length-lngLen<=mainStr.length)
  {
    return mainStr.substring(mainStr.length-lngLen,mainStr.length)
  }
    else{
      return null
    }
  }
//删除
function f_delete()
{
  if(!f_check())
  {
    alert("请选择要删除的商品");
    return false;
  }

  if(confirm('如果删除,这些商品将无法恢复.您确定吗?')){
    form1.act.value='delete';
    form1.action='/servlet/EditGoods';
    form1.submit();
  }
}

function f_excel()
{
  form1.act.value='Goods';
  form1.action='/servlet/ExportExcel';
  form1.submit();
}
function f_c(igd)
{
  var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:1057px;dialogHeight:705px;';
  var url = '/jsp/type/goods/GoodsShow.jsp?node='+igd;
  window.showModalDialog(url,self,y);
}
function f_szjg(igd)
{
  var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:757px;dialogHeight:505px;';
  var url = '/jsp/type/buy/Buys2.jsp?act=szjg&node='+igd+'&t='+new Date().getTime();
  window.showModalDialog(url,self,y);
  window.open(location.href+"&t="+new Date().getTime()+"&id="+form1.id.value,window.name);
}
</script>
<h1><%if(type==1){out.print("商品管理");} else if(type==2){out.print("商品监管");}else if(type==3){out.print("商品查阅");}%></h1>
<div id="head6"><img height="6" alt=""></div>
<form action="?" method="post" name="form1">
<input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>">
<input type="hidden" name="type" value="<%=type%>"/>
<input type="hidden" name="act" value="delete"/>
<input type="hidden" name="used" value="<%=used %>">
 <input type="hidden" name="sql" value="<%=sql.toString()%>">
  <input type="hidden" name="o" VALUE="<%=o%>">
      <input type="hidden" name="aq" VALUE="<%=aq%>">
<input type="hidden" name="files" value="商品表">
<h2>查询</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>编号：</td>
    <td><input type="text" name="goodsnumber" value="<%if(goodsnumber!=null)out.print(goodsnumber);%>"/></td>
    <td>商品名称：</td>
    <td><input type="text" name="subject" value="<%if(subject!=null)out.print(subject);%>"/></td>
  </tr>
  <tr>
    <td nowrap >商品类别：</td>
    <td> <select name="goodstype1" onchange="f_goodstype('0');">
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
    </tr>
    <tr>
    <td>录入时间：</td>
    <td>


      &nbsp;从&nbsp;
        <input id="time_c" name="time_c" size="7"  value="<%if(time_c!=null)out.print(time_c);%>" readonly="readonly">
        <img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_c');" />
    &nbsp;到&nbsp;
        <input id="time_d" name="time_d" size="7"  value="<%if(time_d!=null)out.print(time_d);%>" readonly="readonly">
        <img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_d');" />


    </td>
    <td>条形码：</td>
    <td><input type="text" name="barcode" value="<%if(barcode!=null)out.print(barcode);%>"/></td>

  </tr>
  <tr> <td colspan="4" align="center"><input type="submit" value="查询"></td></tr>
</table>


<br>


<h2>列表 ( <%=count%> )</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <TR id="tableonetr">
    <td nowrap width="1"><input type="checkbox" name="checkall" onclick="CheckAll()" /></td>
    <td nowrap  width="1">&nbsp;</td>
    <td nowrap ><a href="javascript:f_order('n.goodsnumber');">编号</a>
     <%
          if(o.equals("n.goodsnumber"))
          {
            if(aq)
            out.print("↓");
            else
            out.print("↑");
          }
          %>
    </td>
    <td nowrap>条形码</td>
    <td nowrap >商品名称</td>
    <td nowrap >商品类别</td>
    <td nowrap >商品品牌</td>
    <td nowrap >进货价</td>
    <td nowrap >供货价</td>
    <td><a href="javascript:f_order('n.time');">录入时间</a><%
          if(o.equals("n.time"))
          {
            if(aq) 
            out.print("↓");
            else
            out.print("↑");
          }
          %></td>
      <%
    if(type!=3){
      %>  <td>&nbsp;</td>
      <%} %>
</tr>
<%

java.util.Enumeration  e = Node.find(teasession._strCommunity,sql.toString(),pos,pageSize);
if(!e.hasMoreElements())
{
  out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
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
	  
	  Brand b=Brand.find(gobj.getBrand());
  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
  <td  width="1"><input type="checkbox" name="nodeid"  value="<%=nid%>" /></td>
    <td width="1"><%=pos+i%></td>
    <td><%=nobj.getNumber() %></td>
     <td><%if(gobj.getBarcode()!=null)out.print(gobj.getBarcode());%></td>
    <td>
      <A href="#" onclick="f_c('<%=nid%>');" ><%=nobj.getSubject(teasession._nLanguage)%></A>
    </td>
    <td><%out.print(sp.toString());//if(Node.find(nobj.getFather()).getSubject(teasession._nLanguage)!=null)out.print(Node.find(nobj.getFather()).getSubject(teasession._nLanguage));%></td>
    <td>&nbsp;<%=b.getName(teasession._nLanguage)    %></td>
    <td><%=bpobj.getList()%></td>
    <td><%=bpobj.getSupply()%></td>
    <td><%=nobj.getTimeToString()%></td>
    <%
    if(type!=3){
      %>
    <td>
      <input type="button" value="编辑" onClick="window.open('/jsp/type/goods/EditGoods.jsp?node=<%=nid%>&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self');"/>&nbsp;
      <input type="button" value="设置价格" onclick="f_szjg('<%=nid%>');">&nbsp;
      <input type="button" value="删除" onClick="if(confirm('如果删除,这些商品将无法恢复.您确定吗?')){window.open('/servlet/DeleteNode?node=<%=nid%>&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>', '_self')};"/>
    </td>
       <%} %>
  </tr>
  <%} %>
  <%if (count > pageSize) {  %>
  <tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
  <%}  %>
</table>
<br>    <%
    if(type!=3){
      %>

      <input type="button" onClick="window.open('/jsp/type/goods/SelectGoodsType.jsp?NewNode=ON&nodetype=<%=nodetype %>&node=<%=teasession._nNode%>&community=<%=teasession._strCommunity%>&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self');" value="添加商品"/>&nbsp;&nbsp;
      <input type="button" onClick="f_delete();" value="删除选中信息" >&nbsp;&nbsp;
      <input type="button" value="导出Excel表"  onclick="f_excel();">
<%} %>
</form>
<div id="head6"><img height="6" alt=""></div>

</body>
</html>

