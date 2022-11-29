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
<script src="/tea/yl/jquery-1.7.js"></script>
<script src="/tea/yl/top.js"></script>
    <script src='/tea/laydate-master/laydate.dev.js'></script>
    <script src="/jsp/yl/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
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

<table id="tablecenter">
	<%--<tr>
		<td width="120">产品名称:</td>
		<td><input type="text" name="cid" value="放射性碘 I-125 粒子" readonly /></td>
	</tr>--%>

    <tr>
        <td>质检号:</td>
        <td><input type="text" name="quality" alt="质检号不能为空！" /></td>
    </tr>
    <tr>
        <td>批号:</td>
        <td><input type="text" name="batch" alt="批号不能为空！" /></td>
    </tr>
    <tr>
        <td>入库活度:</td>
        <td><input type="text" name="activity" alt="入库活度不能为空！" /></td>
    </tr>
    <tr>
        <td>入库时间:</td>
        <td>
            <input class="Wdate" alt="入库时间不能为空！" onfocus="WdatePicker({readOnly:true,maxDate:'%y-%M-%d'})"  name="createtime" value=""/>
        </td>
    </tr>
    <tr>
        <td>平台入库日期:</td>
        <td>
            <input class="Wdate" alt="平台入库日期不能为空！" onfocus="WdatePicker({readOnly:true,maxDate:'%y-%M-%d'})" id="makeoutdate" name="time" value=""/>
        </td>
    </tr>
    <tr>
        <td>库存数量:</td>
        <td><input type="number" name="amount" alt="库存数量不能为空！"  min="0"/></td>
    </tr>
    <%--<tr>
        <td>预留数量:</td>
        <td><input type="number" name="reserve"  min="0"/></td>
    </tr>--%>
        <tr>
            <td>前台占用数量:</td>
            <td><input type="number" name="ordernum" disabled="disabled"  min="0"/></td>
        </tr>
</table>
    <button class="btn btn-primary" type="button" onclick="fnedit()" >提交</button>&nbsp;&nbsp;&nbsp;&nbsp;
    <%-- <%
    	if(sh.getIsstoporder()==0){
    		out.print("<button class='btn btn-primary' onclick=\"mt.act('stoporder',"+sh.getId()+")\">停止订货</button>");
    	}else{
    		out.print("<button class='btn btn-primary' onclick=\"mt.act('nostoporder',"+sh.getId()+")\">取消停止订货</button>");
    	}
    %> --%>
    <button class="btn btn-default" type="button" onclick="history.back(-1)">返回</button>
</form>

<script type="text/javascript">
    var psid = getParam("psid");
    var nexturl = getParam("nexturl");
    form1.nexturl.value = decodeURIComponent(nexturl);
    form1.psid.value = psid;



    if(psid==0){

    }else{
        fn.ajax("/ProductStocks.do?act=findPS","psid="+psid,function(data){
            if(data.type>0){
                if(data.type==1){
                    //location = '/html/gf/index.html?nexturl='+encodeURIComponent(window.location.pathname+window.location.search);
                    return;
                }
                mtDiag.close();
                mtDiag.show(data.mes);
                return;
            }else{
                //form1.cid.value = "放射性碘 I-125 粒子";
                form1.quality.value = data.obj.quality;
                form1.batch.value = data.obj.batch;
                form1.activity.value = data.obj.activity;
                form1.amount.value = data.obj.amount;
                //form1.reserve.value = data.obj.reserve;
                form1.createtime.value = data.obj.createtime;
                form1.time.value = data.obj.time;
                form1.ordernum.value = data.obj.ordernum;
            }
        });
    }

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
    
</script>
</body>
</html>
