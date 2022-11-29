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
String dibid = teasession.getParameter("dibid");
Complimentary pobj =Complimentary.find(dibid);
LeagueShop lsobj = LeagueShop.find(pobj.getLsid());

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

<form action="?" name="form1" method="POST"  >
<div id="lzi_rkd" style="border:0" >
  <table border="0" cellpadding="0" cellspacing="0" id="tableid1">
    <tr id="lzj_biao_xs">
      <td colspan="3" align="center">赠送单</td>
    </tr>
    <tr>
      <td nowrap >录单日期：<%=pobj.getTime_sToString() %></td>
      <td nowrap >单据编号：<%=dibid%></td>
       <td nowrap>赠送仓库：<%=Warehouse.find(pobj.getWarid()).getWarname()%></td>

    </tr>
    <tr>
     <td nowrap>经办人：<%

       if(pobj.getMember()!=null&&pobj.getMember().length()>0)
     {
       tea.entity.member.Profile p =tea.entity.member.Profile.find(pobj.getMember());
       String m11111 = p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage);
       if(m11111!=null)
       {
         out.print(m11111);
       }else
       {
         out.print(pobj.getMember());
       }
     }
     %></td>
      <td nowrap>赠送单位：<%=lsobj.getLsname()%></td>
      <td nowrap>联系方式：<%=pobj.getTelephone() %></td>
    </tr>
    <tr>
      <td>联系人：<%
     if(pobj.getMember2()!=null&&pobj.getMember2().length()>0)
     {
       tea.entity.member.Profile p2 =tea.entity.member.Profile.find(pobj.getMember2());
       String m = p2.getLastName(teasession._nLanguage)+p2.getFirstName(teasession._nLanguage);
       if(m!=null)
       {
         out.print(m);
       }else
       {
         out.print(pobj.getMember2());
       }
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
                <td align="center" nowrap>数量</td>
                <td align="center" nowrap>备注</td>
              </tr>
              <%
                 java.util.Enumeration e  = GoodsDetails.find(teasession._strCommunity," AND paid = "+DbAdapter.cite(dibid),0,Integer.MAX_VALUE);
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

                <td align="center" nowrap><%=gdobj.getQuantity()%></td>

                <td align="center" nowrap><%=gdobj.getRemarksarr()%></td>
              </tr>
              <%} %>
              <tr>
                <td align="right" colspan="6" nowrap><b>合计数量：</b></td>
                <td align="center" nowrap><%=pobj.getQuantity() %></td>
              </tr>

            </table>

<br>

  <input  id="printbutton1" type="button" value="打印" onClick="window.print();">&nbsp;
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
      var printbutton3=document.getElementById('printbutton3');
      function beforePrint()
      {
        printbutton1.style.display='none';
        printbutton3.style.display='none';
      }
      //打印之后将隐藏掉的信息再显示出来
      function afterPrint()
      {
        printbutton1.style.display='';
        printbutton3.style.display='';
        //  window.close();
      }

      　　</SCRIPT>

</div>


</body>
</html>
