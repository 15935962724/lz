<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.yl.shop.*"%>
<%@page import="tea.entity.sup.*"%><%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.*"%>
<%@page import="util.DateUtil"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

    StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
    String inpname = h.get("inpname");

    String hos = h.get("hos","(0)");
    sql.append(" AND id not in "+hos);
    par.append("&hos="+hos);

    sql.append(" AND addflag <> 1 ");

    int upid = h.getInt("upid");
    if (upid > 0){
        sql.append(" and id not in (select hospital from empowerRecord where upid="+upid+")");
        par.append("&upid="+upid);
    }


    String hosname = MT.f(h.get("hosname"));
    par.append("&inpname="+inpname);
    if(!hosname.equals("")){
        sql.append(" AND name like "+Database.cite("%"+hosname+"%"));
        par.append("&hosname="+hosname);
    }
    String area = h.get("area");
    if(!"".equals(area) && area != null){
        sql.append(" AND area ='" + area + "'");
        par.append("&area="+area);
    }
    String htype = h.get("htype");
    if(!"".equals(htype) && htype != null){
        sql.append(" AND htype ='" + htype + "'");
        par.append("&htype="+htype);
    }
    String hgrader = h.get("hgrader");
    if(!"".equals(hgrader) && hgrader != null){
        sql.append(" AND hgrader ='" + hgrader + "'");
        par.append("&hgrader="+hgrader);
    }
    int pos=h.getInt("pos");
    int sum=ShopHospital.count(sql.toString());
    par.append("&pos=");

%>
<!DOCTYPE html><html><head>

<!-- <script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script> -->
<!-- <script src="/tea/jquery.js" type="text/javascript"></script> -->
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>

<script src="/tea/mt.js"></script>
<script src="/tea/yl/jquery-1.7.js"></script>
<script src="/tea/yl/top.js"></script>
<style>
    .mytab{
        cursor: pointer;
    }
    .radiusBox,.newTable{min-width:inherit;}
    .radiusBox{border:none;}
    .newTable{width:100% !important;}
    .newTable th{border-right:1px #d7d7d7 solid;}
</style>
</head>
<body>
<%


%>
<div id="head6"><img height="6" src="about:blank"></div>
<div class='radiusBox'>
    <table id="tablecenter" class="newTable" cellspacing="0" style="background:none;" >
        <form action="">
            <input name="inpname" value="<%= inpname %>" type="hidden" />
            <tr>
                <td class="th">?????????</td><td><input name="hosname" value="<%=hosname %>" /></td>
            </tr>
            <tr>
                <td>???????????????/????????????:</td>
                <td><select class="province_select" autocomplete="off" name="area" >
                    <option value="">????????????????????????/????????????</option>
                    <option value="7180">?????????</option>
                    <option value="7182">?????????</option>
                    <option value="7184">?????????</option>
                    <option value="7186">?????????</option>
                    <option value="7188">??????????????????</option>
                    <option value="7190">?????????</option>
                    <option value="7192">?????????</option>
                    <option value="7194">????????????</option>
                    <option value="7196">?????????</option>
                    <option value="7198">?????????</option>
                    <option value="7200">?????????</option>
                    <option value="7202">?????????</option>
                    <option value="7204">?????????</option>
                    <option value="7206">?????????</option>
                    <option value="7208">?????????</option>
                    <option value="7210">?????????</option>
                    <option value="7212">?????????</option>
                    <option value="7214">?????????</option>
                    <option value="7216">?????????</option>
                    <option value="7218">?????????????????????</option>
                    <option value="7220">?????????</option>
                    <option value="7222">?????????</option>
                    <option value="7224">?????????</option>
                    <option value="7226">?????????</option>
                    <option value="7228">?????????</option>
                    <option value="7230">???????????????</option>
                    <option value="7232">?????????</option>
                    <option value="7234">?????????</option>
                    <option value="7236">?????????</option>
                    <option value="7238">?????????????????????</option>
                    <option value="7240">???????????????????????????</option>
                    <option value="21508">????????????????????????</option>
                </select></td>
            </tr>
            <tr>
                <td>????????????:</td>
                <td><select name="htype">
                    <option value="">?????????????????????</option>
                    <option value="????????????">????????????</option>
                    <option value="???????????????">???????????????</option>
                    <option value="?????????????????????">?????????????????????</option>
                    <option value="????????????">????????????</option>
                    <option value="?????????">?????????</option>
                    <option value="???????????????">???????????????</option>
                    <option value="????????????">????????????</option>
                    <option value="?????????">?????????</option>
                    <option value="?????????????????????">?????????????????????</option>
                    <option value="???????????????">???????????????</option>
                    <option value="?????????(???)">?????????(???)</option>
                    <option value="?????????????????????(????????????)">?????????????????????(????????????)</option>
                    <option value="?????????????????????">?????????????????????</option>
                    <option value="???????????????">???????????????</option>
                    <option value="????????????">????????????</option>
                    <option value="????????????????????????">????????????????????????</option>
                    <option value="????????????????????????">????????????????????????</option>
                </select></td>
            </tr>
            <td>????????????:</td>
            <td><select name="hgrader">
                <option value="">?????????????????????</option>
                <option value="??????">??????</option>
                <option value="????????????">????????????</option>
                <option value="????????????">????????????</option>
                <option value="????????????">????????????</option>
                <option value="????????????">????????????</option>
                <option value="????????????">????????????</option>
                <option value="????????????">????????????</option>
                <option value="????????????">????????????</option>
                <option value="????????????">????????????</option>
                <option value="????????????">????????????</option>
                <option value="????????????">????????????</option>
                <option value="???????????????">???????????????</option>
            </select></td>
            </tr>
            <tr>
                <td colspan="2"><input type="submit" class="btn btn-primary" value="??????" /></td>
            </tr>
        </form>
    </table>
<table cellspacing="0" class='newTable' id="tablecenter">
    <thead>
        <tr><td colspan='20'>??????<span class='sum'></span></td></tr>
    </thead>
    <tr>

        <th width='60'>??????</th>
        <th>????????????</th>
        <th>????????????</th>
        <th>????????????</th>
        <th>???????????????/????????????</th>
        <th>??????</th>
    </tr>
    <%
        if(sum==0)
        {
            out.print("<tr><td colspan='6' align='center'>?????????????????????????????????????????????????????????????????????</td></tr>");
        }else
        {
            List<ShopHospital> shlist = ShopHospital.find(sql.toString(), pos, 10);
            for(int i=0;i<shlist.size();i++){
                ShopHospital sh = shlist.get(i);
    %>
    <tbody class='mytab'>
        <tr>
            <td><%=pos+i+1%></td>
            <td><%=MT.f(sh.getName())%></td>
            <td><%=MT.f(sh.getHtype())%></td>
            <td><%=MT.f(sh.getHgrader())%></td>
            <td align="center"><%=MT.f(sh.getArea_name())%></td>
            <td><a href="javascript:void(0);" onclick="ret('<%= sh.getId() %>','<%= sh.getName() %>');">??????</a></td>
        </tr>
    </tbody>
    <%}}%>
    <%
        if(sum>20)out.print("<tr><td colspan='20'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,10)+"</td></tr>");
    %>
</table>
</div>
<form name="form2" action="/EmpowerRecords.do" id="form2" method="post" target="_ajax">
    <input name="upid" type="hidden" value="<%=h.get("upid")%>"/>
    <input name="act" value="update_hos" type="hidden"/>
    <input name="hospital_id" type="hidden">

</form>
<script>
    var index = parent.layer.getFrameIndex(window.name); //??????????????????
    var pmt=parent.mt;
    function ret(h,n){
        var url = window.location.search;
        if(url.indexOf("number=10")==-1) {//??????????????????
            pmt.receive(h, n);
            parent.layer.close(index);
        }else {//??????????????????????????????
            layer.open({
                content: '???????????????????????????!',
                btn: ['??????', '??????'],
                shadeClose: false,
                yes: function () {
                    form2.hospital_id.value=h;
                    form2.submit();
                }, no: function () {
                }
            });
        }
    }

</script>
</body>
</html>
