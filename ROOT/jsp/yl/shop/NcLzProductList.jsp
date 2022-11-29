<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.yl.shop.*" %>
<%@page import="tea.entity.*" %>
<%@ page import="tea.entity.member.Profile" %>
<%@ page import="tea.htmlx.FPNL" %>
<%@ page import="util.Config" %>
<%

    Http h = new Http(request, response);
    if (h.member < 1) {
        response.sendRedirect("/servlet/StartLogin?community=" + h.community);
        return;
    }

    StringBuffer sql = new StringBuffer(), par = new StringBuffer();

    String nccode = h.get("nccode","");
    if(nccode.length()>0){
        sql.append(" AND ncCode="+Database.cite(nccode));
        par.append("&nccode="+nccode);
    }
    int menuid = h.getInt("id");
    par.append("?community=" + h.community + "&id=" + menuid);
    int pos = h.getInt("pos",0);
    par.append("&pos="+pos);
    int sum =NcLzProduct.count(sql.toString()+" AND status!=0 ");
    int xinke = Config.getInt("xinke");
    int gaoke = Config.getInt("gaoke");
    int junan = Config.getInt("junan");

%>
<!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<!-- <script src="/tea/jquery.js" type="text/javascript"></script> -->
<script src="/tea/jquery-1.11.1.min.js"></script>
<script src="/tea/yl/top.js"></script>
</head>
<body>
<h1>NC商品编码管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="?">
    <input type="hidden" name="community" value="<%=h.community%>"/>
    <input type="hidden" name="id" value="<%=menuid%>"/>
    <table id="tablecenter" cellspacing="0">
        <tr>
            <td>NC编码:</td>
            <td><input name="nccode" value="<%=nccode%>"></td>
            <td></td>
            <td>

            </td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td colspan="8" align="center">
                <button class="btn btn-primary" type="submit">查询</button>
            </td>
        </tr>
    </table>
</form>
<script>
    //sup.hquery();
</script>

<form name="form2" action="/NcLzProducts.do" method="post" target="_ajax">
    <input type="hidden" name="community" value="<%=h.community%>"/>
    <input type="hidden" name="id"/>
    <input type="hidden" name="nexturl"/>
    <input type="hidden" name="act" value="del"/>

    <div class='radiusBox'>
        <table cellspacing="0" class='newTable'>
            <thead>
            <tr>
                <td colspan='20'><span>列表 <%=sum%>&nbsp;</span><span class='mt15'><button class='btn btn-primary'
                                                                                          type='button'
                                                                                          onclick="mt.act('edit','0')">添加</button></span></td>
            </tr>
            </thead>
            <tr>
                <th >序号</th>
                <th>厂商</th>
                <th>活度</th>
                <th>NC编码</th>
                <th>操作人</th>
                <th>操作</th>
            </tr>
            <%
                if (sum < 1) {
                    out.print("<tr><td colspan='8' class='noCont'>暂无记录!</td></tr>");
                } else {
                    Iterator it = NcLzProduct.find(sql.toString()+" AND status!=0 ",pos,15).iterator();
                    for (int i = 1 + pos; it.hasNext(); i++) {
                        NcLzProduct jihuo = (NcLzProduct) it.next();
            %>
            <tr>
                <td align="center"><%=i %>
                </td>
                <td><%=jihuo.getPuid()==xinke?"欣科":jihuo.getPuid()==gaoke?"高科":jihuo.getPuid()==junan?"君安":"同辐"%></td>
                <td><%
                if(jihuo.getStatus()==1){//单个%>
                  <%=jihuo.getActivity()%>
                <%}else {//范围%>
                    <%=jihuo.getActivityScope()%>
                <%}
                %></td>
                <td><%=jihuo.getNcCode()%></td>
                <td><%=MT.f(Profile.find(jihuo.getMember()).getMember())%></td>
                <td nowrap><%
                    out.println("<button type=\"button\" class=\"btn btn-link\" onclick=\"mt.act('del'," + jihuo.getId() + ")\">删除</button>");
                %></td>
            </tr>
            <%
                    }
                    if (sum > 15)
                        out.print("<tr><td colspan='10' align='right'>" + new FPNL(h.language, par.toString(), pos, sum, 15));
                }%>
        </table>
    </div>
    <%
        //if(acts.contains("oper"))

    %>

</form>

<script>
    form2.nexturl.value = "/jsp/yl/shop/NcLzProductList.jsp";
    mt.act = function (a, id, b) {
        form2.act.value = a;
        form2.id.value = id;
        if (a == 'del') {
            mt.show('你确定要删除吗？', 2, 'form2.submit()');
        } else {
                form2.action = '/jsp/yl/shop/NcLzProductEdit.jsp';
                form2.target = form2.method = '';
                form2.submit();

        }
    };

</script>
</body>
</html>
