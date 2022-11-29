<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="tea.entity.yl.shop.*"%>
<%@page import="tea.entity.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="util.Config" %>
<%@ page import="tea.entity.member.Profile" %>
<%@ page import="tea.entity.yl.shopnew.Invoice" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.ArrayList" %>
<%

    Http h=new Http(request,response);
    if(h.member<1)
    {
        response.sendRedirect("/servlet/StartLogin?community="+h.community);
        return;
    }

    StringBuffer sql=new StringBuffer(),par=new StringBuffer();
    int fid = h.getInt("fid");
    sql.append(" and fid="+fid);
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
            <tr><td colspan="20">匹配服务费记录</td></tr>
            </thead>
            <tr>
                <th width='60'>序号</th>
                <th width="150">服务商</th>
                <th width='60'>厂商</th>
                <th>服务费发票总额</th>
                <th>操作时间</th>
                <th>操作人</th>
            </tr>
            <tbody class='mytab'>
                <%
                    ServiceFeeRecord sf = ServiceFeeRecord.find(fid);
                    Profile p = Profile.find(sf.getProfile());
                    ProcurementUnit pu = ProcurementUnit.find(sf.getPuid());
                    Profile p2 = Profile.find(sf.getMember());
                %>
                <tr>
                    <td><%=pos+1%></td>
                    <td><%=MT.f(p.getMember())%></td>
                    <td><%=MT.f(pu.getName()==null?"同福":pu.getName())%></td>
                    <td><%=sf.getTotalMoney()%></td>
                    <td><%=sf.getTime()%></td>
                    <td><%=MT.f(p2.getMember())%></td>
                </tr>
            </tbody>
            <%--<tr><td colspan="20" style="color:red"></td></tr>--%>
        </table>
    </div>
    <div class='radiusBox' style="margin-top: 15px;">
        <table cellspacing="0" class='newTable'>
            <thead>
            <tr><td colspan="20">匹配服务费详细</td></tr>
            </thead>

            <tbody class='mytab'>
                <tr>
                    <th width='60'>序号</th>
                    <th width="230">发票号</th>
                    <th>计提服务费</th>
                    <th>税金类型</th>
                   <%-- <th>税金</th>--%>
                </tr>
                <%
                    ArrayList<ServiceFeeInfo> siList = ServiceFeeInfo.find(" and fid=" + fid, 0, Integer.MAX_VALUE);
                    for (int i = 0; i < siList.size(); i++) {
                        ServiceFeeInfo s = siList.get(i);
                        Invoice invoice1 = Invoice.find(s.getOid());
                %>
                    <tr>
                        <td><%=i+1%></td>
                        <td><%=invoice1.getInvoiceno()%></td>
                        <td><%=s.getMoney()%></td>
                        <td><%=Profile.TAX[s.getTax()]%></td>
                        <%--<td><%=s.getTaxMoney()%></td>--%>
                    </tr>
                <%
                    }
                %>

            </tbody>
        </table>
    </div>
    <div class='radiusBox' style="margin-top: 15px;">
        <table cellspacing="0" class='newTable'>
            <thead>
            <tr><td colspan="20">已使用服务费发票</td></tr>
            </thead>
            <tr>
                <th width='60'>序号</th>
                <th width="230">发票号</th>
                <th>服务商</th>
                <th>金额</th>
                <th>发票开具时间</th>
            </tr>
            <tbody class='mytab'>
            <%
                ArrayList<Integer> list = sf.getInvoiceArray();
                for (int i = 0; i < list.size(); i++) {
                    ServiceInvoice si = ServiceInvoice.find(list.get(i));
                    Profile pf = Profile.find(si.getProfile());
                    if(si.getState()==1){
            %>
                <tr>
                    <td><%=i+1%></td>
                    <td><%=MT.f(si.getInvoiceCode())%></td>
                    <td><%=MT.f(pf.getMember())%></td>
                    <td><%=si.getMoney()%></td>
                    <td><%=MT.f(si.getTime())%></td>
                </tr>
            <%
                    }else{

            %>
            </tbody>
        </table>
    </div>
<div class='radiusBox' style="margin-top: 15px;">
    <table cellspacing="0" class='newTable'>
        <thead>
        <tr><td colspan="20">结余服务费发票</td></tr>
        </thead>
        <tr>
            <th width='60'>序号</th>
            <th width="230">发票号</th>
            <th>服务商</th>
            <th>金额</th>
            <th>发票开具时间</th>
        </tr>
        <tbody class='mytab'>

        <tr>
            <td><%=i+1%></td>
            <td><%=MT.f(si.getInvoiceCode())%></td>
            <td><%=MT.f(pf.getMember())%></td>
            <td><%=si.getMoney()%></td>
            <td><%=MT.f(si.getTime())%></td>
        </tr>
        <%
            }
                }
        %>
        </tbody>
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
