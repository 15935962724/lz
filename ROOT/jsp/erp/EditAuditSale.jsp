<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter" %><%@page import="tea.resource.Resource" %><%@page import="tea.entity.eon.*" %><%@page import="tea.entity.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.ui.TeaSession" %><%@page import="java.text.*" %><%@page import="java.util.*" %><%@page import="tea.entity.admin.erp.*" %><%@page import="tea.entity.league.*" %> <%@include file="/jsp/include/Canlendar4.jsp" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

if("supplshow".equals(teasession.getParameter("act")))
{
  int supplnamehidden = 0;
  if(teasession.getParameter("supplnamehidden")!=null && teasession.getParameter("supplnamehidden").length()>0)
  {
    supplnamehidden = Integer.parseInt(teasession.getParameter("supplnamehidden"));
    LeagueShop lsobj = LeagueShop.find(supplnamehidden);

    java.util.Enumeration e = AdminUsrRole.find(teasession._strCommunity,"AND unit="+lsobj.getBumen(),0,Integer.MAX_VALUE);
    out.print("<select name=\"member2\" onchange=f_member2();> <option value=0>---------------</option>");
    while(e.hasMoreElements())
    {
      String armember = ((String)e.nextElement());
      Profile pobj = Profile.find(armember);
      String memberall="/"+armember+"/"+pobj.getTelephone(teasession._nLanguage)+"/"+pobj.getAddress(teasession._nLanguage)+"/";
      out.print("<option value="+memberall);
      out.print(">"+pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage));
      out.print("</option>");
    }
    out.print("</select>");
  }
  return;
}
SimpleDateFormat sdf1 = new  SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat sdf = new  SimpleDateFormat("yyyyMMdd");
Date timestring = new Date();
String trade = sdf.format(timestring) + SeqTable.getSeqNo("trade");
String nexturl = teasession.getParameter("nexturl");
String purid = teasession.getParameter("purid");
Paidinfull pobj =Paidinfull.find(purid);


%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>审核加盟店订单</title>
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
      <META HTTP-EQUIV="Expires" CONTENT="0">
        <body bgcolor="#ffffff"   <%if(purid!=null){out.print(" onload=l_ajax()");}%> >
        <script type="">
        //选择加盟店
        function f_c()
        {
          rs = window.showModalDialog('/jsp/erp/LookClient.jsp',self,'edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:875px;dialogHeight:605px;');
          if(rs!=null){
            form1.supplnamehidden.value= rs.split('/')[1]
            form1.supplname.value= rs.split('/')[2];
            sendx("?act=supplshow&supplnamehidden="+form1.supplnamehidden.value,
            function(data)
            {
              document.getElementById('supplshow').innerHTML=data;
            }
            );
            form1.telephone.value=='';
            form1.address.value=='';
            f_show(rs.split('/')[1],form1.purchase.value);
          }

        }
        //选择商品
        function f_xuanze()
        {
          if(form1.waridname.value==0)
          {
            alert("请先选择仓库！");
            form1.waridname.focus();

            return false;
          }
          //  var rs = window.showModalDialog('/jsp/erp/CalloutGoods2.jsp?supplname='+form1.waridname.value+'&rsgoods='+form1.rsgoods.value,self,'edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:857px;dialogHeight:605px;');
          var rs = window.showModalDialog('/jsp/erp/asGoods.jsp?supplname='+form1.supplnamehidden.value+'&waridname='+form1.waridname.value,self,'edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:857px;dialogHeight:605px;');
          if(rs!=null){
            gd_ajax(rs,0);
          }
        }


        //给商品细节表添加记录
        function gd_ajax(igd,t)
        {

          sendx("/jsp/erp/Goods_ajax.jsp?type="+t+"&discount=5&act=gDetailspai&node="+igd+"&purchase="+form1.purchase.value,
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

          sendx("/jsp/erp/paidinfull_ajax.jsp?war="+ form1.waridname.value+"&t2t11111111111=1&act=EditPurchase&purid="+form1.purchase.value,
          function(data)
          {
            document.getElementById('show').innerHTML=data;
            f_show(form1.supplnamehidden.value,form1.purchase.value);
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
        function f_quantity(igd2,igd3,floor,dis,f,gdid)
        {
          var c1 = igd3.split("/");
  var supply   =  document.all('supply'+igd2).value;        //<!--销售单价-->
  var discount =  document.all('discount'+igd2).value*0.1;  // <!--折扣-->
  var dsupply  =  document.all('dsupply'+igd2).value;       //<!--折后单价-->
  var quantity =  document.all('quantity'+igd2).value;      //数量quantity1获取的单个商品的数量
  var total_i    =  document.all('total'+igd2).value;         ///金额total1  <!--折扣乘以数量的价格总计-->
  var discount2 = document.all('discount2'+igd2).value;//商品打折


	   //判断输入的数量不能大于库存数量
	 //  sendx("/jsp/erp/Goods_ajax.jsp?act=co_ajaxInventory&warid="+form1.waridname.value+"&gdid="+gdid,
			//  function(data){

					// if(quantity>parseInt(data.trim()))
					// {
						// alert('您输入的销售商品数量大于了库存');
						// document.all('quantity'+igd2).value = data.trim();
						// document.all('quantity'+igd2).focus();
						// quantity=data.trim();
					// }
					 //如果不大于
					 if(f=='true'&&quantity*supply*discount>floor)
					 {
						 dsupply= supply*discount*dis*0.1;
						 total_i=quantity*supply*discount*dis*1;
						 discount2=dis*1;
					 }
					 else
					 {
						 dsupply= supply*discount;
						 total_i=quantity*supply*discount;
						 discount2="10";
					 }

					 document.all('dsupply'+igd2).value=(dsupply).toFixed(2);
					 document.all('total'+igd2).value=(total_i).toFixed(2);//打完折后的商品金额：显示的金额折后的获取的单个商品的 “数量乘以单价乘以” 打折数值 的金额
					 document.all('discount2'+igd2).value=discount2;
					 	   //修改商品中的供货价
					 sendx("/jsp/erp/Goods_ajax.jsp?act=Paidinfull&supply="+supply+"&quantity="+quantity+"&gdid="+gdid+"&discount="+document.all('discount'+igd2).value+"&dsupply="+dsupply+"&total_i="+total_i+"&discount2="+discount2,
					 function(data){f_total_2();});
					 var cs=0;
					 var cs2=0;
					 var ct2=0;
					 var cdz=0;
					 for(var i = 1;i<=c1.length;i++)
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


			//  }//结束于  function(data){
	  // );
        }
        //修改备注文字
        function f_rem(gdid,i)
        {
          var remarksarr = document.all('remarksarr'+i).value;
          sendx("/jsp/erp/Goods_ajax.jsp?act=remarksarr&gdid="+gdid+"&remarksarr="+encodeURIComponent(remarksarr),
          function(data){}
          );
        }



        //选择联系人 可以得到联系电话和地址
        function f_member2()
        {
          var a =form1.member2.value;
          if(a.split("/")[2]!=null){
            form1.telephone.value=a.split("/")[2];
          }
          if(a.split("/")[3]!=null){
            form1.address.value =a.split("/")[3];
          }
        }
        //显示下面的余额提示
        function f_total_2()
        {
          f_show(form1.supplnamehidden.value,form1.purchase.value);
        }
        function f_show(suppid,purchase)
        {

          sendx('/jsp/erp/Goods_ajax.jsp?act=f_show&suppid='+suppid+'&purchase='+purchase,
          function(data)
          {
            document.getElementById('f_shows').innerHTML=data;
          }
          );
        }



        function f_submit()
        {
          if(form1.supplname.value==0)
          {
            alert('请选择加盟店!');
            form1.supplname.focus();
            return false;
          }
          if(form1.waridname.value==0)
          {
            alert('请选择仓库!');
            form1.waridname.focus();
            return false;
          }
        }
        //选择仓库，计算库存
        function f_war()
        {
          l_ajax();

        }
          </script>

          <div id="lzi_rkd">
            <h1>审核加盟店订单</h1>
            <form action="/servlet/EditPaidinfull" method="POST" name="form1" onsubmit="return f_submit();">
            <input type="hidden" name="supplnamehidden" value="<%=pobj.getSupplname()%>"/>
            <input type="hidden" name="audit" value="EditAuditSale"/>
            <input type="hidden" name="rsgoods" value=""/>
            <input type="hidden" name="purid" value="<%=purid%>"/>
            <input type="hidden" name="act" value="EditPaidinfull"/>
            <input type="hidden" name="nexturl" value="<%=nexturl%>">

            <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
              <tr>
                <td width="9%">加盟店名称：</td>
                <td width="24%"><input type="text" name="supplname" value="<%  LeagueShop lsobj = LeagueShop.find(pobj.getSupplname());if(lsobj.getLsname()!=null){out.print(lsobj.getLsname());}%>"   style="background:#cccccc"  readonly> &nbsp;<input type="button" value="查找" onclick="f_c();"/></td>
                  <td nowrap>仓库名称：</td>
                  <td colspan="2"><select name="waridname" onchange="f_war();">
                    <option value="0">请选择仓库</option>
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

                <td nowrap>销售日期：</td>
                <td>
                  <input name="time_s" size="7"  value="<%if(pobj.getTime_sToString()!=null && pobj.getTime_sToString().toString().length()>0){out.print(pobj.getTime_sToString());}else{out.print(sdf1.format(timestring));}%>">
                  <img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar('<%=tea.entity.site.Community.getYear(10,"-")%>', '<%=tea.entity.site.Community.getYear(10,"+")%>', 0,'yyyy-MM-dd').show(time_s);" alt="" />
                </td>
                <td width="6%" nowrap>销售单号：</td>
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
                  <td align="center" nowrap>折扣</td>
                  <td align="center" nowrap>活动折扣</td>
                  <td align="center" nowrap>折后单价</td>
                  <td align="center" nowrap>数量</td>
                  <td align="center" nowrap>金额</td>
                  <td align="center" nowrap>备注</td>
                  <td align="center" nowrap>&nbsp;</td>
                </tr>
                <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''"  onclick="f_xuanze();" title="点击表格可以添加商品"  style="cursor:pointer">
                  <td align="center" colspan="15">暂无记录，请点击这里，来添加商品。</td>
                </tr>
              </table>
            </span>
            <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
              <tr>
                <td  nowrap>经办人：</td>
                <td id="jin1"><select name="member">
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
                  <span id="supplshow">
                    <select name="member2"  onchange=f_member2();>
                      <option value="0">---------------</option>
                      <%
                      LeagueShop lsobj2 = LeagueShop.find(pobj.getSupplname());
                      if(lsobj2.getBumen()>0){
                        java.util.Enumeration emember = AdminUsrRole.find(teasession._strCommunity,"AND unit="+lsobj2.getBumen(),0,Integer.MAX_VALUE);
                        while(emember.hasMoreElements())
                        {
                          String armember = ((String)emember.nextElement());
                          tea.entity.member.Profile pobj2 = tea.entity.member.Profile.find(armember);
                          String memberall="/"+armember+"/"+pobj2.getTelephone(teasession._nLanguage)+"/"+pobj2.getAddress(teasession._nLanguage)+"/";
                          out.print("<option value="+memberall);
                          if(armember.equals(pobj.getMember2()))
                          {
                            out.print(" selected");
                          }
                          out.print(">"+pobj2.getLastName(teasession._nLanguage)+pobj2.getFirstName(teasession._nLanguage));
                          out.print("</option>");
                        }
                      }
                      %>
                      </select>
                  </span>
                </td>
                <span id="member2show">
                  <td  nowrap>联系电话：</td>
                  <td id="jin1"><input type="text" name="telephone" value="<%if(pobj.getTelephone()!=null)out.print(pobj.getTelephone()); %>" size="11"></td>
                    <td  nowrap>联系地址：</td>
                    <td  id="jin2"><input type="text" name="address" value="<%if(pobj.getAddress()!=null)out.print(pobj.getAddress()); %>"  size="80"/></td>
                </span>
              </tr>
            </table>
            <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
              <tr>
                <td id="f_shows">&nbsp;</td>
              </tr>
            </table>
            <br>
            <input type="submit" value="审核订单"/>&nbsp;
            <input type=button value="返回" onClick="javascript:history.back()">
          </div>

            </form>

        </body>
</html>
