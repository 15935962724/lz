<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.entity.yl.shop.ShopHospital" %>
<%@ page import="tea.entity.yl.shop.ActivityWarning" %>
<%

    Http h = new Http(request, response);
    if (h.member < 1) {
        response.sendRedirect("/servlet/StartLogin?community=" + h.community);
        return;
    }
    String nexturl = h.get("nexturl");
    int id = h.getInt("id");

    ShopHospital sh = ShopHospital.find(id);
    ActivityWarning activityWarning = ActivityWarning.find(sh.getId());

%>
<html>
<head>
    <link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
    <script src='/tea/mt.js'></script>
    <script src='/tea/city.js'></script>
    <script src="/tea/tea.js" type="text/javascript"></script>
    <script src='/tea/jquery-1.11.1.min.js'></script>
    <script src='/tea/yl/top.js'></script>s
</head>
<body onload="changeSelected();">
<h1>预警管理</h1>

<form name="form1" action="/ShopHospitals.do" method="post" target="_ajax">
    <input type="hidden" name="id" value="<%=id%>"/>
    <input type="hidden" name="nexturl" value="<%=h.get("nexturl") %>"/>
    <input type="hidden" name="act" value="editActivityWarning"/>
    <table id="tablecenter">

        <tr>
            <td align="right">医院名称：</td>
            <td><%=MT.f(sh.getName())%>
            </td>
        </tr>
        <tr>
            <td>活度预警值:</td>
            <td><input type="text" name="warning" value="<%=MT.f(activityWarning.getWarning())%>" />(设置最低mCi)
            </td>
        </tr>
        <tr>
            <td>活度警戒值:</td>
            <td><input type="text" name="warning2" value="<%=MT.f(activityWarning.getWarning2())%>" /></td>
        </tr>
        <tr>
            <td>活度停货值:</td>
            <td><input type="text" name="stop" value="<%=MT.f(activityWarning.getStop()) %>" /></td>
        </tr>
        <tr>
            <td>预警平台电话:</td>
            <td><input type="text" name="yjptdh" value="<%=MT.f(activityWarning.getYjptdh()) %>" /></td>
        </tr>
        <tr>
            <td>预警医院电话:</td>
            <td><input type="text" name="yjyydh" value="<%=MT.f(activityWarning.getYjyydh()) %>"/></td>
        </tr>
    </table>
    <button class="btn btn-primary" type="button" onclick="fnedit()">确定</button>&nbsp;&nbsp;&nbsp;&nbsp;
    <button class="btn btn-default" type="button" onclick="location='<%=nexturl%>'">返回</button>
</form>

<script type="text/javascript">
    form1.nexturl.value = location.pathname + location.search;

    function fnedit() {
        form1.submit();
    }

    /*
    * 数字输入框加逗号   1,000,0
    * */
    function toThousands(num){
        var result = '';
        var numArr = num.toString().split('.');
        var int = numArr[0];
        var decmial = numArr[1] ? '.' + numArr[1] : '';
        for (var n = int.length - 1; n >= 0; n--) {
            result += int[int.length - n - 1];
            if ((int.length - n - 1) % 3 === 0 && n !== 0) {
                result += ',';
            }
        }
        return result + decmial;
    };

    function inputChange(obj) {
        var num = $(obj).val().replaceAll(",","");
        $(obj).val(toThousands(num));
    }

</script>
</body>
</html>
