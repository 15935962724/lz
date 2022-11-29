<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.sup.*"%>
<%@page import="tea.entity.yl.shop.*"%><%

    Http h=new Http(request,response);
    if(h.member<1)
    {
        response.sendRedirect("/servlet/StartLogin?community="+h.community);
        return;
    }
    int puid = h.getInt("puid");
    ProcurementUnit p = ProcurementUnit.find(puid);

    Date date = new Date();
    List<Map> lists = new ArrayList<Map>();
    if (p.getRadiationSafetyTime().before(date)){
            Map map = new HashMap();
            map.put("type",1);
            map.put("name","辐射安全许可证");
            lists.add(map);
    }
    if (p.getBusinessLicenseTime().before(date)){
        Map map = new HashMap();
        map.put("type",2);
        map.put("name","企业营业执照");
        lists.add(map);
    }
    if (p.getProductionLicenseTime().before(date)){
        Map map = new HashMap();
        map.put("type",3);
        map.put("name","放射药品生产许可证");
        lists.add(map);
    }
    if (p.getApprovalFormTime().before(date)){
        Map map = new HashMap();
        map.put("type",4);
        map.put("name","转让审批表");
        lists.add(map);
    }
    if (p.getGmpCertificateTime().before(date)){
        Map map = new HashMap();
        map.put("type",5);
        map.put("name","药品GMP证书");
        lists.add(map);
    }
    if (p.getRegistrationApprovalTime().before(date)){
        Map map = new HashMap();
        map.put("type",6);
        map.put("name","药品再注册批件");
        lists.add(map);
    }
    if (p.getPowerOfAttorneyTime().before(date)){
        Map map = new HashMap();
        map.put("type",7);
        map.put("name","授权委托书");
        lists.add(map);
    }

%><html>
<head>
    <link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
    <script src='/tea/mt.js'></script>
    <script src='/tea/city.js'></script>
    <script src="/tea/tea.js" type="text/javascript"></script>
    <script src="/tea/jquery-1.11.1.min.js"></script>
    <script src='/tea/yl/top.js'></script>
    <script type="text/javascript" src="/tea/Calendar.js"></script>
</head>
<body >
<h1>延期申请</h1>

<form id='form1' name="form1" action="/ProcurementUnitServlet.do" method="post" target="_ajax" onSubmit="return mt.check(this)">
    <input type="hidden" name="puid" value=""/>
    <input type="hidden" name="nexturl" value=""/>
    <input type="hidden" name="act" value="editPU"/>

    <table id="tablecenter">
        <tr>
            <td width="100">到期证件:</td>
            <td><select name="type" onchange="getSelect(this)">
                <option value="-1">请选择</option>
                <%
                    for (Map map : lists) {
                        %>
                            <option value="<%=map.get("type")%>"><%=map.get("name")%></option>
                        <%
                    }
                %>
            </select>
            <input type="hidden" name="name" >
            </td>
        </tr>
        <tr>
            <td>申请原因:</td>
            <td><textarea id="delayMessage" name="delayMessage" rows="5" cols="50" ></textarea></td>
        </tr>
        <tr>
            <td>上传附件:</td>
            <td><input id="delay" type="file" accept="image/*"> <input id="delayUrl" type="hidden" name="delayUrl"> </td>
        </tr>

    </table>
    <button class="btn btn-primary" type="button" onclick="fnedit()" >提交</button>&nbsp;&nbsp;&nbsp;&nbsp;

    <button class="btn btn-default" type="button" onclick="history.back(-1)">返回</button>
</form>

<script type="text/javascript">
    var puid = getParam("puid");
    var nexturl = getParam("nexturl");
    form1.nexturl.value = decodeURIComponent(nexturl);
    form1.puid.value = puid;

    $(function(){
        var num = $("input[type='file']").length;
        console.log(num)
        for(var i = 0; i < num; i++){
            var id = $("input[type='file']").eq(i).attr("id");
            document.getElementById(id).addEventListener('change', catUpload, false);
        }
    });

    function catUpload(ent){
        var domnId = ent.target.id;
        var files = $("#"+domnId).prop('files');//获取到文件列表
        console.log(files)
        var  formData = new FormData();
        $.each(files, function(key, value){
            formData.append('file',value);
            // formData.append(value);
        });
        console.log(files);
        $.ajax({
            type : "POST",
            url : "/RecallUploadFile.do",
            data : formData,
            cache: false,
            dataType: 'text',
            processData: false,
            contentType: false,
            success : function(data) {
                console.log(data);
                console.log(domnId+"Path");
                $("#"+domnId+"Url").val($.trim(data))
            },
            error :function () {
                console.log("aaaaaaaaaaaa")
            }

        });

    }

    function getSelect(_this) {
        var text = $(_this).find("option:checked").text();
        $("input[name='name']").val(text)
    }

    function fnedit(){
        var name = $("input[name='name']").val();
        if(name == '' || name == '请选择'){
            alert('请选择到期证件！');
            return false;
        }
        var message = $("#delayMessage").val();
        if(message == ''){
            alert('请输入申请原因！');
            return false;
        }
        var url = $("#delayUrl").val();
        if(url == ''){
            alert('请上传文件！');
            return false;
        }


        fn.ajax("/ProcurementUnitServlet.do?act=addCertificates", $("#form1").serialize(), function (data) {
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



</script>
</body>
</html>
