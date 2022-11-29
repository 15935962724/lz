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
<%@page import="tea.entity.league.*" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String nexturl = teasession.getParameter("nexturl");
String paid =teasession.getParameter("paid");

Paidinfull pobj = Paidinfull.find(paid);
LeagueShop lsobj = LeagueShop.find(pobj.getSupplname());
Warehouse warobj = Warehouse.find(pobj.getWaridname());


%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/erp.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>库房发货</title>
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
      <META HTTP-EQUIV="Expires" CONTENT="0">
        <body bgcolor="#ffffff">
<script>
   f_show('<%=pobj.getSupplname()%>','<%=paid%>');
function f_submit()
{
  if(form1.deltype.value==0)
  {
    alert("发货选择不能为空");
    form1.deltype.focus();
    return false;
  }

  else
  {
    if(form1.deltype2.value=='')
    {
      var s = null;
      if(form1.deltype.value==1)//物流
      {
        s='物流电话';
      }else if(form1.deltype.value==2)//
      {
        s='快递单号';
      }else if(form1.deltype.value==3)//
      {
        s='司机电话';
      }
      else if(form1.deltype.value==4)//
      {
        s='提货人';
      }
      alert(s+'不能为空');
      form1.deltype2.focus();
      return false;
    }
  }
  if(form1.city.value=='')
  {
    alert('省(州)不能为空');
    form1.city.focus();
    return false;
  }
  if(form1.address.value=='')
  {
    alert('收货地址不能为空');
    form1.address.focus();
    return false;
  }
  if(form1.consignee.value=='')
  {
    alert('收货人不能为空');
    form1.consignee.focus();
    return false;
  }
  if(form1.zip.value=='')
  {
    alert('邮编不能为空');
    form1.zip.focus();
    return false;
  }
  if(form1.telephone.value=='')
  {
    alert('电话不能为空');
    form1.telephone.focus();
    return false;
  }

}
function f_deltype()
{
  var deltype=document.getElementById('delid1');
  if(form1.deltype.value==1)//物流
  {
    document.getElementById('delid2').innerHTML='物流电话：';
    deltype.style.display='';
  }else if(form1.deltype.value==2)//
  {
    document.getElementById('delid2').innerHTML='快递单号：';
    deltype.style.display='';
  }else if(form1.deltype.value==3)//
  {
    document.getElementById('delid2').innerHTML='司机电话：';
    deltype.style.display='';
  }
  else if(form1.deltype.value==4)//
  {
    document.getElementById('delid2').innerHTML='提货人：';
    deltype.style.display='';
  } else if(form1.deltype.value==0)//
  {

    deltype.style.display='none';
  }
}
</script>
        <div id="lzi_rkd">
          <h1>库房发货订单详细</h1>
          <form action="/servlet/EditPaidinfull" method="POST" name="form1" ><!-- onsubmit="return f_submit();" -->
          <input type="hidden" name="act" value="DeliveryDetail"/>
          <input type="hidden" name="purid" value="<%=paid%>"/>
          <input type="hidden" name="nexturl" value="<%=nexturl%>"/>
          <h2>商品信息</h2>
          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr>
              <td nowrap>销售单号：</td>
              <td nowrap><%=paid %></td>
              <td nowrap>加盟店名称：</td>
              <td nowrap><%=lsobj.getLsname() %></td>
            </tr>
            <tr>
              <td nowrap>仓库名称：</td>
              <td nowrap><%=warobj.getWarname()%></td>
              <td nowrap>销售日期：</td>
              <td nowrap><%=pobj.getTime_sToString()%></td>
            </tr>
          </table>
          <span id="show">
            <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
              <tr id="tableonetr">
                <td align="center" nowrap>条形码或编号</td>
                <td align="center" nowrap>商品名称</td>
                <td align="center" nowrap>规格型号</td>
                <td align="center" nowrap>品牌</td>
                <td align="center" nowrap>单位</td>
                <td align="center" nowrap>单价</td>
                <td align="center" nowrap>折扣</td>
                 <td align="center" nowrap>活动折扣</td>
                <td align="center" nowrap>折后单价</td>
                <td align="center" nowrap>数量</td>
                <td align="center" nowrap>金额</td>
                 <td align="center" nowrap>备注</td>
              </tr>
              <%
              java.util.Enumeration e  = GoodsDetails.find(teasession._strCommunity," AND paid = "+DbAdapter.cite(paid),0,Integer.MAX_VALUE);
              for(int i = 1;e.hasMoreElements();i++)
              {
                int gdid = ((Integer)e.nextElement()).intValue();
                GoodsDetails gdobj = GoodsDetails.find(gdid);
                int nodeid = gdobj.getNode();
                Node nobj = Node.find(nodeid);
                Goods gobj=Goods.find(nodeid);


              %>
             <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
                  <td align="center"><%=nobj.getNumber() %></td>
                  <td ><%=nobj.getSubject(teasession._nLanguage) %></td>
                  <td align="center"><%=gobj.getSpec(teasession._nLanguage) %></td>
                  <td align="center"><%
                  Brand b=null;
                  if(gobj.getBrand()>0&&(b=Brand.find(gobj.getBrand())).isExists())
                  {
                    if(b.getNode()>0)
                    out.print(b.getName(teasession._nLanguage));
                  }

                  %></td>
                  <td align="center"><%=gobj.getMeasure(teasession._nLanguage)%></td>
                  <td align="center"><%=gdobj.getSupply() %></td>
                  <td align="center"><%=gdobj.getDiscount() %>&nbsp;折</td>
                  <td align="center"><%=gdobj.getDiscount2()%>&nbsp;折</td>
                   <td align="center"><%=gdobj.getDsupply()%></td>
                  <td align="center"><%=gdobj.getQuantity()%></td>
                  <td align="center"><%=gdobj.getTotal().trim()%>&nbsp;元</td>
                  <td align="center"><%=gdobj.getRemarksarr()%></td>
                </tr>
              <%} %>
              <tr>

                <td  colspan="5" align="right"><b>折前合计金额:</b></td>
                <td align="center"><%=pobj.getTotal()%>&nbsp;元</td>

                <td colspan="3" align="right"><b>折后合计数量和金额：</b></td>
                <td align="center"><%=pobj.getQuantity()%></td>
                <td align="center" ><%=pobj.getTotal_2()%>&nbsp;元</td>
                  <td align="center">&nbsp;</td>
              </tr>

            </table>
          </span>
          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr>
              <td nowrap>经办人：</td>
              <td  id="jin1"><%
             Profile pobj1 = Profile.find(pobj.getMember());
             out.print(pobj1.getLastName(teasession._nLanguage)+pobj1.getFirstName(teasession._nLanguage));
              %> </td>
              <td nowrap>联系人：</td>
              <td  id="jin1"><%
              if(pobj.getMember2()!=null){
                Profile pobj2 = Profile.find(pobj.getMember2());
                out.print(pobj2.getLastName(teasession._nLanguage)+pobj2.getFirstName(teasession._nLanguage));
              }
              %>  </td>
              </tr>
              <tr>

              <td nowrap>备注：</td>
              <td  id="jin2" colspan="3"><%=pobj.getRemarks()%></td>
            </tr>
          </table>
          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr>
              <td id="f_shows">&nbsp;</td>
            </tr>
          </table>

          <%
          tea.entity.util.Card  c1 =tea.entity.util.Card.find(lsobj.getProvince());//省
          tea.entity.util.Card  c2 =tea.entity.util.Card.find(lsobj.getCity());//市
          %>
          <h2>收货地址</h2>
          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
          <tr>
          <td nowrap><font color="red">*</font>&nbsp;发货选择:</td>
          <td>
          <select name="deltype" onclick="f_deltype();">
          <option value="0">--------</option>
          <%
          for(int i =1;i<Paidinfull.DEL_TYPE.length;i++)
          {
            out.print("<option value="+i);
            if(pobj.getDeltype()==i)
            {
              out.print("selected");
            }
            out.print(">"+Paidinfull.DEL_TYPE[i]);
            out.print("</option>");
          }
          %>
          </select>&nbsp;<span id="delid1"  style="display:none" >&nbsp;<span id=delid2>&nbsp;</span><input type="text" name="deltype2" value=""/></span>
          </td>
          </tr>
            <tr>
              <td nowrap><font color="red">*</font>&nbsp;省(州)：</td>
              <td  id="jin1"><input type="text" name="city" value="<%if(pobj.getCity()!=null){out.print(pobj.getCity());}else{out.print(c1.getAddress()+c2.getAddress());}%>" ></td>
            </tr>
            <tr>
              <td nowrap><font color="red">*</font>&nbsp;收货地址</td>
              <td  id="jin1"><input type="text" name="address" value="<%
              if(pobj.getShipaddress()!=null){out.print(pobj.getShipaddress());}
              else if(lsobj.getRegion()!=null){out.print(lsobj.getRegion());}
              else if(lsobj.getPort()!=null){out.print(lsobj.getPort());}
              else if(lsobj.getNumber()!=null){out.print(lsobj.getNumber());}
              %>" size="70"></td>
            </tr>
            <tr>
              <td nowrap><font color="red">*</font>&nbsp;收货人</td>
              <td  id="jin2"><input type="text" name="consignee" value="<%if(pobj.getConsignee()!=null){out.print(pobj.getConsignee());}else  if(lsobj.getLsname() !=null){out.print(lsobj.getLsname());}%>" ></td>
            </tr>
            <tr>
              <td nowrap><font color="red">*</font>&nbsp;收货人邮编：</td>
              <td  id="jin2"><input type="text" name="zip" value="<%if(pobj.getZip()!=null)out.print(pobj.getZip());%>" size="6"></td>
            </tr>
            <tr>
              <td nowrap><font color="red">*</font>&nbsp;收货人电话：</td>
              <td  id="jin2"><input type="text" name="telephone" value="<% if(pobj.getTel()!=null&&pobj.getTel().length()>0){out.print(pobj.getTel());}else{out.print(lsobj.getLsbuytel());}%>" ></td>
            </tr>
            <tr>
              <td nowrap><font color="red">*</font>&nbsp;发货时间：</td>
              <td  id="jin2"><%
              Date stime = new Date();
              if(pobj.getStime()!=null)
              {
                stime = pobj.getStime();
              }
             out.print(new tea.htmlx.TimeSelection("stime", stime));
              %></td>
            </tr>
            <tr>
              <td nowrap><font color="red">*</font>&nbsp;预计到达时间：</td>
              <td  id="jin2"><%
              Date ftime=new Date(System.currentTimeMillis()+(1000*60*60*24*3));//*3L三天的
              if(pobj.getFtime()!=null)
              {
                ftime = pobj.getFtime();
              }
              out.print(new tea.htmlx.TimeSelection("ftime", ftime));
              %></td>
              </tr>
          </table>
          <br>
          <input type="submit" value="发货完成"/>&nbsp;
          <input type=button value="返回" onClick="javascript:history.back()">
        </div>

          </form>

        </body>
</html>
