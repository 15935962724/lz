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
<%@page import="tea.entity.admin.erp.*" %>
<%@page import="tea.entity.admin.erp.semi.*" %>
<%

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
SimpleDateFormat sdf1 = new  SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat sdf = new  SimpleDateFormat("yyyyMMdd");
Date timestring = new Date();
String trade =sdf.format(timestring) + SeqTable.getSeqNo("guize");
String nexturl = teasession.getParameter("nexturl");
String purid = teasession.getParameter("purid");//半成品合成成品的订单号
String puridsg = teasession.getParameter("puridsg");//规则编号

SemiPurchase pobj = SemiPurchase.find(puridsg);
SemiGoodsDetails.clearTime();

if("delete".equals(teasession.getParameter("act")))
{
  SemiPurchase.delete(purid);
  response.sendRedirect(nexturl);
  return;
}

StringBuffer strss = new StringBuffer();
String semigoodsname="",goodsname="";
String semistr[] = pobj.getSemigoods().split("/");
if(semistr.length>1)
{
  for(int j=0;j<semistr.length;j++)
  {
    if(semistr[j]!=null && semistr[j].length()>0)
    {
      SemiGoods sgobj2 =  SemiGoods.find(Integer.parseInt(semistr[j]));
      strss.append(sgobj2.getSubject()).append("/");
    }
    semigoodsname=strss.toString();
  }
}
String spstr[] = pobj.getGoods().split("/");
if(spstr.length>1)
{

  Node nodeobj = Node.find(Integer.parseInt(spstr[1]));
  goodsname = nodeobj.getSubject(teasession._nLanguage);
}

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>半成品组装规则</title>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"/>
<META HTTP-EQUIV="Expires" CONTENT="0"/>
<%@include file="/jsp/include/Canlendar4.jsp" %>
<body bgcolor="#ffffff"  <%if(pobj.getSemigoods()!=null)
{
  out.print(" onload=l_ajax236()");
}%>>
<script type="">
function l_ajax236()
{
  l_ajax(1);
  l_ajax2(1);
}
function f_xuanze()
{
  if(form1.waridname.value==0)
  {
    alert('请选择仓库！');
    form1.waridname.focus();
    return false;
  }
  if(form1.supplname.value==0)
  {
    alert('请选择拆卸后的供货商!');
    form1.supplname.focus();
    return false;
  }
  var rs = window.showModalDialog('/jsp/erp/semi/SemiCatecargo2_2cai.jsp?waridname='+form1.waridname.value+'&rsgoods='+form1.rsgoods.value,self,'edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:857px;dialogHeight:605px;');

  if(rs!=null)
  {
    gd_ajax(rs);
  }
}
function f_xuanze2()
{
  if(form1.supplname.value==0)
  {
    alert('请选择供货商!');
    form1.supplname.focus();
    return false;
  }
  var rs = window.showModalDialog('/jsp/erp/semi/GoodsGZcai.jsp?rsgoods='+form1.rsgoods.value,self,'edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:857px;dialogHeight:605px;');
  if(rs!=null){
    gd_ajax2(rs);
  }
}
//给商品细节表添加记录
function gd_ajax(obid)
{
  sendx("/jsp/erp/semi/SemiGoods_ajax_2cai.jsp?act=ccDetails&type=11&ssid="+obid+"&purchase="+form1.purchase.value,
  function(data)
  {
    if(data!=''&&data.length>1)
    {
      alert(data);
      return false;
    }
    l_ajax(0);
  }
  );
}
function gd_ajax2(igd)
{
  sendx("/jsp/erp/semi/GoodsGZ_ajaxcai.jsp?act=gDetails&type=11&node="+igd+"&purchase="+form1.purchase.value,
  function(data)
  {
    if(data!=''&&data.length>1)
    {
      alert(data);
      return false;
    }
    l_ajax2(0);
  }
  );
}
//选择商品中的ajax
function l_ajax(num){
  var stt="&num=0";
  if(num=="1")
  {
    stt="&num=1";l
  }
  sendx("/jsp/erp/semi/SemiCatecargo_ajax2_2cai.jsp?act=EditPurchase&type=11"+stt+"&purid="+form1.purchase.value+"&puridsg="+form1.puridsg.value,
  function(data)
  {
    document.getElementById('show').innerHTML=data;
  }
  );
}
function l_ajax2(num){
  var stt="&num=0";
  if(num==1)
  {
    stt="&num=1";
  }
  sendx("/jsp/erp/semi/SemiCatecargo_ajax3cai.jsp?act=EditSemiCatecargo&type=11"+stt+"&purid="+form1.purchase.value+"&puridsg="+form1.puridsg.value,
  function(data)
  {
    document.getElementById('show1').innerHTML=data;
  }
  );
}
//删除一个商品
function f_delete(igd)
{
  sendx("/jsp/erp/semi/SemiGoods_ajax.jsp?act=SGdelete&gdid="+igd,
  function(data)
  {
    if(data!=''&&data.length>0){
      alert(data);
      l_ajax();
    }
  }
  );
}
//purch_ajaxcai.jsp 中的方法
function f_quantity(igd,igd2,igd3)
{
  var c1 = igd3.split("/");
  var quantity =  document.all('quantity'+igd2).value;      //数量quantity1获取的单个商品的数量
  //显示的 数量
  var cs=0;
  var cs2=0;
  for(var i = 1;i<c1.length-1;i++)
  {
    cs =  parseInt(document.all('quantity'+i).value)+parseInt(cs);//数量
  }
  document.form1.quantity.value=cs;//数量
}
function f_quantity2(igd,igd2,igd3)
{

  var c1 = igd3.split("/");
  var quantity =  document.all('quantitysg'+igd2).value;      //数量quantity1获取的单个商品的数量
  //显示的 数量
  var cs=0;
  var cs2=0;
  for(var i = 1;i<c1.length-1;i++)
  {
    cs =  parseInt(document.all('quantitysg'+i).value)+parseInt(cs);//数量
  }
  document.form1.quantitysg.value=cs;//数量

    var cc = document.all('quantitysg'+igd2).value
}
function f_submit()
{
  if(!document.form1.quantity)
  {
    alert("请选择要合成的半成品品！");
    return false;
  }
  if(!document.form1.quantitysg)
  {
    alert("请选择要合成的商品！");
    return false;
  }
}
</script>
<div id="lzi_rkd">
  <h1>成品拆卸</h1>
  <form action="/servlet/EditSemiGoods" method="POST" name="form1" onsubmit="return f_submit();">
  <input type="hidden" name="act" value="EditSemiCatecargocai"/>
  <input type="hidden" name="nexturl" value="<%=nexturl%>"/>
  <input type="hidden" name="rsgoods" value=""/>
  <input type="hidden" name="purid" value="<%=purid%>"/>
  <input type="hidden" name="puridsg" value="<%=puridsg%>"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td width="6%" nowrap>配货单号：</td>
      <td width="29%"><input type="text" name="purchase" id="ruku" value="<%if(purid!=null){out.print(purid);}else{out.print(trade);}%>" readonly="readonly" style="background:#cccccc"></td>
        <td width="6%" nowrap>配货单号：</td>
        <td width="29%"><input type="text" name="purchasesg" id="ruku" value="<%if(puridsg!=null){out.print(puridsg);}else{out.print(puridsg);}%>" readonly="readonly" style="background:#cccccc"></td>
    </tr><tr>
      <td nowrap>仓库名称：</td>
      <td ><select name="waridname" class="lzj_huo">
        <option value="0">---------------</option>
        <%
        java.util.Enumeration e2 = Warehouse.find(teasession._strCommunity,"",0,Integer.MAX_VALUE);
        while (e2.hasMoreElements())
        {
          int warid = ((Integer)e2.nextElement()).intValue();
          Warehouse warobj = Warehouse.find(warid);
          out.print("<option value= "+warid);
          out.print(">"+warobj.getWarname());
          out.print("</option>");
        }
        %>
        </select>
      </td>
      <td width="9%">供货商：</td>
      <td width="24%">
        <select name="supplname"  class="lzj_huo">
          <option value="0">---------------</option>
          <%
          java.util.Enumeration e1=Supplier.findByCommunity(teasession._strCommunity);
          while(e1.hasMoreElements()){
            int sid=((Integer)e1.nextElement()).intValue();
            Supplier sobj=Supplier.find(sid);
            out.print("<option value= "+sid);

            out.print(">"+sobj.getName(teasession._nLanguage));
            out.print("</option>");
          }
          %>
          </select>      </td>
    </tr>
  </table>
  <h2>选择半成品   　(<%=semigoodsname%>，需要选择库存中对应的半成品)  </h2>
  <span id="show">
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr id="tableonetr">
        <td align="center" nowrap>商品编号</td>
        <td align="center" nowrap>商品名称</td>
        <td align="center" nowrap>规格型号</td>
        <td align="center" nowrap>品牌</td>
        <td align="center" nowrap>单位</td>
        <td align="center" nowrap>数量</td>
      </tr>
      <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''"  onclick="f_xuanze();" title="点击表格可以添加商品"  style="cursor:pointer">
        <td align="center" colspan="12">暂无记录，请点击这里，来添加商品。</td>
      </tr>
    </table>
  </span>
  <h2>选择成品　　(<%=goodsname%>，需要选择合成商品所对应的价格。)</h2>
  <span id="show1">
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr id="tableonetr">
        <td align="center" nowrap>商品编号</td>
        <td align="center" nowrap>商品名称</td>
        <td align="center" nowrap>规格型号</td>
        <td align="center" nowrap>品牌</td>
        <td align="center" nowrap>单位</td>
        <td align="center" nowrap>数量</td>
      </tr>
      <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''"  onclick="f_xuanze2();" title="点击表格可以添加商品"  style="cursor:pointer">
        <td align="center" colspan="12">暂无记录，请点击这里，来添加商品。</td>
      </tr>
    </table>
  </span>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td width="5%" nowrap>经办人：</td>
      <td width="11%" id="jin1"><select name="member" class="lzj_huo">
        <option value="">---------------</option>
        <%
        java.util.Enumeration e3 = AdminUsrRole.find(teasession._strCommunity,"",0,Integer.MAX_VALUE);
        while(e3.hasMoreElements())
        {
          String member = ((String)e3.nextElement());
          Profile p = Profile.find(member);
          out.print("<option value="+member);
          if(member.equals(pobj.getMember()))
          {
            out.print(" SELECTED ");
          }
          else if(teasession._rv.toString().equals(member))
          out.print(" SELECTED ");
          out.print(">"+p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage));
          out.print("</option>");
        }
        %>
        </select></td>
        <td width="4%" nowrap>备注：</td>
        <td width="80%" id="jin2"><input type="text" name="remarks" value="<%if(pobj.getRemarks()!=null)out.print(pobj.getRemarks());%>"  size="80"/></td>
    </tr>
  </table>
  <br>
  <input type="submit" value="生成成品" onclick="return f_submit();"/>&nbsp;
  <input type=button value="返回" onClick="javascript:history.back()">
  </form>
</body>
</html>
