<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="tea.entity.*"%>
<%@ page import="tea.entity.member.Profile" %>
<%@ page import="tea.entity.yl.shop.UpProfile" %>
<%@ page import="tea.entity.yl.shop.SignFor" %>
<%@ page import="java.util.List" %>
<%@ page import="tea.entity.yl.shop.EmpowerRecord" %>
<%@ page import="tea.entity.yl.shop.ShopHospital" %>
<%

Http h=new Http(request,response);
if(h.member<1)
{
    response.sendRedirect("/servlet/StartLogin?community="+h.community);
    return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer();
int member = h.member;
Profile p = Profile.find(member);
String[] stateArr = {"<font color=blue>申请中</font>","<font color=green>申请成功</font>","<font color=red>申请失败</font>"};
String[] uptypeArr = {"服务商","vip"};
List<UpProfile> list = UpProfile.find(" and profile=" + member+"AND isdele=0", 0, Integer.MAX_VALUE);
UpProfile up=null;
EmpowerRecord er=null;
ShopHospital hos=null;
if(list.size()>0){
	up = list.get(0);
	List<EmpowerRecord> erList = EmpowerRecord.find(" and upid="+h.get("upid"), 0, 1);
	er = erList.get(0);
	hos = ShopHospital.find(er.getHospital());
}else{
	up=new UpProfile();
	er=new EmpowerRecord();
	hos=new ShopHospital(0);
}

int state=up.getState();
String[] statearr={"申请中","审核通过","审核未通过"};
String[] arr = {"粒子签收","发票签收","粒子&发票签收"};
String nexturl=h.get("nexturl");

%>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <!-- <script>
        var ls=parent.document.getElementsByTagName("HEAD")[0];
        document.write(ls.innerHTML);
        var arr=parent.document.getElementsByTagName("LINK");
        for(var i=0;i<arr.length;i++)
        {
            document.write("<link href='"+arr[i].href+"' rel='"+arr[i].rel+"' type='text/css'>");
        }
        var tsstr = Date.parse(new Date());
    </script> -->
    <script src='/tea/mt.js'></script>
    <script src='/tea/city.js'></script>
    <script src="/tea/tea.js" type="text/javascript"></script>
    <script src="/tea/yl/jquery-1.7.js"></script>
    <script src="/tea/yl/top.js"></script>
    <script src="/tea/yl/mtDiag.js"></script>
    <script src="/jsp/yl/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <link rel="stylesheet" href="/tea/new/css/bootstrap.css">
    <link rel="stylesheet" href="/tea/new/css/animate.css">
    <link rel="stylesheet" href="/tea/new/css/style1.css">
    <link rel="stylesheet" href="/tea/new/css/common.css">
    <!-- <script src="js/jquery-1.11.3.min.js"></script>
    <script src="js/bootstrap.min.js"></script> -->
</head>
<style>
    body{
        background:#f8fbff;
    }
    .form-group{
        width:100%;
        float:left;

    }
    .container2{
    width: 1170px;
    padding-right: 15px;
    padding-left: 15px;
    margin-right: auto;
    margin-left: auto;
    }
    .natural{overflow:hidden;position:none;}

</style>
<body>
    <div id="Header" class="animate-box" data-animate-effect="fadeInLeft"></div>
<%
	 if(up.getUpid()==0||(up.getUpid()>0&&up.getState()==2)){
    %>
    <!-- container2添加或者修改申请vip -->
    <div class="container2" >
        <div class="row">
            <div class="col-md-12">
                <h1 class="head-tit animate-box" data-animate-effect="fadeInLeft">申请医生流程</h1>
                <div class="rate animate-box" data-animate-effect="fadeInLeft">
                    <span class="active animate-box" data-animate-effect="fadeInLeft"><em>1</em><br>填写资质信息</span>
                    <span class="animate-box last" data-animate-effect="fadeInLeft"><em>2</em><br>资质审核</span>
                </div>
                <div class="rate-fot animate-box">
                    <p>1. 请严格按照相关证件信息进行正确填写</p>
                    <p>2. 请上传最新版的证件原件的彩色扫描或彩色照片，复印件需加盖公司红章</p>
                    <p>3. 请确保上传图片信息清晰可辨，支持格式：JPG BMP JPEG PNG大小不超过2M</p>
                </div>
                <h2 class="head-hd animate-box" data-animate-effect="fadeInLeft">资质信息</h2>
                <form class="form-horizontal" name="form2" action="/EmpowerRecords.do"  id="form2" method="post" enctype="multipart/form-data" target="_ajax">
                    <input type="hidden" name="nexturl" value="<%=nexturl %>">
                    <input type="hidden" name="act" value="upVip">
                <input type="hidden" name="upid" value="<%=up.getUpid() %>">
                <input type="hidden" name="eid" value="<%=er.getEid() %>">
                    <div class="natural upVip animate-box" data-animate-effect="fadeInLeft">

                        <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                            <label class="col-sm-3 control-label"><em>*</em>姓名</label>
                            <div class="col-sm-9">
                            <%=MT.f(p.getMember())%>
                                <!-- <input type="text" class="form-control" id="" placeholder="请输入姓名"> -->
                            </div>
                        </div>
                        <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                            <label class="col-sm-3 control-label"><em>*</em>手机</label>
                            <div class="col-sm-9">
                                <p><%=p.getMobile()%></p>
                            </div>
                        </div>
                        <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                            <label  class="col-sm-3 control-label"><em>*</em>医院名称</label>
                            <div class="col-sm-9">
                                <input name="hospital" id="hospital" type="hidden" value="<%=er.getHospital()%>" class="form-control" />
                            <input name="hospitals" class="form-control fl" alt="医院不能为空!" id="hospitals" type="text" value="<%=MT.f(hos.getName())%>" readonly class="form-control" style="width:200px" />
                            <a href="javascript:;" class="btn btn-default btn-blue" style="margin-left:10px" onclick="showhospitalsearch()">选择医院</a>
                            </div>
                        </div>
                        
                        
                        <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                            <label class="col-sm-3 control-label"><em>*</em>转出/转入审批表</label>
                            <div class="col-sm-9">
                            <input name="turnApproval" type="file" alt="转入/转出审批表不能为空!">
                            <input name="turnApproval.attch" type="hidden" value="<%= MT.f(er.getTurnApproval()) %>" />
                            <%
                                if(er.getTurnApproval()>0){
                            %>
                            <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(er.getTurnApproval()) %>');">查看</a>
                            <%
                                }
                            %>
                        </div>
                        </div>
                        <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                            <label class="col-sm-3 control-label"><em>*</em>辐射安全许可证</label>
                            <div class="col-sm-9">
                            <input name="radiationCard" type="file" alt="辐射安全许可证不能为空!" title="<%= MT.f(er.getRadiationCard()) %>">
                            <input name="radiationCard.attch" id="clientID" type="hidden" value="<%= MT.f(er.getRadiationCard()) %>" />
                            <%
                                if(er.getRadiationCard()>0){
                            %>
                            <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(er.getRadiationCard()) %>');">查看</a>
                            <%
                                }
                            %>
                        </div>
                        </div>
                        <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                            <div class="col-sm-offset-3 col-sm-9 ts">
                                注:上传图片格式gif\jpg\png\bmp,大小不超过2M
                            </div>
                        </div>
                        <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                            <label class="col-sm-3 control-label"><em>*</em>辐射安全许可证有效期</label>
                            <div class="col-sm-9">
                            <input name="raditaionStart" alt="辐射安全许可证有效期开始不能为空!" class="Wdate form-control fl" value="<%=MT.f(er.getRaditaionStart())%>" onfocus="WdatePicker({minDate:'%y-%M-%d'})" id="makeoutdate" type="text" style="width:129px;height:auto;" />
                            <span class="fl" style="padding:0px 10px">至</span>
                            <input name="radiation" alt="辐射安全许可证有效期结束不能为空!" class="Wdate form-control fl" value="<%=MT.f(er.getRadiation())%>" onfocus="WdatePicker({minDate:'%y-%M-%d'})" id="makeoutdate1" type="text" style="width:129px;height:auto;" />
                        </div>
                        </div>
                        <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                            <label class="col-sm-3 control-label"><em>*</em>放射诊疗许可证</label>
                           <div class="col-sm-9">
                            <input name="radiate" type="file" alt="放射诊疗许可证不能为空!" title="<%= MT.f(er.getRadiate()) %>">
                            <input name="radiate.attch" type="hidden" value="<%= MT.f(er.getRadiate()) %>" />
                            <%
                                if(er.getRadiate()>0){
                            %>
                            <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(er.getRadiate()) %>');">查看</a>
                            <%
                                }
                            %>
                        </div>
                        </div>
                        <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                            <label class="col-sm-3 control-label"><em>*</em>放射性药品使用许可证</label>
                            <div class="col-sm-9">
                            <input name="radiateCard" type="file"  alt="放射性药品使用许可证不能为空!" title="<%= MT.f(er.getRadiateCard()) %>">
                            <input name="radiateCard.attch" type="hidden" value="<%= MT.f(er.getRadiateCard()) %>" />
                            <%
                                if(er.getRadiateCard()>0){
                            %>
                            <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(er.getRadiateCard()) %>');">查看</a>
                            <%
                                }
                            %>
                        </div>
                        </div>
                        <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                            <label class="col-sm-3 control-label"><em>*</em>粒子签收人/发票签收人</label>
                            <div class="col-sm-9">
                            <input name="signFor" type="file" alt="粒子签收人/发票签收人!">
                            <input name="signFor.attch" type="hidden" value="<%= MT.f(er.getSignFor()) %>" />
                            <%
                                if(er.getSignFor()>0){
                            %>
                            <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(er.getSignFor()) %>');">查看</a>
                            <%
                                }
                            %>
                        </div>
                        </div>
                    </div>
					<%
                        List<SignFor> list3 = SignFor.find(" and eid=" + er.getEid(), 0, Integer.MAX_VALUE);
                        if(list3.size()<1){
                    %>
                    <div class="natural last upVip animate-box" data-animate-effect="fadeInLeft">
                        <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                            <label class="col-sm-3 control-label"><em>*</em>粒子签收人信息</label>
                            <div class="col-sm-1 control-label" style="padding-left:0px;padding-right:0px;">姓名</div>
                            <div class="col-sm-8">
                               
                                <input type="text" name="signatory" alt="签收人姓名不能为空!"  class="form-control">
                            </div>
                        </div>
                        <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                            <div class="col-sm-offset-3 col-sm-1 control-label" style="padding-left:0px;padding-right:0px;">电话</div>
                            <div class="col-sm-8">
                                <input type="text" name="mobile" alt="签收人手机号不能为空!" class="form-control">
                            </div>
                        </div>
                        <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                            <div class="col-sm-offset-3 col-sm-1 control-label" style="padding-left:0px;padding-right:0px;">科室</div>
                                <div class="col-sm-8">
                                    <select  name="department" alt="请选择签收人科室!"  class="form-control">
                                        <option value="">请选择</option>
                                        <%
                                        for (int i = 1; i < SignFor.DEPARTMENT_ARR.length; i++) {
                                            out.print("<option value='"+i+"'>"+SignFor.DEPARTMENT_ARR[i]+"</option>");
                                        }


                                        %>
                                    </select>
                                </div>
                        </div>
                        <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                            <div class="col-sm-offset-3 col-sm-1 control-label" style="padding-left:0px;padding-right:0px;">签收类型</div>
                                <div class="col-sm-8">
                                    <select  name="signType" alt="请选择签收人签收类型" class="form-control">
                                        <option value="">请选择</option>
                                        <option value="0">粒子签收</option>
                                        <option value="1">发票签收</option>
                                        <option value="2">粒子+发票签收</option>
                                    </select>
                                </div>
                        </div>
                        <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                            <div class="col-sm-offset-3 col-sm-9">
                                <input placeholder="详细地址" type="text" name="address" style="width:100%" alt="签收人详细地址不能为空" class="form-control">
                            </div>
                        </div>
                        <div class="form-group animate-box" data-animate-effect="fadeInLeft" style="height:20px;">

                        </div>
<%
                        }else{
                        	for (int i = 0; i < list3.size(); i++) {
                                SignFor sf3 = list3.get(i);
                        		
%>
<input type="hidden" name="sid" value="<%=sf3.getSid() %>">
<div class="natural last upVip animate-box" data-animate-effect="fadeInLeft">
                        <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                            <label class="col-sm-3 control-label"><em>*</em><%
                                if(sf3.getSignType()==0){//粒子%>
                              粒子签收人信息
                            <%}else if(sf3.getSignType()==1){//发票%>
                                  发票签收人信息
                                <%}else {//粒子+发票%>
                                    粒子/发票签收人信息
                                <%}%></label>
                            <div class="col-sm-1 control-label" style="padding-left:0px;padding-right:0px;">姓名</div>
                            <div class="col-sm-8">
                               
                                <input type="text" name="signatory" alt="签收人姓名不能为空!" value="<%=MT.f(sf3.getSignatory())%>" class="form-control">
                            </div>
                        </div>
                        <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                            <div class="col-sm-offset-3 col-sm-1 control-label" style="padding-left:0px;padding-right:0px;">电话</div>
                            <div class="col-sm-8">
                                <input type="text" name="mobile" alt="签收人手机号不能为空!" value="<%=MT.f(sf3.getMobile())%> " class="form-control">
                            </div>
                        </div>
                        <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                            <div class="col-sm-offset-3 col-sm-1 control-label" style="padding-left:0px;padding-right:0px;">科室</div>
    <div class="col-sm-8">
                            <select  name="department" alt="请选择签收人科室!"  class="form-control">
                                <option value="">请选择</option>
                                <%
                                    for (int j = 1; j < SignFor.DEPARTMENT_ARR.length; j++) {
                                        if(sf3.getDepartment()==j){
                                            out.print("<option value='" + j + "' selected=selected>" + SignFor.DEPARTMENT_ARR[j] + "</option>");
                                        }else {
                                            out.print("<option value='" + j + "'>" + SignFor.DEPARTMENT_ARR[j] + "</option>");
                                        }
                                    }

                                %>
                            </select>
    </div>
                        </div>
                        <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                            <div class="col-sm-offset-3 col-sm-1 control-label" style="padding-left:0px;padding-right:0px;">签收类型</div>
    <div class="col-sm-8">
                            <select name="signType" alt="请选择签收人签收类型!" class="form-control">
                                <option value="">请选择</option>
                                <%
                                    for (int i1 = 0; i1 < arr.length; i1++) {
                                        if(sf3.getSignType()==i1){
                                            out.print("<option value='"+i1+"' selected=selected>"+arr[i1]+"</option>");
                                        }else{
                                            out.print("<option value='"+i1+"'>"+arr[i1]+"</option>");
                                        }

                                    }
                                %>
                            </select>
    </div>
                        </div>
                        <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                            <div class="col-sm-offset-3 col-sm-9">
                                <input type="text" name="address" style="width:100%" alt="签收人详细地址不能为空"  value="<%=MT.f(sf3.getAddress())%>" class="form-control">
                            </div>
                        </div>
                        <div class="form-group animate-box" data-animate-effect="fadeInLeft" style="height:20px;">

                        </div>
                        <input type="button" onclick="fnadd(this)" value="添加"/>
                        <input type="button" onclick="fndel(this)" value="删除"/>
                        
                        
</div>
<%
                        	}
                        }
                        %>
                        <div class="form-group animate-box" data-animate-effect="fadeInLeft" style="background: #fff;padding-bottom:15px;">
                            <div style='text-align:center;'>
                            
                                <button onclick="upVip()" class="btn btn-default vip-tj">提交审核</button>
                            </div>
                        </div>
                    
                </form>
            </div>
        </div>
    </div>
    <%
	}
    %>
<form action="/Attchs.do" name="form9" method="post" target="_ajax">
    <input name="act" type="hidden" value="down" />
    <input name="attch" type="hidden" />
</form>

    
    <script type="text/javascript">
        mt.fit();
    
    function upVip(){
        if(mtDiag.check($("#form2"))) {
            form2.submit();
        }
        /*var a = form2.hospitals.value;
       alert(a);
       var b = form2.raditaionStart.value;
       alert(b);*/
    }
    function showhospitalsearch(){
        layer.open({
            type: 2,
            title: '查询医院',
            shadeClose: true,
            area: ['700px', '550px'],
            closeBtn:1,
            content: '/jsp/yl/shop/choseHospital.jsp?upid=<%=up.getUpid() %>'
        });
    }
    function fnedid(){
    	$(".container2").show();
    	$(".container").hide();
    }
    function downatt(num){
        form9.attch.value = num;
        form9.submit();
    }
    mt.receive=function(h,n){
        $("#hospital").val(h);
        $("#hospitals").val(n);
    }
    function fndel(obj){
    	$(obj).parent().remove();
        mt.fit();
    }

    function fnadd(obj){
        var obj2=$(obj).parent().clone(true);
        console.log(obj2);
        obj2.insertAfter($(obj).parent());
        mt.fit();
    }
    </script>
</body>
</html>