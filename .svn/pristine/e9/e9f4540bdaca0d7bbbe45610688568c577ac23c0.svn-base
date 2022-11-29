<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="tea.entity.*" %>
<%@ page import="tea.entity.member.Profile" %>
<%@ page import="tea.entity.yl.shop.UpProfile" %>
<%@ page import="java.util.List" %>
<%@ page import="tea.entity.yl.shop.EmpowerRecord" %>
<%@ page import="tea.entity.yl.shop.ShopHospital" %>
<%@ page import="tea.entity.yl.shop.Consignee" %>
<%

    Http h = new Http(request, response);
    if (h.member < 1) {
        response.sendRedirect("/servlet/StartLogin?community=" + h.community);
        return;
    }
    int id = h.getInt("id");

%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="/tea/mobhtml/m-style.css">
    <script src='/tea/mt.js'></script>
    <script src='/tea/city.js'></script>
    <script src="/tea/tea.js" type="text/javascript"></script>
    <script src='/tea/jquery-1.3.1.min.js'></script>
    <script src='/tea/yl/top.js'></script>
    <script src='/tea/laydate-master/laydate.dev.js'></script>
    <script src="/jsp/yl/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <script src="/tea/yl/mtDiag.js"></script>
    <title>收货地址</title>
</head>
    <style>
        .person-con4 select{height:30px;}
    </style>
<body>
<form name="form2" action="/Consignees.do" id="form2" method="post" target="_ajax" enctype="multipart/form-data">
    <input type="hidden" name="nexturl">
    <input type="hidden" name="act">
    <input type="hidden" name="id" value="<%=h.getInt("id")%>">

    <div class="body">
        <%
            Consignee c = Consignee.find(0);
            if (id > 0) {
                c = Consignee.find(id);
            }
        %>
        <div class="Content">
            <div class="person-con4">
                <p href="" class="per-con3-a bor-b">
                    <span class="fl-left ft16 fcol-666 con3-span">收货人</span>
                    <input name="name" type="text" value="<%=MT.f(c.getName())%>" class="per-add-inp ft16">
                </p>
                <p href="" class="per-con3-a bor-b">
                    <span class="fl-left ft16 fcol-666 con3-span">手机号码</span>
                    <input name="mobile" type="text" value="<%=MT.f(c.getMobile())%>" class="per-add-inp ft16">

                </p>
                <p href="" class="per-con3-a bor-b">
                    <span class="fl-left ft16 fcol-666 con3-span">邮箱</span>
                    <input name="mail" type="text" value="<%=MT.f(c.getMail())%>" class="per-add-inp ft16">
                </p>
                <p href="" class="per-con3-a bor-b">
                    <span class="fl-left ft16 fcol-666 con3-span">邮编</span>
                    <input name="youbian" type="text" value="<%=MT.f(c.getYoubian())%>" class="per-add-inp ft16">

                </p>
                <p href="" class="per-con3-a bor-b">
                    <span class="fl-left ft16 fcol-666 con3-span" style='margin-right:25px;'>所在地区</span>
                    <script>mt.city("city0", "city1", "", '<%=MT.f(c.getCity())%>');</script>
                </p>
                <p href="" class="per-con3-a ">
                    <span class="fl-left ft16 fcol-666 con3-span">详细地址</span>
                    <input name="address" type="text" value="<%=MT.f(c.getAddress())%>" class="per-add-inp ft16">
                </p>

            </div>
            <div class="person-con5">
                <p href="" class="per-con3-a ">
                    <span class="fl-left ft16 fcol-666 ">设置默认地址</span>
                    <input name="ismoren" class="switch-btn switch-btn-animbg fl-right" type="checkbox"
                           <%if(c.getIsmoren()==1){%>checked  <%
                    }%>>
                </p>
            </div>
            <div class="person-con5">
                <a href="javascript:;" class="per-add-del ft16" onclick="dele('<%=c.getId()%>')">删除收货地址</a>
            </div>
            <p style='margin-top:20px;'>
                <input type="button" value="保存" onclick="subEmpower()" class="per-add-save ft16">
            </p>
        </div>
    </div>
</form>
<form name="form" action="/Consignees.do" id="form" method="post" target="_ajax" enctype="multipart/form-data">
    <input type="hidden" name="nexturl" value="">
    <input type="hidden" name="act">
    <input type="hidden" name="id">
</form>
</body>
</html>
<script>
    var reg = /^1(3|4|5|6|7|8|9)\d{9}$/;
    var reg1 = /^\d{6}$/;
    var reg3=/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
    function subEmpower() {

        if (mtDiag.check1($("#form2"))) {
            form2.act.value = 'add';
            var mob = form2.mobile.value;
            var youbian = form2.youbian.value;
            var name = form2.name.value;
            var city = form2.city1.value;
            var mail = form2.mail.value;
            var address = form2.address.vaue;
            if(!reg3.test(mail)){
                mt.show("邮箱格式不正确");
                form1.mail.focus();
                return false;
            }
            if (!reg.test(mob)) {
                mt.show("手机格式不正确");
                form2.mobile.focus();
                return false;
            }
            if (!reg1.test(youbian)) {
                mt.show("邮编格式不正确");
                form2.youbian.focus();
                return false;
            }
            if(name.length==0){
                mt.show("收件人格式不正确");
                form2.name.focus();
                return false;
            }
            if(city.length==0){
                mt.show("地区格式不正确");
                form2.city.focus();
                return false;
            }
            form2.nexturl.value="/mobjsp/yl/shopweb/G-PersonalAddressSetting.jsp";
            form2.submit();

        }

    }
    function dele(a) {
        form2.nexturl.value = "/mobjsp/yl/shopweb/G-PersonalAddressSetting.jsp";
        form2.act.value = 'delete';
        form2.id.value=a;
        form2.submit();
    }


</script>