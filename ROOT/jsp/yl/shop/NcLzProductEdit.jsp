<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.entity.*" %>
<%@ page import="util.Config" %>
<%@ page import="tea.entity.yl.shop.NcLzProduct" %>
<%

    Http h = new Http(request, response);
    if (h.member < 1) {
        response.sendRedirect("/servlet/StartLogin?community=" + h.community);
        return;
    }
    String nexturl = h.get("nexturl");
%>
<html>
<head>
    <link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
    <script src="/tea/mt.js" type="text/javascript"></script>
    <script src="/tea/jquery-1.11.1.min.js"></script>
    <script src='/tea/yl/top.js'></script>
</head>
<body onload="changeSelected();">
<h1>编辑激活码</h1>

<form name="form1" action="/NcLzProducts.do" method="post" target="_ajax" onSubmit="return mt.check(this)">
    <input type="hidden" name="id" value="<%=0%>"/>
    <input type="hidden" name="nexturl" value="<%=h.get("nexturl") %>"/>
    <input type="hidden" name="act" value="add"/>
    <table id="tablecenter">
        <tr>
            <td align="right">商品厂商</td>
            <td>
                <select name="puid">
                <option value="<%=Config.getInt("gaoke")%>">高科</option>
                <option value="<%=Config.getInt("junan")%>">君安</option>
                <option value="<%=Config.getInt("xinke")%>">欣科</option>
                </select>
            </td>
        </tr>
        <tr>
            <td align="right">商品活度（单个数字 如：1.5 或 范围 如：0.8-1.5）：</td>
            <td><input name="activity" style="width: 20%" /></td>
        </tr>
        <tr>
            <td align="right">NC编码：</td>
            <td><input name="nccode" style="width: 20%" /></td>
        </tr>

    </table>
    <button class="btn btn-primary" type="button" onclick="fnedit()">提交</button>&nbsp;&nbsp;&nbsp;&nbsp;
    <button class="btn btn-default" type="button" onclick="location='<%=nexturl%>'">返回</button>
</form>

<script type="text/javascript">
    form1.nexturl.value = "/jsp/yl/shop/NcLzProductList.jsp";
    function fnedit() {
        form1.submit();
    }

</script>
</body>
</html>
