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
    int type = h.getInt("type");//是否是修改 ==2修改 ==10详细进入
    String []str={"审核中","审核通过","审核未通过","已取消"};

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
    <style>
        .con-left-list .tit-on6 {
            color: #044694;
        }

    </style>
</head>
<body style='min-height:800px;'>
<%@ include file="/jsp/yl/shopweb/PersonalTop.jsp" %>
<div id="Content">
    <div class="con-left">
        <%@ include file="/jsp/yl/shopweb/PersonalLeft.jsp" %>
    </div>
    <div class="con-right">
        <p class="right-zhgl right-zhgl2" style="line-height:40px;height:40px;">
            <span>会议申请</span>

        </p>
        <%-- <p style='width:100%;overflow:hidden;'>
            <input class='mbxz' type='button' value='申请模板下载'>
        </p> --%>
        <form name="form2" class="form-horizontal" id="form2" action="/TbMeetings.do" method="post"
              enctype="multipart/form-data" target="_ajax">
            <input type="hidden" name="act" value="add_meeting">
            <input type="hidden" name="meet_id" value="<%=meeting_id%>">
            <input type="hidden" name="nexturl">
            <table class='meet-tab'>
                <tr>
                    <td class='td1'><em>*</em>会议名称：</td>
                    <td><%if(meeting_id==0||type==2){%>
                        <input  name="meet_name" type="text" alt="会议名称不能为空！" value="<%=MT.f(meeting.getName())%>">
                        <%}else {%>
                        <span><%=MT.f(meeting.getName())%></span>
                        <%}%>
                    </td>
                </tr>
                <tr>
                    <td class='td1'><em>*</em>会议通知：</td>
                    <td>
                        <%if (meeting_id == 0) {//新增%>
                        <input name="inform" type="file" value="" alt="会议通知为必须项！">
                        <%} else if(type==2){//修改%>
                             <input name="inform" type="file" value="" alt="会议通知为必须项！">
                        <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(meeting.getInform())%>');">查看</a>

                        <%}else {//查看%>
                        <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(meeting.getInform())%>');">查看</a>
                        <%}%>

                    </td>
                </tr>
                <tr>
                    <td class='td1'><em>*</em>招商函：</td>
                    <td>
                        <%if (meeting_id == 0) {//新增%>
                        <input name="zhaoshang" type="file" alt="招商函为必须项！">
                        <%}else if(type==2){%>
                        <input name="zhaoshang" type="file" alt="招商函为必须项！">
                        <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(meeting.getZhaoshang())%>');">查看</a>

                        <%} else {%>
                        <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(meeting.getZhaoshang())%>');">查看</a>
                        <%}%>
                    </td>
                </tr>
                <tr>
                    <td class='td1'><em>*</em>会议申请表：</td>
                    <td>
                        <%if (meeting_id == 0) {%>
                        <input name="apply" type="file" alt="会议申请表为必须项！"/>
                        <%}else if(type==2){%>
                        <input name="apply" type="file" alt="会议申请表为必须项！"/>
                        <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(meeting.getApply())%>');">查看</a>

                        <%} else {%>
                        <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(meeting.getApply())%>');">查看</a>
                        <%}%>

                    </td>

                    <td>
                        <a href="/tea/meetApply.doc" download="/tea/meetApply.doc"

                           style="color:#044694;text-decoration: underline" >会议申请表模版下载</a>
                    </td>
                </tr>
                <%if(meeting_id!=0){%>
                <tr>
                    <td class='td1'>状态：</td>
                    <td><span><%=str[meeting.getType()]%></span></td>
                </tr>
                <%}
                if(meeting.getType()==2&&10!=h.getInt("type")){//审核失败%>
                <tr>
                    <td class='td1'>审核失败原因：</td>
                    <td>
                        <span><%=meeting.getCause()%></span>
                    </td>
                </tr>

                <%}%>
            </table>
            <%if (meeting_id == 0) {%>
            <p style='width:100%;text-align:center;'>
                <button class='meet-tj' onclick="mysupmit()">提交审核</button>
            </p>
            <%}%>
            <%if(meeting.getType()==2&& meeting_id!=0&&type!=2){//已退回，可以取消修改%>
            <p style='width:100%;text-align:center;'>
                <button class='meet-tj' onclick="dele_meet('<%=meeting.getId()%>')">取消会议</button>
            </p>
            <p style='width:100%;text-align:center;'>
                <button class='meet-tj' onclick="xiugai_meet('<%=meeting.getId()%>','2')">修改会议</button>
            </p>
            <%}else if(type==2){//修改%>
            <p style='width:100%;text-align:center;'>
                <button class='meet-tj' onclick="mysupmit()">提交审核</button>
            </p>
            <%}else if(type==3){%>

            <%}%>
        </form>
    </div>

</div>
<form action="/Attchs.do" name="form9" method="post" target="_ajax">
    <input name="act" type="hidden" value="down"/>
    <input name="attch" type="hidden"/>
</form>
</body>
</html>
<script>
    function downatt(num) {
        form9.attch.value = num;
        form9.submit();
    }

    function mysupmit() {

        form2.nexturl.value="/jsp/yl/shopweb/MeetingManage.jsp";
        if (mtDiag.check($("#form2"))) {

            form2.submit();
        }

    }

    function dele_meet(id) {
        form2.act.value="dele_meet";
        form2.nexturl.value="/jsp/yl/shopweb/MeetingManage.jsp";
        form2.submit();
    }

    function xiugai_meet(id, type) {
        location.href="/jsp/yl/shopweb/ApplyMeeting.jsp?id="+id+"&type="+type;
    }
</script>