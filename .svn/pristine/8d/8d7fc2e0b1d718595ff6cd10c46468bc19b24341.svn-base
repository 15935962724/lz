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
<h1>厂商管理</h1>

<form id='form1' name="form1" action="/ProcurementUnitServlet.do" method="post" target="_ajax" onSubmit="return mt.check(this)">
    <input type="hidden" name="puid" value=""/>
    <input type="hidden" name="nexturl" value=""/>
    <input type="hidden" name="act" value="editPU"/>

    <table id="tablecenter">
        <tr>
            <td width="100">厂商名称:</td>
            <td><input type="text" name="name" /></td>
        </tr>

        <tr>
            <td>全称:</td>
            <td><input type="text" name="fullname" /></td>
        </tr>
        <tr>
            <td>英文全称:</td>
            <td><input type="text" name="fullnameen" /></td>
        </tr>
        <tr>
            <td>联系人:</td>
            <td><input type="text" name="person" /></td>
        </tr>
        <tr>
            <td>手机:</td>
            <td><input type="text" name="mobile" /></td>
        </tr>
        <tr>
            <td>邮箱:</td>
            <td><input type="text" name="email" /></td>
        </tr>
        <tr>
            <td>邮编:</td>
            <td><input type="text" name="zipcode" /></td>
        </tr>
        <tr>
            <td>传真:</td>
            <td><input type="text" name="fax" /></td>
        </tr>

        <tr>
            <td>地址:</td>
            <td><input type="text" name="address" /></td>
        </tr>
        <tr>
            <td>电话:</td>
            <td><input type="text" name="telephone" /></td>
        </tr>
        <tr>
            <td>网址:</td>
            <td><input type="text" name="website" /></td>
        </tr>
        <tr>
            <td>退货电话:</td>
            <td><input type="text" name="telephoneReturn" /></td>
        </tr>

        <tr>
            <td>排序:</td>
            <td><input type="number" name="sort" /></td>
        </tr>
        <tr>
            <td>辐射安全许可证:</td>
            <td><input type="text" name="radiationSafetyTime" placeholder="选择有效期"  onclick="new Calendar().show('form1.radiationSafetyTime');" />
                <input type="hidden" id="radiationSafetyUrl" name="radiationSafetyUrl" /> <input type="file" id="radiationSafety"  accept="image/* , application/pdf"  value="上传文件"></td>
        </tr>
        <tr>
            <td>企业营业执照:</td>
            <td><input type="text" name="businessLicenseTime" placeholder="选择有效期" onclick="new Calendar().show('form1.businessLicenseTime');" />
                <input type="hidden" id="businessLicenseUrl" name="businessLicenseUrl" /> <input type="file" id="businessLicense" accept="image/* , application/pdf" value="上传文件"></td>
        </tr>
        <tr>
            <td>放射药品生产许可证:</td>
            <td><input type="text" name="productionLicenseTime" placeholder="选择有效期" onclick="new Calendar().show('form1.productionLicenseTime');" />
                <input type="hidden" id="productionLicenseUrl" name="productionLicenseUrl" /> <input type="file" id="productionLicense"  accept="image/* , application/pdf" value="上传文件"></td>
        </tr>
        <tr>
            <td>转让审批表:</td>
            <td><input type="text" name="approvalFormTime" placeholder="选择有效期" onclick="new Calendar().show('form1.approvalFormTime');" />
                <input type="hidden" id="approvalFormUrl" name="approvalFormUrl" /> <input type="file" id="approvalForm" accept="image/* , application/pdf"  value="上传文件"></td>
        </tr>
        <tr>
            <td>药品GMP证书:</td>
            <td><input type="text" name="gmpCertificateTime" placeholder="选择有效期" onclick="new Calendar().show('form1.gmpCertificateTime');" />
                <input type="hidden" id="gmpCertificateUrl" name="gmpCertificateUrl" /> <input type="file" id="gmpCertificate" accept="image/* , application/pdf"  value="上传文件"></td>
        </tr>
        <tr>
            <td>药品再注册批件:</td>
            <td><input type="text" name="registrationApprovalTime" placeholder="选择有效期" onclick="new Calendar().show('form1.registrationApprovalTime');" />
                <input type="hidden" id="registrationApprovalUrl" name="registrationApprovalUrl" /> <input type="file" id="registrationApproval" accept="image/* , application/pdf"  value="上传文件"></td>
        </tr>
        <tr>
            <td>授权委托书:</td>
            <td><input type="text" name="powerOfAttorneyTime" placeholder="选择有效期" onclick="new Calendar().show('form1.powerOfAttorneyTime');" />
                <input type="hidden" id="powerOfAttorneyUrl" name="powerOfAttorneyUrl" /> <input type="file"  id="powerOfAttorney"  accept="image/* , application/pdf"></td>
        </tr>
        <tr>
            <td>证件到期预警电话:</td>
            <td><input type="number" name="manufactorMobile" placeholder="厂商预留电话" /><br/><input type="number" name="platformMobile" placeholder="平台预留电话" /></td>
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
    var puid = getParam("puid");
    var nexturl = getParam("nexturl");
    form1.nexturl.value = decodeURIComponent(nexturl);
    form1.puid.value = puid;
    /* if(puid==0){
        form1.name.value = "";
    }else{ */
    fn.ajax("/ProcurementUnitServlet.do?act=findPU","puid="+puid,function(data){
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
            data.obj.name==null?form1.name.value = "":form1.name.value = data.obj.name;
            data.obj.sort==null?form1.sort.value = "":form1.sort.value = data.obj.sort;
            data.obj.fullname==null?form1.fullname.value = "":form1.fullname.value = data.obj.fullname;
            data.obj.fullnameen==null?form1.fullnameen.value = "":form1.fullnameen.value = data.obj.fullnameen;
            data.obj.mobile==null?form1.mobile.value = "":form1.mobile.value = data.obj.mobile;
            data.obj.person==null?form1.person.value = "":form1.person.value = data.obj.person;
            data.obj.email==null?form1.email.value = "":form1.email.value = data.obj.email;
            data.obj.zipcode==null?form1.zipcode.value = "":form1.zipcode.value = data.obj.zipcode;
            data.obj.fax==null?form1.fax.value = "":form1.fax.value = data.obj.fax;

            data.obj.address==null?form1.address.value = "":form1.address.value = data.obj.address;
            data.obj.telephone==null?form1.telephone.value = "":form1.telephone.value = data.obj.telephone;
            data.obj.website==null?form1.website.value = "":form1.website.value = data.obj.website;
            data.obj.telephoneReturn==null?form1.telephoneReturn.value = "":form1.telephoneReturn.value = data.obj.telephoneReturn;

            data.obj.radiationSafetyTime==null?form1.radiationSafetyTime.value = "":form1.radiationSafetyTime.value = data.obj.radiationSafetyTime;
            data.obj.radiationSafetyUrl==null?form1.radiationSafetyUrl.value = "":form1.radiationSafetyUrl.value = data.obj.radiationSafetyUrl;
            data.obj.businessLicenseTime==null?form1.businessLicenseTime.value = "":form1.businessLicenseTime.value = data.obj.businessLicenseTime;
            data.obj.businessLicenseUrl==null?form1.businessLicenseUrl.value = "":form1.businessLicenseUrl.value = data.obj.businessLicenseUrl;
            data.obj.productionLicenseTime==null?form1.productionLicenseTime.value = "":form1.productionLicenseTime.value = data.obj.productionLicenseTime;
            data.obj.productionLicenseUrl==null?form1.productionLicenseUrl.value = "":form1.productionLicenseUrl.value = data.obj.productionLicenseUrl;
            data.obj.approvalFormTime==null?form1.approvalFormTime.value = "":form1.approvalFormTime.value = data.obj.approvalFormTime;
            data.obj.approvalFormUrl==null?form1.approvalFormUrl.value = "":form1.approvalFormUrl.value = data.obj.approvalFormUrl;
            data.obj.gmpCertificateTime==null?form1.gmpCertificateTime.value = "":form1.gmpCertificateTime.value = data.obj.gmpCertificateTime;
            data.obj.gmpCertificateUrl==null?form1.gmpCertificateUrl.value = "":form1.gmpCertificateUrl.value = data.obj.gmpCertificateUrl;
            data.obj.registrationApprovalTime==null?form1.registrationApprovalTime.value = "":form1.registrationApprovalTime.value = data.obj.registrationApprovalTime;
            data.obj.registrationApprovalUrl==null?form1.registrationApprovalUrl.value = "":form1.registrationApprovalUrl.value = data.obj.registrationApprovalUrl;
            data.obj.powerOfAttorneyTime==null?form1.powerOfAttorneyTime.value = "":form1.powerOfAttorneyTime.value = data.obj.powerOfAttorneyTime;
            data.obj.powerOfAttorneyUrl==null?form1.powerOfAttorneyUrl.value = "":form1.powerOfAttorneyUrl.value = data.obj.powerOfAttorneyUrl;
            data.obj.manufactorMobile==null?form1.manufactorMobile.value = "":form1.manufactorMobile.value = data.obj.manufactorMobile;
            data.obj.platformMobile ==null?form1.platformMobile .value = "":form1.platformMobile .value = data.obj.platformMobile ;


        }
    });
    //}

    function fnedit(){
        if(form1.name.value == ""){
            mtDiag.show("厂商名称不能为空!");
        }else {
            fn.ajax("/ProcurementUnitServlet.do?act=editPU", $("#form1").serialize(), function (data) {
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

</script>
</body>
</html>
