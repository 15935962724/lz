<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
    int meeting_id = h.getInt("id", 0);//获取会议id
    TbMeeting meeting = TbMeeting.find(meeting_id);
    int type = h.getInt("type");//是否是修改 ==2修改
    String[] str = {"审核中", "审核通过", "审核未通过", "已取消"};

%>
<html>
<head>
    <meta charset="UTF-8">
    <title>会议申请</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="/tea/mobhtml/m-style.css">

    <script src="/tea/mt.js" type="text/javascript"></script>
    <script src="/jsp/sup/sup.js" type="text/javascript"></script>
    <script src="/tea/new/js/superslide.2.1.js"></script>
    <script src='/tea/yl/mtDiag.js' type="text/javascript"></script>
    <script src="/tea/jquery-1.3.1.min.js"></script>
</head>
    <style>
    .file {
    position: relative;
    display: inline-block;
    border: none;
    overflow: hidden;
    color: #044694;
    text-decoration: none;
    text-indent: 0;
    width:73%;
    line-height: 20px;
    top:10px;
    }
    .met-span{width:25%;}
    .per-con3-a .file input[type=file] {
    position: absolute;
    font-size: 100px;
    right: 0;
    top: 0;
    opacity: 0;
    width:auto;
    font-size: 1rem;
    }
    .file:hover {
    color: #044694;
    text-decoration: none;
    }
    .showFileName{
    margin-left:10px;
    display:inline-block
    ;width:70%;
    overflow:hidden;
    text-overflow:ellipsis;
    }
    @media screen and (max-width: 320px) {
    .file{width:200px;}
    .showFileName{width:70%;}
    .per-add-inp{width:200px;}
    }
    </style>
<body>
<div class="body">


    <div class="Content">
        <form name="form2" class="form-horizontal" id="form2" action="/TbMeetings.do" method="post"
              enctype="multipart/form-data" target="_ajax">
            <input type="hidden" name="act" value="add_meeting">
            <input type="hidden" name="meet_id" value="<%=meeting_id%>">
            <input type="hidden" name="nexturl">

            <div class="person-con4 met-con met-con2">
<%--                <div class="per-con3-a4 bor-b">--%>
                    <%--<tr>
                        <td class='td1'><em>*</em>会议名称：</td>
                        <td><%if(meeting_id==0||type==2){%>
                            <input  name="meet_name" type="text" alt="会议名称不能为空！" value="<%=MT.f(meeting.getName())%>">
                            <%}else {%>
                            <span><%=MT.f(meeting.getName())%></span>
                            <%}%>
                        </td>
                    </tr>--%>
                    <p class='per-con3-a bor-b'>
                        <span class="fl-left ft16  met-span"><em>*</em>会议名称</span>
                        <%if (meeting_id==0||type==2) {//新增,修改%>
                        <input class='per-add-inp ft16 ml-t15' type="text" alt="会议名称不能为空！" name="meet_name" value="<%=MT.f(meeting.getName())%>"/>

                        <%} else {%>
                        <span class="fl-left ft16  ml-t15"><%=MT.f(meeting.getName())%></span>
                        <%}%>

                    </p>
                    <%--<p class="met-res">不通过原因<a class="fl-right">修改</a></p>--%>


                    <%-- <td>
                            <%if (meeting_id == 0) {//新增%>
                            <input name="zhaoshang" type="file" alt="招商函为必须项！">
                            <%}else if(type==2){%>
                            <input name="zhaoshang" type="file" alt="招商函为必须项！">
                            <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(meeting.getZhaoshang())%>');">查看</a>

                            <%} else {%>
                            <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(meeting.getZhaoshang())%>');">查看</a>
                            <%}%>
                        </td>--%>
                    <p class='per-con3-a bor-b'>
                        <span class="fl-left ft16  met-span"><em>*</em>会议申请表</span>
                        <%--<a class="fl-left ft16  ml-t15 me-a">123.jpg</a>--%>
                        <%
                            if (meeting_id == 0) {//新增%>
                            <a href="javascript:;" class="file">
                                <span class='showFileName'></span>
                                <span style='float:right'>上传</span>
                                <input type="file" class=' a-upload' name="apply" id="" alt="会议申请表为必须项！">
                            </a>
<%--                        <input name="apply" type="file" alt="会议申请表为必须项！"/>--%>
                            <%}else if(type==2){//修改%>
                        <a href="javascript:;" class="file">
                            <span class='showFileName'></span>
                            <span style='float:right'>上传</span>
                            <input type="file" class=' a-upload' name="apply" id="" alt="会议申请表为必须项！">
                        </a>
<%--                        <input name="apply" type="file" alt="会议申请表为必须项！"/>--%>
                        <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(meeting.getApply())%>');">查看</a>
                            <%} else {//查看
                        %>
                        <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(meeting.getApply())%>');">查看</a>

                        <%}%>
                    </p>
                    <%--<p class="met-res">不通过原因<a class="fl-right">修改</a></p>--%>


                    <p class='per-con3-a bor-b'>
                        <span class="fl-left ft16 met-span"><em>*</em>招商函</span>
                        <%--<a class="fl-left ft16  ml-t15 me-a">123.jpg</a>--%>

                        <%
                            if (meeting_id == 0) {//新增%>
                            <a href="javascript:;" class="file">
                                <span class='showFileName'></span>
                             <span style='float:right'>上传</span>
                                <input type="file" class=' a-upload' name="zhaoshang" id="" alt="招商函为必须项！">
                            </a>
<%--                        <input name="zhaoshang" type="file" alt="招商函为必须项！">--%>
                        <%
                        } else  if(type==2){//修改%>
                        <a href="javascript:;" class="file">
                            <span class='showFileName'></span>
                            <span style='float:right'>上传</span>
                            <input type="file" class=' a-upload' name="zhaoshang" id="" alt="招商函为必须项！">
                        </a>
<%--                        <input name="zhaoshang" type="file" alt="招商函为必须项！">--%>
                        <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(meeting.getZhaoshang())%>');">查看</a>
                        <%}else {
                        %>
                        <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(meeting.getZhaoshang())%>');">查看</a>
                        <%}%>
                        <%--<p class="met-res">不通过原因<a class="fl-right">修改</a></p>--%>
                    </p>

                    <p class='per-con3-a bor-b'>
                        <span class="fl-left ft16 met-span"><em>*</em>会议通知</span>
                        <%--<a class="fl-left ft16  ml-t15 me-a">123.jpg</a>--%>
                        <%if (meeting_id == 0) {//新增%>
                        <a href="javascript:;" class="file">
                            <span class='showFileName'></span>
                            <span style='float:right'>上传</span>
                            <input type="file" class=' a-upload' name="inform" id="" alt="会议通知为必须项！">
                        </a>
<%--                        <input name="inform" type="file" value="" alt="会议通知为必须项！">--%>
                        <%}else if(type==2){//修改%>
                        <a href="javascript:;" class="file">
                            <span class='showFileName'></span>
                            <span style='float:right'>上传</span>
                            <input type="file" class=' a-upload' name="inform" id="" alt="会议通知为必须项！">
                        </a>
<%--                        <input name="inform" type="file" value="" alt="会议通知为必须项！">--%>
                        <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(meeting.getInform())%>');">查看</a>

                        <%} else {//编辑%>
                        <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(meeting.getInform())%>');">查看</a>
                        <%}%>
                    </p>
                    <%--<p class="met-res">不通过原因<a class="fl-right">修改</a></p>--%>

                <%if (meeting_id != 0) {//新增不显示状态%>

                    <p  class='per-con3-a bor-b'>
                        <span class="fl-left ft16 met-span">&nbsp;&nbsp;状态</span>
                        <span class="fl-left ft16  ml-t15"><%=MT.f(str[meeting.getType()])%></span>
                    </p>

                <%}

                if(meeting.getType()==2){%>

                    <p  class='per-con3-a bor-b'>
                        <span class="fl-left ft16 met-span"><em>*</em>审核失败原因</span>
                        <span><%=MT.f(meeting.getCause())%></span>
                    </p>

                <%}%>
            </div>
            <p style="margin-top:15px;">
                    <%if(meeting_id==0||type==2){//审核中%>
                <button class='meet-tj per-add-save ft14' onclick="mysupmit()" >提交审核</button>
                    <%}else if(meeting.getType()==2){//失败%>
                <input type="button" onclick="dele_meet('<%=meeting.getId()%>')" value="取消会议" class="per-add-save ft14">
                <input type="button"  onclick="xiugai_meet('<%=meeting.getId()%>','2')" value="修改会议" class="per-add-save ft14">
                    <%}%>

            <p>
            </p>
        </form>
<%--    </div>--%>


</div>
<form action="/Attchs.do" name="form9" method="post" target="_ajax">
    <input name="act" type="hidden" value="down"/>
    <input name="attch" type="hidden"/>
</form>
<script>

    function downatt(num) {
        form9.attch.value = num;
        form9.submit();
    }

    function dele_meet(id) {
        form2.act.value = "dele_meet";
        form2.nexturl.value = "/mobjsp/yl/shopweb/MeetingManage.jsp";
        form2.submit();
    }

    function mysupmit() {

        form2.nexturl.value = "/mobjsp/yl/shopweb/MeetingManage.jsp";
        if (mtDiag.check($("#form2"))) {
            form2.submit();
        }

    }
    function xiugai_meet(id, type) {
        location.href="/mobjsp/yl/shopweb/MeetingContent.jsp?id="+id+"&type="+type;
    }

    // $("#fileinp").change(function () {
    //     console.log($(".per-add-inp ").val());
    //     $(".file-tit").html($(".per-add-inp ").val());
    // })
    $(function(){
        $('.a-upload').change(function() {
            var filePath=$(this).val();
            var arr=filePath.split('\\');
            var fileName=arr[arr.length-1];
            console.log(arr[1]);
            console.log(fileName);
            $(this).parent().find('.showFileName').html(fileName);
        });
    });
</script>
</body>
</html>