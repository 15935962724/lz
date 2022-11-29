<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="tea.entity.yl.shop.*"%>
<%@page import="tea.entity.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="util.Config" %>
<%@ page import="java.util.List" %>
<%

    Http h=new Http(request,response);
    if(h.member<1)
    {
        response.sendRedirect("/servlet/StartLogin?community="+h.community);
        return;
    }

    StringBuffer sql=new StringBuffer(),par=new StringBuffer();
    Integer puid = h.getInt("puid");
    if(puid!=null)
    {
        sql.append(" AND puid="+puid);
        par.append("&puid="+puid);
    }else{
        puid = h.getInt("puid");
        sql.append(" AND puid="+puid);
        par.append("&puid="+puid);
    }

    Integer proflie = h.getInt("profile");
    if(proflie != null){
        sql.append(" AND profile="+proflie);
        par.append("&profile="+proflie);
    }
    Date t0=h.getDate("t0");
    if(t0!=null)
    {
        sql.append(" AND time>"+Database.cite(t0));
        par.append("&t0="+MT.f(t0));
    }
    Date t1=h.getDate("t1");
    if(t1!=null)
    {
        sql.append(" AND time<"+Database.cite(t1));
        par.append("&t1="+MT.f(t1));
    }

    String invoiceCode = h.get("invoiceCode");
    if(invoiceCode != null){
        sql.append(" AND invoiceCode="+invoiceCode);
        par.append("&invoiceCode="+invoiceCode);
    }

    sql.append(" and type=-1");
    par.append("&type=-1");

    int pos=h.getInt("pos");
    par.append("&pos=");

    int sum=ServiceInvoice.count(sql.toString());
    String acts=h.get("acts","");

    int puj_id = h.getInt("puj_id");
    System.out.println(puj_id);




%>
<!DOCTYPE html>
<html>
<head>
    <link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
    <script src="/tea/yl/jquery-1.7.js"></script>
    <script src="/tea/yl/top.js"></script>

    <script src='/tea/laydate-master/laydate.dev.js'></script>
    <script src="/jsp/yl/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <script type="text/javascript" src="/tea/angular.min.js"></script>

</head>
<body ng-app="lz" ng-controller="lzController">
<style>
    .mytab input[type=number]:focus{border:1px #ccc solid;}
    .mytab input::-webkit-outer-spin-button,
    .mytab input::-webkit-inner-spin-button {
        -webkit-appearance: none;
    }
    .mytab input[type="number"]{
        -moz-appearance: textfield;
    }
</style>
<h1>匹配发票</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form id='form1' name="form1" action="?" >
    <input type="hidden" name="community" value="<%=h.community%>"/>
    <input type="hidden" name="puid" value="<%=puid%>"/>
    <input type="hidden" name="proflie" value="<%=proflie%>"/>
    <input type="hidden" name="type" value="-1"/>
    <table id="tablecenter" cellspacing="0">

        <tr>
            <td width="240">
                发票号: <input type="text" name="invoiceCode" value=""/>　
            </td>
            <td width="460">发票开具时间:
                <input name="t0" value="<%=MT.f(t0)%>" onfocus="WdatePicker({readOnly:true,maxDate:'%y-%M-%d'})"  id="makeoutdate" class="Wdate"/> -
                <input name="t1" value="<%=MT.f(t1)%>" onfocus="WdatePicker({readOnly:true,maxDate:'%y-%M-%d'})"  id="makeoutdate" class="Wdate"/>
            </td>
            <td>供应商公司:
                <select name="puj_id" id="puj_id">
                    <option value="-1">请选择</option>
                    <%
                        List<ProcurementUnitJoin> list = ProcurementUnitJoin.find("AND profile="+proflie+"AND puid="+puid,0,Integer.MAX_VALUE);
                        for (int j = 0; j < list.size(); j++) {
                            out.print("<option value="+MT.f(list.get(j).getJid())+">"+MT.f(list.get(j).getCompany())+"</option>");
                        }
                    %>
                </select>
            </td>
            <td><button class="btn btn-primary" onclick="findStocks()" type="button">查询</button></td>
        </tr>
    </table>
</form>

<form name="form2" action="/ServiceInvoices.do" method="post" target="_ajax">
    <input type="hidden" name="community" value="<%=h.community%>"/>
    <input type="hidden" name="sid"/>
    <input type="hidden" name="puid" value="<%=puid%>"/>
    <input type="hidden" name="nexturl"/>
    <input type="hidden" name="act"/>


    <div class='radiusBox'>
        <table cellspacing="0" class='newTable'>
            <thead>
            <tr><td colspan='20'>列表<span class='sum'></span><span style="float:right;padding:0px 25px;" id="totalMoney">发票金额:￥ <em style="color:red;display:inline-block">0</em></span></td></tr>
            </thead>
            <tr>
                <th width="60"><label><input id="all" type="checkbox" name="checkMoney" value="0">&nbsp;&nbsp;全选</label></th>
                <th width='60'>序号</th>
                <th>发票号</th>
                <th>服务商</th>
                <th>服务商公司</th>
                <th>金额</th>
                <th>发票开具时间</th>
                <th>类型</th>
            </tr>
            <tbody class='mytab'>

            </tbody>
            <tr class="ggpage"><td colspan='12' align='right' id='ggpage'></td></tr>
        </table>
    </div>
    <div class='mt15'><a class="btn btn-primary" type="button" ng-click="mateOrder()">匹配发票</a></div>

</form>

<script type="text/javascript" >

    form2.nexturl.value=location.pathname+location.search;
    var arr = new Array("<font color=green>新增</font>","<font color=blue>结余</blue>");
    function loadlist(pos){
        mypos = pos;
        var listtb = new page.loadPage({"url":"/ServiceInvoices.do?act=findSIList&"+$("#form1").serialize(),"callBackFunc":createList,'page_size':'10','type':2,'page_size_max':'10','par':myurl,'showtype':1,'pos':pos,'showfun':loadlist});
        listtb.show();
    }
    loadlist(0);

    function findStocks(){
        loadlist(0);
    }
    var ids="";
    var total = 0;
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
                if(proObj.obj.state==0){
                    var boxDiv = $("<tr></tr>");
                    var $name = $("<td><label><input type='checkbox' name='checkMoney' ng-checked='selectAll' alt='"+proObj.obj.sid+"' ng-click=updateSelection($event,"+proObj.obj.sid+","+proObj.obj.money+") value='"+proObj.obj.money+"' /></label><td>"+(parseInt(i)+1+parseInt(mypos))+"</td><td>"+proObj.obj.invoiceCode+"</td><td>"+proObj.profileName+"</td><td>"+proObj.company+"</td><td>"+proObj.obj.money+"</td><td>"+proObj.obj.time+"</td><td>"+arr[proObj.obj.type]+"</td></td>");
                    boxDiv.append($name);
                    listDiv.append(boxDiv);
                }
            }

        }else{
            listDiv.append("<tr><td colspan='12' style='text-align:center'>暂无发票</td></tr>");
        }


    }

    var app = angular.module('lz',[]);
    app.controller('lzController',function($scope,$http){
        // 发票id集合
        $scope.selectIds = [];
        $("#all").change(function(){
            $scope.selectIds = [];
            var flage =$(this).is(":checked");
            $("input[name='checkMoney']").each(function(){

                $(this).prop("checked",flage);
                var id = $(this).attr("alt");
                var va = $(this).attr("value");
                if(va != 0){
                    if(flage){
                        $scope.selectIds.push(id);
                        total+=Number(va);
                    }else{
                        var idx = $scope.selectIds.indexOf(id);
                        $scope.selectIds.splice(idx,1);
                        total-=Number(va);
                    }
                }
            })
            $("#totalMoney em").text(total.toFixed(2));
            //console.log(total)
        });
        // 更新复选框：
        $scope.updateSelection = function($event,id,money){
            // 复选框选中
            if($event.target.checked){
                // 向数组中添加元素
                $scope.selectIds.push(id);
                total+=money;
                $("#totalMoney em").text(total.toFixed(2));
            }else{
                // 从数组中移除
                var idx = $scope.selectIds.indexOf(id);
                $scope.selectIds.splice(idx,1);
                total-=money;
                $("#totalMoney em").text(total.toFixed(2));
            }

        }
        for(i=0;i<$scope.selectIds.length;i++){
            if(i==0){
                ids+=$scope.selectIds[i];
            }else{
                ids+=",";
                ids+=$scope.selectIds[i];
            }
        }
        $scope.mateOrder = function () {
            var myselect = document.getElementById("puj_id");
            var index = myselect.selectedIndex;
            var day = myselect.options[index].value;
            var re = /^[1-9]+[0-9]*]*$/;
            /*if(!re.test(day)){
                mtDiag.show("请选择服务商公司!","msg");
            }else {}*/
            if($scope.selectIds.length>0){
                　　　　　
                location.href="/jsp/yl/shopnew/ListInvoiceMate.jsp?puid=<%=puid%>&puj_id="+day+"&money="+total.toFixed(2)+"&profile=<%=proflie%>&ids="+$scope.selectIds;

            }else{
                mtDiag.show("至少选择一条数据!","msg");
            }
        }
    })


</script>
</body>
</html>
