<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.yl.shop.*"%>
<%@ page import="tea.entity.member.Profile" %>
<%@ page import="java.util.Date" %>
<%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
int sid = h.getInt("sid");
ServiceInvoice si = ServiceInvoice.find(sid);

int puid = h.getInt("puid");



%><html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/yl/jquery-1.7.js"></script>
<script src="/tea/yl/top.js"></script>
<!--
<script src="/tea/mt.js" type="text/javascript"></script>
<script src='/tea/jquery.js'></script> -->
<script src='/tea/laydate-master/laydate.dev.js'></script>
<script src="/jsp/yl/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
</head>
<body >
<h1>服务商服务费发票管理</h1>

<form id='form1' name="form1" action="/ServiceInvoices.do" method="post" target="_ajax" onSubmit="return mt.check(this)">
<input type="hidden" name="sid" value="<%=si.getSid()%>"/>
<input type="hidden" name="puid" value="<%=puid%>"/>
<input type="hidden" name="nexturl" value=""/>
<input type="hidden" name="act" value="editSI"/>

<table id="tablecenter">
	<tr>
		<td>发票号:</td>
		<td><input type="text" name="invoiceCode" /></td>
	</tr>

    <tr>
        <td>服务商:</td>
        <td>
            <%
                if(Profile.find(si.getProfile()).member==null){
                    %>
                    <input type="hidden" name="profile" value="" readonly/>
                    <span class="parentIframe"></span>&nbsp;&nbsp;
                    <button type='button' class='btn btn-default' onclick=myact('joinProfile','')>选择服务商</button>
                    <%
                }else{
                    %>
                    <input type="hidden" name="profile" value="" readonly/>
                    <span class="parentIframe"><%=Profile.find(si.getProfile()).member%></span>&nbsp;&nbsp;
                    <button type='button' class='btn btn-default' onclick=myact('joinProfile','')>选择服务商</button></td>
                    <%
                }
            %>
    </tr>
    <tr>
        <td>服务商公司：</td>
        <td>
            <input type="hidden" name="company" value="" readonly/>
            <span class="parentIframe2"><%=MT.f(ProcurementUnitJoin.find(si.getPuj_id()).company)%></span>&nbsp;&nbsp;
            <button type='button' class='btn btn-default' onclick=myact('joinCompany','')>选择服务商公司</button>
        </td>
    </tr>
    <tr>
        <td>金额:</td>
        <td><input type="text" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')" name="money" /></td>
    </tr>
    <tr>
        <td>发票开具时间:</td>
        <td><input name="time" onfocus="WdatePicker({readOnly:true,maxDate:'%y-%M-%d'})"  id="makeoutdate" class="Wdate" /></td>
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
    var sid = getParam("sid");
    var nexturl = getParam("nexturl");
    form1.nexturl.value = decodeURIComponent(nexturl)+"?puid="+<%=puid%>;

    fn.ajax("/ServiceInvoices.do?act=findSI","sid="+sid,function(data){
        //console.log(data);
        if(data.type>0){
            if(data.type==1){
                //location = '/html/gf/index.html?nexturl='+encodeURIComponent(window.location.pathname+window.location.search);
                return;
            }
            mtDiag.close();
            mtDiag.show(data.mes);
            return;
        }else{
            form1.invoiceCode.value = data.obj.invoiceCode;
            form1.money.value = data.obj.money;
            form1.profile.value = data.obj.profile;
            form1.time.value = data.obj.time;
            form1.company.value = data.obj.company;

        }
    });


    function fnedit(){
        if(form1.invoiceCode.value == ""){
            mtDiag.show("发票号不能为空!");
        }else if(form1.profile.value== ""){
            mtDiag.show("请选择供应商!");
        }else if(form1.company.value== ""){
            mtDiag.show("请选择供应商公司!");
        }else {
            fn.ajax("/ServiceInvoices.do?act=editSI", $("#form1").serialize(), function (data) {
                if (data.type > 0) {
                    if (data.type == 1) {
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
    function myact(a,id){
        if(a=="joinProfile"){
            layer.open({
                type: 2,
                title: '服务商',
                shadeClose: true,
                area: ['80%', '80%'],
                closeBtn:1,
                content: '/jsp/yl/shop/SiJoinProfile.jsp?puid='+<%=puid%>
            });
        }else if(a=="joinCompany"){
            var a = form1.profile.value;
            layer.open({
                type: 2,
                title: '服务商公司',
                shadeClose: true,
                area: ['80%', '80%'],
                closeBtn:1,
                content: '/jsp/yl/shop/JoinCompany.jsp?puid=<%=puid%>&profile='+a
            });

        }
    }

</script>
</body>
</html>
