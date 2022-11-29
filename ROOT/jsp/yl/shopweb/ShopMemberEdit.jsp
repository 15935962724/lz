<%@page import="tea.entity.yl.shop.ShopQualification"%>
<%@page import="tea.entity.yl.shop.ShopHospital"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.*"%><%@page import="tea.entity.admin.*"%><%@page import="tea.entity.member.*"%><%

	Http h=new Http(request,response);
	if(h.member<1)
	{
		out.println("<script>alert('您还没有登陆或登陆已超时！请重新登陆');location.replace('/my/Login.jsp?nexturl='+encodeURIComponent(location.pathname+location.search));</script>");
		return;
	}

	/* Member m=Member.find(h.member); */
	Profile m=Profile.find(h.member);

	/* Site s=Site.find(1); */


%><!doctype html><html><head>
<title><%=Res.get(h.language,"个人资料")%></title>

</head>
<body>

<%
	boolean flag = false;
	ShopQualification sq = ShopQualification.findByMember(m.profile);
	if(m.qualification>0||(sq.status==1)||sq.status==5){//不能编辑
		flag = true;
	}
%>
<script src='/tea/mt.js'></script>
<script src='/tea/city.js'></script>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src='/tea/jquery-1.3.1.min.js'></script>
<link rel="stylesheet" href="/tea/new/css/style.css">
<script src="/tea/new/js/jquery.min.js"></script>
<script src="/tea/new/js/superslide.2.1.js"></script>
<script src="/tea/yl/mtDiag.js"></script>
<style>
	.con-left .bd:nth-last-child(2){
		display:block;
	}
	.con-left ul.bd:nth-last-child(2) li:nth-child(1){
		font-weight: bold;
	}

</style>
<form name="form1" action="/ShopQualifications.do" method="post" enctype="multipart/form-data" target="_ajax" onSubmit="return mt.check(this)">
	<input type="hidden" name="act" value="edit"/>
	<input type="hidden" name="nexturl" value="parent.location.reload()"/>
	<input type="hidden" name="qua" value="<%= sq.id%>"/>
	<input type="hidden" name="state" value=""/>
	<%-- <input type="hidden" name="avatar" value="<%=m.avatar%>"/> --%>
	<%--  <table id="tablecenter" cellspacing="0" style="background:none;">
     <tr><td class="ModifyHead"><img id="_avatar" src="<%=MT.f(m.avatar,"/tea/image/avatar.jpg")%>" /><br>
    <a href="javascript:my.avatar()">修改头像</a></td></tr></table>  --%>


	<%@ include file="/jsp/yl/shopweb/PersonalTop.jsp" %>
	<div id="Content">
		<div class="con-left">
			<%@ include file="/jsp/yl/shopweb/PersonalLeft.jsp" %>
		</div>
		<div class="con-right">
			<div class="qualification">
				<p class="right-zhgl">
					<span>账户管理</span>
				</p>
				<p class="right-dz">
					<span>基本信息</span>
				</p>
				<div class="right-list">
					<table id="tab1"  class="right-tab4" border="0" cellspacing="0">
						<input type="hidden" name="mesg" value="请致电010-68533123，与管理员确认，审核通过后，方能提交订单。" />
						<tr>
							<td class="td-left">用户名：</td>
							<td class="td-right"><%=MT.f(m.member)%></td>
						</tr>
						<tr>
							<td class="td-left">手机：</td>
							<td class="td-right"><% if(!MT.f(m.mobile).equals("")){
								out.print(MT.f(m.mobile)+"&nbsp;&nbsp;<a href='javascript:void(0);' onclick=oncheckpage('mobile','修改手机号') >修改</a>");
							}else{
								out.print("还未绑定手机&nbsp;&nbsp;<a href='javascript:void(0);' onclick=onsetpage('mobile','绑定手机号')>绑定</a>");
							}%></td>
						</tr>
						<tr>
							<td class="td-left">邮箱：</td>
							<td class="td-right"><% if(!MT.f(m.email).equals("")){
								out.print(MT.f(m.email)+"&nbsp;&nbsp;<a href='javascript:void(0);' onclick=oncheckpage('email','修改邮箱')>修改</a>");
							}else{
								out.print("还未绑定邮箱&nbsp;&nbsp;<a href='javascript:void(0);' onclick=onsetpage('email','绑定邮箱') >绑定</a>");
							}%></td>
						</tr>
					</table>
					<div style="margin-top:20px;<%= (m.membertype==2?"display: none;":"") %>">
						<p class="right-dz">
							<span>资质信息</span>
						</p>
						<table class="right-tab4" border="0" cellspacing="0" style="margin-top:20px;background:none;<%= (flag?"display: none;":"")%>"  >
							<tr>
								<td class="td-left"><span style="color: red;">*</span>姓名：</td>
								<td><input name="name" value="<%= MT.f(sq.realname) %>" alt="姓名" /></td>
							</tr>
							<tr>
								<td class="td-left"><span style="color: red;">*</span>所属医院：</td>
								<td>
									<%-- <%
                                List<ShopHospital> shlist = ShopHospital.find("", 0, 500);
                                    %>
                                    <SELECT name="hospital" id="hospital" alt="医院" >
                                    <option value="-1">--请选择--</option>
                                        <%
                                            for(int i=0;i<shlist.size();i++){
                                                ShopHospital sh = shlist.get(i);
                                                out.print("<option "+(sh.getId()==sq.hospital_id?"selected='selected'":"")+" value='"+sh.getId()+"'>"+sh.getName()+"</option>");
                                            }
                                        %>
                                    </SELECT> --%>
									<input type="hidden" value="<%= sq.hospital_id %>" name="hospital">
									<input type="text" value="<%= (sq.hospital_id==0?"":ShopHospital.find(sq.hospital_id).getName()) %>" readonly="readonly" name="hospitals">
									<input type="button" value="选择医院" onclick="showhospitalsearch()" />
								</td>
							</tr>
							<tr><td class="td-left"></td><td>如果名单中找不到自己的医院 请电话联系我们</td></tr>
							<tr>
								<td class="td-left">
									<span style="color: red;">*</span>科室：
								</td>
								<td>
									<select name="department">
										<option value="-1">--请选择--</option>
										<%
											for(int i=1;i<ShopQualification.DEPARTMENT_ARR.length;i++){
												out.print("<option "+(i==sq.department?"selected='selected'":"")+" value='"+i+"'>"+ShopQualification.DEPARTMENT_ARR[i]+"</option>");
											}
										%>
									</select>
								</td>
							</tr>
							<tr>
								<td class="td-left"><span style="color: red;">*</span>城市：</td>
								<td><script>mt.city('city0','city1','city2','<%= MT.f(sq.area) %>')</script></td>
							</tr>
							<tr>
								<td class="td-left"><span style="color: red;">*</span>详细地址：</td>
								<td><input name="address" alt="详细地址" value="<%= MT.f(sq.address) %>" /></td>
							</tr>
							<tr>
								<td class="td-left"><span style="color: red;">*</span>手机：</td>
								<td><input name="mobile" alt="手机" value="<%= MT.f(sq.mobile) %>" /></td>
							</tr>
							<tr>
								<td class="td-left">固定电话：</td>
								<td><input name="tel" value="<%= MT.f(sq.telphone) %>" /></td>
							</tr>
							<tr>
								<td class="td-left"><span style="color: red;">*</span>资质证明：</td>
								<td class='righttexts'><input type="file" name="qualification"  />
									<input name="qualification.attch" type="hidden" value="<%= MT.f(sq.qualification) %>" />
									<%
										if(sq.qualification>0){
									%>
									<a href='javascript:void(0);' onclick="downatt('<%= MT.enc(sq.qualification) %>');">查看</a>
									<%
										}
									%>
									<p>请打包上传以下资质证明：辐射安全许可证正本、副本（包括I-125增项）、放射诊疗许可证、转让审批、本人员工证明。<br/>或将文件传真至：010-68533123，或者告诉我们</p>

								</td>
							</tr>
							<tr>
								<td colspan="2" class="submitTd">
									<input type="button" onclick="mysupmit('<%= ((sq.status==4||sq.status==6)?"4":"0") %>');" value="保存"/>&nbsp;
									<input type="button" onclick="mysupmit('<%= ((sq.status==4||sq.status==6)?"5":"1") %>');" value="提交审核"/>
								</td>
							</tr>
						</table>
						<table class="right-tab4" border="0" cellspacing="0" style="margin-top:20px;background:none;<%= (flag?"":"display: none;")%>">
							<tr>
								<td class="td-left">姓名：</td>
								<td><%= MT.f(sq.realname) %></td>
							</tr>
							<tr>
								<td class="td-left">所属医院：</td>
								<td>
									<%=
									MT.f(ShopHospital.find(sq.hospital_id).getName())
									%>
								</td>
							</tr>
							<tr>
								<td class="td-left">
									科室：
								</td>
								<td>
									<%=
									MT.f(ShopQualification.DEPARTMENT_ARR[sq.department])
									%>
								</td>
							</tr>
							<tr>
								<td class="td-left">城市：</td>
								<td><script>mt.city(<%= sq.area%>)</script></td>
							</tr>
							<tr>
								<td class="td-left">详细地址：</td>
								<td><%= MT.f(sq.address) %></td>
							</tr>
							<tr>
								<td class="td-left">手机：</td>
								<td><%= MT.f(sq.mobile) %></td>
							</tr>
							<tr>
								<td class="td-left">固定电话：</td>
								<td><%= MT.f(sq.telphone) %></td>
							</tr>
							<tr>
								<td class="td-left">资质证明：</td>
								<td>
									<%
										if(sq.qualification>0){
									%>
									<a href='javascript:void(0);' onclick="downatt('<%= MT.enc(sq.qualification) %>');">下载</a>
									<%
									}else{
									%>
									无
									<%
										}
									%>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</form>


<form action="/Attchs.do" name="form9" method="post" target="_ajax">
	<input name="act" type="hidden" value="down" />
	<input name="attch" type="hidden" />
</form>

<script>
    /* mt.receive=function(a)
    {
      form1.avatar.value=$('_avatar').src=a;
    };
    form1.email.focus(); */

    function oncheckpage(type,tit){
        layer.open({
            type: 2,
            title: tit,
            shadeClose: true,
            area: ['475px', '230px'],
            closeBtn:1,
            content: '/jsp/yl/shopweb/ShopCheckEmailMobile.jsp?type='+type
        });
    }

    function onsetpage(type,tit){
        layer.open({
            type: 2,
            title: tit,
            shadeClose: true,
            area: ['475px', '270px'],
            closeBtn:1,
            content: '/jsp/yl/shopweb/ShopEmailMobile.jsp?type='+type
        });
        //location = '/jsp/yl/shopweb/ShopEmailMobile.jsp?type='+type;
    }
    function showhospitalsearch(){
        mt.show("/jsp/yl/shopweb/HospitalSearch.jsp?inpname=hospital",2,"查询医院",800,600);
    }
    mt.receive=function(h,n){
        //$("#"+n).val(h);
        //fchange(h,n);
        form1.hospital.value=h;
        form1.hospitals.value=n;
    }
    function fchange(value,b)
    {
        sendx("/jsp/admin/edn_ajax.jsp?act=selhosmember&hosid="+value,function(data){
            $("#"+b).html(data.trim());
        });
        //selchange($("#"+b)[0]);
    }
    function downatt(num){
        form9.attch.value = num;
        form9.submit();
    }

    function mysupmit(num){

        if(mt.check(document.getElementsByName("form1")[0])){
            //alert("123");
            form1.state.value = num;
            mt.show(null,0);
            form1.submit();
        }else{
            return false;
        }
    };

</script>

<script>
    mt.fit();
</script>


<%-- <%=s.footer%> --%>
</body>
</html>
