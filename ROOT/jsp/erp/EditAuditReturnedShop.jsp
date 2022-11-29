<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter" %><%@page import="tea.resource.Resource" %><%@page import="tea.entity.eon.*" %><%@page import="tea.entity.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.ui.TeaSession" %><%@page import="java.text.*" %><%@page import="java.util.*" %><%@page import="tea.entity.admin.erp.*" %><%@page import="tea.entity.league.*" %><%
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
int refundtype = 0;
if(teasession.getParameter("refundtype")!=null && teasession.getParameter("refundtype").length()>0)
{
  refundtype=Integer.parseInt(teasession.getParameter("refundtype"));
}

String purid = teasession.getParameter("purid");
ReturnedShop pobj =ReturnedShop.find(purid);
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>审核加盟店退货单</title>
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
  <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
  <META HTTP-EQUIV="Expires" CONTENT="0">
  <%@include file="/jsp/include/Canlendar4.jsp" %>
    <body bgcolor="#ffffff"   <%if(pobj.getRsgoods()!=null){out.print(" onload=l_ajax()");}%> >
    <script type="">
       //选择商品

       function f_xuanze()
       {
         var rs = window.showModalDialog('/jsp/erp/ReturnedShopGoods.jsp',self,'edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:857px;dialogHeight:605px;');
         if(rs!=null){
           gd_ajax(rs);
         }
         //form1.rsgoods.value = rs;
       }
       //给商品细节表添加记录
       function gd_ajax(igd)
       {
         sendx("/jsp/erp/Goods_ajax.jsp?act=gDetails&node="+igd+"&purchase="+form1.purchase.value,
         function(data)
         {
           if(data!=''&&data.length>1)
           {
             alert(data);
           }
           l_ajax();
         }
         );
       }
       //选择商品中的ajax
       function l_ajax(){
         sendx("/jsp/erp/purch_ajax.jsp?refundtype="+form1.refundtype.value+"&act=EditPurchase&purid="+form1.purchase.value,
         function(data)
         {
           document.getElementById('show').innerHTML=data;
         }
         );
       }
       //删除一个商品
       function f_delete(igd)
       {
         sendx("/jsp/erp/Goods_ajax.jsp?act=Gdelete&gdid="+igd,
         function(data)
         {
           if(data!=''&&data.length>0){
             alert(data);
             l_ajax();
           }
         }
         );
       }
        //ajax文件中的js方法
       function f_quantity(igd2,igd3,floor,dis,f)
       {
         var c1 = igd3.split("/");
         var supply   =  document.all('supply'+igd2).value;        //<!--销售单价-->
         var discount =  document.all('discount'+igd2).value*0.1;  // <!--折扣-->
         var dsupply  =  document.all('dsupply'+igd2).value;       //<!--折后单价-->
         var quantity =  document.all('quantity'+igd2).value;      //数量quantity1获取的单个商品的数量
         var total_i    =  document.all('total'+igd2).value;         ///金额total1  <!--折扣乘以数量的价格总计-->



         if(f=='true'&&quantity*supply*discount>floor)
         {
             dsupply= supply*discount*dis*0.1;
             total_i=quantity*supply*discount*dis*0.1;
         }else
         {
           dsupply= supply*discount;
           total_i=quantity*supply*discount;
         }



         document.all('dsupply'+igd2).value=(dsupply).toFixed(2);
         document.all('total'+igd2).value=(total_i).toFixed(2);//打完折后的商品金额：显示的金额折后的获取的单个商品的 “数量乘以单价乘以” 打折数值 的金额


         var cs=0;
         var cs2=0;
         var ct2=0;
         var cdz=0;
         for(var i = 1;i<c1.length-1;i++)
         {
           var s = document.all('supply'+i).value;
           var t = document.all('total'+i).value;//单个商品的价格
           var s1q = document.all('quantity'+i).value; //单个商品的数量
           var a = s*s1q;
           cs =  parseInt(s1q)+parseInt(cs);//数量合计
           cs2=  parseFloat(s)+parseFloat(cs2);//折前金额总计
           cdz =  parseFloat(t)+parseFloat(cdz);//折后金额总计

         }
         document.form1.quantity.value=cs;//数量
         document.form1.total.value=cs2.toFixed(2);//总计
         document.form1.total_2.value=cdz.toFixed(2);//总计
     }
     function f_w(igd)
     {
        form1.w.value= document.all('waridname'+igd).value;
     }
     function f_submit()
     {
       if(form1.w.value==0)
       {
         alert("请选择存放仓库！");
         return false;
       }
     }
       </script>
        <div id="lzi_rkd">
          <h1>审核加盟店退货单</h1>
          <form action="/servlet/EditReturnedShop" method="POST" name="form1" onsubmit="return f_submit();">
           <input type="hidden" name="rsgoods" value=""/>
            <input type="hidden" name="purid" value="<%=purid%>"/>
            <input type="hidden" name="act" value="EditReturnedShop"/>
            <input type="hidden" name="nexturl" value="<%=nexturl%>"/>
            <input type="hidden" name="refundtype" value="<%=refundtype%>"/>
            <input type="hidden" name="supplnamehidden" value="<%=pobj.getSupplname()%>"/>
            <input type="hidden" name="w"/>
            <input type="hidden" name="member2" value="0"/>
          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

            <tr>
              <td nowrap>加盟店名称：</td>
              <td >
                <%
                LeagueShop lsobj = LeagueShop.find(pobj.getSupplname());
                out.print(lsobj.getLsname());
                %>

              </td>
              <td nowrap>退货日期：</td>

               <td>
                 <input name="time_s" size="7" readonly="readonly" value="<%if(pobj.getTime_sToString()!=null && pobj.getTime_sToString().toString().length()>0){out.print(pobj.getTime_sToString());}else{out.print(sdf1.format(timestring));}%>">
              <img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar('<%=tea.entity.site.Community.getYear(10,"-")%>', '<%=tea.entity.site.Community.getYear(10,"+")%>', 0,'yyyy-MM-dd').show(time_s);" alt="" />
              </td>
                <td width="6%" nowrap>退货单号：</td>
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
                <td align="center" nowrap>单价</td>
                <td align="center" nowrap>数量</td>
                <td align="center" nowrap>金额</td>

              </tr>
              <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" style="cursor:pointer" onclick="f_xuanze();" title="点击表格可以添加商品">
               <td align="center" colspan="12">暂无记录，请点击这里，来添加商品。</td>
              </tr>
            </table>
          </span>
          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr>
              <td  nowrap>经办人：</td>
              <td id="jin1"><select name="member" class="lzj_huo">
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
                  } else if(teasession._rv.toString().equals(member)){
                    out.print(" SELECTED ");
                  }
                  out.print(">"+p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage));
                  out.print("</option>");
                }

                %>
                </select> </td>


                  <td  nowrap>备注：</td>
                  <td  id="jin2"><input type="text" name="remarks" value="<%if(pobj.getRemarks()!=null)out.print(pobj.getRemarks());%>"  size="80"/></td>
            </tr>
            <tr>
              <td  nowrap>联系人：</td>
              <td>
              <%
              if(pobj.getMember2()!=null){
                tea.entity.member.Profile pobj2 = tea.entity.member.Profile.find(pobj.getMember2());
                out.print(pobj2.getLastName(teasession._nLanguage)+pobj2.getFirstName(teasession._nLanguage));
              }
              %>
              </td>

              <td  nowrap>联系电话：</td>
              <td id="jin1"><input type="text" name="telephone" value="<%if(pobj.getTelephone()!=null)out.print(pobj.getTelephone()); %>" size="11"></td>
                <td  nowrap>联系地址：</td>
                <td  id="jin2"><input type="text" name="address" value="<%if(pobj.getAddress()!=null)out.print(pobj.getAddress()); %>"  size="80"/></td>

            </tr>
            <tr><td  nowrap>是否接受退货：</td>
              <td><input type="radio" value="1" name="type" checked="checked"/>&nbsp;接受退货&nbsp;&nbsp;<input type="radio" value="2" name="type"/>&nbsp;不接受退货</td>
</tr>

          </table>

          <br>
          <input type="submit" value="审核退货单"/>&nbsp;
          <input type=button value="返回" onClick="javascript:history.back()">
        </div>

          </form>

        </body>
</html>
