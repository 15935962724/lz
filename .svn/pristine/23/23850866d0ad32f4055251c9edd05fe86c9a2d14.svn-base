<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.yl.shop.*"%>
<%@page import="tea.entity.sup.*"%><%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.*"%>
<%@page import="util.DateUtil"%>
<%@ page import="tea.entity.member.Profile" %>
<%

    Http h=new Http(request,response);
    if(h.member<1)
    {
        response.sendRedirect("/servlet/StartLogin?community="+h.community);
        return;
    }

    StringBuffer sql=new StringBuffer(),par=new StringBuffer();

    Date t0=h.getDate("t0");
    if(t0!=null)
    {
        sql.append(" AND createtime>"+Database.cite(t0));
        par.append("&t0="+MT.f(t0));
    }
    Date t1=h.getDate("t1");
    if(t1!=null)
    {
        sql.append(" AND createtime<"+Database.cite(t1));
        par.append("&t1="+MT.f(t1));
    }
    int type = h.getInt("type");
    if(type>=0){
        sql.append(" AND type="+type);
        par.append("&type="+type);
    }
    int member = h.getInt("member");
    if(member>0){
        sql.append(" and member="+member);
        par.append("&member="+member);
    }
    String orderId = h.get("orderId");
    if(orderId!=null && !"".equals(orderId)){
        sql.append(" and oid in (select id from shoporder where order_id like "+ Database.cite("%"+orderId+"%")+")");
    }


%>
<!DOCTYPE html>
<html>
<head>
    <link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
    <script src="/tea/yl/jquery-1.7.js"></script>
    <script src="/tea/yl/top.js"></script>

    <script src='/tea/laydate-master/laydate.dev.js'></script>
    <script src="/jsp/yl/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
</head>
<body>

<h1>库存操作记录</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<form id='form1' name="form1" action="?" >
    <input type="hidden" name="community" value="<%=h.community%>"/>
    <table id="tablecenter" cellspacing="0">

        <tr>

            <td width="420">操作时间区间:
                <input name="t0" value="<%=MT.f(t0)%>" onfocus="WdatePicker({readOnly:true,dateFmt:'yyyy-M-d H:mm',maxDate:'%y-%M-%d'})"  id="makeoutdate" class="Wdate"/> -
                <input name="t1" value="<%=MT.f(t1)%>" onfocus="WdatePicker({readOnly:true,dateFmt:'yyyy-M-d H:mm',maxDate:'%y-%M-%d'})"  id="makeoutdate" class="Wdate"/>
            </td>
            <td width="180">操作类型:
                <select name="type">
                    <option value="-1">请选择</option>
                    <%
                        List<StockOperation> soList = StockOperation.find("", 0, Integer.MAX_VALUE);
                        if(soList.size()>0) {
                            for (int i = 0; i < 5; i++) {
                                out.print("<option value=" + i + ">" + soList.get(0).getTypeArr()[i] + "</option>");
                            }
                        }
                    %>
                </select>
            </td>
            <td width="180">操作人:
                <select name="member">
                <option>请选择</option>
                    <%

                        ArrayList<Integer> list = new ArrayList<Integer>();
                        for (StockOperation s : soList) {
                            if(!list.contains(s.getMember())){
                                list.add(s.getMember());
                            }
                        }
                        for (Integer mem : list) {
                            out.print("<option value="+mem+">"+ Profile.find(mem).getMember()+"</option>");
                        }
                    %>
                </select>
            </td>
            <td>订单编号: <input type="text" name="orderId" /></td>
            <td>质检号: <input type="text" name="quality" /></td>
            <td>批号: <input type="text" name="batch" /></td>
            <td><button class="btn btn-primary" onclick="findStocks()" type="button">查询</button></td>
        </tr>
    </table>
</form>
<form name="form2" action="/StockOperations.do" method="post" target="_ajax">
    <input type="hidden" name="community" value="<%=h.community%>"/>
    <input type="hidden" name="psid"/>
    <input type="hidden" name="nexturl"/>
    <input type="hidden" name="act"/>

    <div class='radiusBox'>
        <table cellspacing="0" class='newTable'>
            <thead>
            <tr><td colspan='20'>列表<span class='sum'></span></td></tr>
            </thead>
            <tr>
                <th width='60'>序号</th>

                <th>类别</th>
                <th>操作时间</th>
                <th>质检号</th>
                <th>批号</th>
                <th>活度(mCi)</th>
                <th>订单编号</th>
                <th>操作类型</th>
                <th>操作人</th>
                <th>描述</th>
            </tr>
            <tbody class='mytab'>

            </tbody>
            <tr class="ggpage"><td colspan='12' align='right' id='ggpage'></td></tr>
        </table>
    </div>

</form>

<script type="text/javascript" >

    form2.nexturl.value=location.pathname+location.search;
    function loadlist(pos){
        mypos = pos;
        var listtb = new page.loadPage({"url":"/StockOperations.do?act=findSOList&"+$("#form1").serialize(),"callBackFunc":createList,'page_size':'10','type':2,'page_size_max':'10','par':myurl,'showtype':1,'pos':pos,'showfun':loadlist});
        listtb.show();
    }
    loadlist(0);

    function findStocks(){
        loadlist(0);
    }

    function createList(resultlist){
        if(resultlist.sum<=10){
            $(".ggpage").hide();
        }else{
            $(".ggpage").show();
        }
        if(resultlist.type==1){
            return;
        }
        if(resultlist.type==2){
            mtDiag.show(resultlist.mes);
            return;
        }
        $(".sum").html(resultlist.sum);
        var listDiv = $(".mytab");
        listDiv.html("");
        if(resultlist.data_list!=''){//是否存在数据
            for(var i=0;i<resultlist.data_list.length;i++){
                var proObj = resultlist.data_list[i];
                var boxDiv = $("<tr></tr>");
                var $name = $("<td>"+(parseInt(i)+1+parseInt(mypos))+"</td><td>放射性碘 I-125 粒子</td><td>"+proObj.time+"</td><td>"+proObj.quality+"</td><td>"+proObj.batch+"</td><td>"+proObj.obj.activity+"</td><td>"+(proObj.obj.oid==0?"--":proObj.orderId)+"</td><td>"+proObj.obj.typeArr[proObj.obj.type]+"</td><td>"+proObj.member+"</td><td>"+proObj.obj.describe+"</td>");
                boxDiv.append($name);
                listDiv.append(boxDiv);
            }

        }else{
            listDiv.append("<tr><td colspan='12' style='text-align:center'>暂无库存操作记录</td></tr>");
        }

    }

</script>
</body>
</html>
