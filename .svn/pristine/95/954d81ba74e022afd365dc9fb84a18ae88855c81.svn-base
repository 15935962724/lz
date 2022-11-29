<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="tea.entity.*"%>

<%

    Http h=new Http(request,response);
    if(h.member<1)
    {
        response.sendRedirect("/servlet/StartLogin?community="+h.community);
        return;
    }

    StringBuffer sql=new StringBuffer(),par=new StringBuffer();

    String name = h.get("name");
    String client = h.get("client");
    int state = h.getInt("state");
    int perfact = h.getInt("perfact");


%>
<!DOCTYPE html>
<html>
<head>
    <link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
    <script src="/tea/mt.js"></script>
    <script src="/tea/yl/jquery-1.7.js"></script>
    <script src="/tea/yl/top.js"></script>

    <script src='/tea/laydate-master/laydate.dev.js'></script>
    <script src="/jsp/yl/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

</head>
<body>
<style>

</style>
<h1>授权申请</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<form id='form1' name="form1" action="?" >
    <input type="hidden" name="community" value="<%=h.community%>"/>
    <table id="tablecenter" cellspacing="0">
        <tr>
            <td width="210">用户:
                <input type="text" name="name" value="<%=MT.f(name)%>" />
            </td>
            <td width="210">委托人:
                <input type="text" name="client" value="<%=MT.f(client)%>" />
            </td>
            <td width="180">状态:
                <select name="state">
                    <option value="-1">请选择</option>
                    <option value="0">授权申请审核中</option>
                    <option value="1">授权申请通过</option>
                    <option value="2">授权申请失败</option>

                </select>
            </td>
            <td width="280">医院资质:
                <select name="perfect">
                    <option value="-1">请选择</option>
                    <option value="0">未提交医院资质</option>
                    <option value="1">提交医院资质未审核</option>
                    <option value="2">添加医院资质审核通过</option>
                    <option value="3">提交医院资质审核不通过</option>
                </select>
            </td>
            <td>
                <button class="btn btn-primary" onclick="findStocks()" type="button">查询</button>
            </td>
        </tr>

    </table>
</form>

<form name="form2" action="/EmpowerRecords.do" id="form2" method="post" target="_ajax">
    <input type="hidden" name="community" value="<%=h.community%>"/>
    <input type="hidden" name="nexturl"/>
    <input type="hidden" name="act"/>

    <div class='radiusBox'>
        <table cellspacing="0" class='newTable'>
            <thead>
            <tr><td colspan="20">列表<span class='sum'></span></td></tr>
            </thead>
            <tr>
                <th width='60'>序号</th>
                <th>服务商</th>
                <th>医院名称</th>
                <th>授权有效期</th>
                <th>委托人</th>
                <th>申请时间</th>
                <th>状态</th>
                <th>操作</th>
            </tr>
            <tbody class='mytab'>

            </tbody>
            <tr class="ggpage"><td colspan='10' align='right' id='ggpage'></td></tr>
        </table>
    </div>

</form>

<script type="text/javascript" >

    form2.nexturl.value=location.pathname+location.search;
    var arr1 = new Array("授权申请审核中","授权申请通过","授权申请失败");
    var arr2 = new Array("未提交医院资质","提交医院资质未审核","提交医院资质审核通过","提交医院资质审核不通过");

    function loadlist(pos){
        mypos = pos;
        var listtb = new page.loadPage({"url":"/EmpowerRecords.do?act=findERList&"+$("#form1").serialize(),"callBackFunc":createList,'page_size':'10','type':2,'page_size_max':'10','par':myurl,'showtype':1,'pos':pos,'showfun':loadlist});
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
        //console.log(resultlist.sum);

        var listDiv = $(".mytab");
        listDiv.html("");
        if(resultlist.data_list!=''){//是否存在数据
            for(var i=0;i<resultlist.data_list.length;i++){
                var proObj = resultlist.data_list[i];
                var boxDiv = $("<tr></tr>");
                var $name = $("<td>"+(parseInt(i)+1+parseInt(mypos))+"</td><td>"+proObj.profile+"</td><td>"+proObj.hospital+"</td><td>"+proObj.obj.stateTime+" - "+proObj.obj.endTime+"</td><td>"+proObj.obj.client+"</td><td>"+proObj.obj.empowerTime+"</td><td>"+(proObj.obj.perfect==0?arr1[proObj.obj.state]:arr2[proObj.obj.perfect])+"</td><td><a class='btn btn-link' href=/jsp/yl/shop/EmpowerInfo.jsp?eid="+proObj.obj.eid+">查看详情</a><a class='btn btn-link' onclick='youji("+proObj.obj.eid+")'>邮寄授权书</a>");
                boxDiv.append($name);
                listDiv.append(boxDiv);
            }

        }else{
            listDiv.append("<tr><td colspan='12' style='text-align:center'>暂无记录</td></tr>");
        }

    }

    function myact(a,id) {

    }
    function youji(id) {
        layer.open({
            type: 2,
            title: '邮寄授权书',
            shadeClose: true,
            area: ['400px', '300px'],
            closeBtn:1,
            content: '/jsp/yl/shopweb/AmilShouQuan.jsp?eid='+id
        });
    }


</script>
</body>
</html>
