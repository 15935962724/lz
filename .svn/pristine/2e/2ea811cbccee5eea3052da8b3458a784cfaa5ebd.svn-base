
mt.checkText=function(e){
	var txtcheck=e.value;
	if(txtcheck==null||txtcheck.trim()==""){
		mt.show(e.alt+"不能为空!");
		e.focus();
		return false;
	}else{
		return true;
	}
}
function checkpwd2(){
	return form1.password.value==form1.password2.value;
}

function checkName(){
	var m=form1.member;
	if(m.value==null||m.value.trim()==""){
		mt.show(m.alt+"不能为空!");
		m.focus();
		return false;
	}else if(m.value.length<4||m.value.length>16){
		mt.show(m.alt+"应为4-16字符!");
		m.focus();
		return false;
	}else{
		var firstword=m.value.charAt(0);
		if(!isNaN(firstword)){
			mt.show(m.alt+"不能以数字开头!");
			m.focus();
			return false;
		}
		sendx('/ChildMembers.do?act=haschild&member='+encodeURIComponent(m.value)+"&community="+form1.community.value,
				function(a){
					if("true"==a){
						mt.show(m.alt+"已存在，请重新输入用户名!");
						m.focus();
						return false;
					}
		});
	}
	return true;
}

function subpwd(){
	var nexturl=window.location.href;
	if(foChange.password.value!=foChange.password2.value){
		mt.show("两次密码输入不一致！");
	}else{
		sendx("/ChildMembers.do?act=changePwd&old="+foChange.old.value+"&password="+foChange.password.value,
				function(a){
					if(a!=null&&a!=""){
						mt.show(a,1,nexturl);
					}
		});
	}
}

function checkPwd(){
	var m=form1.password;
	if(m.value==null||m.value.trim()==""){
		mt.show(m.alt+"不能为空!");
		m.focus();
		return false;
	}else if(m.value.length<6||m.value.length>32){
		mt.show(m.alt+"应为6-32字符!");
		m.focus();
		return false;
	}else{

	}
	return true;
}

function checkPwd2(){
	if(form1.password.value!=form1.password2.value){
		mt.show("两次输入密码不一致!");
		form1.password2.focus();
		return false;
	}
	return true;
}

function checkMail(e){
	//var mail=m.value;
	//var testm=/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/;
	  //var testm=/^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
    var testm =/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/;
   	var txtcheck=e.value;
	if(txtcheck==null||txtcheck.trim()==""){
		mt.show(e.alt+"不能为空!");
		e.focus();
		return false;
	}else if(!txtcheck.match(testm)){
		mt.show(e.alt+"格式输入错误!");
		e.focus();
		return false;
	}else{
		return true;
	}

}
function checkMobile(e){
	 	var testm = /^([0-9]{11})?$/;
	   	var txtcheck=e.value;
		if(txtcheck==null||txtcheck.trim()==""){
			return true;
		}else if(!txtcheck.match(testm)){
			mt.show(e.alt+"格式输入错误!");
			e.focus();
			return false;
		}else{
			return true;
		}
}

function checkAll(){
	if(checkName()&&checkPwd()&&checkPwd2()&&mt.checkText(form1.fname)&&mt.checkText(form1.unitname)&&checkMail(form1.email)){
		form1.submit();

	}
}

function checkSome(){
	if(mt.checkText(form1.fname)&&mt.checkText(form1.unitname)&&checkMail(form1.email)){
		form1.submit();

	}
}

function chageTab(tab1,tab2){
	document.getElementById(tab1).style.display="";
	document.getElementById(tab2).style.display="none";
}

function showTd(member){
	var m=document.getElementById(member);
	if(m.style.display==""){
		m.style.display="none";
	}else{
		m.style.display="";
	}
}
function delInfo(member,community,url){
	sendx('/ChildMembers.do?act=delete&member='+encodeURIComponent(member)+"&community="+community,
			function(a){
				if(a!=null&&a!=""){
					mt.show(a,1,'/jsp/type/ChildMember/'+url+'.jsp');
				}
	});
}
function delAll(community,url){
	var ms=document.getElementsByName("mems");
	var mems="";

	for(var i=0;i<ms.length;i++){
		if(ms[i].checked){
			mems=mems+"|"+ms[i].value;
		}
	}
	sendx('/ChildMembers.do?act=delAll&members='+encodeURIComponent(mems)+"&community="+community,
			function(a){
				if(a!=null&&a!=""){
					mt.show(a,1,'/jsp/type/ChildMember/'+url+'.jsp');
				}
	});
}
function build(){
	window.open("/jsp/type/ChildMember/EditMember.jsp?nextUrl=/jsp/type/ChildMember/ChildMemberList.jsp", "_self");
}
function showInfo(member,community){
	window.open("/jsp/type/ChildMember/MemberInfo.jsp?member="+encodeURIComponent(member)+"&community="+community+"&nextUrl=/jsp/type/ChildMember/ChildMemberList.jsp", "_self");
}

function excel(){
	form2.action="/ChildMembers.do";
	form2.act.value="Excel";
	form2.submit();
}
function editInfo(member,community){
	window.open("/jsp/type/ChildMember/EditMember.jsp?member="+encodeURIComponent(member)+"&community="+community+"&nextUrl=/jsp/type/ChildMember/ChildMemberList.jsp", "_self");
}
function clearPwd(member,community){
	sendx('/ChildMembers.do?act=clearPwd&member='+encodeURIComponent(member)+"&community="+community,
			function(a){
				if(a!=null&&a!=""){
					mt.show(a,1,'/jsp/type/ChildMember/ChildMemberList.jsp');
				}
	});

}
function email(){
	var ms=document.getElementsByName("mems");
	var mems="";
	for(var i=0;i<ms.length;i++){
		if(ms[i].checked){
			mems=mems+"/"+ms[i].value;
		}
	}
	if(mems==""){
		mt.show("请选择收件人！");
	}else{
		var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:830px;dialogHeight:710px;';
		 var url = '/jsp/type/ChildMember/WestracEmail.jsp?t='+new Date().getTime()+"&member="+encodeURIComponent(mems)+"&sql=";
		 var rs = window.showModalDialog(url,self,y);
		 if(rs==1)
		 {
			 window.location.reload();
		 }
	}

}

function getDates(){

	if(mt.isIE){
		var d=new Calendar();
		d.show('form1.birth');
	}else{
		var d=new Calendar();
		d.show('form1.birth');
	}
}



function f_v(member)
{
	if(!member){
		var ms=document.getElementsByName("mems");
		var member="";

		for(var i=0;i<ms.length;i++){
			if(ms[i].checked){
				member=member+"|"+ms[i].value;
			}
		}
	}
	if(member==""){
		mt.show("请选择被审核人员！");
	}else{
	var str = '<center><span id="showid"></span><input type="hidden" id="igd" name="igd" value='+member+'><input type="radio" id="membertypeid" name="membertype" checked value="3">通过审核&nbsp;&nbsp;<input type="radio" id="membertypeid" name="membertype" value="9">审核不通过&nbsp;&nbsp;</center>';
//alert("s");
	mt.show(str,2);
	//ymPrompt.confirmInfo({icoCls:'',msgCls:'confirm',message:str,title:'请选择审核状态',height:150,handler:getInput,autoClose:false});
	mt.ok=getInput;
	}
}
function getInput(){

	var strNew = 2;
	var temp=document.getElementsByName("membertype");
	for (i=0;i<temp.length;i++){
		//遍历Radio
		if(temp[i].checked)
		{
			strNew = temp[i].value;
		}
	}
	document.getElementById("showid").innerHTML='<font color=red>审核信息处理中,请稍候...</font>';
	//  ymPrompt.win({message:'<br><center><font color=red>审核信息处理中,请稍候...</font></center>',width:200,height:100,handler:noTitlebar,titleBar:false});
	var igd = document.getElementById('igd').value;

	sendx("/ChildMembers.do?act=WmemberVerifginput&member="+encodeURIComponent(igd)+"&membertype="+strNew,
			 function(data)
			 {

			//  alert("4444->>>>."+data.length);
			   if(data!=''&&data.length>1 )//如果有这个用户  则写入Cookie .trim()
			   {
					data = data.trim();
					//alert(data);
					if(data=='true'){
						mt.show('<center>审核成功</center>',1,'/jsp/type/ChildMember/ChildMembersAudit.jsp');
				       //window.location.reload();
					}else if(data=='false')
					{
						mt.show('<center>审核失败</center>',1,'/jsp/type/ChildMember/ChildMembersAudit.jsp');
					}
			   }
			 }
			 );



}

function f_tab(type){
	form1.membertype.value=type;
	form1.submit();

}
