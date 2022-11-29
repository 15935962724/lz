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
<%@ page import="tea.htmlx.FPNL" %>
<%@ page import="util.Config" %>
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


    int menuid = h.getInt("id");
    par.append("?community=" + h.community + "&id=" + menuid);

    String name = h.get("name");
    if (!"".equals(name) && name != null) {
        sql.append(" AND name like'%" + name + "%'");
        par.append("&name=" + name);
    }
    String h_code = h.get("h_code");
    if (!"".equals(h_code) && h_code != null) {
        sql.append(" AND h_code ='" + h_code + "'");
        par.append("&h_code=" + h_code);
    }
    String area = h.get("area");
    if (!"".equals(area) && area != null) {
        sql.append(" AND area ='" + area + "'");
        par.append("&area=" + area);
    }
    String htype = h.get("htype");
    if (!"".equals(htype) && htype != null) {
        sql.append(" AND htype ='" + htype + "'");
        par.append("&htype=" + htype);
    }
    String hgrader = h.get("hgrader");
    if (!"".equals(hgrader) && hgrader != null) {
        sql.append(" AND hgrader ='" + hgrader + "'");
        par.append("&hgrader=" + hgrader);
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

    int type = h.getInt("type",4);//获取查询类型  1 时间  2次数
    int sum =JihuoCode.count("AND type="+type);
    if(type==4){
        sum=JihuoCode.count("");
    }
    String acts = h.get("acts", "");
    int shijian = Config.getInt("shijian");
    int cishu = Config.getInt("cishu");
    int kehuduan = Config.getInt("kehuduan");

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
<h1>激活码管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="?">
    <input type="hidden" name="community" value="<%=h.community%>"/>
    <input type="hidden" name="id" value="<%=menuid%>"/>
    <table id="tablecenter" cellspacing="0">
        <tr>
            <td>类型选择:</td>
            <td><select name="type">
                <option value="">请选择</option>
                <option value="<%=shijian%>" <%if(type==shijian){%>selected<%}%>>时间</option>
                <option value="<%=cishu%>" <%if(type==cishu){%>selected<%}%>>次数</option>
                <option value="<%=kehuduan%>" <%if(type==kehuduan){%>selected<%}%>>客户端</option>
            </select></td>
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

<form name="form2" action="/JihuoCodes.do" method="post" target="_ajax">
    <input type="hidden" name="community" value="<%=h.community%>"/>
    <input type="hidden" name="id"/>
    <input type="hidden" name="nexturl"/>
    <input type="hidden" name="act"/>

    <div class='radiusBox'>
        <table cellspacing="0" class='newTable'>
            <thead>
            <tr>
                <td colspan='20'><span>列表 <%=sum%>&nbsp;</span><span class='mt15'><button class='btn btn-primary'
                                                                                          type='button'
                                                                                          onclick="mt.act('edit','0')">添加</button>&nbsp;
&nbsp;<button class='btn btn-primary' type='button' onclick="mt.act('expex','0')">导入激活码</button></span></td>
            </tr>
            </thead>
            <tr>
                <th><input type="checkbox" id="all"/>全选</th>
                <th >序号</th>
                <th>激活码编码</th>
                <th>激活码类型</th>
                <th>购买方式</th>
                <th>创建时间</th>
                <th>使用状态</th>
                <th>创建人</th>
                <th>操作</th>
            </tr>
            <%
                if (sum < 1) {
                    out.print("<tr><td colspan='8' class='noCont'>暂无记录!</td></tr>");
                } else {
                    Iterator  it;
                    if(type==4){
                       it = JihuoCode.find("",pos,15).iterator();
                    }else {
                        it = JihuoCode.find("AND type="+type,pos,15).iterator();
                    }
                    for (int i = 1 + pos; it.hasNext(); i++) {
                        JihuoCode jihuo = (JihuoCode) it.next();
            %>
            <tr>
                <td><input type="checkbox" name="issigns" value="<%=jihuo.getId() %>"/></td>
                <td align="center"><%=i %>
                </td>
                <td><%=MT.f(jihuo.getCode())%></td>
                <td><%
                if(jihuo.getType()== Config.getInt("shijian")){%>
                    时间
                <%}else if(jihuo.getType()== Config.getInt("cishu")) {%>
                    次数
                <%}else {%>
                    客户端
                <%}%></td>
                <td><%
                    int child_ = jihuo.getType_child();
                    List<ShopProductModel>list =  ShopProductModel.find("AND id ="+child_,0,Integer.MAX_VALUE);
                    ShopProductModel s = list.get(0);
                   %>



                    <%=MT.f(s.getModel())%></td>
                <%--<td><%=MT.f(jihuo.getMail())%></td>--%>
                <td><%=MT.f(jihuo.getTime())%></td>
                <td><%if(jihuo.getUsetype()==0){%>
                    <span style="color: green">未使用</span>
                <%}else {%>
                    <span style="color: red">已使用</span>
                <%}%></td>
                <td><%=MT.f(Profile.find(jihuo.getMember()).getMember())%></td>
                <td nowrap><%
                    //if(acts.contains("oper"))
                    //{
                    out.println("<button type=\"button\" class=\"btn btn-link\" onclick=\"mt.act('edit'," + jihuo.getId() + ")\">编辑</button>");
                    out.println("<button type=\"button\" class=\"btn btn-link\" onclick=\"mt.act('del'," + jihuo.getId() + ")\">删除</button>");
                    //}
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

    //全选操作
    $("#all").click(function () {

        if ($("#all").prop('checked')) {

            $(":checkbox").prop("checked", true);
        } else {

            $(":checkbox").prop("checked", false);
        }
        var len = $("input:checkbox:checked").length;
        if (len == 0) {
            $('#button').attr('disabled', "true");

        } else {
            $('#button').removeAttr("disabled");
        }

    });
    //单选操作
    $("input[name='issigns']").click(function () {

        var len = $("input[name='issigns']:checked").length;
        if (len == 0) {
            $('#button').attr('disabled', "true");

        } else {
            $('#button').removeAttr("disabled");
        }
        var alllen = document.getElementsByName("issigns").length;

        if (len < alllen) {
            $("#all").prop("checked", false);
        }
        if (len == alllen) {
            $("#all").prop("checked", true);
        }

    });

    form2.nexturl.value = "/jsp/yl/shop/jihuoCodes.jsp";
    mt.act = function (a, id, b) {
        form2.act.value = a;
        form2.id.value = id;
        if (a == 'del') {
            mt.show('你确定要删除吗？', 2, 'form2.submit()');
        } else {
            if (a == 'view') {
                form2.action = '';
                form2.target = form2.method = '';
                form2.submit();
            } else if (a == 'edit') {
                form2.action = '/jsp/yl/shop/JiHuoCodeEdit.jsp';
                form2.target = form2.method = '';
                form2.submit();
            } else if (a == 'sign') {
                form2.action = '/jsp/yl/shop/ShopHospitalSign.jsp';
                form2.target = form2.method = '';
                form2.submit();
            } else if (a == 'setissign') {
                mt.show("是否确定改变当前选中医院的签收设置？", 2);
                mt.ok = function () {
                    if (id == 0) {
                        var obj = document.getElementsByName('issigns'); //选择所有name="'test'"的对象，返回数组
                        //取到对象数组后，我们来循环检测它是不是被选中
                        var s = '';
                        for (var i = 0; i < obj.length; i++) {
                            if (obj[i].checked) s += obj[i].value + ','; //如果选中，将value添加到变量s中
                        }
                        form2.id.value = s;
                    }
                    form2.submit();
                }

            } else if (a == 'endtime') {
                form2.action = '/jsp/yl/shop/HospitalEndtimeEdit.jsp';
                form2.target = form2.method = '';
                form2.submit();
            } else if (a == 'editname') {
                form2.action = '/jsp/yl/shop/ShopHospitalsNameEdit.jsp';
                form2.target = form2.method = '';
                form2.submit();
            } else if (a == 'expex') {
                layer.open({
                    type: 2,
                    title: '导入文件',
                    shadeClose: true,
                    area: ['95%', '95%'],
                    content: '/jsp/yl/shop/ExpExcelEditJihuoCode.jsp' //iframe的url /jsp/yl/shop/ExpExcel.jsp
                });
            }


        }
    };
    $(function () {
        //var area = $("area");
        $("select[name='area']").val("<%= area%>");
        $("select[name='htype']").val("<%= htype%>");
        $("select[name='hgrader']").val("<%= hgrader%>");
    });
</script>
</body>
</html>
