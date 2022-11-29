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
    String actmy = h.get("actmy");
    if(!"".equals(actmy) && actmy != null){
        sql.append(" AND act="+actmy);
        par.append("&actmy="+actmy);
    }
    String allPar = h.get("allPar");
    if(!"".equals(allPar) && allPar != null){
        sql.append(" AND par="+Database.cite(allPar));
        par.append("&allPar="+allPar);
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


    int member = h.getInt("member");
    if(member!=0){
        sql.append(" AND member "+member);
        par.append("&member="+member);
    }

    int pos=h.getInt("pos");
    par.append("&pos=");

    //int sum=ProductStock.count(sql.toString());
    //String acts=h.get("acts","");



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
    <h1>操作记录管理</h1>
    <div id="head6"><img height="6" src="about:blank"></div>

    <form id='form1' name="form1" action="?" >
        <input type="hidden" name="community" value="<%=h.community%>"/>
        <input type="hidden" name="act"/>
        <input type="hidden" name="id" value="<%= h.get("id")%>"/>
        <table id="tablecenter" cellspacing="0">
            <input type="hidden" name="page_size" value="20">

            <tr>
                <td width="240">
                    请求方法: <input type="text" name="actmy" value="<%= MT.f(actmy)%>"/>　
                </td>
                <td width="240">
                    参数: <input type="text" name="allPar" value="<%= MT.f(allPar)%>"/>　
                </td>
                <td>操作时间:
                    <input name="t0" value="<%=MT.f(t0)%>" onfocus="WdatePicker({readOnly:true,maxDate:'%y-%M-%d'})"  id="makeoutdate" class="Wdate"/> -
                    <input name="t1" value="<%=MT.f(t1)%>" onfocus="WdatePicker({readOnly:true,maxDate:'%y-%M-%d'})"  id="makeoutdate" class="Wdate"/>
                </td>
                <td width="240">
                    用户id: <input type="text" name="member" value="<%= MT.f(member)%>"/>
                </td>
                <td><button class="btn btn-primary" onclick="findStocks()" type="button">查询</button></td>
            </tr>
        </table>
    </form>
    <form name="form2" action="/ProductStocks.do" method="post" target="_ajax">
        <input type="hidden" name="community" value="<%=h.community%>"/>
        <input type="hidden" name="psid"/>
        <input type="hidden" name="nexturl"/>
        <input type="hidden" name="act"/>

        <div class='radiusBox'>
            <table cellspacing="0" class='newTable' style="border-collapse: collapse;border-spacing: 0;">
                <thead>
                <tr><td colspan='20'>列表<span class='sum'></span></td></tr>
                </thead>
                <tr>
                    <th width='50'>序号</th>
                    <th>用户id</th>
                    <th>用户</th>
                    <th>请求地址</th>
                    <th>请求方法</th>
                    <th width='100'>参数</th>
                    <th width='100'>请求时间</th>
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
        var listtb = new page.loadPage({"url":"/OperationMess.do?act=findPSList&"+$("#form1").serialize(),"callBackFunc":createList,'page_size':'20','type':2,'page_size_max':'10','par':myurl,'showtype':1,'pos':pos,'showfun':loadlist});
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
                var $name = $("<td>"+(parseInt(i)+1+parseInt(mypos))+"</td><td>"+proObj.obj.member+"</td><td>"+proObj.obj.profile+"</td><td>"+proObj.obj.requesturl+"</td><td>"+proObj.obj.act+"</td><td style='word-wrap: break-word;word-break: break-all;width:500px;'>"+proObj.obj.par+"</td><td>"+proObj.obj.timeStr+"</td>");
                boxDiv.append($name);
                listDiv.append(boxDiv);
            }

        }else{
            listDiv.append("<tr><td colspan='12' style='text-align:center'>暂无记录</td></tr>");
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
                    location.reload();
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
