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

    int count = ActivityWarning.count(" AND id=2022 ");
    if(count==0){//2022没有新增一个
        ActivityWarning activityWarning = ActivityWarning.find(2022);
        activityWarning.setStop("1");
        activityWarning.setName("1");
        activityWarning.insert();
    }
    ActivityWarning activityWarning = ActivityWarning.find(2022);
    int jumpNum = Integer.parseInt(activityWarning.getStop());
    int jumpNum2 = Integer.parseInt(activityWarning.getName());


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
<h1>JumpQualityDirecter</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<form name="form2" action="/ShopHospitals.do" method="post" target="_ajax">
    <input type="hidden" name="community" value="<%=h.community%>"/>
    <input type="hidden" name="id"/>
    <input type="hidden" name="nexturl"/>
    <input type="hidden" name="act" value="updateJumpQualityDirecter"/>

    <div class='radiusBox'>
        <table cellspacing="0" class='newTable'>
            <tr>
                <td>是否跳过质量负责人：</td>
                <td>
                    <input type="radio" name="isjump" value="1" <%=jumpNum==1?"checked='checked'":""%> >是
                    <input type="radio" name="isjump" value="0" <%=jumpNum==0?"checked='checked'":""%>>否
                </td>
                <td>是否跳过质量管理员：</td>
                <td>
                    <input type="radio" name="isjump2" value="1" <%=jumpNum2==1?"checked='checked'":""%> >是
                    <input type="radio" name="isjump2" value="0" <%=jumpNum2==0?"checked='checked'":""%>>否
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
