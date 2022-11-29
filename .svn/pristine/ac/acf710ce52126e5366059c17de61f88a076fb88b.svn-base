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
    int agreedid = h.getInt("id");

    Agreed agreed = Agreed.find(agreedid);
    int type = agreed.getType();
    Profile profile = Profile.find(agreed.getProfile());

    ProcurementUnitJoin puj = ProcurementUnitJoin.find(agreed.getCompanyid());
    int puid = puj.getPuid();
    String cj = "";//厂家
    if (puid == Config.getInt("gaoke")) {
        cj = "高科";
    } else if (puid == Config.getInt("junan")) {
        cj = "君安";
    } else if (puid == Config.getInt("xinke")) {
        cj = "欣科";
    } else if (puid == Config.getInt("tongfu")) {
        cj = "同辐";
    }

    String sql = " AND id="+agreedid;
%><!DOCTYPE html><html><head>
<script>
    var ls = parent.document.getElementsByTagName("HEAD")[0];
    document.write(ls.innerHTML);
    var arr = parent.document.getElementsByTagName("LINK");
    for (var i = 0; i < arr.length; i++) {
        document.write("<link href='" + arr[i].href + "' rel='" + arr[i].rel + "' type='text/css'>");
    }
</script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/view.js" type="text/javascript"></script>
<script src="/tea/jquery-1.11.1.min.js"></script>

</head>
<body>
<h1><%=type==0?"同辐服务商":"高科医院"%>满意度详情</h1>
<table id="tablecenter" cellspacing="0">
    <%if(type==0){%>
    <tr>
        <td>公司名称</td>
        <td><%=MT.f(puj.getCompany()) %>
        </td>
    </tr>
    <tr>
        <td>地址</td>
        <td><%=MT.f(agreed.getGsdz()) %>
    </tr>
    <tr>
        <td>联系人</td>
        <td><%=MT.f(profile.getMember()) %>
    </tr>
    <tr>
        <td>联系电话</td>
        <td><%=MT.f(profile.getMobile()) %>
    </tr>
    <tr>
        <td>提交时间</td>
        <td><%=MT.f(agreed.getCreatTime()) %>
    </tr>
    <tr>
        <td>邮箱</td>
        <td><%=MT.f(profile.getEmail()) %>
    </tr>
    <tr>
        <td>传真</td>
        <td><%=MT.f(agreed.getCz()) %>
    </tr>
    <tr>
        <td>籽源生产厂家</td>
        <td><%=MT.f(cj) %>
        </td>
    </tr>
    <%
        }else {%>
    <tr>
        <td>医院名称</td>
        <td><%=MT.f(agreed.getGsdz()) %>
        </td>
    </tr>
    <tr>
        <td>科室</td>
        <td><%=MT.f(agreed.getCz()) %>
        </td>
    </tr>
    <tr>
        <td>联系人</td>
        <td><%=MT.f(profile.getMember()) %>
    </tr>
    <tr>
        <td>联系电话</td>
        <td><%=MT.f(profile.getMobile()) %>
    </tr>
    <tr>
        <td>籽源生产厂家</td>
        <td>原子高科股份有限公司</td>
    </tr>
        <%}
        String myd = agreed.getMyd();
        String[] split = myd.split(",");
        String mydbz = agreed.getMydbz();
        String[] split1 = mydbz.split(",");
        for (int i = 0; i < Agreed.TIMU.length; i++) {
    %>
    <tr>
        <td><%=Agreed.TIMU[i]%>
        </td>
        <td><%
            String daan = "";
            try {
                daan = Agreed.DAAN[Integer.parseInt(split[i]) - 1];
                if(Integer.parseInt(split[i])>2){
                    daan+="【"+MT.f(split1[i])+"】";
                }
            } catch (Exception e) {
                daan = "";
            }


        %>
            <%=daan%>
        </td>
    </tr>
    <%
        }
    %>
    <tr>
        <td>新产品需求</td>
        <td><%=agreed.getCpxq()==1?MT.f(agreed.getCpxqsm()):"无"%>
        </td>
    </tr>
    <tr>
        <td>意见或建议</td>
        <td><%=MT.f(agreed.getIdea())%>
        </td>
    </tr>
</table>
<br>
<button class="btn btn-primary" type="button" onclick="daochu()">导出</button>
<button class="btn btn-default" type="button" onclick="location='<%=nexturl%>'">返回</button>
</body>
</html>
<form action="/ExpTable.do" name="form3" method="post" target="_ajax">
    <input type="hidden" name="act" value="exp_agreed">
    <input type="hidden" name="sql" value="<%=sql%>">
    <input type="hidden" name="type" value="<%=type%>">
</form>
<script>
    function daochu() {
        form3.submit();
    }
</script>
