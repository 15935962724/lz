<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.yl.shop.*"%>
<%@page import="tea.entity.sup.*"%><%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.*"%>
<%@page import="util.DateUtil"%>
<%

    Http h=new Http(request,response);
    if(h.member<1)
    {
        response.sendRedirect("/servlet/StartLogin?community="+h.community);
        return;
    }

    StringBuffer sql=new StringBuffer(),par=new StringBuffer();
    String quality = h.get("quality");
    if(!"".equals(quality) && quality != null){
        sql.append(" AND quality="+quality);
        par.append("&quality="+quality);
    }
    String batch = h.get("batch");
    if(!"".equals(batch) && batch != null){
        sql.append(" AND batch="+batch);
        par.append("&batch="+batch);
    }
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

    double activity = h.getDouble("activity");

    List<Double> dlist = ProductStock.getAct(activity,0.03);
    if(activity!=0){
        sql.append(" AND act>="+dlist.get(1)+" AND act < "+dlist.get(0));
        par.append("&activity="+activity);
    }

    int pos=h.getInt("pos");
    par.append("&pos=");

    //int sum=ProductStock.count(sql.toString());
    //String acts=h.get("acts","");

    String[] TAB = {"可用库存", "全部库存"};
    String[] SQL = {" AND  (amount) > 0 ", "   "};
    int tab = h.getInt("tab", 0);
    par.append("&tab=" + tab);


%>
<!DOCTYPE html>
<html>
<head>
    <link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
    <script src="/tea/mt.js" type="text/javascript"></script>
    <script src="/tea/yl/jquery-1.7.js"></script>
    <script src="/tea/yl/top.js"></script>
    <script src='/tea/laydate-master/laydate.dev.js'></script>
    <script src="/jsp/yl/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

</head>
<body>
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
    <h1>库存管理</h1>
    <div id="head6"><img height="6" src="about:blank"></div>

    <form id='form1' name="form1" action="?" >
        <input type="hidden" name="community" value="<%=h.community%>"/>
        <input type="hidden" name="act"/>
        <input type="hidden" name="tab" value="<%= tab%>"/>
        <input type="hidden" name="id" value="<%= h.get("id")%>"/>
        <table id="tablecenter" cellspacing="0">
            <input type="hidden" name="page_size" value="20">

            <tr>
                <td width="240">
                    质检号: <input type="text" name="quality" value="<%= MT.f(quality)%>"/>　
                </td>
                <td width="240">
                    批号: <input type="text" name="batch" value="<%= MT.f(batch)%>"/>　
                </td>
                <td>入库时间:
                    <input name="t0" value="<%=MT.f(t0)%>" onfocus="WdatePicker({readOnly:true,maxDate:'%y-%M-%d'})"  id="makeoutdate" class="Wdate"/> -
                    <input name="t1" value="<%=MT.f(t1)%>" onfocus="WdatePicker({readOnly:true,maxDate:'%y-%M-%d'})"  id="makeoutdate" class="Wdate"/>
                </td>
                <td width="240">
                    活度（±0.03）: <input type="text" name="activity" value="<%= MT.f(activity)%>"/>
                </td>
                <td><button class="btn btn-primary" onclick="findStocks()" type="button">查询</button></td>
            </tr>
        </table>
    </form>
<%
    out.print("<div class='switch'>");
    for (int i = 0; i < TAB.length; i++) {
        out.print("<a href='javascript:mt.tab(" + i + ")' class='" + (i == tab ? "current" : "") + "'>" + TAB[i] + "</a>");
    }
    out.print("</div>");
%>
    <form name="form2" action="/ProductStocks.do" method="post" target="_ajax">
        <input type="hidden" name="community" value="<%=h.community%>"/>
        <input type="hidden" name="psid"/>
        <input type="hidden" name="nexturl"/>
        <input type="hidden" name="act"/>

        <div class='radiusBox'>
            <table cellspacing="0" class='newTable'>
                <thead>
                <tr><td colspan='20'>列表<span class='sum'></span>&nbsp;<button class='btn btn-primary' type='button' onclick="myact('edit','0')">添加</button>&nbsp;<button class='btn btn-primary' type='button' onclick="myact('edit1','0')">批量添加</button>&nbsp;<button class='btn btn-primary' type='button' onclick="myact('expex','0')">导入库存</button>&nbsp;<button class='btn btn-primary' type='button' onclick="myact('daochu','0')">导出库存</button>&nbsp;<span class="actdiv"></span></td></tr>
                </thead>
                <tr>
                    <th width='60'><input type="checkbox" id="all"/>全选</th>
                    <th width='60'>序号</th>
                    <th>产品名称</th>
                    <th>质检号</th>
                    <th>批号</th>
                    <th>检验时间</th>
                    <th>入库时间</th>
                    <th>入库活度(mCi)</th>
                    <th>当前活度(mCi)</th>
                    <th>库存数量/支</th>
                    <th>预留数量/支</th>
                    <th>有效期(天)</th>
                    <th>用户占用库存（前台下单）</th>
                    <th>操作</th>
                </tr>
                <tbody class='mytab'>

                </tbody>
                <tr class="ggpage"><td colspan='12' align='right' id='ggpage'></td></tr>
            </table>
        </div>
        <%--<div class='mt15'><a class="btn btn-primary" type="button" onclick="myact('edit','0')">添加</a></div>--%>

    </form>

<script type="text/javascript" >

    form2.nexturl.value=location.pathname+location.search;
    function loadlist(pos){
        mypos = pos;
        var listtb = new page.loadPage({"url":"/ProductStocks.do?act=findPSList&"+$("#form1").serialize(),"callBackFunc":createList,'page_size':'20','type':2,'page_size_max':'10','par':myurl,'showtype':1,'pos':pos,'showfun':loadlist});
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
        if(resultlist.dlist0!=resultlist.dlist1){
            $(".actdiv").html("查询区间为："+resultlist.dlist1+"-"+resultlist.dlist0);
        }else{
            $(".actdiv").html("");
        }
        $(".sum").html(resultlist.sum);
        var listDiv = $(".mytab");
        listDiv.html("");
        if(resultlist.data_list!=''){//是否存在数据
            for(var i=0;i<resultlist.data_list.length;i++){
                var proObj = resultlist.data_list[i];
                var boxDiv = $("<tr></tr>");
                var $name = $("<td><input type='checkbox' /></td><td>"+(parseInt(i)+1+parseInt(mypos))+"</td><td>放射性碘 I-125 粒子</td><td>"+proObj.obj.quality+"</td><td>"+proObj.obj.batch+"</td><td>"+proObj.obj.createtime+"</td><td>"+proObj.obj.time+"</td><td>"+proObj.obj.activity+"</td><td>"+proObj.pow+"</td><td>"+proObj.obj.amount+"</td><td><input type=number name=reserve min=0 onchange=mya(this,'"+proObj.obj.psid+"','"+proObj.obj.amount+"','"+proObj.obj.reserve+"') value="+proObj.obj.reserve+"  style='width:60px;border:none'/></td><td>"+proObj.validity+"</td><td>"+proObj.obj.ordernum+"</td><td><button type='button' class='btn btn-link' onclick=myact('ShopBatchesData','"+proObj.obj.psid+"')>查看占用</button>&nbsp;&nbsp;<button type='button' class='btn btn-link' onclick=myact('edit','"+proObj.obj.psid+"')>编辑</button>&nbsp;&nbsp;<button type='button' class='btn btn-link' onclick=myact('del','"+proObj.obj.psid+"')>删除</button></td>");
                boxDiv.append($name);
                listDiv.append(boxDiv);
            }

        }else{
            listDiv.append("<tr><td colspan='12' style='text-align:center'>暂无库存</td></tr>");
        }

    }
    function mya(obj,id,amount,reserve){
        var res = $(obj).val();
        //console.log(obj,id,amount,reserve,res);
        /*if(res>amount){
            $(obj).val(reserve);
            mtDiag.show("预留数量不能大于库存数量！","msg");
        }else*/
        if(!(/(^[0-9]\d*$)/.test(res))){
            $(obj).val(reserve);
            mtDiag.show("请输入大于等于0的整数！","msg");
        }else{
            fn.ajax("/ProductStocks.do?act=editRes", {"psid":id,"reserve":res}, function (data) {
                if (data.type > 0) {
                    if (data.type == 1) {
                        $(obj).val(reserve);
                        mtDiag.show("预留数量不能大于库存数量！","msg");
                        return;
                    }
                    mtDiag.close();
                    mtDiag.show(data.mes);
                    return;
                } else {
                    mtDiag.show("操作成功！","msg");
                    obj.value=data.obj.reserve;
                    loadlist(0);
                }
            });
        }
    }
    function myact(a,id){
        form2.act.value=a;
        form2.psid.value=id;
        form2.nexturl.value = "/jsp/yl/shop/ProductStocks.jsp";
        if(a=="edit"){
            form2.action='/jsp/yl/shop/ProductStocksEdit.jsp';
            form2.target=form2.method='';
            form2.submit();
        }else if(a=="edit1"){
            form2.action='/jsp/yl/shop/ProductStocksEditNew.jsp';
            form2.target=form2.method='';
            form2.submit();
        }else if(a=="del"){
            mtDiag.show("您确定要删除吗?","confirm",function(){
                fn.ajax("/ProductStocks.do?act=delPS","psid="+id,function(data){
                    if(data.type==0){
                        mtDiag.show("操作执行成功!","alert",null,form2.nexturl.value);
                    }else{
                        mtDiag.show("系统异常，请重试!","msg");
                    }
                });
            },function(){
                mtDiag.show("取消删除!");
            });
        }else if(a=='expex'){
            layer.open({
                type: 2,
                title: '导入文件',
                shadeClose: true,
                area: ['90%', '90%'],
                content: '/jsp/yl/shop/ExpExcelEditStock.jsp' //iframe的url /jsp/yl/shop/ExpExcel.jsp
                ,end:function(){
                    location.reload();
                }
            });
        }else if(a=='ShopBatchesData'){
            layer.open({
                type: 2,
                title: '查看占用',
                shadeClose: true,
                area: ['90%', '90%'],
                content: '/jsp/yl/shop/ShopBatchesData.jsp?psid='+id //iframe的url /jsp/yl/shop/ExpExcel.jsp
                ,end:function(){
                    //location.reload();
                }
            });
        }else if(a=='daochu'){
            form1.action="/ProductStocks.do";
            form1.act.value=a;
            form1.target='_self';form1.method='post';
            form1.submit();
        }
    }



</script>
</body>
</html>
