<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.entity.Http" %>
<%@ page import="tea.entity.yl.shop.ShopHospital" %>
<%@ page import="tea.entity.yl.shop.ActivityWarning" %>
<%

    Http h = new Http(request, response);
    if (h.member < 1) {
        response.sendRedirect("/servlet/StartLogin?community=" + h.community);
        return;
    }

    int count = ActivityWarning.count(" AND id=2023 ");
    if(count==0){//2023没有新增一个
        ActivityWarning activityWarning = ActivityWarning.find(2023);
        activityWarning.setStop("10");
        activityWarning.insert();
    }
    ActivityWarning activityWarning = ActivityWarning.find(2023);


%>
<!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/jquery-1.11.1.min.js"></script>
<script src="/tea/yl/top.js"></script>
</head>
<body>
<h1>daySendMessageMax</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<form name="form2" action="/ShopHospitals.do" method="post" target="_ajax">
    <input type="hidden" name="community" value="<%=h.community%>"/>
    <input type="hidden" name="act" value="daySendMessageMax"/>
    <div class='radiusBox'>
        <table cellspacing="0" class='newTable'>
            <tr>
                <td>当日发送登录验证码上限条数：</td>
                <td>
                    <input type="number" name="maxNumber" value="<%=activityWarning.getStop()%>" >
                </td>
                <td> <button class="btn btn-primary" type="button" onclick="updateJumpQualityDirecter()">确定</button></td>
            </tr>

        </table>
    </div>
</form>
<script>
    form2.nexturl.value = location.pathname + location.search;
    function updateJumpQualityDirecter() {
        form2.submit();
    }
</script>
</body>
</html>
