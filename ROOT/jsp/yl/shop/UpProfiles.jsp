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

<h1>用户升级申请</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<form id='form1' name="form1" action="?" >
    <input type="hidden" name="community" value="<%=h.community%>"/>
    <table id="tablecenter" cellspacing="0">
        <tr>
            <td width="210">用户:
                <input type="text" name="name" value="<%= MT.f(name)%>" />
            </td>
            <td width="180">升级类型:
                <select name="uptype">
                    <option value="-1">请选择</option>
                    <option value="0">服务商</option>
                    <option value="1">VIP</option>

                </select>
            </td>
            <td width="180">状态:
                <select name="state">
                    <option value="-1">请选择</option>
                    <option value="0">申请中</option>
                    <option value="1">审核通过</option>
                    <option value="2">审核未通过</option>
                </select>
            </td>
            <td>
                <button class="btn btn-primary" onclick="findStocks()" type="button">查询</button>
            </td>
        </tr>

    </table>
</form>

<form name="form2" action="/UpProfiles.do" id="form2" method="post" target="_ajax">
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
                <th>用户</th>
                <th>手机</th>
                <th>邮箱</th>
                <th>升级类型</th>
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
    var arr = new Array("服务商","VIP");
    var arr1 = new Array("申请中","审核通过","审核未通过");
    function loadlist(pos){
        mypos = pos;
        var listtb = new page.loadPage({"url":"/UpProfiles.do?act=findUPList&"+$("#form1").serialize(),"callBackFunc":createList,'page_size':'10','type':2,'page_size_max':'10','par':myurl,'showtype':1,'pos':pos,'showfun':loadlist});
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
                var $name = $("<td>"+(parseInt(i)+1+parseInt(mypos))+"</td><td>"+proObj.member+"</td><td>"+proObj.mobile+"</td><td>"+proObj.email+"</td><td>"+arr[proObj.obj.uptype]+"</td><td>"+proObj.obj.uptime+"</td><td>"+arr1[proObj.obj.state]+"</td><td><button type='button' class='btn btn-link' onclick=myact('info','"+proObj.obj.upid+"')>查看详情</button></td>");
                boxDiv.append($name);
                listDiv.append(boxDiv);
            }

        }else{
            listDiv.append("<tr><td colspan='12' style='text-align:center'>暂无记录</td></tr>");
        }

    }

    function myact(a,id) {

        if(a=="info"){
            location.href='/jsp/yl/shop/UpgradeInfo.jsp?upid='+id;
        }

    }



</script>
</body>
</html>
