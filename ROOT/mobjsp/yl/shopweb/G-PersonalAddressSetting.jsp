<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="util.Config" %>
<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.yl.shop.*" %>
<%@page import="tea.entity.member.Profile" %>
<%
    Http h = new Http(request, response);
    if (h.member < 1) {
        response.sendRedirect("/servlet/StartLogin?community=" + h.community);
        return;
    }
    int member = h.member;
    List<Consignee> list = Consignee.find("AND member=" + member, 0, Integer.MAX_VALUE);
    System.out.println(list.size());

%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="/tea/mobhtml/m-style.css">
    <script src='/tea/city.js'></script>
    <title>收货地址</title>
</head>
<body>
<div class="body">
<%--    <div class="Header">--%>
<%--        <p class="header-tit ft18"><a href="" class="head-back"></a>收货地址<img src="img/icon2.png" alt=""--%>
<%--                                                                             class="head-list"></p>--%>
<%--        --%>
<%--    </div>--%>

    <div class="Content">
        <div class="person-con4">
            <%
                if (list.size() > 0) {
                    for (Consignee c : list) {


            %>
            <div class="per-add-line1 bor-b">
                <p class="ft16 per-add-xm">
                    <span><%=MT.f(c.getName())%></span>
                    <span><%=MT.f(c.getMobile())%></span>
                </p>
                <p class="fl-left ft14 per-add-w">
                    <em class="ft12" style="color: red"><%if(c.getIsmoren()==1){%>
                      默认
                    <%}%></em>
                    <%
                    String a = c.getCity()+"";
                    String b = a.substring(0,2);
                    int pro = Integer.valueOf(b);
                    int src = Integer.valueOf(a);

                    %>
                    <script>
                        var a = getProvince("<%=pro%>");
                        var b = getSrcity2('<%=pro%>', '<%=src%>');
                        document.write(a);
                        document.write(b);
                    </script>
                    <%=MT.f(c.getAddress())%>
                    邮箱：<%=MT.f(c.getMail())%>
                </p>
                <a href="/mobjsp/yl/shopweb/G-PersonalAddress.jsp?id=<%=c.getId()%>" class="fl-right ft16 per-add-bj bor-l">编辑</a>
            </div>
            <%
                    }
                }
            %>
        </div>
    <a type='button' href="/mobjsp/yl/shopweb/G-PersonalAddress.jsp" class=" ft16 per-add-save"  style='margin-top:15px;text-align:center;'>新增地址</a>
    </div>
</div>
</body>
</html>
<script>


</script>