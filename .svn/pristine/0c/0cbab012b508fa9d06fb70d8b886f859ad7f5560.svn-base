<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.yl.shop.*" %>
<%@page import="tea.db.*" %>
<%@page import="tea.ui.yl.shop.*" %>
<%@page import="tea.entity.sup.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.*" %>
<%@page import="util.DateUtil" %>
<%@ page import="tea.entity.member.Profile" %>
<%

    Http h = new Http(request, response);
    if (h.member < 1) {
        response.sendRedirect("/servlet/StartLogin?community=" + h.community);
        return;
    }
/*
String act=h.get("act");
if("action".equals(act))
{
  out.print("oper");
  return;
}*/
    StringBuffer sql = new StringBuffer(), par = new StringBuffer();

    int profile = h.getInt("profile");
    Profile p = Profile.find(profile);

    String[] sarr = MT.f(p.hospitals, "|").split("\\|");
    String aasd ="";
    for (int i = 1; i <sarr.length ; i++) {
         aasd += sarr[i];

         if(i!=sarr.length-1){
             aasd+=",";
         }

    }
    System.out.println(aasd);


    int menuid = h.getInt("id");
    par.append("?community=" + h.community + "&id=" + menuid);
    par.append("&profile="+profile);

    String name = h.get("name");
    if (!"".equals(name) && name != null) {
        sql.append(" AND name like'%" + name + "%'");
        par.append("&name=" + h.enc(name));
    }
    String area = h.get("area");
    if (!"".equals(area) && area != null) {
        sql.append(" AND area ='" + area + "'");
        par.append("&area=" + h.enc(area));
    }
    String htype = h.get("htype");
    if (!"".equals(htype) && htype != null) {
        sql.append(" AND htype ='" + htype + "'");
        par.append("&htype=" + h.enc(htype));
    }
    String hgrader = h.get("hgrader");
    if (!"".equals(hgrader) && hgrader != null) {
        sql.append(" AND hgrader ='" + hgrader + "'");
        par.append("&hgrader=" + h.enc(hgrader));
    }
    String deadline = h.get("deadline");
    if (!"".equals(deadline) && deadline != null) {
        sql.append(" AND datediff(d,getdate(),expirationDate) <= " + deadline);
    }
    int issign = h.getInt("issign", -1);
    if (issign != -1) {
        sql.append(" and issign=" + issign);
        par.append("&issign=" + issign);
    }

    int pos = h.getInt("pos");
    par.append("&pos=");

    System.out.println(sql.toString());
    int sum = sarr.length;
    String acts = h.get("acts", "");

%>
<!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<!-- <script src="/tea/jquery.js" type="text/javascript"></script> -->
<script src="/tea/jquery-1.11.1.min.js"></script>
</head>
<body>
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
                <td colspan='10'>列表 <%=sum-1%>
                </td>
            </tr>
            </thead>
            <tr>
                <th width='60'>序号</th>
                <th>医院名称</th>
                <th>医院类别</th>
                <th>医院等级</th>
                <th>省（自治区/直辖市）</th>
                <th>操作</th>
            </tr>
            <%
                if (sum < 1) {
                    out.print("<tr><td colspan='8' class='noCont'>暂无记录!</td></tr>");
                } else {
                    List<ShopHospital> sh_list  = ShopHospital.find("AND id in ( "+aasd+" )",pos,10);
                    for (int i = 0; i <sh_list.size() ; i++) {
                        ShopHospital sh = sh_list.get(i);


            %>
            <tr>
                <td align="center"><%=pos+i+1%>
                </td>
                <td><%=MT.f(sh.getName())%></a></td>
                <td><%=MT.f(sh.getHtype())%></a></td>
                <td><%=MT.f(sh.getHgrader())%></a></td>
                <td align="center"><%=MT.f(sh.getArea_name())%>
                </td>
                <td nowrap><%
                    //if(acts.contains("oper"))
                    //{
                    out.println("<button type=\"button\" class=\"btn btn-link\" onclick=\"sethid('" + sh.getId() + "','" + sh.getName() + "')\">选择</button>");
                    //}
                %></td>
            </tr>
            <%
                    }
                    if (sum > 10)
                        out.print("<tr><td colspan='10' align='right'>" + new tea.htmlx.FPNL(h.language, par.toString(), pos, sum, 10));
                }%>
        </table>
    </div>

</form>

<script>

    function sethid(id, name) {
        //alert(1);
        parent.mt.sethid(id, name);
        parent.mt.close();
        //parent.mtsethid(id,name);
    }

    $(function () {
        //var area = $("area");
        $("select[name='area']").val("<%= area%>");
        $("select[name='htype']").val("<%= htype%>");
        $("select[name='hgrader']").val("<%= hgrader%>");
    });

</script>
</body>
</html>
