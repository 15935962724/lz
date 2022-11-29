<%@page import="tea.entity.yl.shop.ShopQualification"%>
<%@page import="tea.entity.yl.shop.ShopHospital"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.*"%><%@page import="tea.entity.admin.*"%><%@page import="tea.entity.member.*"%><%

    Http h=new Http(request,response);
    if(h.member<1)
    {
        out.println("<script>alert('您还没有登陆或登陆已超时！请重新登陆');location.replace('/my/Login.jsp?nexturl='+encodeURIComponent(location.pathname+location.search));</script>");
        return;
    }

    /* Member m=Member.find(h.member); */
    Profile m=Profile.find(h.member);

    /* Site s=Site.find(1); */


%><!doctype html><html><head>
<title><%=Res.get(h.language,"个人资料")%></title>

</head>
<body style="min-height:800px;">

<%
    boolean flag = false;
    ShopQualification sq = ShopQualification.findByMember(m.profile);
    if(m.qualification>0||(sq.status==1)||sq.status==5){//不能编辑
        flag = true;
    }
%>
<script src='/tea/mt.js'></script>
<script src='/tea/city.js'></script>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src='/tea/jquery-1.3.1.min.js'></script>
<link rel="stylesheet" href="/tea/new/css/style.css">
<script src="/tea/new/js/jquery.min.js"></script>
<script src="/tea/new/js/superslide.2.1.js"></script>
<script src="/tea/yl/mtDiag.js"></script>
<style>
    .con-left .bd:nth-last-child(2){
        display:block;
    }
    .con-left ul.bd:nth-last-child(2) li:nth-child(3){
        font-weight: bold;
    }
    .con-left-list .tit-on7{color:#044694;}

</style>
<form name="form1" action="/ShopQualifications.do" method="post" enctype="multipart/form-data" target="_ajax" onSubmit="return mt.check(this)">
    <input type="hidden" name="act" value="edit"/>
    <input type="hidden" name="nexturl" value="parent.location.reload()"/>
    <input type="hidden" name="qua" value="<%= sq.id%>"/>
    <input type="hidden" name="state" value=""/>
    <%-- <input type="hidden" name="avatar" value="<%=m.avatar%>"/> --%>
    <%--  <table id="tablecenter" cellspacing="0" style="background:none;">
     <tr><td class="ModifyHead"><img id="_avatar" src="<%=MT.f(m.avatar,"/tea/image/avatar.jpg")%>" /><br>
    <a href="javascript:my.avatar()">修改头像</a></td></tr></table>  --%>


    <%@ include file="/jsp/yl/shopweb/PersonalTop.jsp" %>
    <div id="Content">
        <div class="con-left">
            <%@ include file="/jsp/yl/shopweb/PersonalLeft.jsp" %>
        </div>
        <div class="con-right">
            <p class="right-zhgl">
                <span>账户管理</span>
            </p>
            <p class="right-dz">
                <span>安全设置</span>
            </p>
            <div class="right-list1">
                <p class="right-aq">
                    <span>邮箱　　<em><%=MT.f(m.email)%></em></span>
                    <% if(!MT.f(m.email).equals("")){
                        out.print("<a href='javascript:void(0);' onclick=oncheckpage('email','修改邮箱')>修改</a>");
                    }else{
                        out.print("还未绑定邮箱&nbsp;&nbsp;<a href='javascript:void(0);' onclick=oncheckpage('email','绑定邮箱') >绑定</a>");
                    }%>
                </p>
                <p class="right-aq">
                    <span>手机号　<em><%=MT.f(m.mobile)%></em></span>
                    <% if(!MT.f(m.mobile).equals("")){
                        /*out.print("&nbsp;&nbsp;<a href='javascript:void(0);' onclick=oncheckpage('mobile','修改手机号') >修改</a>");*/
                    }else{
                        out.print("还未绑定手机&nbsp;&nbsp;<a href='javascript:void(0);' onclick=onsetpage('mobile','绑定手机号')>绑定</a>");
                    }%>
                </p>
                <p class="right-aq">
                    <span>登录密码<em>****</em></span>
                    <a href='javascript:void(0);' onclick="editPW('editPW')">修改</a>
                </p>
            </div>

        </div>
    </div>
</form>


<form action="/Attchs.do" name="form9" method="post" target="_ajax">
    <input name="act" type="hidden" value="down" />
    <input name="attch" type="hidden" />
</form>

<script>

    function oncheckpage(type,tit){
        layer.open({
            type: 2,
            title: tit,
            shadeClose: true,
            area: ['475px', '220px'],
            closeBtn:1,
            //content: '/jsp/yl/shopweb/ShopCheckEmailMobile.jsp?type='+type
            content: '/jsp/yl/shopweb/ShopCheckEmaiupdate.jsp?type='+type+"&nexturl=/jsp/yl/shopweb/SecuritySetting.jsp"
        });
    }

    function onsetpage(type,tit){
        layer.open({
            type: 2,
            title: tit,
            shadeClose: true,
            area: ['475px', '270px'],
            closeBtn:1,
            content: '/jsp/yl/shopweb/ShopEmailMobile.jsp?type='+type
        });
    }

    function downatt(num){
        form9.attch.value = num;
        form9.submit();
    };

    function editPW(type) {
        layer.open({
            type: 2,
            title:"修改密码",
            shadeClose: true,
            area: ['480px', '290px'],
            closeBtn:1,
            //content: '/jsp/yl/shopweb/ShopCheckEmailMobile.jsp?type='+type
            content: '/jsp/yl/shopweb/ShopCheckEmaiupdate.jsp?type='+type+"&nexturl=/jsp/yl/shopweb/SecuritySetting.jsp"
        });
    };

</script>

<script>
    mt.fit();
</script>

</body>
</html>
