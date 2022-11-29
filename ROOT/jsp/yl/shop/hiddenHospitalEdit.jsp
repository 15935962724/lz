<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.entity.Http" %>
<%@ page import="tea.entity.yl.shop.HiddenHospital" %>
<%@ page import="java.util.ArrayList" %>
<%

    Http h = new Http(request, response);
    if (h.member < 1) {
        response.sendRedirect("/servlet/StartLogin?community=" + h.community);
        return;
    }
    int menu = h.getInt("id");

    ArrayList<HiddenHospital> hiddenHospitals = HiddenHospital.find("", 0, Integer.MAX_VALUE);
    HiddenHospital hiddenHospital = hiddenHospitals.get(0);
    if("insert".equals(h.get("act"))){
        String hospitalName = h.get("hospitalName");
        hiddenHospital.setHospital_name(hospitalName);
        hiddenHospital.update();
    }

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
<h1>HiddenHospital</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<form name="form2" action="?" method="post" target="_ajax">
    <input type="hidden" name="community" value="<%=h.community%>"/>
    <input type="hidden" name="act" value="insert"/>
    <input type="hidden" name="id" value="<%=menu%>"/>

    <div class='radiusBox'>
        <table cellspacing="0" class='newTable'>
            <tr>
                <td>要隐藏的医院名（多个用,隔开）：</td>
                <td>
                    <textarea name="hospitalName" id='_content' cols='100' rows='10' title='填写医院名...' ><%=hiddenHospital.getHospital_name()%></textarea>
                </td>
                <td> <button class="btn btn-primary" type="button" onclick="updateJumpQualityDirecter()">确定</button></td>
            </tr>

        </table>
    </div>
</form>
<script>
    function updateJumpQualityDirecter() {
        form2.submit();
    }
</script>
</body>
</html>
