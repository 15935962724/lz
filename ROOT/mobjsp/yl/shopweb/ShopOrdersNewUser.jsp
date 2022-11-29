<%@page import="util.Config"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.member.Profile"%><%

    Http h=new Http(request,response);
    if(h.member<1){
        String param = request.getQueryString();
        String url = request.getRequestURI();
        if(param != null)
            url = url + "?" + param;
        response.sendRedirect("/mobjsp/yl/user/login_mobile.html?nexturl="+Http.enc(url));
        return;
    }
    int menu=h.getInt("id");
    StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
    par.append("&menu="+menu);

    //sql.append(" AND member="+h.member);
    Profile profile = Profile.find(h.member);
    sql.append(" AND order_id in (select order_id from shoporderdispatch where a_consignees="+DbAdapter.cite(profile.member)+")");
    par.append("&member="+h.member);

    sql.append(" AND status!=6");
    par.append("&status!=6");
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
        sql.append(" AND createDate>"+DbAdapter.cite(time0));
        par.append("&createDate="+MT.f(time0));
    }
    Date time1=h.getDate("time1");
    if(time1!=null)
    {
        sql.append(" AND createDate<"+DbAdapter.cite(time1));
        par.append("&createDate="+MT.f(time1));
    }

    int puid = h.getInt("puid",-1);
    if(puid!=-1){
        sql.append(" AND puid = "+puid);
        par.append("&puid="+puid);
    }


    String[] TAB={"全部订单","待收货","已完成"};
    String[] SQL={"  "," AND status=3"," AND status=4"};

    int tab=h.getInt("tab",0);
    par.append("&tab="+tab);

    int pos=h.getInt("pos");
    par.append("&pos=");



%><!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width,user-scalable=0">
        <title>粒子订单</title>

<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/new/js/jquery.min.js"></script>
<script src="/tea/yl/mtDiag.js"></script>
<link rel="stylesheet" href="/tea/mobhtml/m-style.css">
</head>
<body>

<div class="body">
    <form name="form1" action="?">
        <input type="hidden" name="id" value="<%=menu%>"/>
        <input type="hidden" name="tab" value="<%=tab%>"/>
        <div class="order-sea">
            <div class="order-sea-left fl-left">
                <%--<p style="position:relative;">
                    <span class="ft14 order-l-span">医院：</span>
                    <input type="text" name="hname" class="right-box-data" id="hname" value="<%=hname %>" readonly style=""/>
                    <input id="hospitalsel" class="btn btn-link" style="position:absolute;width:auto;right:-70px;color:#044694;border:none;background:none;top:0px;height:33px;" onclick="layer.open({type: 2,title: '选择医院',shadeClose: true,area: ['98%', '580px'],closeBtn:1,content: '/jsp/yl/shopwebnew/Selhospital.jsp'});" type="button" value="请选择"/>
                </p>--%>
                <p>
                    <span class="ft14 order-l-span">厂商：</span>
                    <select name='puid' style=""  class="right-box-yy">
                        <option value=''>请选择</option>
                        <option <%= (puid==Config.getInt("tongfu")?"selected='selected'":"") %> value='<%= Config.getInt("tongfu") %>'>同辐</option>
                        <option <%= (puid==Config.getInt("gaoke")?"selected='selected'":"") %> value='<%= Config.getInt("gaoke") %>'>高科</option>
                        <option <%= (puid==Config.getInt("junan")?"selected='selected'":"") %> value='<%= Config.getInt("junan") %>'>君安</option>
                    </select>
                </p>
                <p>
                    <span class="ft14 order-l-span">订单编号：</span>
                    <input type="text" class="right-box-inp" name="orderId" value="<%=MT.f(orderId)%>"/>
                </p>
                <p>
                    <span class="ft14 order-l-span">订单时间：</span>
                    <span class="time">
                        <input name="time0" value="<%=MT.f(time0)%>" onclick="mt.date(this)" class="right-box-data1"/>
                        <span style="">~</span>
                        <input name="time1" value="<%=MT.f(time1)%>" onclick="mt.date(this)" class="right-box-data1"/>
                    </span>
                </p>
            </div>
            <input type="submit" class="fl-right order-cxb ft14" value="查询">
        </div>

    </form>

    <div class="order-lx">
            <%out.print("<ul>");
                for(int i=0;i<TAB.length;i++)
                {
                    out.print("<li class='ft14 fl-left "+(i==tab?"on":"")+"'><a href='javascript:mt.tab("+i+")'>"+TAB[i]+"("+ShopOrder.count(sql.toString()+SQL[i])+")</a></li>");
                }
                out.print("</ul>");
            %>
    </div>

    <form name="form2" action="/ShopOrders.do" method="post" target="_ajax">
        <input type="hidden" name="orderId"/>
        <input type="hidden" name="status"/>
        <input type="hidden" name="cancelReason"/>
        <input type="hidden" name="tab" value="<%=tab%>"/>
        <input type="hidden" name="nexturl"/>
        <input type="hidden" name="act"/>


                    <%
                        sql.append(SQL[tab]);

                        int sum=ShopOrder.count(sql.toString());
                        if(sum<1)
                        {
                            out.print("<p class='text-c'>暂无记录!</p>");
                        }else
                        {
                            //sql.append(" order by createDate desc");
                            Iterator it=ShopOrder.find(sql.toString()+" order by createDate desc ",pos,5).iterator();
                            for(int i=1+pos;it.hasNext();i++)
                            {
                                ShopOrder t=(ShopOrder)it.next();

                                ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(t.getOrderId());

                                String querySql = " AND order_id="+DbAdapter.cite(t.getOrderId());
                                List<ShopOrderData> sodList = ShopOrderData.find(querySql,0,Integer.MAX_VALUE);
                                ShopOrderData odata=null;
                                if(sodList.size()>0){

                                    //Filex.logs("yt.txt",t.getOrderId());
                                    odata=sodList.get(0);
                                }
                                String uname = MT.f(Profile.find(t.getMember()).member);
                                int status = t.getStatus();
                                String statusContent = "";
                                if(status==0)
                                    statusContent = "待付款";
                                else if(status==1||status==2||status==-1||status==-2||status==-3||status==-4||status==-5)
                                    statusContent = "待发货";
                                else if(status==3)
                                    statusContent = "待收货";
                                else if(status==4)
                                    statusContent = "已完成";
                                else if(status==5)
                                    statusContent = "<a href='###' onclick=\"layer.alert('"+MT.f(t.getCancelReason())+"');\">已取消</a>";
                                else if(status==7)
                                    statusContent = "已退货";
                    %>
        <div class="order-list">
           <p class="order-line1 ft14">
               <span class="fl-left order-tit"><%=MT.f(sod.getA_hospital()) %></span>
               <span class="fl-right order-zt"><%if(tab==0){%><%=statusContent%><%}%></span>
           </p>
           <ul class="ft14">
               <li>
                   <span class="list-spanr5 fl-left">订单编号：</span>
                   <span class="list-spanr fl-left"><%=t.getOrderId()%></span>
               </li>
               <li>
                   <span class="list-spanr5 fl-left">厂商：</span>
                   <span class="list-spanr fl-left"><%= ProcurementUnit.findName(t.getPuid()) %></span>
               </li>
               <li>
                   <span class="list-spanr5 fl-left">数量：</span>
                   <span class="list-spanr fl-left">
                       <%
                       if(sodList.size()>0){
                           out.print(odata.getQuantity());
                       }
                    %>
                   </span>
               </li>

               <li>
                   <span class="list-spanr5 fl-left">已开票数量：</span>
                   <span class="list-spanr fl-left"><%=t.getIsinvoicenum() %></span>
               </li>

               <li>
                   <span class="list-spanr5 fl-left">下单时间：</span>
                   <span class="list-spanr fl-left"><%=MT.f(t.getCreateDate(),1)%></span>
               </li>
           </ul>
           <p class="order-btnp">



                            <%

                                List<ShopExchanged> exchangelst=ShopExchanged.find(" and order_id="+Database.cite(t.getOrderId()), 0, Integer.MAX_VALUE);
                                if(exchangelst.size()==0){
                                    if(status!=5&&t.getInvoiceStatus()==0){
                                        if(Profile.find(h.member).membertype!=2){
                                            if(status>0){
                                                //out.println("<a href=\"javascript:mt.act('getfp','"+MT.enc(t.getOrderId())+"');\">索要发票</a>");
                                            }
                                        }else{
                                            //out.println("<a href=\"javascript:mt.act('getfp','"+MT.enc(t.getOrderId())+"');\">索要发票</a>");
                                        }
                                    }
                                }

                                out.println("<a class='btn' href=\"javascript:mt.act('data','"+MT.enc(t.getOrderId())+"');\">查看</a>");

                                if(status==0)
                                    out.println("<a class='btn' href=\"javascript:mt.act('status','"+t.getOrderId()+"',5,'取消订单');\" >取消订单</a>");
                                if(status==3){

                                    Profile m=Profile.find(h.member);
                                    //if(m.membertype==2)
                                    out.println("<a  class='btn' onclick=\"mt.act('printOrder','"+t.getOrderId()+"');\" >查看发货单</a>");
                                        //out.println("<a class='btn' href=\"javascript:mt.act('printOrder','"+t.getOrderId()+"');\">打印发货单</a>");
                                    //if(m.membertype != 2) //服务器，不允许确认收货，只能通过签收人微信扫码
                                    //out.println("<a class='btn' href=\"javascript:mt.act('status','"+t.getOrderId()+"',4,'确认收货');\">确认收货</a>");
                                }
                                //if(status==4||status==5)
                                //	out.println("|<a href=\"javascript:mt.act('status','"+t.getOrderId()+"',6,'删除订单');\">删除</a>");
                                if(status==4){
                                    ShopExchanged ex=ShopExchanged.findByOrderId(t.getOrderId());
                                    if(ex.id>0){
                                        out.println("<a class='btn' href=\"javascript:mt.act('refund','"+MT.enc(t.getOrderId())+"');\">查看退货</a>");

                                    }else{
                                        out.println("<a class='btn' href=\"javascript:mt.act('refund','"+MT.enc(t.getOrderId())+"');\">申请退货</a>");

                                    }
                                    Profile m=Profile.find(h.member);
                                    /*if(m.membertype==2){
                                        out.println("<a class='btn' href=\"javascript:mt.act('printOrder','"+t.getOrderId()+"');\">打印发货单</a>");
                                    }*/
                                    //if(m.membertype == 2||m.membertype==0){
                                        out.println("<a  class='btn' onclick=\"mt.act('printOrder','"+t.getOrderId()+"');\" >查看发货单</a>");
                                    //}
                                }

                            %>
           </p>
        </div>

                    <%}
                        if(sum>5)out.print("<div id='ggpage'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,5)+"</div>");
                    }%>


                <%
                    Profile pro = Profile.find(h.member);
                    if(pro.getMembertype() == 2){
                        sql.append(" AND isLzCategory=1");
                        sql.append(" order by createDate desc");
                %>
                <!--div class='center text-c pd20'><button class="btn btn-primary btn-blue" type="button" onclick="dcorder()">导出</button></div-->
                <%} %>

    </form>


</div>
<script>
    form2.nexturl.value=location.pathname+location.search;
    mt.act=function(a,orderId,status,statusContent)
    {
        form2.act.value=a;
        form2.orderId.value=orderId;
        if(a=='del')
        {
            mt.show('你确定要删除吗？',2,'form2.submit()');
        }else if(a=='status')
        {
            form2.status.value=status;
            if(status==5){
                layer.prompt({title: '取消订单原因', formType: 2}, function (pass, index) {
                    if(pass==""){
                        layer.alert("“取消订单原因”不能为空！");
                    }else{
                        form2.cancelReason.value=t.value;
                        form2.submit();
                    }
                    layer.close(index);
                });

            }else{
                mt.show('你确定要"'+statusContent+'"吗？',2,'form2.submit()');
            }
        }else if(a=='data')
        {
            //window.open("ShopOrderDatas.jsp?orderId="+orderId);
            location.href="/mobjsp/yl/shopweb/ShopOrderDatasNew.jsp?orderId="+orderId;

        }else if(a=='payment')
        {
            //window.open("ShopOrderDatasRefund.jsp?orderId="+orderId);
            window.open("/html/folder/14110391-1.htm?orderId="+orderId);
        }else if(a=='refund')
        {
            //window.open("ShopOrderDatasRefund.jsp?orderId="+orderId);
            location.href="/mobjsp/yl/shopweb/ShopOrderDatasRefundNew.jsp?orderId="+orderId;
        }else if(a=='getfp'){
            //parent.location="/jsp/yl/shopweb/ShopGetFp.jsp?orderId="+orderId;
            parent.location="/html/folder/14113269-1.htm?orderId="+orderId;
        }else if(a=='printOrder'){
            /* form2.action=("/jsp/yl/shop/ShopOrderDatasReceipt.jsp");
            form2.target='_self';form2.method='get';form2.submit(); */
            // parent.location="/jsp/yl/shop/ShopOrderDatasReceipt.jsp";
            location.href="/jsp/yl/shop/ShopOrderDatasReceipt.jsp?orderId="+orderId;
        }
    };
    function dcorder(){
        form3.submit();
    }
    mt.receive=function(v,n,h){
        document.getElementById("hname").value=v;
    };
    mt.fit();
</script>
</body>
</html>
