<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
<html>
<head>
    <title>收货地址</title>

    <script src='/tea/mt.js'></script>
    <script src='/tea/city.js'></script>
    <script src="/tea/tea.js" type="text/javascript"></script>
    <script src="/tea/jquery-1.11.1.min.js"></script>
    <script src='/tea/yl/top.js'></script>
    <link rel="stylesheet" href="/tea/new/css/style.css">
    <style>
        td {
            text-align: left !important;
        }

        td input {
            padding: 0px 4px;
        }

        td input[type='file'] {
            padding: 0px;
        }

        .con {
            padding: 15px 20px 0px;
        }

        .con table { /*margin:0 auto;*/
        }

        .con table td {
            padding: 6px 0px;
            font-size: 14px;
            color: #333333;
            line-height: 20px;
        }

        .con table td input.getyzm {
            -webkit-border-radius: 5px;
            -moz-border-radius: 5px;
            border-radius: 5px;
            cursor: pointer;
            border: 1px solid #044694;
            height: 32px;
            color: #044694;
            background: #f1f6fb;
            padding: 0 8px
        }

        .con table td .tijiao {
            width: 148px;
            height: 30px;
            line-height: 30px;
            background: #00A2E8;
            font-size: 14px;
            font-weight: bold;
            color: #fff;
            margin-top: 15px;
            border: 0px;
            cursor: pointer;
        }

        .righttexts p {
            padding-top: 5px;
            line-height: 160%
        }

        .con table td .form-control {
            float: left;
        }

        .con table td em {
            font-style: normal;
            color: red;
            padding: 0px 2px;
            font-size: 18px;
        }
    </style>
</head>
<body>
<div class="qualification con">
    <form name="form2" action="/Consignees.do" id="form2" method="post" enctype="multipart/form-data">
        <input type="hidden" name="nexturl">
        <input type="hidden" name="act">
        <input type="hidden" name="id"value="<%=h.getInt("id")%>">
        <input type="hidden" name="isorder">
        <%
            Consignee c=Consignee.find(0);
            if(id>0){
                 c = Consignee.find(id);
            }
        %>
        <table id="tablecenter" cellspacing="0" class="right-tab4" style="background:none;">
            <tr>
                <td class="text-r"><em>*</em>收货人：</td>
                <td>
                    <input name="name" id="name" alt="收货人不能为空!" class="form-control" style="width:292px"
                           type="text" value="<%=MT.f(c.getName())%>"/>
                </td>
            </tr>
            <tr>
                <td class="text-r"><em>*</em>手机号：</td>
                <td>
                    <input name="mobile" id="mobile" alt="手机号不能为空!" class="form-control" style="width:292px"
                           type="text" value="<%=MT.f(c.getMobile())%>"/>
                </td>
            </tr>
            <tr>
                <td class="text-r"><em>*</em>邮箱：</td>
                <td>
                    <input name="mail" id="mail"  alt="邮箱不能为空!"  class="form-control" style="width:292px"
                           type="text" value="<%=MT.f(c.getMail())%>"/>
                </td>
            </tr >
            <tr>
                <td class="text-r"><em>*</em>邮编：</td>
                <td>
                    <input pattern="^\d{6}$" name="youbian" id="youbina" alt="邮编不能为空!" class="form-control" style="width:292px"
                           type="text" value="<%=MT.f(c.getYoubian())%>"/>
                </td>
            </tr>
            <tr>
                <td class="text-r"><em>*</em>所在地区：</td>
                <td>
                    <script>mt.city("city0","city1","",'<%=MT.f(c.getCity())%>');</script>
                </td>
            </tr>
            <tr>
                <td class="text-r"><em>*</em>详细地址：</td>
                <td>
                    <input alt="地址不能为空!" name="address" id="address" class="form-control" style="width:292px"
                           type="text" value="<%=MT.f(c.getAddress())%>"/>
                </td>
            </tr >
            <%
            if(h.getInt("jiesuan")==1){%>
                <tr style="display: none">
                <td class="text-r"><em>*</em>是否默认：</td>
                <td>
                    <select name="ismoren" class="form-control" style="width:292px">
                        <option class="text-r" value="0" <%= (c.getIsmoren()==0?"selected='selected'":"") %>>否</option>
            <option class="text-r" value="1" <%= (c.getIsmoren()==1?"selected='selected'":"") %>>是</option>
            </select>

            </td>
            </tr>
            <%}else {%>
            <tr>
                <td class="text-r"><em>*</em>是否默认：</td>
                <td>
                    <select name="ismoren" class="form-control" style="width:292px">
                        <option class="text-r" value="0" <%= (c.getIsmoren()==0?"selected='selected'":"") %>>否</option>
                        <option class="text-r" value="1" <%= (c.getIsmoren()==1?"selected='selected'":"") %>>是</option>
                    </select>

                </td>
            </tr>
           <% }
            %>


        </table>
    </form>

</div>
<div class="center text-c pd20">
    <a href="javascript:;" onclick="subEmpower()" class="btn btn-primary btn-blue">保存</a>&nbsp;&nbsp;
    <button class="btn btn-default" type="button" onclick="closetc()">关闭</button>
</div>
</body>
</html>
<script>
    var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
    function closetc() {
        parent.layer.close(index);
    }
    var a = parent.document.URL;
    a=a.substring(21,a.length);
    form2.nexturl.value = "/jsp/yl/shopweb/PersonalAddress.jsp";
    var reg = /^1(3|4|5|6|7|8|9)\d{9}$/;
    var reg1 = /^\d{6}$/;
    var reg3=/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
    function subEmpower() {
        if (mtDiag.check1($("#form2"))) {
            form2.act.value = 'add';
            var mob = form2.mobile.value;
            var city = form2.city1.value;
            if(city.length<1){
                mt.show("必选项所在地区");
                form2.city.focus();
                return false;
            }
            if(!reg.test(mob)){
                mt.show("手机格式不正确");
                form2.mobile.focus();
                return false;
            }
            var mail = form2.mail.value;
            if(mail.length>0&&!reg3.test(mail)){
                mt.show("邮箱格式不正确");
                form1.mail.focus();
                return false;
            }
            var youbian = form2.youbian.value;
            if(!reg1.test(youbian)){
                mt.show("邮编格式不正确");
                form2.youbian.focus();
                return false;
            }
            if(a.indexOf("ShopOrderFormUnitTps")==-1){
                form2.submit();
            }else {
                    fn.ajax("/mobjsp/yl/shop/ajax.jsp?act=orderjiesuan",$("#form2").serialize(),function(data){
                        if(data.type>0){
                            mtDiag.close();
                            mtDiag.show(data.mes);
                            return;
                        }else{
                            mtDiag.show('操作成功！',"alert",null,function(index){
                                parent.readd(data);
                                //parent.location.reload();
                                parent.mtDiag.close();
                            });
                        }
                    });

            }

        }

    }



</script>