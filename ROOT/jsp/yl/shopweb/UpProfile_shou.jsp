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
    //response.sendRedirect("/servlet/StartLogin?community="+h.community);
    out.print("<script>parent.location='"+"/servlet/StartLogin?community="+h.community+"';</script>");
    return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer();
int member = h.member;
Profile p = Profile.find(member);
String[] stateArr = {"<font color=blue>申请中</font>","<font color=green>申请成功</font>","<font color=red>申请失败</font>"};
String[] uptypeArr = {"服务商","vip"};
List<UpProfile> list = UpProfile.find("AND isdele=0 and profile=" + member, 0, Integer.MAX_VALUE);
UpProfile up=null;
EmpowerRecord er=null;
ShopHospital hos=null;
if(list.size()>0){
	up = list.get(0);
	List<EmpowerRecord> erList = EmpowerRecord.find("and upid="+up.getUpid(), 0, 1);
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
    <script src="/tea/jquery-1.11.1.min.js"></script>
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

</style>
<body>
    <%
        if(up.getUpid()==0){
    %>
    <div class="container" >
        <div class="row">
            <div class="col-md-12">
                <h1 class="head-tit animate-box" >申请医生流程</h1>
                <div class="rate animate-box" >
                    <span class="active animate-box" ><em>1</em><br>填写资质信息</span>
                    <span class="animate-box last" ><em>2</em><br>资质审核</span>
                </div>
                <div class="rate-fot animate-box">
                    <p>1. 请严格按照相关证件信息进行正确填写</p>
                    <p>2. 请上传最新版的证件原件的彩色扫描或彩色照片，复印件需加盖公司红章</p>
                    <p>3. 请确保上传图片信息清晰可辨，支持格式：JPG BMP JPEG PNG大小不超过2M</p>
                </div>
                <h2 class="head-hd animate-box" >资质信息</h2>
                <form class="form-horizontal" name="form2" action="/EmpowerRecords.do"  id="form2" method="post" enctype="multipart/form-data" target="_ajax">
                    <input type="hidden" name="nexturl">
                    <input type="hidden" name="act" value="upVip">
                    <input type="hidden" name="upid" value="<%=up.getUpid() %>">
                    <input type="hidden" name="eid" value="<%=er.getEid() %>">
                    <div class="natural upVip animate-box" style="overflow:hidden;">

                        <div class="form-group animate-box" >
                            <label class="col-sm-3 control-label"><em>*</em>姓名</label>
                            <div class="col-sm-9">
                                <%=MT.f(p.getMember())%>
                                <!-- <input type="text" class="form-control" id="" placeholder="请输入姓名"> -->
                            </div>
                        </div>
                        <div class="form-group animate-box" >
                            <label class="col-sm-3 control-label"><em>*</em>手机</label>
                            <div class="col-sm-9">
                                <p><%=p.getMobile()%></p>
                            </div>
                        </div>
                        <div class="form-group animate-box" >
                            <label  class="col-sm-3 control-label"><em>*</em>医院名称</label>
                            <div class="col-sm-9">
                                <input name="hospital" id="hospital" type="hidden" value="<%=er.getHospital()%>" class="form-control" />
                                <input name="hospitals" class="form-control fl" alt="医院不能为空!" id="hospitals" type="text" value="<%=MT.f(hos.getName())%>" readonly class="form-control" style="width:200px" />
                                <a href="javascript:;" class="btn btn-default btn-blue" style="margin-left:10px" onclick="showhospitalsearch()">选择医院</a>
                            </div>
                        </div>


                        <div class="form-group animate-box" >
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
                        <div class="form-group animate-box" >
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
                        <div class="form-group animate-box" >
                            <div class="col-sm-offset-3 col-sm-9 ts">
                                注:上传图片格式gif\jpg\png\bmp,大小不超过2M
                            </div>
                        </div>
                        <div class="form-group animate-box" >
                            <label class="col-sm-3 control-label"><em>*</em>辐射安全许可证有效期</label>
                            <div class="col-sm-9">
                                <input name="raditaionStart" alt="辐射安全许可证有效期开始不能为空!" class="Wdate form-control fl" value="<%=MT.f(er.getRaditaionStart())%>" onfocus="WdatePicker({minDate:'%y-%M-%d'})" id="makeoutdate" type="text" style="width:129px;height:auto;" />
                                <span class="fl" style="padding:0px 10px">至</span>
                                <input name="radiation" alt="辐射安全许可证有效期结束不能为空!" class="Wdate form-control fl" value="<%=MT.f(er.getRadiation())%>" onfocus="WdatePicker({minDate:'%y-%M-%d'})" id="makeoutdate1" type="text" style="width:129px;height:auto;" />
                            </div>
                        </div>
                        <div class="form-group animate-box" >
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
                        <div class="form-group animate-box" >
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
                        <div class="form-group animate-box" >
                            <label class="col-sm-3 control-label"><em>*</em>签收人/发票签收人</label>
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
                    <div class="natural last upVip animate-box" >
                        <div class="form-group animate-box" >
                            <label class="col-sm-3 control-label"><em>*</em>粒子/发票签收人信息</label>
                            <div class="col-sm-1 control-label" style="padding-left:0px;padding-right:0px;">姓名</div>
                            <div class="col-sm-8">

                                <input type="text" name="signatory" alt="签收人姓名不能为空!"  class="form-control">
                            </div>
                        </div><!--姓名结束-->
                        <div class="form-group animate-box" >
                            <div class="col-sm-offset-3 col-sm-1 control-label" style="padding-left:0px;padding-right:0px;">电话</div>
                            <div class="col-sm-8">
                                <input type="text" name="mobile" alt="签收人手机号不能为空!" class="form-control">
                            </div>
                        </div><!--电话结束-->
                        <div class="form-group animate-box" >
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
                        </div><!--科室结束-->
                        <div class="form-group animate-box" >
                            <div class="col-sm-offset-3 col-sm-1 control-label" style="padding-left:0px;padding-right:0px;">签收类型</div>
                            <div class="col-sm-8">
                                <select  name="signType" alt="请选择签收人签收类型" class="form-control">
                                    <option value="">请选择</option>
                                    <option value="0">粒子签收</option>
                                    <option value="1">发票签收</option>
                                    <option value="2">粒子+发票签收</option>
                                </select>
                            </div>
                        </div><!--签收类型结束-->
                        <div class="form-group animate-box" >
                            <div class="col-sm-offset-3 col-sm-9">
                                <input type="text" name="address" style="width:100%" placeholder="详细地址" alt="签收人详细地址不能为空" class="form-control">
                            </div>
                        </div><!--地址结束-->
                        <div class="form-group animate-box"  style="height:20px;">

                        </div>
                        <input type="button" onclick="fnadd(this)" value="添加"/>
                        <input type="button" onclick="fndel(this)" value="删除"/>
                        </div>
                            <%
                        }else{
                        	for (int i = 0; i < list3.size(); i++) {
                                SignFor sf3 = list3.get(i);

%>
                        <input type="hidden" name="sid" value="<%=sf3.getSid() %>">
                        <div class="natural last upVip animate-box" >
                            <div class="form-group animate-box" >
                                <label class="col-sm-3 control-label"><em>*</em>粒子签收人信息</label>
                                <div class="col-sm-1 control-label" style="padding-left:0px;padding-right:0px;">姓名</div>
                                <div class="col-sm-8">

                                    <input type="text" name="signatory" alt="签收人姓名不能为空!" value="<%=MT.f(sf3.getSignatory())%>" class="form-control">
                                </div>
                            </div>
                            <div class="form-group animate-box" >
                                <div class="col-sm-offset-3 col-sm-1 control-label" style="padding-left:0px;padding-right:0px;">电话</div>
                                <div class="col-sm-8">
                                    <input type="text" name="mobile" alt="签收人手机号不能为空!" value="<%=MT.f(sf3.getMobile())%> " class="form-control">
                                </div>
                            </div>
                            <div class="form-group animate-box" >
                                <div class="col-sm-offset-3 col-sm-1 control-label" style="padding-left:0px;padding-right:0px;">科室</div>
                                    <div class="col-sm-8">
                                        <select name="department" alt="请选择签收人科室!"  class="form-control">
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
                            <div class="form-group animate-box" >
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
                            <div class="form-group animate-box" >
                                <div class="col-sm-offset-3 col-sm-9">
                                    <input type="text" name="address" style="width:100%" alt="签收人详细地址不能为空"  value="<%=MT.f(sf3.getAddress())%>" class="form-control">
                                </div>
                            </div>
                            <div class="form-group animate-box"  style="height:20px;">

                            </div>
                            <input type="button" onclick="fndel(this)" value="删除"/>


                        </div>
                            <%
                        	}
                        }
                        %>
                        <div class="form-group animate-box"  style="background: #fff;padding-bottom:15px;">
                            <div class="col-sm-offset-4 col-sm-9">
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
<%
	if(up.getUpid()>0){
%>
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1 class="head-tit animate-box" >医生申请</h1>
                <div class="rate animate-box" >
                    <span class="active animate-box" ><em>1</em><br>填写资质信息</span>
                    <span class="active animate-box last" ><em>2</em><br>资质审核</span>
                </div>

                <h2 class="head-hd animate-box conduct" ><%=statearr[state] %></h2>
                <div class="natural upVip animate-box"  style="min-height: 327px;">
                    <div class="form-group animate-box" >
                        <label class="col-sm-3 control-label">姓名</label>
                        <div class="col-sm-3">
                            <p><%=MT.f(p.member)%></p>
                        </div>
                        <label class="col-sm-3 control-label">手机</label>
                        <div class="col-sm-3">
                            <p>
                            <% if(!MT.f(p.mobile).equals("")){
                        out.print(MT.f(p.mobile)/*+"&nbsp;&nbsp;<a href='javascript:void(0);' onclick=oncheckpage('mobile','修改手机号') >修改</a>"*/);
                    }else{
                        out.print("还未绑定手机&nbsp;&nbsp;<a href='javascript:void(0);' onclick=onsetpage('mobile','绑定手机号')>绑定</a>");
                    }%>
                            </p>
                        </div>
                    </div>
                     
                    <div class="form-group animate-box" >
                        <label class="col-sm-3 control-label">医院名称</label>
                        <div class="col-sm-3">
                            <p><%=MT.f(hos.getName())%></p>
                        </div>
                        <!-- <label class="col-sm-3 control-label">所在科室</label>
                        <div class="col-sm-3">
                            <p>放射科</p>
                        </div> -->
                    </div>
                    <!-- <div class="form-group animate-box" >
                        <label class="col-sm-3 control-label">所在地</label>
                        <div class="col-sm-9">
                            <p>北京 北京市 昌平区丁家桥87号住院部7楼</p>
                        </div>
					</div> -->
                    <div class="form-group animate-box"  style="height: 20px;">

                    </div>
                   
                    <div class="form-group animate-box" >
                        <label class="col-sm-3 control-label">转入/转出审批表</label>
                        <div class="col-sm-3">
                            <p>
                            <%
                        if(er.getTurnApproval()>0){
                    %>
                    <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(er.getTurnApproval()) %>');">查看</a>
                    <%
                        }else{
                            out.print("无文件!");
                        }
                    %>
                            </p>
                        </div>
                        <label class="col-sm-3 control-label">辐射安全许可证</label>
                        <div class="col-sm-3">
                            <p>
                            <%
                        if(er.getRadiationCard()>0){
                    %>
                    <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(er.getRadiationCard()) %>');">查看</a>
                    <%
                        }else{
                            out.print("无文件!");
                        }
                    %>
                            </p>
                        </div>
                    </div>
                    <div class="form-group animate-box" >
                        <label class="col-sm-3 control-label">辐射安全许可证有效期</label>
                        <div class="col-sm-3">
                            <p><%=MT.f(er.getRaditaionStart())%>至<%=MT.f(er.getRadiation())%></p>
                        </div>
                        <label class="col-sm-3 control-label">放射诊疗许可证</label>
                        <div class="col-sm-3">
                            <p>
                            <%
                        if(er.getRadiate()>0){
                    %>
                    <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(er.getRadiate()) %>');">查看</a>
                    <%
                        }else{
                            out.print("无文件!");
                        }
                    %>
                            </p>
                        </div>
                    </div>
                    <div class="form-group animate-box" >
                        <label class="col-sm-3 control-label">放射性药品使用许可证</label>
                        <div class="col-sm-3">
                            <p>
                            <%
                        if(er.getRadiateCard()>0){
                    %>
                    <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(er.getRadiateCard()) %>');">查看</a>
                    <%
                        }else{
                            out.print("无文件!");
                        }
                    %>
                            </p>
                        </div>
                        <label class="col-sm-3 control-label">粒子/发票签收人</label>
                        <div class="col-sm-3">
                            <p>
                            <%
                        if(er.getSignFor()>0){
                    %>
                    <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(er.getSignFor()) %>');">查看</a>
                    <%
                        }else{
                            out.print("无文件!");
                        }
                    %>
                            </p>
                        </div>
                    </div>

                </div>
                <%
                List<SignFor> list2 = SignFor.find(" and eid=" + er.getEid(), 0, Integer.MAX_VALUE);
                
                %>
                
                <div class="natural upVip animate-box"  style="min-height: 327px;">
                <%
                for (int i = 0; i < list2.size(); i++) {
                    SignFor sf = list2.get(i);
                    String qstitle="";
                    
                %>
                    <div class="form-group animate-box" >
                    <%
                    if(sf.getSignType()==0){
                    	qstitle="粒子签收人";
                    }else if(sf.getSignType()==1){
                    	qstitle="发票签收人";
                    }else if(sf.getSignType()==2){
                    	qstitle="粒子签收人/发票签收人";
                    }
                    %>
                        <label class="col-sm-2 control-label"><%=qstitle %></label>
                        <div class="col-sm-1 control-label" style="padding-left:0px;padding-right:0px;">姓名</div>
                        <div class="col-sm-3">
                            <p><%=MT.f(sf.getSignatory())%></p>
                        </div>
                        <label class="col-sm-offset-1 col-sm-2 control-label">手机</label>
                        <div class="col-sm-3">
                            <p><%=MT.f(sf.getMobile())%></p>
                        </div>
                    </div>
                    <div class="form-group animate-box" >
                        <label class="col-sm-offset-1 col-sm-2 control-label">医院名称</label>
                        <div class="col-sm-3">
                            <p><%=MT.f(hos.getName())%></p>
                        </div>
                        <label class="col-sm-offset-1 col-sm-2 control-label">所在科室</label>
                        <div class="col-sm-3">
                            <p>
                            <%
                             for (int j = 1; j < SignFor.DEPARTMENT_ARR.length; j++) {
                                        if(sf.getDepartment()==j){
                                            out.print(SignFor.DEPARTMENT_ARR[j]);
                                        }
                             }
                             %>
                            </p>
                        </div>
                    </div>
                    <div class="form-group animate-box" >
                        <label class="col-sm-offset-1 col-sm-2 control-label">所在地</label>
                        <div class="col-sm-9">
                            <p><%=MT.f(sf.getAddress())%></p>
                        </div>

                    </div>
                    <%
                             }
                    
                	if(up.getState()==2){
                	%>
                	<div class="form-group animate-box" >
                	<label class="col-sm-offset-1 col-sm-2 control-label">审核未通过原因</label>
                        <div class="col-sm-9">
                            <p><%=MT.f(up.getDescribe()) %></p>
                        </div>
                	</div>
                	<%
                	}
                %>
                    <div class="form-group animate-box"  style="height: 20px;">

                    </div>
                    <!-- <div class="form-group animate-box" >

                        <label class="col-sm-2 control-label">发票签收人信息</label>
                        <div class="col-sm-1 control-label" style="padding-left:0px;padding-right:0px;">姓名</div>
                        <div class="col-sm-3">
                            <p>webmaster</p>
                        </div>
                        <label class="col-sm-offset-2 col-sm-1 control-label">手机</label>
                        <div class="col-sm-3">
                            <p>13810916535</p>
                        </div>
                    </div>
                    <div class="form-group animate-box" >
                        <label class="col-sm-offset-2 col-sm-1 control-label">医院名称</label>
                        <div class="col-sm-3">
                            <p>北医中院</p>
                        </div>
                        <label class="col-sm-offset-2 col-sm-1 control-label">所在科室</label>
                        <div class="col-sm-3">
                            <p>放射科</p>
                        </div>
                    </div>
                    <div class="form-group animate-box" >
                        <label class="col-sm-offset-2 col-sm-1 control-label">所在地</label>
                        <div class="col-sm-9">
                            <p>北京 北京市 昌平区丁家桥87号住院部7楼</p>
                        </div>

                    </div> -->
                </div>
                
                <% 
                	if(up.getState()==2){
                %>
                <div style='text-align:center;background: #fff;padding-bottom:15px;'>
                    <button onclick="fnedid()" class='vip-tj'>修改</button>
                    <button onclick="dele_up('<%=up.getUpid()%>')" class='vip-tj'>取消申请</button>
                </div>
                <div  style='text-align:center;background: #fff;padding-bottom:15px;'>

                </div>
                <%
                	}
                %>
            </div>order_dey_rongqi_shouna.jsp
        </div>
    </div>
    <%
	}
    
	
    %>
<form action="/Attchs.do" name="form9" method="post" target="_ajax">
    <input name="act" type="hidden" value="down" />
    <input name="attch" type="hidden" />
</form>
    <form action="/UpProfiles.do" name="form4" method="post" target="_ajax">
        <input name="act" type="hidden" value="dele_up" />
        <input name="upid" type="hidden"/>
        <input name="vip" type="hidden" value="1">
        <input name="nexturl" type="hidden" />
    </form>

    
    <script type="text/javascript">
        mt.fit();
    form2.nexturl.value=location.pathname+location.search;
    
    function upVip(){
        if(mtDiag.check1($("#form2"))) {
            if(form2.hospitals.value==null || form2.hospitals.value=="")
            {
                mt.show("必选项医院");
                form2.hospitals.focus();
                return false;
            }
            form2.submit();
        }
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
    	location.href="/jsp/yl/shopweb/UpProfile_shou_edit.jsp?upid=<%=up.getUpid() %>&nexturl="+location.pathname+location.search;
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
        function dele_up(id) {
            form4.nexturl.value="/html/folder/19092170-1.htm";/*测试 /html/folder/19082256-1.htm           正式 /html/folder/19092170-1.htm*/
            form4.upid.value=id;
            mt.show('你确定要取消申请么？', 2, 'form4.submit()');
        }
    </script>
</body>
</html>