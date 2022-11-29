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


%>
<!DOCTYPE html>
<html>
<head>

    <script src="/tea/mt.js" type="text/javascript"></script>
    <script src="/jsp/sup/sup.js" type="text/javascript"></script>
    <link rel="stylesheet" href="/tea/new/css/style.css">
    <script src="/tea/new/js/jquery.min.js"></script>
    <script src="/tea/new/js/superslide.2.1.js"></script>
    <script src="/tea/yl/mtDiag.js"></script>
    <script src="/tea/city.js"></script>
    <style>
        .con-left .bd:nth-last-child(2) {
            display: block;
        }

        .con-left ul.bd:nth-last-child(2) li:nth-child(2) {
            font-weight: bold;
        }

        .con-left-list .tit-on7 {
            color: #044694;
        }

    </style>
</head>
<body style='min-height:800px;'>
<%@ include file="/jsp/yl/shopweb/PersonalTop.jsp" %>
<form name="form" action="/Consignees.do" id="form" method="post" target="_ajax" enctype="multipart/form-data">
    <input type="hidden" name="nexturl">
    <input type="hidden" name="act">
    <input type="hidden" name="id">
</form>
<div id="Content">
    <div class="con-left">
        <%@ include file="/jsp/yl/shopweb/PersonalLeft.jsp" %>
    </div>
    <div class="con-right">
        <p class="right-zhgl">
            <span>账户管理</span>
        </p>
        <p class="right-dz">
            <span>收货地址</span>
            <input type="button" value="新增收货地址" class="right-add" onclick="addAddress()">


        </p>
        <div class="right-list">
            <table class="right-tab right-tab2" border="1" cellspacing="0">
                <tr>
                    <th>收货人</th>
                    <th>收货地址</th>
                    <th>邮编</th>
                    <th>电话/手机</th>
                    <th>邮箱</th>
                    <th class="th4">操作</th>
                </tr>
                <%
                    if (list.size() > 0) {
                        for (Consignee c : list) {
                            int city = c.getCity();


                %>
                <tr>
                    <td><%=MT.f(c.getName())%>
                    </td>
                    <%
                        String a = c.getCity() + "";
                        String b = a.substring(0, 2);
                        int pro = Integer.valueOf(b);
                        int src = Integer.valueOf(a);
                    %>
                    <td>
                        <script>
                            var a = getProvince("<%=pro%>");
                            var b = getSrcity2('<%=pro%>', '<%=src%>');
                            document.write(a);
                            document.write(b);
                        </script>

                        <%=MT.f(c.getAddress())%>
                    </td>
                    <td><%=MT.f(c.getYoubian())%>
                    </td>
                    <td><%=MT.f(c.getMobile())%>
                    </td>
                    <td><%=MT.f(c.getMail())%></td>
                    <td>
                        <a href="javascript:" onclick="mt.act('update','<%=c.getId()%>')">修改</a>
                        <a href="javascript:" onclick="mt.act('delete','<%=c.getId()%>')">删除</a>
                        <%if(c.getIsmoren()==0){%>
                        <a href="javascript:" onclick="mt.act('ismoren','<%=c.getId()%>')">设为默认</a>
                        <%}else {%>
                        <%--href ="javascript:return false;" onclick="return false;" style="cursor: default;"--%>
                        <a href="javascript:return false;" style="cursor: default; color: gainsboro" onclick="return false;">设为默认</a>
                        <%}%>


                    </td>
                </tr>
                <%
                        }
                    }
                %>
            </table>
        </div>
    </div>
</div>
</body>
</html>
<script>
    function addAddress() {
        layer.open({
            type: 2,
            id: 'add',
            title: '添加收货地址',
            shadeClose: true,
            area: ['645px', '570px'],
            closeBtn: 1,
            content: '/jsp/yl/shopweb/Address_edit.jsp'
        });
        //location = '/jsp/yl/shopweb/ShopEmailMobile.jsp?type='+type;
    }

    mt.act = function (a, b) {
        if (a == "update") {
            layer.open({
                type: 2,
                id: 'update',
                title: '修改收货地址',
                shadeClose: true,
                area: ['645px', '570px'],
                closeBtn: 1,
                content: '/jsp/yl/shopweb/Address_edit.jsp?id=' + b
            });
        } else if (a == "delete") {
            form.nexturl.value = "/jsp/yl/shopweb/PersonalAddress.jsp";
            form.act.value = a;
            form.id.value = b;
            mt.show('确定要删除选中的信息吗？删除不可恢复，请谨慎操作!', 2, 'form.submit()');
        }else if(a=="ismoren"){
            form.nexturl.value = "/jsp/yl/shopweb/PersonalAddress.jsp";
            form.act.value = a;
            form.id.value = b;
            mt.show('确定要设置为默认？请谨慎操作!', 2, 'form.submit()');
        }
    }
</script>

