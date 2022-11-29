<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.entity.*" %>
<%@ page import="util.Config" %>
<%@ page import="tea.entity.member.SMSMessage" %>
<%@ page import="tea.entity.member.Profile" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="tea.entity.yl.shop.ShopOrder" %>
<%@ page import="tea.entity.yl.shop.ShopHospital" %>
<%

    Http h = new Http(request, response);
   /* if (h.member < 1) {
        response.sendRedirect("/servlet/StartLogin?community=" + h.community);
        return;
    }
    //短信模板有内容
    String content = h.get("content", "");
    if (!"".equals(content)) {
        ArrayList arrayList = Profile.find1(" AND membertype=2 AND deleted=0", 0, Integer.MAX_VALUE);
        for (int i = 0; i < arrayList.size(); i++) {
            Profile o = (Profile) arrayList.get(i);
            if(MT.f(o.mobile).equals("")){
                continue;
            }
            String s = SMSMessage.create("Home", "webmaster",MT.f(o.mobile) , h.language, content);
        }

    }*/

%>
<!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<!-- <script src="/tea/jquery.js" type="text/javascript"></script> -->
<script src="/tea/jquery-1.11.1.min.js"></script>
<script src="/tea/yl/top.js"></script>
</head>
<body>
<h1>短信推送</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" id="form1" action="?">
    <table id="tablecenter" cellspacing="0">
        <tr>
            <td>短信模板内容</td>
            <td><input type="text" value="" name="content"></td>
        </tr>
        <tr>
            <td colspan="8" align="center">
                <button class="btn btn-primary" type="button" onclick="jump()">短信推送</button>
            </td>
        </tr>
    </table>
</form>
<script>

    function jump() {
        form1.submit();
    }

</script>
</body>
</html>
