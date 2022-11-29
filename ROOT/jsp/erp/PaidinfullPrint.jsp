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
String paid = teasession.getParameter("paid");
Paidinfull pobj = Paidinfull.find(paid);
LeagueShop lsobj = LeagueShop.find(pobj.getSupplname());

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<body bgcolor="#ffffff">
<script type="">

function f_excel()
{
  form1.action='/servlet/ExportExcel';
//  //window.open('/servlet/ExportExcel')
  form1.submit();
  // var rs = window.showModalDialog('/servlet/ExportExcel?sql='+form1.sql.value+'&files='+encodeURIComponent(form1.files.value)+'&act='+form1.act.value,self,'edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:927px;dialogHeight:506px;');
}
</script>
<br>
<form action="?" name="form1" method="POST"  >
  <input type="hidden" name="sql" value="<%=paid%>">
  <input type="hidden" name="files" value="加盟店销售单">
  <input type="hidden" name="act" value="PaidinfullPrint">
<div id="lzi_rkd" style="border:0" >
  <table border="0" cellpadding="0" cellspacing="0" id="tableid1">
    <tr id="lzj_biao_xs">
      <td colspan="3" align="center">销售单</td>
    </tr>
    <tr>
      <td nowrap >录单日期：<%=pobj.getTime_sToString() %></td>
      <td nowrap >单据编号：<%=paid%></td>
       <td nowrap>发货仓库：<%=Warehouse.find(pobj.getWaridname()).getWarname()%></td>

    </tr>
    <tr>
     <td nowrap>经办人：<%tea.entity.member.Profile p =tea.entity.member.Profile.find(pobj.getMember());out.print(p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage)); %></td>
      <td nowrap>购买单位：<%=lsobj.getLsname()%></td>
      <td nowrap>联系方式：<%=pobj.getTelephone() %></td>
    </tr>
    <tr>
      <td>联系人：<%
     if(pobj.getMember()!=null)
     {
       tea.entity.member.Profile p2 =tea.entity.member.Profile.find(pobj.getMember());
       out.print(p2.getLastName(teasession._nLanguage)+p2.getFirstName(teasession._nLanguage));
     }
      %></td>
      <td>联系地址： <%=pobj.getAddress() %></td>


    </tr>
  </table>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
              <tr id="tableonetr">
              <td>&nbsp;</td>
               <td align="center" nowrap>条形码或编号</td>
                <td align="center" nowrap>商品名称</td>
                <td align="center" nowrap>规格型号</td>
                <td align="center" nowrap>品牌</td>
                <td align="center" nowrap>单位</td>
                <td align="center" nowrap>单价</td>
                <td align="center" nowrap>折扣</td>
                <td align="center" nowrap>活动打折</td>
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
                int n =gdobj.getNode();
                Node nobj = Node.find(n);
                Goods gobj=Goods.find(n);

              %>
              <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
              <td><%=i %></td>
                <td  nowrap><%=nobj.getNumber() %></td>
                <td  nowrap><%=nobj.getSubject(teasession._nLanguage) %></td>

                <td ><%=gobj.getSpec(teasession._nLanguage) %></td>
                 <td ><%
                Brand b=null;
                if(gobj.getBrand()>0&&(b=Brand.find(gobj.getBrand())).isExists())
                {
                  if(b.getNode()>0)
                  out.print(b.getName(teasession._nLanguage));
                }

                %></td>
                <td nowrap><%=gobj.getMeasure(teasession._nLanguage)%></td>
                <td align="center" nowrap><%=gdobj.getSupply()%></td>

                <td align="center"><%=gdobj.getDiscount()%>&nbsp;折</td>
                <td align="center"><%if(gdobj.getDiscount2()!=null)out.print(gdobj.getDiscount2());%>&nbsp;折</td>
                <td align="center" nowrap><%=gdobj.getDsupply()%></td>
                <td align="center" nowrap><%=gdobj.getQuantity()%></td>
                <td align="center" nowrap><%=gdobj.getTotal()%></td>
                <td align="center" nowrap><%=gdobj.getRemarksarr()%></td>
              </tr>
              <%} %>
              <tr>
                <td align="right"  colspan="6" nowrap><b>折前金额:</b></td>
                <td align="center" nowrap><%=pobj.getTotal() %>&nbsp;元</td>
                <td align="right" colspan="3" nowrap><b>折后数量和金额：</b></td>
                <td align="center" nowrap><%=pobj.getQuantity() %></td>
                <td align="center" nowrap><%=pobj.getTotal_2()%>&nbsp;元</td>
              </tr>

            </table>

            <br>
             <table border="0" cellpadding="0" cellspacing="0" id="tableid2">
               <tr>
                 <td>您的余额：   元。此单即为本年对账单，请在三日内验收签字回传，否则我公司将按此单确认</td>
               </tr>
                 <tr>
                 <td>此次商品中有     元商品在     前可调换一次，否则此次商品部在享受有退换的权利。</td>
               </tr>
          </table>

<br>

  <input  id="printbutton1" type="button" value="打印" onClick="window.print();">&nbsp;
  <input  id="printbutton2" type="button" value="导出Excel表"  onclick="f_excel();">&nbsp;
  <input  id="printbutton3" type="button" value="关闭"  onClick="javascript:window.close();">&nbsp;
</form>
<object  id="WebBrowser"  width=0  height=0  classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></object>


      <!-- document.all.WebBrowser.ExecWB(7,1); -->

      <script type="">
      //-----  下面是打印控制语句  ----------
      window.onbeforeprint=beforePrint;
      window.onafterprint=afterPrint;
      //打印之前隐藏不想打印出来的信息
      var printbutton1=document.getElementById('printbutton1');
      var printbutton2=document.getElementById('printbutton2');
      var printbutton3=document.getElementById('printbutton3');
      function beforePrint()
      {
        printbutton1.style.display='none';
        printbutton2.style.display='none';
        printbutton3.style.display='none';
      }
      //打印之后将隐藏掉的信息再显示出来
      function afterPrint()
      {
        printbutton1.style.display='';
        printbutton2.style.display='';
        printbutton3.style.display='';
        //  window.close();
      }

      　　</SCRIPT>

</div>


</body>
</html>
