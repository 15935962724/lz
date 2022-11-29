<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.sup.*"%>
<%@page import="tea.entity.yl.shop.*"%>
<%@ page import="tea.entity.member.Profile" %>
<%@ page import="tea.entity.admin.orthonline.Hospital" %>
<%@ page import="tea.entity.member.Meeting" %>
<%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
int id = h.getInt("id");

    TbMeeting up = TbMeeting.find(id);
    Profile p = Profile.find(up.getMember());
    String []str={"审核中","审核通过","审核未通过","已取消"};

%><html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js"></script>
<script src="/tea/yl/jquery-1.7.js"></script>
<script src="/tea/yl/top.js"></script>

</head>
<body >
<h1>会议申请详情</h1>
<form name="form2" action="/TbMeetings.do" id="form2" method="post" target="_ajax">
    <input type="hidden" name="community" value="<%=h.community%>"/>
    <input type="hidden" name="nexturl"/>
    <input type="hidden" name="act" value="shenpi_meet"/>
    <input type="hidden" name="id" value="<%=id%>">
    <input type="hidden" name="type">
</form>
<table id="tablecenter">
    <tr>
        <td width="100">会议名称:</td>
        <td><%=MT.f(up.getName())%></td>
    </tr>
	<tr>
		<td width="100">申请人:</td>
		<td><%=MT.f(p.getMember())%></td>
	</tr>
    <tr>
        <td width="100">申请时间:</td>
        <td><%=MT.f(up.getCreate_Data())%></td>
    </tr>
    <tr>
        <td width="100">手机号:</td>
        <td><%=p.getMobile()%></td>
    </tr>
    <tr>
        <td width="100">邮箱:</td>
        <td><%=MT.f(p.getEmail())%></td>
    </tr>
    <tr>
        <td width="100">会议通知:</td>
        <td>
            <%
                if(up.getInform()>0){
            %>
            <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(up.getInform()) %>');">查看</a>
            <%
                }else{
                    out.print("无文件!");
                }
            %>
        </td>
    </tr>
    <tr>
        <td width="100">招商函:</td>
        <td>
            <%
                if(up.getZhaoshang()>0){
            %>
            <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(up.getZhaoshang()) %>');">查看</a>
            <%
                }else{
                    out.print("无文件!");
                }
            %>
        </td>
    </tr>
    <tr>
        <td width="100">会议申请表:</td>
        <td>
            <%
                if(up.getApply()>0){
            %>
            <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(up.getApply()) %>');">查看</a>
            <%
                }else{
                    out.print("无文件!");
                }
            %>
        </td>
    </tr>
    <tr>
        <td width="100">状态:</td>
        <td><%=str[up.getType()]%></td>
    </tr>
    <%if(up.getType()==2){%>
    <tr>
        <td width="100">驳回原因:</td>
        <td><%=MT.f(up.getCause())%></td>
    </tr>
    <%}%>
</table>

<form action="/Attchs.do" name="form9" method="post" target="_ajax">
    <input name="act" type="hidden" value="down" />
    <input name="attch" type="hidden" />
</form>
<div class="mt15">
    <%
        if(up.getType() == 0){
    %>
    <button class="btn btn-primary" type="button" onclick="yes()">审核通过</button>&nbsp;&nbsp;<button class="btn btn-primary" type="button" onclick="no()">审核不通过</button>&nbsp;&nbsp;
    <%
        }
    %>
    <button class="btn btn-default" type="button" onclick="history.back(-1)">返回</button>
</div>
<script>

    form2.nexturl.value=location.pathname+location.search;
   function no() {
       layer.prompt({title: '拒绝原因', formType: 2}, function (pass, index) {
           fn.ajax("/TbMeetings.do?act=shenpi_meet&id=<%=id%>&type=2", "desc=" + pass, function (data) {
               if (data.type == 0) {
                   layer.msg('操作执行成功', {time: 1000}, function () {
                       location.reload();
                   });
               } else {
                   layer.alert("系统异常，请重试!");
               }

           });
           layer.close(index);
       });
   }
   function yes() {
       form2.type.value="1";
       form2.submit();
   }
    function downatt(num){

        form9.attch.value = num;
        form9.submit();
    }
    mt.fit();
</script>

</body>
</html>
