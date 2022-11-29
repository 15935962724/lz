<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.sup.*"%>
<%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
int psid = h.getInt("psid");
ProductStock p = ProductStock.find(psid);



%><html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
    <script src="/tea/mt.js" type="text/javascript"></script>
    <script src="/tea/jquery-1.11.1.min.js"></script>
    <script src="/tea/yl/top.js"></script>
<!--
<script src="/tea/mt.js" type="text/javascript"></script>
<script src='/tea/jquery.js'></script> -->
</head>
<body >
<h1>库存管理</h1>
<style>
    .date{border:1px #d7d7d7 solid;width:160px;}
</style>


<form id='form1' name="form1" action="/ProductStocks.do" method="post" target="_ajax" onSubmit="return mt.check(this)">
<input type="hidden" name="psid" value=""/>
<input type="hidden" name="nexturl" value=""/>
<input type="hidden" name="act" value="editPS"/>
<input type="hidden" name="isclaer" value="1"/>

<table id="tablecenter">
	<tr>
        <td>质检号</td>
        <td>批号</td>
        <td>入库活度</td>
        <td>入库时间</td>
        <td>平台入库日期</td>
        <td>库存数量</td>
        <td>操作</td>
	</tr>
    <tbody id="mybody">
    <tr>
        <td for="quality"><input name="quality" id="quality0" /></td>
        <td for="batch" ><input name="batch" id="batch0" /></td>
        <td for="activity" ><input name="activity" id="activity0" /></td>
        <td for="createtime" ><input name="createtime" readonly id="createtime0" onclick="mt.date(this)" /></td>
        <td for="time" ><input name="time" id="time0" readonly value="<%= MT.f(new Date())%>"  onclick="mt.date(this)" /></td>
        <td for="amount" ><input name="amount" id="amount0" /></td>
        <td><input value="复制" onclick="copytr(this)" type="button"></td>
    </tr>
    </tbody>
</table>
    <input class="btn btn-primary" type="button" value="添加行" onclick="addtr()" />
    <input class="btn btn-primary" type="button" onclick="mysub()" value="提交" />
    <input class="btn btn-primary" type="button" value="返回" onclick="history.back(-1)" />
</form>

<script type="text/javascript">
    var psid = getParam("psid");
    var nexturl = getParam("nexturl");
    form1.nexturl.value = decodeURIComponent(nexturl);
    form1.psid.value = psid;




    function fnedit(){

        if(mtDiag.check($("#form1"))){
            fn.ajax("/ProductStocks.do?act=editPS", $("#form1").serialize(), function (data) {
                if (data.type > 0) {
                    if (data.type == 1) {
                        mtDiag.show("预留数量不能大于库存数量！","msg");
                        return;
                    }
                    mtDiag.close();
                    mtDiag.show(data.mes);
                    return;
                } else {
                    mtDiag.show("操作成功！", "alert", null, form1.nexturl.value);
                }
            });
        }



    }

    <%
    out.print("var validator2 = $('#form1').validate({");
	out.print("rules: {");
	out.print("quality: {required: true},");
    out.print("batch: {required: true},");
    out.print("activity: {required: true},");
    out.print("createtime: {required: true},");
    out.print("time: {required: true},");
    out.print("amount: {required: true},");
    //out.print("reserve: {required: true}");


	out.print("},");
	out.print("submitHandler: function(form) {");
	out.print("mysub();");
	//out.print("form2.submit();");
	out.print("}});");
    %>



    function mysub(){
        fn.ajax("/ProductStocks.do?act=editPSList",$("#form1").serialize(),function(data){
            if(data.type>0){

                mtDiag.close();
                mtDiag.show(data.mes);
                return;
            }else{
                mtDiag.show('操作成功！',"alert",null,function(index){
                    //parent.location.reload();
                   // parent.mtDiag.close();
                    location = form1.nexturl.value;
                });
            }
        });
    }
    var index = 1;
    function addtr(){
        var str = '<tr><td for=\"quality\"><input name=\"quality\" id="quality'+index+'" /></td><td for=\"batch\" ><input name=\"batch\" id="batch'+index+'" /></td><td for=\"activity\" ><input name=\"activity\" id="activity'+index+'" /></td><td for=\"createtime\" ><input name=\"createtime\" id="createtime'+index+'" readonly onclick=\"mt.date(this)\" /></td><td for=\"time\" ><input name=\"time\" id="time'+index+'" value="<%= MT.f(new Date())%>" readonly onclick=\"mt.date(this)\" /></td><td for=\"amount\" ><input name=\"amount\" id="amount'+index+'" /></td><td><input value=\"复制\" onclick="copytr(this)" type=\"button\">&nbsp;<input value=\"删除\" onclick="deltr(this)" type=\"button\"></td></tr>';
        $("#mybody").append(str);
        index++;
    }

    function deltr(obj){
        $(obj).parent().parent().remove();
    }

    function copytr(obj){
        //var mystr = $(obj).parent().parent().html();
       // console.log(mystr);
        var quality =  $(obj).parent().parent().find("input[name='quality']").val();
        var batch = $(obj).parent().parent().find("input[name='batch']").val();
        var activity = $(obj).parent().parent().find("input[name='activity']").val();
        var createtime = $(obj).parent().parent().find("input[name='createtime']").val();
        var time = $(obj).parent().parent().find("input[name='time']").val();
        var amount = $(obj).parent().parent().find("input[name='amount']").val();
        var reserve =  $(obj).parent().parent().find("input[name='reserve']").val();

        var str = '<tr><td for=\"quality\"><input name=\"quality\" id="quality'+index+'" value="'+quality+'" /></td><td for=\"batch\" ><input name=\"batch\" id="batch'+index+'" value="'+batch+'" /></td><td for=\"activity\" ><input name=\"activity\" value="'+activity+'"  id="activity'+index+'" /></td><td for=\"createtime\" ><input name=\"createtime\" readonly value="'+createtime+'" id="createtime'+index+'" onclick=\"mt.date(this)\" /></td><td for=\"time\" ><input name=\"time\" value="'+time+'" readonly id="time'+index+'" onclick=\"mt.date(this)\" /></td><td for=\"amount\" ><input name=\"amount\" value="'+amount+'" id="amount'+index+'" /></td><td><input value=\"复制\" onclick="copytr(this)" type=\"button\">&nbsp;<input value=\"删除\" onclick="deltr(this)" type=\"button\"></td></tr>';
        $("#mybody").append(str);

        //$("#mybody").append(mystr);
        //console.log(mystr);

        index++;
        //console.log($(obj).parent().parent().find("input[name='quality']").attr("id"));
    }

</script>
</body>
</html>