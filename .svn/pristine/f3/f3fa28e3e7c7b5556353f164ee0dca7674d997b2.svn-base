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
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String purid = teasession.getParameter("purid");
Loss pobj = Loss.find(purid);

Profile p = Profile.find(pobj.getMember());
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>打印报损单信息</title>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<body bgcolor="#ffffff" >

<br>
<div id="lzi_rkd">

  <table border="0" cellpadding="0" cellspacing="0" id="tableid1">
    <tr id="lzj_biao_xs">
      <td colspan="3" align="center">报损单&nbsp;[&nbsp;操作员：&nbsp;<%=p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage) %>&nbsp;]</td>
    </tr>
    <tr>
      <td nowrap >报损日期：<%=pobj.getTime_sToString() %></td>
      <td nowrap >单据编号：<%=purid%></td>
      <td nowrap>经手人：<%=p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage) %></td>
    </tr>
    <tr>
      <td nowrap>报损仓库：<%=Warehouse.find(pobj.getWaridname()).getWarname() %></td>
      <td nowrap>供货单位：<%=Supplier.find(pobj.getSupplname()).getName(teasession._nLanguage)%></td>
      <td nowrap>附加说明：</td>
    </tr>
    <tr><td>摘要： </td>
    </tr>
  </table>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
              <tr id="tableonetr">
               <td align="center" nowrap>&nbsp;</td>
               <td align="center" nowrap>条形码或编号</td>
                <td align="center" nowrap>商品名称</td>
                <td align="center" nowrap>规格型号</td>
                <td align="center" nowrap>品牌</td>
                <td align="center" nowrap>单位</td>
                <td align="center" nowrap>数量</td>
                <td align="center" nowrap>金额</td>
              </tr>
              <%
              java.util.Enumeration e  = GoodsDetails.find(teasession._strCommunity," AND paid = "+DbAdapter.cite(purid),0,Integer.MAX_VALUE);
              for(int i = 1;e.hasMoreElements();i++)
              {
                int gdid = ((Integer)e.nextElement()).intValue();
                GoodsDetails gdobj = GoodsDetails.find(gdid);
                int nodeid = gdobj.getNode();
                Node nobj = Node.find(nodeid);
                Goods g=Goods.find(nodeid);

              %>


              <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
              <td align="center"><%=i %></td>
                <td align="center"><%=nobj.getNumber()%></td>
                <td align="center"><%=nobj.getSubject(teasession._nLanguage)%></td>
                <td align="center"><%=g.getSpec(teasession._nLanguage) %></td>
                <td align="center"><%
        Brand b=null;
        if(g.getBrand()>0&&(b=Brand.find(g.getBrand())).isExists())
        {
          if(b.getNode()>0)
             out.print(b.getName(teasession._nLanguage));
        }

        %></td>
                <td align="center"><%=g.getMeasure(teasession._nLanguage)%></td>
                <td align="center"><%=gdobj.getQuantity()%></td>
                <td align="center"><%=gdobj.getTotal()%>&nbsp;元</td>
              </tr>
          <tr>
          <%} %>
                <td colspan="5">&nbsp;</td>
                <td align="center" nowrap><b>合计数量和金额：</b></td>
                <td align="center"><%=pobj.getQuantity()%></td>
                <td align="center"><%=pobj.getTotal() %>&nbsp;元</td>
              </tr>

            </table>

<br />



 <input id="printbutton" name="按钮" type="button" onClick="window.print();" value="打印">
 <input id="printbutton2" type="button" value="关闭"  onClick="javascript:window.close();">

      <object  id="WebBrowser"  width=0  height=0  classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
      </object>


      <!-- document.all.WebBrowser.ExecWB(7,1); -->

      <script type="">
      //-----  下面是打印控制语句  ----------
      window.onbeforeprint=beforePrint;
      window.onafterprint=afterPrint;
      //打印之前隐藏不想打印出来的信息
      var printbutton=document.getElementById('printbutton');
       var printbutton2=document.getElementById('printbutton2');
      function beforePrint()
      {
        printbutton.style.display='none';
        printbutton2.style.display='none';
      }
      //打印之后将隐藏掉的信息再显示出来
      function afterPrint()
      {
        printbutton.style.display='';
         printbutton2.style.display='';
        //  window.close();
      }

      　　</SCRIPT>




</div>


</body>
</html>
