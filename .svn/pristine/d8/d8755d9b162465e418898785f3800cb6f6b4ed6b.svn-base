<%@page import="tea.ui.yl.shop.ProductStocks" %>
<%@page import="util.Config" %>
<%@page import="tea.db.DbAdapter" %>
<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.entity.yl.shop.*" %>
<%@page import="tea.entity.member.Profile" %>
<%@page import="tea.entity.yl.shopnew.InvoiceData" %>
<%@page import="tea.entity.yl.shopnew.Invoice" %>
<%@page import="tea.entity.admin.AdminUsrRole" %>
<%@ page import="tea.entity.admin.AdminRole" %>
<%@ page import="tea.entity.member.ModifyRecord" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%

    Http h = new Http(request, response);
    if (h.member < 1) {
        response.sendRedirect("/servlet/StartLogin?community=" + h.community);
        return;
    }

    StringBuffer sql = new StringBuffer();

    String orderId = h.get("orderId");
//根据订单id查询订单信息
    ShopOrder so = ShopOrder.findByOrderId(orderId);
    sql.append(" AND order_id=" + DbAdapter.cite(orderId));

    int sum = ShopOrderData.count(sql.toString());

    String nexturl = h.get("nexturl");
//上海管理员  14122306
    AdminUsrRole aur = AdminUsrRole.find(h.community, h.member);


    int crole = AdminRole.findByName("同辐订单管理员", "Home");//角色
    if (Config.getInt("gaoke") == so.getPuid()) {
        crole = AdminRole.findByName("高科订单管理员", "Home");//角色
    } else if (Config.getInt("junan") == so.getPuid()) {
        crole = AdminRole.findByName("君安订单管理员", "Home");//角色
    }
    Enumeration ce = AdminUsrRole.findByRole(crole);

    boolean isadmin = false;
    while (ce.hasMoreElements()) {
        int cpro = Integer.parseInt(String.valueOf(ce.nextElement()));
        if (cpro == h.member) {
            isadmin = true;
            break;
        }
    }
    if (h.member == 14100001) {
        isadmin = true;
    }


%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
</head>
<body>
<h1>订单详细</h1>

<%
    int tpflag = 0;
    String hdstr = "";
    String tmstr = "";
    int status = so.getStatus();

    String [] statusc = {"待确认","待发货","未出库","已出库","已完成","已取消","已删除","已退货"};
    String statusContent = statusc[status];
    //    if (status == 0){
//
//    }
//        statusContent = "等待付款";
//    else if (status == 4)
//        statusContent = "已完成";
//    else if (status == 5)
//        statusContent = "取消订单";

    ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(so.getOrderId());
    Profile p = Profile.find(so.getMember());//12.6新加 手机号更改为获取p的mobile，之前为获取sod的a_mobile；
    float price = so.getAmount().floatValue();
    Profile profile = Profile.find(so.getMember());
    ArrayList sodList = ShopOrderData.find(" AND order_id=" + Database.cite(so.getOrderId()), 0, Integer.MAX_VALUE);
    if (sodList.size() > 0) {
        ShopOrderData sorderdata = (ShopOrderData) sodList.get(0); //订单详细
        price += sorderdata.getAmount().floatValue();
    }
%>
<table id="tablecenter" cellspacing="0" style="margin-top:10px">
    <tr style="font-weight:bold;">
        <td colspan="4" align='left'>订单信息</td>
    </tr>
    <tr>
        <td width="10%" align='right'>订单编号</td>
        <td align='left'><%=MT.f(so.getOrderId()) %>
        </td>
        <td align='right'>下单时间</td>
        <td align='left'><%=MT.f(so.getCreateDate(), 1) %>
        </td>
    </tr>
    <tr>
        <td align='right'>当前状态</td>
        <td align='left'><%=MT.f(statusContent) %>
        </td>
        <td align='right'>支付方式</td>
        <td align='left'><%= ShopOrder.payTypeARR[so.getPayType()] %>
        </td>
    </tr>
    <%if(so.getOrderType()==1&&so.getPayType()!=0){%>
    <tr>
        <td align='right'>激活码状态</td>
        <td align='left'><%=MT.f(ShopOrder.jhpstastusARR[so.getJhpstastus()])%>
        </td>
        <td align='right'></td>
        <td align='left'>
        </td>
    </tr>
    <%}
        if (so.getStatus() == 5) {
    %>
    <tr>
        <td align='right'>取消订单原因</td>
        <td align='left'><%=MT.f(so.getCancelReason()) %>
        </td>
    </tr>
    <%
        }
    %>
    <tr style="font-weight:bold;">
        <td colspan="4" align='left'>收货人信息</td>
    </tr>
    <tr>
        <td align='right'>收货人姓名</td>
        <td align='left'><%=MT.f(sod.getA_consignees())%></td>
        <td align='right'>医院</td>
        <td align='left'><%=MT.f(sod.getA_hospital())%></td>
    </tr>
    <tr>
        <td align='right'>地址</td>
        <td align='left'><%=MT.f(sod.getA_address())%></td>
        <td align='right'>科室</td>
        <td align='left'><%=MT.f(sod.getA_department())%></td>
    </tr>
    <tr>
        <td align='right'>手机号</td>
        <td align='left'><%=MT.f(sod.getA_mobile())%></td>
        <td align='right'>邮箱</td>
        <td align='left'><%=MT.f(so.getMail())%></td>
    </tr>

    <tr style="font-weight:bold;">
        <td colspan="4" align='left'>开票信息</td>
    </tr>
    <tr>
        <td align='right'>是否开票</td>
        <td align='left'><%= (so.getIsinvoice() == 0 ? "否" : "是") %>
        </td>
        <td align='right'<%=so.getIsinvoice() == 0 ? "style='display: none'" : ""%> >是否补开</td>
        <td align='right'<%=so.getIsinvoice() == 0 ? "style='display: none'" : ""%> ><%if (so.getIsbkinvoice() == 0) {%>
            否
            <%} else {%>
            是
            <%}%></td>

    </tr>
    <tbody <%= (so.getIsinvoice() == 0 ? "style='display: none'" : "") %> >
    <tr>
        <td align='right'>名称</td>
        <td align='left'><%=MT.f(so.getInvoiceName())%>
        </td>
        <td align='right'>税号</td>
        <td align='left'><%=MT.f(so.getInvoiceDutyParagraph())%>
        </td>
    </tr>
    <tr>
        <td align='right'>地址省</td>
        <td align='left'><%=MT.f(so.getInvoiceProvinces())%>
        </td>
        <td align='right'>地址</td>
        <td align='left'><%=MT.f(so.getInvoiceAddress())%>
        </td>
    </tr>
    <tr>
        <td align='right'>电话</td>
        <td align='left'><%=MT.f(so.getInvoiceMobile())%>
        </td>
        <td align='right'>开户行</td>
        <td align='left'><%=MT.f(so.getInvoiceOpeningBank())%>
        </td>
    </tr>
    <tr>
        <td align='right'>账号</td>
        <td align='left'><%=MT.f(so.getInvoiceAccountNumber())%>
        </td>
        <td align='right'>费用名称</td>
        <td align='left'><%=MT.f(so.getInvoiceCostName())%>
        </td>
    </tr>
    </tbody>
    <%
        if (so.getStatus() == 3 || so.getStatus() == 4 || so.getStatus() == 7) {
            ShopOrderExpress soe = ShopOrderExpress.findByOrderId(so.getOrderId());

            if (so.getStatus() == 7) {
                soe = ShopOrderExpress.findByOrderId(so.getOldorderid());
            }
            if (soe.time != null) {
    %>
    <tr style="font-weight:bold;">
        <td colspan="4" align='left'>发货信息</td>
    </tr>
    <tr>
        <td nowrap align='right'>运单号</td>
        <td colspan="3" align='left'><%=MT.f(soe.express_code)%>
        </td>
    </tr>
    <tr>
        <td nowrap align='right'>销售编号</td>
        <td align='left'><%=MT.f(soe.NO1)%>
        </td>
        <td nowrap align='right'>生产批号</td>
        <td align='left'><%=MT.f(soe.NO2)%>
        </td>
    </tr>
    <tr>
        <td nowrap align='right'>发货日期</td>
        <td align='left'><%=MT.f(soe.time)%>
        </td>
    </tr>
    <tr>
        <td nowrap align='right'>发件人</td>
        <td align='left'><%=MT.f(soe.person)%>
        </td>
        <td nowrap align='right'>联系电话</td>
        <td align='left'><%=MT.f(soe.mobile)%>
        </td>

    </tr>
    <%
        if (MT.f(soe.express_img).length() > 0) {

            String imgsr = "";
            if (MT.f(soe.express_img).length() > 0) {
                String[] imgarr = soe.express_img.split(",");
                for (int i = 0; i < imgarr.length; i++) {
                    Attch attch = Attch.find(Integer.parseInt(imgarr[i]));
                    imgsr = attch.path;
                }
            }

            out.print("<tr><td nowrap align='right'>快递图片：</td><td align='left' colspan='3'><img src='" + imgsr + "' width='300px' height='300px' ></td></tr>");
        }

    %>
    <%
            }
        }
    %>


    <tr style="font-weight:bold;">
        <td colspan="4" align='left' style='border:none;padding-top:15px'>订单备注</td>
    </tr>
    <tr>
        <td colspan="4" align='left'
            style='color:red'><%out.print(so.getUserRemarks() == null || so.getUserRemarks().length() < 1 ? "无" : MT.f(so.getUserRemarks())); %></td>
    </tr>
    <%-- <%
        if(so.getIshidden()==1){
    %> --%>
    <%--<tr style="font-weight:bold;"><td colspan="4" align='left' style='border:none;padding-top:15px'>特殊备注</td></tr>
    <tr><td colspan="4" align='left' style='color:red'><%out.print(MT.f(so.getRemarks())); %></td></tr>--%>
    <%-- <%
        }
    %> --%>
</table>

<form name="form2" action="/ShopOrders.do" method="post" target="_ajax">
    <input type="hidden" name="orderId"/>
    <input type="hidden" name="status"/>
    <input type="hidden" name="nexturl" value="<%=nexturl%>"/>
    <input type="hidden" name="act"/>
    <%-- <%
        if(so.getIshidden()!=1){
    %> --%>
    <table id="tablecenter" cellspacing="0">
        <tr style="font-weight:bold;">
            <td colspan="9" align='left'>商品信息</td>
        </tr>
        <tr id="tableonetr">
            <td>商品编号</td>
            <td>商品图片</td>
            <td align='left'>商品名称</td>
            <%
                if (so.getOrderType() == 1) {
            %>
            <td>软件大小</td>
            <td>软件版本</td>
            <td>购买方式</td>
            <td>激活码</td>
            <%
                }
            %>
            <td>商品单价</td>
            <td>商品数量</td>
        </tr>
            <%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Profile pf = Profile.find(so.getMember());
  
  //根据订单id查询订单详情信息
  Iterator it=ShopOrderData.find(sql.toString(),0,Integer.MAX_VALUE).iterator();
  for(int i=1;it.hasNext();i++)
  {
	  ShopOrderData t=(ShopOrderData)it.next();
	  
	  //判断product_id是否商品的id，如果不是则为套装id；最后产品或套装中的商品存入list中
      int product_id=t.getProductId();
      ShopProduct sp = ShopProduct.find(product_id);
      ShopPackage spage = new ShopPackage(0);
      List<ShopProduct> spagePList = new ArrayList<ShopProduct>();
      if(t.getExpectedActivity()!=0){
    	  tpflag = 1;
      }
      hdstr = MT.f(t.getExpectedActivity());
      tmstr = MT.f(t.getExpectedDelivery());
      String pname = "";
	  if(sp.isExist){
		  pname=sp.getAnchor(h.language);
		  /* if(sp.model_id>0){
			  ShopProductModel spm = ShopProductModel.find(sp.model_id);
			  if(spm.getModel()!=null&&spm.getModel().length()>0){
				  ShopCategory sc = ShopCategory.find(spm.getCategory());
				  pname += "&nbsp;<span style='color:red;'>【"+MT.f(sc.attribute)+"："+spm.getModel()+"】</span>";
			  }
		  } */
		  if(t.getActivity()>0){
			  ShopCategory sc = ShopCategory.find(sp.category);
			  pname += "&nbsp;<span style='color:red;'>【"+MT.f(sc.attribute)+"："+t.getActivity()+"】</span>";
		  }
	  }else{
		  spage = ShopPackage.find(product_id);
		  pname="[套装]"+MT.f(spage.getPackageName());
		  spagePList.add(0,ShopProduct.find(spage.getProduct_id()));
		  String [] sarr = spage.getProduct_link_id().split("\\|");
		  for(int m=1;m<sarr.length;m++){
			  spagePList.add(m,ShopProduct.find(Integer.parseInt(sarr[m])));
		  }
	  }
	  out.println("<td>");
	  if(sp.isExist)
		  out.println(sp.yucode);
	  out.println("</td>");
	  out.println("<td style='text-align:center'>");
	  if(sp.isExist&&sp.picture!=null&sp.picture.length()>0)
		  out.println("<a href='/html/folder/14110010-1.htm?product="+sp.product+"' target='_blank'><img src='"+MT.f(sp.getPicture('b'))+"' alt="+sp.name[1]+" onerror='javascript:this.src=\"/tea/image/404.jpg\"' height='30'/></a>");
	  out.println("</td>");
	  out.println("<td>"+pname);
	  out.println("</td>");

	  if(so.getOrderType()==1){
            out.print("<td>"+MT.f(sp.color)+"</td>");
            out.print("<td>"+MT.f(sp.size)+"</td>");
            ShopCategory sc1 = ShopCategory.find(sp.category);
            ShopProductModel spm = ShopProductModel.find(sp.model_id);
            out.print("<td>"+sc1.name[1]+spm.getModel()+"</td>");
             List<JihuoUse>list_jihuo = JihuoUse.find("AND orderid="+DbAdapter.cite(t.getOrderId())+" AND productid="+t.getProductId(),0,Integer.MAX_VALUE);//根据订单和商品获取激活码使用记录
            if(list_jihuo.size()>0) {//有激活码
                String jihuo_code = JihuoCode.find(list_jihuo.get(0).getCodeid()).getCode();//获取激活码
                out.print("<td>"+MT.f(jihuo_code)+"</td>");
            }else {//无激活码
                    out.print("<td>暂无激活码</td>");

            }
        }

		  out.println("<td style='text-align:center;' class='redsize'><span style='font-size:13px;'>&yen;</span>"+MT.f((double)t.getUnit(),2)+"</td>");
		  out.println("<td style='text-align:center;'>"+t.getQuantity()+"</td>");
		  out.println("</tr>");

		  if(!sp.isExist){
			  for(int n=0;n<spagePList.size();n++){
				  ShopProduct s1 = spagePList.get(n);
				  String s1name = s1.getAnchor(h.language);
				  out.println("<tr class='tzP'><td style='text-align:right;'>"+s1.yucode+"</td>");
				  out.println("<td style='text-align:right;'>");
				  if(s1.picture!=null&s1.picture.length()>0)
					  out.println("<a href='/html/folder/14110010-1.htm?product="+s1.product+"' target='_blank'><img src='"+MT.f(s1.getPicture('b'))+"' alt="+s1.name[1]+" onerror='javascript:this.src=\"/tea/image/404.jpg\"' height='30'/></a>");
				  out.println("</td>");
				  out.println("<td style='text-align:right;'>"+s1name+"</td>");
				  out.println("<td style='text-align:right;text-decoration:line-through;'><span style='font-size:13px;'>&yen;</span>"+MT.f(s1.price,2)+"</td>");
				  out.println("<td>&nbsp;</td>");
				  out.println("<td style='text-align:right;'>"+t.getQuantity()+"</td>");
				  out.println("</tr>");
			  }
		  }


  }
  //商品总价改为开票金额
}

	%>
        <tr>
            <td colspan="9" class="tagsize" style="text-align: right;">
                商品总价：<span>&yen&nbsp;<%=MT.f((double) so.getAmount(), 2)%></span>
                &nbsp;&nbsp;&nbsp;&nbsp;
            </td>
        </tr>
            <%
out.print("</table>");

%>
        <%-- <%
            }
        %> --%>
        <!-- 订单状态为已出库或者已完成时，可以看到上海上传的质检报告 -->
        <div>
            <%
                int flag = 0;//不显示按钮 等于几就显示几个按钮
                int attchval = 0;
                StringBuffer strbutton = new StringBuffer();//拼接button里边的参数

                if (Config.getInt("tongfu") == so.getPuid()) {

                    String attchstr = "";
                    int cannum = 0;//参数个数
                    String button2 = "";
                    if (so.getStatus() == 3 || so.getStatus() == 4) {
                        ShopOrderExpress express = ShopOrderExpress.findByOrderId(so.getOrderId());
                        String img = MT.f(express.images);
                        attchstr = img;
                        if (img.length() > 0) {
                            String imgs[] = img.split(",");
                            cannum = imgs.length;

                            for (int i = 0; i < imgs.length; i++) {
                                flag++;
                                String image = imgs[i];
                                attchval = Integer.parseInt(image);
                                out.print("<img src='" + Attch.find(Integer.parseInt(image)).path + "'>");
                                if (i == imgs.length - 1) {
                                    strbutton.append(Attch.find(Integer.parseInt(image)).path);
                                    //strbutton.append("a");
						/* String aa=strbutton.toString();
						String[] arr=aa.split(",");
						String cans="";
						for(int a=0;a<arr.length;a++){
							
							button2="<button class='btn btn-primary' type='button'  onclick=downatt2('"+arr[0]+"','"+arr[1]+"')>下载质检报告</button>";
						} */

                                } else {
                                    strbutton.append(Attch.find(Integer.parseInt(image)).path + ",");
                                    //strbutton.append("b"+",");
                                    //button2="<button class='btn btn-primary' type='button'  onclick='downatt2()>下载质检报告</button>";
                                }


                            }
                        }
                    }

                }


            %>
        </div>

        <%
         List<ModifyRecord> modifyRecords = ModifyRecord.find(" AND order_id="+Database.cite(so.getOrderId())+" order by modifyTime ",0,Integer.MAX_VALUE);
        if(modifyRecords.size()>0){
            %>
        <table id="tablecenter" cellspacing="0">
            <tr style="font-weight:bold;"><td colspan="4" align='left'>订单日志</td></tr>
            <tr id="tableonetr">
                <td>操作人</td>
                <td>时间</td>
                <td>操作类型</td>
                <td>操作内容</td>
            </tr>
            <%
                for (ModifyRecord m: modifyRecords) {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");
                    String format = sdf.format(m.getModifyTime());
            %>
            <tr>
                <td><%=MT.f(Profile.find(m.getMember()).getMember())%></td>
                <td><%=MT.f(format)%></td>
                <td><%=MT.f(m.getContent())%></td>
                <td><%=MT.f(Profile.find(m.getMember()).getMember())+" "+format+" "+MT.f(m.getContent())+" "+MT.f(m.getContentDetail())%></td>
            </tr>
            <%}
            %>
        </table>
            <%
        }
        %>




        <div class="center mt15">
            <%
                if (flag > 0) {
                    if (flag == 1) {
            %>
            <button class="btn btn-primary" type="button" onclick="downatt('<%=MT.enc(attchval) %>')">下载质检报告</button>
            <%
            } else {
                //out.print(button2);
            %>
            <button class="btn btn-primary" type="button" onclick="downatt2('<%=strbutton.toString() %>')">下载质检报告
            </button>

            <%
                    }
                }
            %>
            <button class="btn btn-primary" type="button" onclick="printView('<%=orderId%>')">打印预览</button>
            &nbsp;<button class="btn btn-default" type="button" onclick="location='<%=nexturl%>'">返回</button>
        </div>
</form>
<form action="/Attchs.do" name="form3" method="post" target="_ajax">
    <input name="act" type="hidden" value="down"/>
    <input name="attch" type="hidden"/></div>
</form>
<script>
    function printView(orderId) {
        window.open("/jsp/yl/shop/ShopOrderDatasPrint.jsp?orderId=" + orderId);
    }

    function downatt(num) {
        form3.attch.value = num;
        form3.submit();
    }

    function downatt2(a) {


        var arr = a.split(",");

        arr.map(function (i) {
            var a = document.createElement('a');
            a.setAttribute('download', '');
            a.href = i;
            document.body.appendChild(a);
            a.click();
        })
    }
</script>
</body>
</html>
