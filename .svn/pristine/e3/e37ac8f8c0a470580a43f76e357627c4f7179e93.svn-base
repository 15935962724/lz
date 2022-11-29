<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.entity.*" %>
<%@ page import="util.Config" %>
<%

    Http h = new Http(request, response);
    /*if (h.member < 1) {
        response.sendRedirect("/servlet/StartLogin?community=" + h.community);
        return;
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
<h1>销量图表</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" id="form1" action="?">
    <table id="tablecenter" cellspacing="0">
        <tr>
            <td>时间选择:</td>
            <td><select name="year">
                <%
                    for (int i = 2015; i <2099 ; i++) {%>
                      <option value="<%=i%>"><%=i%></option>
                    <%}%>
            </select></td>
            <td><select name="month">
                <%
                    for (int i = 1; i <13 ; i++) {
                if(i==1){%>
                  <option value="0">请选择</option>
                <%}
                %>
                <option value="<%=i%>"><%=i%></option>
                    <%}
                %>
            </select></td>
            <td>
                厂商选择
            </td>
            <td><select name="puid">
                <option value="-1">请选择</option>
                <option value="<%=Config.getInt("tongfu")%>">同辐</option>
                <option value="<%=Config.getInt("junan")%>">君安</option>
                <option value="<%=Config.getInt("gaoke")%>">高科</option>
            </select></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td colspan="8" align="center">
                <button class="btn btn-primary" type="button" onclick="jump()">查询</button>
            </td>
        </tr>
    </table>
</form>
<script>

        function jump() {
            var year = form1.year.value;
            var month = form1.month.value;
            var puid = form1.puid.value;
            layer.open({
                type: 2,
                title:'销量图表',
                area:['100%', '100%'],
                fix: false, //不固定
                maxmin: false,
                content: "/jsp/yl/shop/xltj.jsp?year="+year+"&month="+month+"&puid="+puid,
                end: function(){
                    //window.location.reload();
                }
            });
        }

        function showprofilesearch(){
            mt.show("/jsp/yl/shop/ProfileSearch.jsp",2,"查询签收人",900,500);
        }

</script>
</body>
</html>
