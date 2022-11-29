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
String trade = sdf.format(timestring) + SeqTable.getSeqNo("trade");
String nexturl = teasession.getParameter("nexturl");
String purid = teasession.getParameter("purid");
Purchase pobj = Purchase.find(purid);
pobj.getRsgoods();
if("delete".equals(teasession.getParameter("act")))
{
  pobj.delete();
  response.sendRedirect(nexturl);
  return;
}
int flowtype = 0;
if(teasession.getParameter("flowtype")!=null&&teasession.getParameter("flowtype").length()>0)
{
  flowtype = Integer.parseInt(teasession.getParameter("flowtype"));
}
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css" onsubmit="return f_submit();">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>半成品采购单</title>
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
      <META HTTP-EQUIV="Expires" CONTENT="0">
        <%@include file="/jsp/include/Canlendar4.jsp" %>
        <body bgcolor="#ffffff"  <%if(pobj.getRsgoods()!=null){out.print(" onload=l_ajax()");}%> >
        <script type="">
        function f_submit()
        {
          if(form1.supplname.value==0)
          {
            alert('请选择供货商!');
            form1.supplname.focus();
            return false;
          }
          if(form1.waridname.value==0)
          {
            alert('请选择仓库!');
            form1.waridname.focus();
            return false;
          }
          if(form1.member.value=='')
          {
            alert('请选择经办人!');
            form1.member.focus();
            return false;
          }
        }


        function f_xuanze()
        {
          if(form1.supplname.value==0)
          {
            alert('请选择供货商!');
            form1.supplname.focus();
            return false;
          }
          if(form1.waridname.value==0)
          {
            alert('请选择仓库!');
            form1.waridname.focus();
            return false;
          }
          if(form1.member.value=='')
          {
            alert('请选择经办人!');
            form1.member.focus();
            return false;
          }
          var rs = window.showModalDialog('/jsp/erp/semi/Goods2.jsp?sid='+form1.supplname.value+'&rsgoods='+form1.rsgoods.value,self,'edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:857px;dialogHeight:605px;');
          if(rs!=null)
          {
            gd_ajax(rs);
          }
        }

        //给商品细节表添加记录
        function gd_ajax(ssid)
        {
          sendx("/jsp/erp/semi/SemiGoods_ajax.jsp?act=sgDetails&ssid="+ssid+"&purchase="+form1.purchase.value,
          function(data)
          {
            if(data!=''&&data.length>1)
            {
              alert(data);
              return false;
            }
            l_ajax();
          }
          );
        }

        //选择商品中的ajax
        function l_ajax(){

          var str="Semipurch_ajax2.jsp";
          if(<%=flowtype%>==3)
          {
            str="Semipurch_ajax4.jsp";
          }
          sendx("/jsp/erp/semi/"+str+"?act=EditPurchase&type=2&purid="+form1.purchase.value,
          function(data)
          {
            document.getElementById('show').innerHTML=data;
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

        //purch_ajax.jsp 中的方法
        function f_quantity(igd,igd2,igd3)
        {
          var c1 = igd3.split("/");
          var supply   =  document.all('supply'+igd2).value;        //<!--销售单价-->
          var quantity =  document.all('quantity'+igd2).value;      //数量quantity1获取的单个商品的数量
          var total_i    =  document.all('total'+igd2).value;         ///金额total1  <!--折扣乘以数量的价格总计-->
          //         alert(document.form1.elements(s1).value);
          var quantitymin = document.all('quantitymin'+igd2).value;
          if(parseInt(quantity)<parseInt(quantitymin))
          {
            document.all('quantity'+igd2).value=quantitymin;
            alert("不能少于最小进货数量");
            return false;
          }
          document.all('total'+igd2).value=quantity*igd;//显示的金额
          //显示的 数量
          var cs=0;
          var cs2=0;
          for(var i = 1;i<c1.length-1;i++)
          {
            cs =  parseInt(document.all('quantity'+i).value)+parseInt(cs);//数量
            cs2=  parseFloat(document.all('total'+i).value)+parseFloat(cs2);//总计
            //             alert( document.form1.elements('total'+i).value+cs2);
          }
          document.form1.quantity.value=cs;//数量
          document.form1.total.value=cs2;//总计
        }
        function f_quantity2(igd,igd2,igd3)//到货数量
        {

          var c1 = igd3.split("/");
          var supply   =  document.all('supply'+igd2).value;        //<!--销售单价-->
          var quantity =  document.all('quantity'+igd2).value;      //数量quantity1获取的单个商品的数量
          var total_i    =  document.all('total'+igd2).value;         ///金额total1  <!--折扣乘以数量的价格总计-->

          var quantitymm = document.all('quantitymm'+igd2).value;

          if(parseInt(quantity)>parseInt(quantitymm))
          {
            document.all('quantity'+igd2).value=quantitymm;
            alert("不能大于进货数量！");
            return false;
          }
          document.all('total'+igd2).value=quantity*igd;//显示的金额
          //显示的 数量
          var cs=0;
          var cs2=0;
          for(var i = 1;i<c1.length-1;i++)
          {
            cs =  parseInt(document.all('quantity'+i).value)+parseInt(cs);//数量
            cs2=  parseFloat(document.all('total'+i).value)+parseFloat(cs2);//总计
          }
          document.form1.quantity.value=cs;//数量
          document.form1.total.value=cs2;//总计
        }

        function f_submit()
        {
          if(form1.supplname.value==0)
          {
            alert('请选择供货商!');
            form1.supplname.focus();
            return false;
          }
          if(form1.waridname.value==0)
          {
            alert('请选择仓库!');
            form1.waridname.focus();
            return false;
          }
          if(form1.member.value==0)
          {
            alert('请选择经办人!');
            form1.member.focus();
            return false;
          }
        }
        </script>
        <div id="lzi_rkd">


          <h1><%if(flowtype==0)
        {
          %>
         半成品采购单
          <%
        }

        if(flowtype==1)
        {
          %>
          审核采购单
          <%
        }if(flowtype==2)
        {
          %>
          已审核未到货
          <%
        }
        %></h1>
          <form action="/servlet/EditSemiGoods" method="POST" name="form1" onsubmit="return f_submit();">
          <input type="hidden" name="act" value="EditSemiGoods"/>
          <input type="hidden" name="nexturl" value="<%=nexturl%>"/>
          <input type="hidden" name="rsgoods" value=""/>
          <input type="hidden" name="flowtype"  value="<%=flowtype%>"/>
          <input type="hidden" name="purid" value="<%=purid%>"/>

          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr>
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
                    if(pobj.getSupplname()==sid)
                    {
                      out.print(" SELECTED");
                    }
                    out.print(">"+sobj.getName(teasession._nLanguage));
                    out.print("</option>");
                  }
                  %>
                  </select>      </td>


                  <td nowrap>仓库名称：</td>
                  <td colspan="2"><select name="waridname" class="lzj_huo">

                    <option value="0">---------------</option>
                    <%
                    java.util.Enumeration e2 = Warehouse.find(teasession._strCommunity,"",0,Integer.MAX_VALUE);
                    while (e2.hasMoreElements())
                    {
                      int warid = ((Integer)e2.nextElement()).intValue();
                      Warehouse warobj = Warehouse.find(warid);
                      out.print("<option value= "+warid);
                      if(pobj.getWaridname()==warid)
                      {
                        out.print(" selected");
                      }
                      out.print(">"+warobj.getWarname());
                      out.print("</option>");
                    }
                    %>
                    </select>
                  </td>
            </tr>
            <tr>

              <td nowrap>入库日期：</td>
              <td>

                <input name="time_s" size="7"  value="<%if(pobj.getTime_sToString()!=null && pobj.getTime_sToString().toString().length()>0){out.print(pobj.getTime_sToString());}else{out.print(sdf1.format(timestring));}%>">
                <img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar('<%=tea.entity.site.Community.getYear(10,"-")%>', '<%=tea.entity.site.Community.getYear(10,"+")%>', 0,'yyyy-MM-dd').show(time_s);" alt="" />
              </td>
              <td width="6%" nowrap>入库单号：</td>
              <td width="29%"><input type="text" name="purchase" id="ruku" value="<%if(purid!=null){out.print(purid);}else{out.print(trade);}%>" readonly="readonly" style="background:#cccccc"></td>
            </tr>
          </table>
          <span id="show">
            <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
              <tr id="tableonetr">
                <td align="center" nowrap>商品编号</td>
                <td align="center" nowrap>商品名称</td>
                <td align="center" nowrap>规格型号</td>
                <td align="center" nowrap>品牌</td>
                <td align="center" nowrap>单位</td>
                <td align="center" nowrap>进货价</td>
                <td align="center" nowrap>数量</td>
                <td align="center" nowrap>金额</td>
              </tr>
              <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''"  onclick="f_xuanze();" title="点击表格可以添加商品"  style="cursor:pointer">
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
             <%
            if(flowtype==1){
              %>
              <tr>
                <td colspan="4">是否同意此采购单:&nbsp;&nbsp;
                  <input type="radio" name="noyestype" value="1" checked>&nbsp;同意&nbsp;
                  <input type="radio" name="noyestype" value="0">&nbsp;不同意&nbsp;(注:如果选择不同意,此次采购单会自动删除.)
                </td>
              </tr>
              <%}%></tr>
          </table>
          <br>
          <%
          if(flowtype==0)
          {
            out.print(" <input type=\"submit\" value=\"保存采购订单\"/>");
          }else if(flowtype==1)
          {
            out.print(" <input type=\"submit\" value=\"审核采购订单\"/>");
          }else if(flowtype==2 || flowtype==3)
          {
            out.print(" <input type=\"submit\" value=\"审核入库\"/>");
          }
          %>

          <input type=button value="返回" onClick="javascript:history.back()">
          </form>
        </body>
</html>
