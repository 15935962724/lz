<%@page import="util.Config"%>
<%@page import="tea.entity.MT"%>
<%@page import="tea.entity.*"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.Http"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@ page import="tea.entity.yl.shop.*" %>
<%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}
String act=h.get("act","");
StringBuffer sql=new StringBuffer(),par=new StringBuffer();

sql.append(" AND member="+h.member);
par.append("?member="+h.member);

int menuid=h.getInt("id");
int seid=h.getInt("seid");
if(request.getMethod().equals("POST")){
	if("finish".equals(act)){
		ShopExchanged.find(seid).set("status","1");
	}
}
int tab=h.getInt("tab");
par.append("&tab="+tab);


//按医院查询

String hname=h.get("hname","");
if(hname.length()>0){
	sql.append(" and order_id in (select order_id from shoporderdispatch where a_hospital like "+Database.cite("%"+hname+"%")+")");
	par.append("&hname="+h.enc(hname));
}
String orderId=h.get("orderId","");
if(orderId.length()>0)
{
sql.append(" AND order_Id LIKE "+Database.cite("%"+orderId+"%"));
par.append("&orderId="+h.enc(orderId));
}

Date time0=h.getDate("time0");
if(time0!=null)
{
	sql.append(" AND time>="+DbAdapter.cite(time0));
	par.append("&time0="+time0);
}
Date time1=h.getDate("time1");
if(time1!=null)
{
	sql.append(" and time<"+DbAdapter.cite(time1));
	par.append("&time1="+time1);
}

int puid = h.getInt("puid",-1);
if(puid!=-1){
	sql.append(" AND puid = "+puid);
	  par.append("&puid="+puid);
}

String[] TAB={"全部","待退货","已完成","待确认","已拒绝"};
String[] SQL={""," AND status=0"," AND (status =1 or (status=2 and exchangedstatus!=0))"," AND status=2 and exchangedstatus=0"," AND status=3 "};
int pos=h.getInt("pos");
par.append("&pos=");
int size=20;
int count=ShopExchanged.count(sql.toString());

%>
<!DOCTYPE html><html><head>

<!-- <link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>-->
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<link rel="stylesheet" href="/tea/new/css/style.css">
<script src="/tea/new/js/jquery.min.js"></script>
<script src="/tea/new/js/superslide.2.1.js"></script>
<script src="/tea/yl/mtDiag.js"></script>
<style>
    .con-left .bd:nth-child(2){
        display:block;
    }
    .con-left .bd:nth-child(2) li:nth-child(2){
        font-weight: bold;
    }
    .right-tab th,.right-tab td{padding:0px 5px;}
	.con-left-list .tit-on1{color:#044694;}
</style>
</head>
<body style='min-height:800px;'>
<%@ include file="/jsp/yl/shopweb/PersonalTop.jsp" %>
<div id="Content">
    <div class="con-left">
        <%@ include file="/jsp/yl/shopweb/PersonalLeft.jsp" %>
    </div>
    <div class="con-right">
        <div class="con-right-box">
            <form name="form1" action="?">
            <input type="hidden" name="tab" value="<%=tab%>"/>
            <div class="right-line1">
                <p>
                    <span>医　　院：</span>
                    <span style="width:283px;display: inline-block">
						<input type="text" name="hname" class="right-box-data" id="hname" value="<%=hname %>" readonly style="width:202px;"/>
						<input id="hospitalsel" class="right-search" style="border: 1px solid #dadada;float: none;margin: 0px;height: 32px;background: #ececec;color: #333;
						line-height: 31px;" onclick="layer.open({type: 2,title: '选择医院',shadeClose: true,offset:'100px',area: ['60%', '580px'],closeBtn:1,content: '/jsp/yl/shopwebnew/Selhospital.jsp'});" type="button" value="请选择"/>
					</span>

                    <span>　　　　订单编号：</span>
                    <input type="text" class="right-box-inp" name="orderId" value="<%=MT.f(orderId)%>" style="width:329px;"/>
                </p>
                <p>
                    <span>开票单位：</span>
                    <select name='puid' style="width:282px;"  class="right-box-yy">
                        <option value=''>请选择</option>
                        <option <%= (puid==Config.getInt("tongfu")?"selected='selected'":"") %> value='<%= Config.getInt("tongfu") %>'>同辐</option>
                        <option <%= (puid==Config.getInt("gaoke")?"selected='selected'":"") %> value='<%= Config.getInt("gaoke") %>'>高科</option>
                        <option <%= (puid==Config.getInt("junan")?"selected='selected'":"") %> value='<%= Config.getInt("junan") %>'>君安</option>
                    </select>
                    <span>　　　　下单时间：</span>
                    <input name="time0" value="<%=MT.f(time0)%>" onclick="mt.date(this)" class="right-box-data1"/>
                    <span style="padding:0 8px">至</span>
                    <input name="time1" value="<%=MT.f(time1)%>" onclick="mt.date(this)" class="right-box-data1"/>

                </p>
            </div>
            <input type="submit" class="right-search" value="查询">
            </form>
        </div>
        <div class="right-list">

            <form name="form2" action="?" method="post">
                <input type="hidden" name="nexturl"/>
                <input type="hidden" name="act"/>
                <input type="hidden" name="seid"/>
                <input type="hidden" name="orderId"/>
                <input type="hidden" name="id" value="<%=menuid %>"/>
                <%
                    out.print("<ul class='right-list-zt'>");
                    for(int i=0;i<TAB.length;i++)
                    {
                        out.print("<li><a href='javascript:mt.tab("+i+")' class='"+(i==tab?"current":"")+"'>"+TAB[i]+"("+ShopExchanged.count(sql.toString()+SQL[i])+")</a></li>");
                    }
                    out.print("</div>");
                %>
                <div class='results'>
                    <table class="right-tab" border="1" cellspacing="0">
                        <tr id="tableonetr">
                            <th align="center">序号</th>
                            <th align="center">订单编号</th>
                            <!--th align="center">退货单编号</th-->
                            <th align="center">医院</th>
                            <th align="center">开票单位</th>
                            <th align="center">快递单号</th>
                            <th align="center">商品名称</th>
                            <th align="center">退单类型</th>
                            <th align="center">请求退货数量</th>
                            <th align="center">实际退货数量</th>
                            <th align="center">提交时间</th>
                            <%
                                if(tab==3||tab==4){
                                    out.print("<th align='center'>操作</th>");
                                }
                            %>
                        </tr>
                        <%
                            sql.append(SQL[tab]);

                            int sum=ShopExchanged.count(sql.toString());
                            if(sum<1)
                            {
                                out.print("<tr><td colspan='11' align='center'>暂无记录!</td></tr>");
                            }else
                            {
                                sql.append(" order by time desc");
                                ArrayList list = ShopExchanged.find(sql.toString(),pos,size);
                                for (int i = 0;i<list.size(); i++) {
                                    ShopExchanged se = (ShopExchanged) list.get(i);
                                    ShopProduct sp=ShopProduct.find(se.product_id);
                                    ProcurementUnit pu = ProcurementUnit.find(se.puid);
                                    ShopPackage spage = new ShopPackage(0);
                                    List<ShopProduct> spagePList = new ArrayList<ShopProduct>();
                                    ShopOrder so = ShopOrder.findByOrderId(se.orderId);
                                    ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(so.getOrderId());
                                    String pname = "";
                                    if(sp.isExist){
                                        pname=sp.name[1];
                                    }else{
                                        spage = ShopPackage.find(se.product_id);
                                        pname="[套装]"+MT.f(spage.getPackageName());
                                        spagePList.add(0,ShopProduct.find(spage.getProduct_id()));
                                        String [] sarr = spage.getProduct_link_id().split("\\|");
                                        for(int m=1;m<sarr.length;m++){
                                            spagePList.add(m,ShopProduct.find(Integer.parseInt(sarr[m])));
                                        }
                                    }

                        %>
                        <tr>
                            <td align="center"><%=i+pos+1 %></td>
                            <td align="center"><%=se.orderId %></td>
                            <td align="center"><%=MT.f(sod.getA_hospital())%></td>
                            <td align="center"><%=MT.f(pu.getName()) %></td>
                            <%--<td align="center" ><a href="###" onclick=mt.act('view',"<%=se.id %>")><%=se.exchanged_code %></a></td>--%>
                            <td align="center"><%=MT.f(se.expressNo) %></td>
                            <td align="center">
                                <%
                                    if(sp.isExist){
                                        out.print(pname);
                                    }else{
                                        out.println("<table width='100%' class='bornone'>");
                                        out.println("<tr><td>"+pname+"</td></tr>");
                                        for(int n=0;n<spagePList.size();n++){
                                            ShopProduct s1 = spagePList.get(n);
                                            out.println("<tr><td>"+s1.getAnchor(h.language)+"</td></tr>");
                                        }
                                        out.println("</table><script>mt.fit();</script>");
                                    }
                                %>
                            </td>
                            <td align="center"><%=se.type==1?"退货":"换货" %></td>
                            <%
                                if(se.status==0){
                                    out.println("<td align='center'>"+se.quantity+"</td>");
                                    out.println("<td align='center'></td>");
                                }else if(se.status==1){
			 /*  List<ShopOrderData> lstorderdata=ShopOrderData.find(" and order_id="+Database.cite(se.orderId), 0, 1);
			  ShopOrderData t=new ShopOrderData(0);
			  t=lstorderdata.get(0); */
                                    out.println("<td align='center'>"+se.quantity+"</td>");
                                    out.println("<td align='center'>"+se.quantity+"</td>");
                                }else if(se.status==2){
                                    out.println("<td align='center'>"+se.quantity+"</td>");

                                    out.println("<td align='center'>"+se.exchangednum+"</td>");


                                }else if(se.status==3){//已拒绝
                                    out.println("<td align='center'>"+se.quantity+"</td>");
                                    out.println("<td align='center'></td>");
                                }
                            %>

                            <td align="center"><%=MT.f(se.time) %></td>
                            <%
                                if(tab==3||tab==4){
                                    if(se.status==2&&se.exchangedstatus==0){
                                        out.print("<td align='center'><input style='border:none;background:none;color:#044694;' type='button' onclick=mt.act('yesexchange',0,'"+se.orderId+"') value='确认退货数量'></td>");
                                    }
                                    if(se.status==3){
                                        out.print("<td align='center'><input style='border:none;background:none;color:#044694;' type='button' onclick=mt.act('submit_dele','"+se.id+"','"+se.orderId+"') value='取消退货'></td>");
                                    }
                                }
                            %>
                        </tr>



                        <%
                                }
                                if(sum>size)
                                    out.print("<td colspan='10' align='right' id='ggpage'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,size));
                            }%>
                    </table>
                </div>
            </form>
        </div>
    </div>
</div>




<script>
sup.hquery();
</script>


<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,oid){
	form2.act.value=a;
	form2.seid.value=id;
	if(a=='view'){
        layer.open({type: 2,title: '退货单明细',shadeClose: true,area: ['500px', '400px'],closeBtn:1,content: "/jsp/yl/shop/ShopExchangedDetail.jsp?seid="+id});
		//mt.show("/jsp/yl/shop/ShopExchangedDetail.jsp?seid="+id,1,"退换单明细",410,300);
		return;
	}else if(a=="finish"){
		mt.show("确认完成吗？",2,"form2.submit()");
	}else if(a=='yesexchange'){
		  form2.action="/ShopExchangeds.do";
		  form2.target="_ajax";
		  form2.act.value=a;
		  form2.orderId.value=oid;
		  form2.submit();
    }else if(a=="submit_dele"){
        form2.action="/ShopExchangeds.do";
        form2.target="_ajax";
        form2.act.value=a;
        form2.orderId.value=oid;
        form2.submit();
    }
	
}

setFreeze(document.getElementsByTagName('TABLE')[1],0,1);

</script>
<script>
mt.receive=function(v,n,h){
    document.getElementById("hname").value=v;
};
mt.fit();
</script>
</body>
</html>
