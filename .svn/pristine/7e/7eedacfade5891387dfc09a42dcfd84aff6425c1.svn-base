<%@page import="tea.db.DbAdapter" %>
<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.entity.yl.shopnew.*" %>
<%@page import="tea.entity.yl.shop.*" %>
<%@page import="tea.entity.member.Profile" %>
<%@ page import="util.Config" %>
<%

    Http h = new Http(request, response);
    if (h.member < 1) {
        response.sendRedirect("/servlet/StartLogin?community=" + h.community);
        return;
    }

    String nexturl = h.get("nexturl");
    int questionid = h.getInt("id");
//根据发票id查询发票和发票详情
    Question question = Question.find(questionid);
    String sql = " AND id="+questionid;
%><!DOCTYPE html><html><head>
<script>
    var ls=parent.document.getElementsByTagName("HEAD")[0];
    document.write(ls.innerHTML);
    var arr=parent.document.getElementsByTagName("LINK");
    for(var i=0;i<arr.length;i++)
    {
        document.write("<link href='"+arr[i].href+"' rel='"+arr[i].rel+"' type='text/css'>");
    }
</script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/view.js" type="text/javascript"></script>
<script src="/tea/jquery-1.11.1.min.js"></script>

</head>
<body>
<h1>问卷详情</h1>
<table id="tablecenter" cellspacing="0">
    <tr>
        <td >医院名称</td>
        <td><%=MT.f(question.getHospital_name()) %>
        </td>
    </tr>
    <tr>
        <td>医院科室</td>
        <td><%=MT.f(question.getHospital_ks()) %>
    </tr>
    <tr>
        <td>提交人</td>
        <td><%=MT.f(Profile.find(question.getProfile()).getMember()) %>
    </tr>
    <tr>
        <td>提交时间</td>
        <td><%=MT.f(question.getCreatTime()) %>
    </tr>
    <tr>
        <td>订单号</td>
        <td><%=MT.f(question.getOrderId()) %>
        </td>
    </tr>
    <tr>
        <td>订单时间</td>
        <td><%=MT.f(question.getBeginTime()) + "-" + MT.f(question.getEndTime()) %>
        </td>
    </tr>
    <tr>
        <td>性别</td>
        <td><%=MT.f(question.getGender() == 1 ? "男" : question.getGender() == 2 ? "女" : "") %>
        </td>
    </tr>
    <tr>
        <td>年龄</td>
        <td><%=MT.f(question.getAge()) %>
        </td>
    </tr>
    <tr>
        <td>原患疾病</td>
        <td><%=MT.f(question.getYhjb()) %>
        </td>
    </tr>
    <tr>
        <td>既往史</td>
        <td><%=MT.f(question.getJws() == 1 ? "吸烟史、饮酒史" : question.getJws() == 2 ? "妊娠期、肝病史、肾病史、过敏史" : "") %>
        </td>
    </tr>
    <tr>
        <td>用药原因</td>
        <td><%=MT.f(question.getYyyy()) %>
        </td>
    </tr>
    <tr>
        <td>药品来源</td>
        <td><%=MT.f(question.getYply() == 1 ? "宁波君安药业科技有限公司" : question.getYply() == 2 ? "其他" : "") %>
        </td>
    </tr>
    <tr>
        <td>用量</td>
        <td><%=MT.f(question.getNum()) + "粒" %>
        </td>
    </tr>
    <tr>
        <td>联合用药情况</td>
        <td><%=question.getLhyyqk() == 1 ? "有" : "无"%>
        </td>
    </tr>
    <%
        if (question.getLhyyqk() == 1) {%>
    <tr>
        <td>联合用药详情</td>
        <td><%=MT.f(question.getLhyyqktext())%>
        </td>
    </tr>
    <%
        }
    %>
    <tr>
        <td>碘[125I]密封籽源：客户使用本药品前后肿瘤是否缩小，生活质量是否改善</td>
        <td><%=question.getSfgs() == 1 ? "有" : question.getSfgs() == 2 ? "无" : "严重"%>
        </td>
    </tr>
    <tr>
        <td>严重情况说明</td>
        <td><%=MT.f(question.getYzqksm())%>
        </td>
    </tr>
    <tr>
        <td>不良反应</td>
        <td><%=question.getBlfy() == 1 ? "有" : "无"%>
        </td>
    </tr>
    <%
        if (question.getBlfy() == 1) {%>
    <tr>
        <td>不良反应详情</td>
        <td><%=question.getBlfytext()%>
        </td>
    </tr>
    <%
        }
    %>
</table>
<br>
<button class="btn btn-primary" type="button" onclick="daochu()">导出</button>
<button class="btn btn-default" type="button" onclick="location='<%=nexturl%>'">返回</button>
</body>
</html>
<form action="/ExpTable.do" name="form3" method="post" target="_ajax">
    <input type="hidden" name="act" value="exp_question">
    <input type="hidden" name="sql" value="<%=sql%>">
</form>
<script>
    function daochu() {
        form3.submit();
    }
</script>
