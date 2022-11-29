<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.entity.sup.*" %>
<%@page import="tea.entity.yl.shop.ShopHospital" %>
<%@ page import="tea.entity.yl.shop.JihuoCode" %>
<%@ page import="util.Config" %>
<%@ page import="tea.entity.yl.shop.ShopProductModel" %>
<%

    Http h = new Http(request, response);
    if (h.member < 1) {
        response.sendRedirect("/servlet/StartLogin?community=" + h.community);
        return;
    }
    String nexturl = h.get("nexturl");
    int id = h.getInt("id");

    JihuoCode jihuo = JihuoCode.find(id);


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

<form name="form1" action="/JihuoCodes.do" method="post" target="_ajax" onSubmit="return mt.check(this)">
    <input type="hidden" name="id" value="<%=id%>"/>
    <input type="hidden" name="nexturl" value="<%=h.get("nexturl") %>"/>
    <input type="hidden" name="act" value="add"/>
    <table id="tablecenter">

        <tr>
            <td align="right">激活码编号：</td>
            <td><input name="code" style="width: 20%" value="<%=MT.f(jihuo.getCode())%>"/></td>
        </tr>
        <%--<tr>
            <td align="right">邮箱账号：</td>
            <td><input name="mail" style="width: 20%" value="<%=MT.f(jihuo.getMail())%>"/></td>
        </tr>--%>
        <tr>
            <td align="right">激活码类型</td>
            <td><select name="type" id="type" onchange="typeok()">
                <option value="">请选择</option>
                <option value="<%=Config.getInt("shijian")%>"
                        <%if(jihuo.getType()==Config.getInt("shijian")){%>selected<%}%>>时间
                </option>
                <option value="<%=Config.getInt("cishu")%>"
                        <%if(jihuo.getType()==Config.getInt("cishu")){%>selected<%}%>>次数
                </option>
                <option value="<%=Config.getInt("kehuduan")%>"
                        <%if(jihuo.getType()==Config.getInt("kehuduan")){%>selected<%}%>>客户端
                </option>
            </select>
                <select name="type_child" id="type_child">
                    <%if (h.getInt("id") == 0) {//新增%>
                    <option value="">请选择</option>
                    <%}%>

                    <%
                        List<ShopProductModel> s = ShopProductModel.find("AND category=" + jihuo.getType(), 0, Integer.MAX_VALUE);
                        if (jihuo.getType_child() != 0) {
                            for (ShopProductModel s1 : s) {%>
                    <option value="<%=s1.getId()%>"
                            <%if(jihuo.getType_child()==s1.getId()){%>selected<%}%>><%=s1.getModel()%>
                    </option>

                    <% }
                    %>


                    <%
                        }
                    %>
                    <%--<option value="1" <%if(jihuo.getType()==1){%>selected<%}%>>时间</option>--%>
                </select>
            </td>
        </tr>
    </table>
    <button class="btn btn-primary" type="button" onclick="fnedit()">提交</button>&nbsp;&nbsp;&nbsp;&nbsp;
    <button class="btn btn-default" type="button" onclick="location='<%=nexturl%>'">返回</button>
</form>

<script type="text/javascript">
    form1.nexturl.value = "/jsp/yl/shop/jihuoCodes.jsp";

    //给地区名称area_name赋值
    function typeok() {
        var a = document.getElementById("type").value;
        fn.ajax("/mobjsp/yl/shop/ajax.jsp?act=type_child", {id: a}, function (data) {
            if (data.type > 0) {

            } else {

                var ids = data.id.toString();
                var names = data.name.toString();

                var id = ids.split(",");
                var name = names.split(",");
                for (y = 0; y < id.length; y++) {
                    var tamp = '<option value=\"';
                    for (j = 0; j < id.length; j++) {
                        tamp += id[y];
                        break;
                    }
                    tamp += '\">';
                    for (i = 0; i < name.length; i++) {
                        tamp += name[y];
                        break;
                    }
                    tamp += '</option>';
                    if (y == 0) {
                        $('#type_child').html(tamp);
                    } else {
                        $('#type_child').append(tamp);
                    }

                }
            }
        });


    }

    function selectArea() {
        var selectIndex = document.getElementById("_area").selectedIndex;//获得是第几个被选中了
        var selectText = document.getElementById("_area").options[selectIndex].text //获得被选中的项目的文本
        form1.area_name.value = selectText;
    }

    //初始
    function changeSelected() {
        changeAreaSelected();
        changeHtypeSelected();
        changeHgraderSelected();
    }


    //控制select option是否选中
    function jsSelectItemByValue(objSelect, objItem) {
        for (var i = 0; i < objSelect.options.length; i++) {
            if (objSelect.options[i].value == objItem) {
                objSelect.options[i].selected = true;
                break;
            }
        }
    }

    function fnedit() {
        form1.submit();
    }

</script>
</body>
</html>
