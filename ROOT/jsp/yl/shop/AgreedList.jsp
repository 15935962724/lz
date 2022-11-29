<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.entity.Http" %>
<%@page import="tea.entity.MT" %>
<%@page import="tea.entity.member.Profile" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="tea.entity.Database" %>
<%@ page import="tea.entity.yl.shop.Question" %>
<%@ page import="tea.entity.yl.shop.Agreed" %>
<%@ page import="tea.entity.yl.shop.ProcurementUnitJoin" %>
<%@ page import="java.util.List" %>
<%@ page import="IceInternal.Ex" %>
<%

    Http h = new Http(request, response);
    if (h.member < 1) {
        response.sendRedirect("/servlet/StartLogin?community=" + h.community);
        return;
    }
    StringBuffer sql = new StringBuffer(), par = new StringBuffer();

    int type = h.getInt("type");//0 同辐服务商满意度     1 高科医院满意度
    par.append("&type="+type);
    if(type==0) {
        sql.append(" AND type!=1 ");
    }else {
        sql.append(" AND type=1 ");
    }

    Date t0 = h.getDate("t0");
    if (t0 != null) {
        sql.append(" AND creatTime>=" + Database.cite(t0));
        par.append("&t0=" + MT.f(t0));
    }
    Date t1 = h.getDate("t1");
    if (t1 != null) {
        sql.append(" AND creatTime<=" + Database.cite(t1));
        par.append("&t1=" + MT.f(t1));
    }
    int menuid = h.getInt("id");
    par.append("?community=" + h.community + "&id=" + menuid);
    String name = h.get("name");
    if (!"".equals(name) && name != null) {
        sql.append(" AND hospital_name like'%" + name + "%'");
        par.append("&name=" + name);
    }
    int pos = h.getInt("pos");
    par.append("&pos=");
    System.out.println(sql.toString());
    int sum = Agreed.count(sql.toString());

%>
<!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<!-- <script src="/tea/jquery.js" type="text/javascript"></script> -->
<script src="/tea/yl/top.js"></script>
<script src="/tea/yl/jquery-1.7.js"></script>
<script src='/tea/laydate-master/laydate.dev.js'></script>
<script src="/jsp/yl/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
</head>
<body>
<h1><%=type==0?"同辐服务商":"高科医院"%>满意度调查列表</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="?">
    <input type="hidden" name="community" value="<%=h.community%>"/>
    <input type="hidden" name="id" value="<%=menuid%>"/>
    <input type="hidden" name="type" value="<%=type%>"/>
    <table id="tablecenter" cellspacing="0">
        <tr>
            <%--<td class="th">医院名称：</td>
            <td><input name="name" value="<%= MT.f(name)%>"/></td>--%>
            <td>提交时间:
                <input name="t0" value="<%=MT.f(t0)%>" onclick="mt.date(this)"
                       id="makeoutdate" class="date"/> -
                <input name="t1" value="<%=MT.f(t1)%>" onclick="mt.date(this)"
                       id="makeoutdate" class="date"/>
            </td>
            <td align="center">
                <button class="btn btn-primary" type="submit">查询</button>
            </td>
        </tr>
    </table>
</form>
<script>
    //sup.hquery();
</script>

<form name="form2" action="/ShopHospitals.do" method="post" target="_ajax">
    <input type="hidden" name="community" value="<%=h.community%>"/>
    <input type="hidden" name="id"/>
    <input type="hidden" name="nexturl"/>
    <input type="hidden" name="act"/>

    <div class='radiusBox'>
        <table cellspacing="0" class='newTable'>
            <thead>
            <tr>
                <td colspan='20'><span>列表 <%=sum%>&nbsp;</span><span class='mt15'></span></td>
            </tr>
            </thead>
            <tr>
                <th width="40"><input type="checkbox" id="all"/>全选</th>
                <%if(type==0){%>
                <th>服务商公司</th>
                <%}else {%>
                <th>医院名</th>
                <%}%>
                <th>提交人</th>
                <th>提交时间</th>
                <th>操作</th>
            </tr>
            <%
                if (sum < 1) {
                    out.print("<tr><td colspan='8' class='noCont'>暂无记录!</td></tr>");
                } else {
                    Iterator it = Agreed.find(sql.toString(), pos, 15).iterator();
                    for (int i = 1 + pos; it.hasNext(); i++) {
                        Agreed sh = (Agreed) it.next();
                        ProcurementUnitJoin puj = ProcurementUnitJoin.find(sh.getCompanyid());
            %>
            <tr>

                <td><input type="checkbox" name="agreedid" value="<%=sh.getId() %>" id="all"/>
                </td>
                <%if(type==0){%>
                <td><%=MT.f(puj.getCompany()) %>
                </td>
                <%}else {%>
                  <td><%=MT.f(sh.getGsdz())%></td>
                <%}%>
                <td><%=MT.f(Profile.find(sh.getProfile()).getMember()) %>
                </td>
                <td>
                    <%=MT.f(sh.getCreatTime())%>
                </td>
                <td nowrap><%
                    out.println("<button type=\"button\" class=\"btn btn-link\" onclick=\"mt.act('edit'," + sh.getId() + ")\">查看详情</button>");
                %></td>
            </tr>
            <%
                    }
                    if (sum > 15)
                        out.print("<tr><td colspan='12' align='right'>" + new tea.htmlx.FPNL(h.language, par.toString(), pos, sum, 15));
                }%>
        </table>
    </div>
    <br>
    <%if (sum > 0) {%>
    <button class="btn btn-primary" type="button" onclick="daochu()">导出word</button>
    <button class="btn btn-primary" type="button" onclick="daochu2()">导出excel</button>
    <%}%>
</form>
<form action="/ExpTable.do" name="form3" method="post" target="_ajax">
    <input type="hidden" name="act" value="exp_agreed">
    <input type="hidden" name="type" value="<%=type%>">
    <input type="hidden" name="sql" value="<%=sql%>">
    <input type="hidden" name="ids">
</form>
<script>

    form2.nexturl.value = location.pathname + location.search;
    mt.act = function (a, id) {
        form2.act.value = a;
        form2.id.value = id;
        if (a == 'edit') {
            form2.action = "/jsp/yl/shop/agreedDetail.jsp";
            form2.target = '_self';
            form2.method = 'get';
            form2.submit();
        }
    };

    function daochu() {
        var ids = "";
        $("input[name='agreedid']").each(function (index, element) {
            if (element.checked == true) {
                ids += element.value + ",";
            }
        });
        if(ids == ''){
            alert("请勾选导出项");
        }else {
            ids = ids.substring(0, ids.length - 1);
            form3.ids.value=ids;
            form3.submit();
        }
    }

    function daochu2() {
        var ids = "";
        $("input[name='agreedid']").each(function (index, element) {
            if (element.checked == true) {
                ids += element.value + ",";
            }
        });
        if(ids == ''){
            alert("请勾选导出项");
        }else {
            ids = ids.substring(0, ids.length - 1);
            form3.ids.value=ids;
            form3.act.value="expAgreedExcel";
            form3.submit();
        }

    }

    //全选操作
    $("#all").click(function(){

        if ($("#all").prop('checked')) {

            $(":checkbox").prop("checked", true);
        } else {

            $(":checkbox").prop("checked", false);
        }
        var len = $("input:checkbox:checked").length;
        if(len==0){
            $('#button').attr('disabled',"true");

        }else{
            $('#button').removeAttr("disabled");
        }

    });

</script>
</body>
</html>
