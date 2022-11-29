<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.entity.yl.shop.ShopHospital" %>
<%@ page import="java.util.*" %>
<%@ page import="util.CommonUtils" %>
<%@ page import="tea.entity.yl.shop.ApprovalProcess" %>
<%

    Http h = new Http(request, response);
    if (h.member < 1) {
        response.sendRedirect("/servlet/StartLogin?community=" + h.community);
        return;
    }
    String nexturl = h.get("nexturl");
    int id = h.getInt("id");
    ShopHospital sh = ShopHospital.find(id);
    //查询到期的证件
    int apid = h.getInt("apid");
    ApprovalProcess ap = ApprovalProcess.find(apid);

    StringBuffer url = request.getRequestURL();
    String tempContextUrl = url.delete(url.length() - request.getRequestURI().length(), url.length()).toString();
%>
<html>
<head>
    <link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
    <script src='/tea/mt.js'></script>
    <script src='/tea/city.js'></script>
    <script src="/tea/tea.js" type="text/javascript"></script>
    <script src='/tea/jquery-1.11.1.min.js'></script>
    <script src='/tea/yl/top.js'></script>
</head>
<body onload="changeSelected();">
<h1>预警管理</h1>

<form name="form1" action="/ApprovalProcesss.do" id="form1" method="post"
      enctype="multipart/form-data" target="_ajax">
    <input type="hidden" name="id" value="<%=id%>"/>
    <input type="hidden" name="apid" value="<%=apid%>"/>
    <input type="hidden" name="nexturl" value="/jsp/yl/shopnew/shopHospitalsextensionRequestList.jsp?type=1&id=<%=id%>"/>
    <input type="hidden" name="act" value="editchaoliang"/>
    <table id="tablecenter">

        <tr>
            <td align="right">医院名称：</td>
            <td><%=MT.f(sh.getName())%>
            </td>
        </tr>
        <tr>
            <td>申请原因:</td>
            <td><textarea  name="reason" cols='28' rows='5'><%=apid>0?MT.f(ap.getReason()):""%></textarea></td>
        </tr>
        <tr>
            <td>文件:</td>
            <td>
                <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                    <div class="col-sm-9">
                        <input name="yanqi" type="file"
                               title="<%= MT.f(ap.getAttchid()) %>">
                        <input name="yanqi.attch" id="clientID" type="hidden"
                               value="<%= MT.f(ap.getAttchid())%>"/>
                        <%
                            if (ap.getAttchid() > 0) {
                        %>
                        <a href="<%=CommonUtils.getFileUrlByAttchId(tempContextUrl, ap.getAttchid())%>"
                           target="_blank" style="color: #007aaf">查看  (不上传文件默认为使用原文件)</a>
                        <%
                            }
                        %>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>原Bq数量:</td>
            <td><%=ShopHospital.showBq(MT.f(sh.getBq1()))%></td>
        </tr>
        <tr>
            <td>Bq数量调整为:</td>
            <td><input name="bq" value="<%=MT.f(ap.getBq())%>" onkeyup="inputChange(this)"/></td>
        </tr>
    </table>
    <button class="btn btn-primary" type="button" onclick="fnedit()">确定</button>&nbsp;&nbsp;&nbsp;&nbsp;
    <button class="btn btn-default" type="button" onclick="location='<%=nexturl%>'">返回</button>
</form>

<script type="text/javascript">
    function fnedit() {
        form1.submit();
    }

    function changelb() {
        var id = form1.id.value;
        var apid = form1.apid.value;
        var nexturl = form1.nexturl.value;
        var yqlb = form1.yqlb.value;
        location.href="/jsp/yl/shopnew/postponeAdd.jsp?yqlb="+yqlb+"&id="+id+"&apid="+apid+"&nexturl="+nexturl;
    }

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
