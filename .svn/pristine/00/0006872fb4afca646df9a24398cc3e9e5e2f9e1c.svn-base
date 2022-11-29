<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="tea.entity.yl.shop.*"%>
<%@page import="tea.entity.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="util.Config" %>
<%

    Http h=new Http(request,response);
    if(h.member<1)
    {
        response.sendRedirect("/servlet/StartLogin?community="+h.community);
        return;
    }

    StringBuffer sql=new StringBuffer(),par=new StringBuffer();

    Integer puid = Config.getInt(h.get("puid"));
    if(puid!=null)
    {
        sql.append(" AND puid="+puid);
        par.append("&puid="+h.get("puid"));
    }else{
        puid = h.getInt("puid");
        sql.append(" AND puid="+puid);
        par.append("&puid="+h.get("puid"));
    }
    int type = h.getInt("type");
    if(type>-1){
        sql.append(" AND type="+type);
        par.append("&type="+type);
    }
    int state = h.getInt("state");
    if(state>-1){
        sql.append(" AND state="+state);
        par.append("&state="+state);
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
        sql.append(" AND invoiceCode like'%" + invoiceCode + "%'");
        par.append("&invoiceCode="+invoiceCode);
    }

    int pos=h.getInt("pos");
    par.append("&pos=");

    int sum=ServiceInvoice.count(sql.toString());
    String acts=h.get("acts","");



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
<h1>服务商服务费发票管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form id='form1' name="form1" action="?" >
    <input type="hidden" name="community" value="<%=h.community%>"/>
    <input type="hidden" name="puid" value="<%=puid%>"/>
    <table id="tablecenter" cellspacing="0">

        <tr>
            <td width="240">
                发票号: <input type="text" name="invoiceCode" value=""/>　
            </td>
            <td width="460">发票开具时间:
                <input name="t0" value="<%=MT.f(t0)%>" onfocus="WdatePicker({readOnly:true,maxDate:'%y-%M-%d'})"  id="makeoutdate" class="Wdate"/> -
                <input name="t1" value="<%=MT.f(t1)%>" onfocus="WdatePicker({readOnly:true,maxDate:'%y-%M-%d'})"  id="makeoutdate" class="Wdate"/>
            </td>
            <td>发票类型:
                <select name="type">
                    <option value="-1">请选择</option>
                    <%
                        String[] typeArr = new String[]{"新增","结余"};
                        for (int j = 0; j < 2; j++) {
                            out.print("<option value="+j+">"+typeArr[j]+"</option>");
                        }
                    %>
                </select>
            </td>
            <td>
                发票状态:
                <select name="state">
                    <option value="-1">请选择</option>
                    <%
                        String[] stateArr = new String[]{"未使用","已使用"};
                        for (int i = 0; i < 2; i++) {
                            out.print("<option value="+i+">"+stateArr[i]+"</option>");
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
            <tr><td colspan='20'>列表<span class='sum'></span></td></tr>
            </thead>
            <tr>
                <th width='60'>序号</th>
                <th>发票号</th>
                <th>服务商</th>
                <th>服务商公司</th>
                <th>金额</th>
                <th>发票开具时间</th>
                <th>类型</th>
                <th>状态</th>
                <th>操作</th>
            </tr>
            <tbody class='mytab'>

            </tbody>
            <tr class="ggpage"><td colspan='12' align='right' id='ggpage'></td></tr>
        </table>
    </div>
    <div class='mt15'><a class="btn btn-primary" type="button" onclick="myact('edit','0')">添加</a>&nbsp;&nbsp;&nbsp;<a
            href="javascript:;" onclick=myact('joinProfile','') class="btn btn-primary">选择服务商</a></div>

</form>

<script type="text/javascript" >

    form2.nexturl.value=location.pathname+location.search;
    var arr = new Array("<font color=green>新增</font>","<font color=blue>结余</blue>");
    var arr1 = new Array("<font color=green>未使用</font>","<font color='#999'>已使用</blue>");
    function loadlist(pos){
        mypos = pos;
        var listtb = new page.loadPage({"url":"/ServiceInvoices.do?act=findSIList&"+$("#form1").serialize(),"callBackFunc":createList,'page_size':'10','type':2,'page_size_max':'10','par':myurl,'showtype':1,'pos':pos,'showfun':loadlist});
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
                var $name = $("<td>"+(parseInt(i)+1+parseInt(mypos))+"</td><td>"+proObj.obj.invoiceCode+"</td><td>"+proObj.profileName+"</td><td>"+proObj.company+"</td><td>"+proObj.obj.money+"</td><td>"+proObj.obj.time+"</td><td>"+arr[proObj.obj.type]+"</td><td>"+arr1[proObj.obj.state]+"</td>");

                boxDiv.append($name);
                if(proObj.obj.type == 0 && proObj.obj.state == 0){
                    boxDiv.append($("<td><button type='button' class='btn btn-link' onclick=myact('edit','"+proObj.obj.sid+"')>编辑</button>&nbsp;&nbsp;<button type='button' class='btn btn-link' onclick=myact('del','"+proObj.obj.sid+"')>删除</button></td>"));
                }else if(proObj.obj.type==1 || proObj.obj.state==1){
                    boxDiv.append($("<td><button type='button' class='btn btn-link' onclick=myact('info','"+proObj.obj.fid+"')>详情</button></td>"));
                }else{
                    boxDiv.append($("<td></td>"));
                }
                listDiv.append(boxDiv);
            }

        }else{
            listDiv.append("<tr><td colspan='12' style='text-align:center'>暂无发票</td></tr>");
        }

    }

    function myact(a,id){
        form2.act.value=a;
        form2.sid.value=id;
        form2.nexturl.value = "/jsp/yl/shop/ServiceInvoices.jsp";
        if(a=="edit"){
            form2.action='/jsp/yl/shop/ServiceInvoicesEdit.jsp';
            form2.target=form2.method='';
            form2.submit();
        }else if(a=="del"){
            mtDiag.show("您确定要删除吗?","confirm",function(){
                fn.ajax("/ServiceInvoices.do?act=delSi","sid="+id,function(data){
                    if(data.type==0){
                        mtDiag.show("操作执行成功!","alert",null,form2.nexturl.value);
                    }else{
                        mtDiag.show("系统异常，请重试!","msg");
                    }
                });
            },function(){
                mtDiag.show("取消删除!");
            });
        }else if(a=="info"){
            layer.open({
                type: 2,
                title: '发票使用详情',
                shadeClose: true,
                area: ['80%', '80%'],
                closeBtn:1,
                content: '/jsp/yl/shop/InvoiceUseInfo.jsp?fid='+id
            });
        }else if(a=="joinProfile"){
            layer.open({
                type: 2,
                title: '服务商',
                shadeClose: true,
                area: ['80%', '80%'],
                closeBtn:1,
                content: '/jsp/yl/shop/choseProfile.jsp?puid='+<%=puid%>
            });
        }
    }

</script>
</body>
</html>
