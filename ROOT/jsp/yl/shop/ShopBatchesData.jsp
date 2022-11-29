<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="tea.entity.yl.shop.*"%>
<%@page import="tea.entity.*"%>
<%@ page import="util.Config" %>
<%@ page import="tea.entity.member.Profile" %>
<%@ page import="tea.entity.yl.shopnew.Invoice" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.util.*" %>
<%

    Http h=new Http(request,response);
    if(h.member<1)
    {
        response.sendRedirect("/servlet/StartLogin?community="+h.community);
        return;
    }

    StringBuffer sql=new StringBuffer(),par=new StringBuffer();
    int psid = h.getInt("psid");
    sql.append(" and psid="+psid);
    int pos=h.getInt("pos");


%>
<!DOCTYPE html>
<html>
<head>
    <link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
    <script src="/tea/yl/jquery-1.7.js"></script>
    <script src="/tea/yl/top.js"></script>

    <script src='/tea/laydate-master/laydate.dev.js'></script>
    <script src="/jsp/yl/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

</head>
<body>
<style>
    .mytab input[type=number]:focus{border:1px #ccc solid;}
    .mytab input::-webkit-outer-spin-button,
    .mytab input::-webkit-inner-spin-button {
        -webkit-appearance: none;
    }
    .mytab input[type="number"]{
        -moz-appearance: textfield;
    }
</style>
<h1></h1>
<div id="head6"><img height="6" src="about:blank"></div>


    <div class='radiusBox'>
        <table cellspacing="0" class='newTable'>
            <thead>
            <tr><td colspan="20">库存占用记录</td></tr>
            </thead>
            <tr>
                <th width='60'>序号</th>
                <th width="150">订单号</th>
                <th>占用数量</th>
                <th>占用状态</th>
            </tr>
            <tbody class='mytab'>
                <%
                    List<ShopBatchesData> sbdlist = ShopBatchesData.find(sql.toString(),0,Integer.MAX_VALUE );
                    for (int i = 0; i < sbdlist.size(); i++) {
                        ShopBatchesData sbd = sbdlist.get(i);
                %>
                <tr>
                    <td><%=(pos+1)+i%></td> 
                    <td><%=MT.f(sbd.getOrderId())%></td>
                    <td><%=MT.f(sbd.getNumber())%></td>
                    <td><%
                    if(sbd.getOccupyNumber()==0){
                        out.print("未分批");
                    }else if(sbd.getOccupyNumber()==sbd.getNumber()){
                        out.print("已完成分批");
                    }else if(sbd.getOccupyNumber()==sbd.getNumber()){
                        out.print("部分分批");
                    }
                    %></td>

                </tr>
            <%
                }
            %>
            </tbody>
            <%--<tr><td colspan="20" style="color:red"></td></tr>--%>
        </table>
    </div>
    <div class='mt15'><a id="closeIframe" class="btn btn-default" type="button">关闭</a></div>


<script type="text/javascript" >

    var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
    $('#closeIframe').click(function(){
        parent.layer.close(index);
    });




</script>
</body>
</html>
