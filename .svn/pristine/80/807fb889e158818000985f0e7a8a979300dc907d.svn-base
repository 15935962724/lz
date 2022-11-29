<%@page import="tea.entity.yl.shopnew.ReplyMoney" %>
<%@page import="java.util.List" %>
<%@page import="tea.entity.MT" %>
<%@page import="tea.entity.yl.shop.ShopHospital" %>
<%@page import="tea.entity.yl.shop.ShopQualification" %>
<%@page import="tea.entity.Http" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<%
    Http h = new Http(request, response);
    String nexturl = h.get("nexturl");
    int rid = h.getInt("rid", 0);
    int puid = h.getInt("puid");
    ReplyMoney r = ReplyMoney.find(rid);
    String pname = h.get("pname", "");
    int type = h.getInt("type");//获取是否按服务商添加  0不是默认0 ，1按服务商添加回款
%>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src='/tea/mt.js'></script>
<script src='/tea/tea.js'></script>
<script src='/tea/city.js'></script>
<script src='/tea/jquery.js'></script>
<script src='/tea/laydate-master/laydate.dev.js'></script>
<script src="/jsp/yl/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

<body>
<h1>添加回款</h1>
<form action="/ReplyMoneys.do" name="form2" method="post" target="_ajax" onSubmit="return mt.check(this)">
    <input name="act" type="hidden" value="edit"/>
    <input name="rid" type="hidden" value="<%= rid %>"/>
    <input name="puid" type="hidden" value="<%= puid %>"/>
    <input name="nexturl" type="hidden" value="<%= nexturl %>"/>
    <input name="profile" id="profile" type="hidden"/>
    </div>
    <div class='radiusBox'>
        <table id="tdbor" cellspacing="0" class='newTable'>
            <thead>
            <tr>
                <td colspan='5' class='bornone'>&nbsp;</td>
            </tr>
            </thead>
            <tr>
                <td>回款类型</td>
                <%--选择回款添加类型，默认不按服务商添加--%>
                <td>
                    <select name="type" id="type" onchange="select_fuwushang()">
                        <option value="0" <%if(type==0){%>
                          selected
                        <%}%> >按医院添加</option>
                        <option value="1"  <%if(type==1){%>
                                selected
                                <%}%>>按服务商添加</option>

                    </select>
                </td>
            </tr>
            <tr>
                <td>汇款时间：</td>
                <td>
                    <input class="Wdate" onfocus="WdatePicker({readOnly:true,maxDate:'%y-%M-%d'})" id="makeoutdate"
                           name="replyTime" value="<%= MT.f(r.getReplyTime()) %>"/>
                    <%-- <input name="replyTime" value="<%= MT.f(r.getReplyTime()) %>"  readonly="readonly" onclick="mt.date(this)" alt="汇款时间" /> --%>
                </td>
            </tr>
            <%if (1==type) {//按服务商进行添加%>
            <tr>
                <td>服务商：</td>
                <td><input type="text" alt="服务商" name="pname" id="pname" value="<%=pname %>"/>
                    <input id="hospitalsel"
                           onclick="mt.show('/jsp/yl/shopnew/SelProfile_shop_new.jsp?puid=<%=puid%>',1,'选择服务商',500,500)"
                           type="button" value="请选择"/>
                </td>
            </tr>
            <%}%>
            <tr>
                <td>回款单位：</td>
                <%
                    ShopHospital sh1 = ShopHospital.find(r.getHid());
                %>
                <td><input name="hid" id="hid" value="<%= r.getHid()  %>" type="hidden"/><input id="hid1"
                                                                                                readonly="readonly"
                                                                                                size="30"
                                                                                                value="<%= MT.f(sh1.getName()) %>"
                                                                                                alt="回款单位"/>&nbsp;<button
                        class="btn btn-primary btn-xs" type="button" <%if(type==1){//按服务商选择医院%>
                        onclick="selHospital_new()">选择回款单位
                <%}else {//直接选择医院%>
                    onclick="selHospital()">选择回款单位
                <%}%>
                </button>
                </td>
            </tr>
            <tr>
                <td>回款金额：</td>
                <td><input name="replyPrice" mask='float' alt="回款金额" value="<%= r.getReplyPrice() %>"/></td>
            </tr>
            <tr>
                <td>备注：</td>
                <td><textarea name='context' rows="" cols=""><%= MT.f(r.getContext()) %></textarea></td>
            </tr>
        </table>
    </div>
    <div class='center mt15'>
        <input type="submit" class="btn btn-primary" value="保存"/> <input class="btn btn-default" type="button"
                                                                         value="返回" onclick="history.back();"/>
    </div>
</form>
</body>
<script type="text/javascript">
    function selHospital_new() {
        var profile1= form2.profile.value;
        if(profile1.length==0){
            mt.show("请先选择服务商！");
        }else {
            mt.show("/jsp/yl/shopnew/ShopHospitals_new.jsp?puid=<%=puid%>&profile=" + profile1, 2, "选择回款单位", 800, 400);
            mt.fit();
        }
    }
    function selHospital() {
        mt.show("/jsp/yl/shopnew/ShopHospitals.jsp?", 2, "选择回款单位", 800, 400);
        mt.fit();
    }

    mt.sethid = function (id, name) {
        $("#hid").val(id);
        $("#hid1").val(name);
    };

    mt.receive1 = function (h, n) {
        $("#" + n).val(h);
    };

    mt.addtr = function (h, n, p) {
        $("#mytab tr").each(function () {
            //alert(this.innerHTML);
        });
        if ($("#mytab tr[name='mtr']").length == 0) {
            $("#mytab tr:eq(1)").remove();
        }
        var mtr = "<tr name='mtr'><td><input type='hidden' name='myproduct' value='" + h + "' />" + n + "</td><td>" + p + "</td><td><a href='javascript:void(0);' onclick='mt.deltr(this)'>删除</a></td></tr>";
        $("#mytab").append(mtr);
    };

    mt.deltr = function (obj) {
        $(obj).parent().parent().remove();
        mt.addmes();
    };
    mt.addmes = function () {

        if ($("#mytab tr[name='mtr']").length == 0) {
            $("#mytab").append("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
        }
    };
    mt.receive2 = function (v, n, h) {


        document.getElementById("pname").value = v;
        document.getElementById("profile").value = n;
    };

    function select_fuwushang() {
        var type1 = document.getElementById("type").value;
        location.href="/jsp/yl/shopnew/AddReplyMoney.jsp?type="+type1+"&rid=<%=rid%>&puid=<%=puid%>&nexturl=<%=nexturl%>";
    }

</script>
</html>