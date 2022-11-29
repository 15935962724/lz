<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.Http"%>
<%@page import="tea.entity.Res"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<script>
var ls=parent.document.getElementsByTagName("HEAD")[0];
document.write(ls.innerHTML);
var arr=parent.document.getElementsByTagName("LINK");
for(var i=0;i<arr.length;i++)
{
  document.write("<link href='"+arr[i].href+"' rel='"+arr[i].rel+"' type='text/css'>");
}
</script>
<script src="/tea/jquery-1.3.1.min.js" type="text/javascript"></script>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<body class="dpxreg">
<%
Http h=new Http(request);
String [] tk = h.getValues("tk");
if(tk==null||tk.length<3){
	tk = new String[3];
	tk[0]="#";
	tk[1]="#";
	tk[2]="#";
}
Resource r=new Resource("/tea/ui/member/community/dpxReg");
%>
<div class="zhuc"><div class="zhucetop"></div>
<div class="memberReg">
<div class="con"> <form action="/Papcs.do" target="_ajax"  onSubmit="return mt.check(this)" name="form2">
    <input type="hidden" name="act" value="dpxreg" /> <input type="hidden" name="nexturl" value="/index.jsp" /><div style="padding:20px;">
    <input id="_type0" checked="checked" type="radio" onclick="tabdiv(0)" name="type" value="3" /><label for="_type0">学员注册</label>
    <input id="_type1" type="radio" name="type" onclick="tabdiv(1)" value="1"   /><label for="_type1">院校注册</label>
    <input id="_type2" type="radio" name="type" onclick="tabdiv(2)" value="2" /><label for="_type2">企业注册</label></div>
    <div class="tab">
    <table id="tab1">
            <tr>
                <td class="th"><%=r.getString(h.language, "username")%>：</td>
                <td><input name='username' alt='<%=r.getString(h.language, "username")%>' min='3'></td>
            </tr>
            <tr>
                <td class="th"><%=r.getString(h.language, "password")%>：</td>
                <td><input alt="<%=r.getString(h.language, "password")%>" type="password" min="6" name="password" /></td>
            </tr> 
            <tr>
                <td class="th"><%=r.getString(h.language, "confirmpassword")%>：</td>
                <td><input alt="<%=r.getString(h.language, "confirmpassword")%>" type="password" name="password2" /></td>
            </tr>
     </table>
            
     <table id="tab2">
            	<tr>
			<td align="right" class="th" nowrap="nowrap">
				就职单位：
			</td>
			<td>
				<input name="org" alt="就职单位" style="width: 240px;"
					onfocus="mt.f_org(this)" onblur="mt.f_org(this)">
			</td>
		</tr>
		<tr>
			<td align="right" class="th" nowrap="nowrap">
				职称职位：
			</td>
			<td>
				<input name="title" onfocus="mt.f_jz(this)" onblur="mt.f_jz(this)"
					alt="职称职位" style="width: 240px;">
			</td>
		</tr>
		<tr>
			<td class="th" >
				研究方向：
			</td>
			<td>
				<input name="job" onfocus="mt.f_yj(this)" onblur="mt.f_yj(this)"
					alt="研究方向" style="width: 240px;">
				<br />
				<span id="job_info"></span>
			</td>
		</tr>
	</table>
		 <table id="tab3">
            	<tr>
            	<td>
            		 <span class="th">单位名称：</span>
            	</td>
            	<td>
            		 <input name="name"  alt="单位名称" onfocus="mt.f_name(this)" onblur="mt.f_name(this)">
            	</td>
            </tr>
            <tr>
            	<td>
            		 <span class="th">营业执照代码：</span>
            	</td>
            	<td>
            		 <input name="license" alt="营业执照代码" onfocus="mt.f_license(this)" onblur="mt.f_license(this)">
            		 <div class="rights" style="color:#f00;">如果您的企业已被注册或之前注册过忘记了如何管理，请<a style="color:#f00;font-weight:bold;" href="/html/china-latin2013/category/14020648-1.htm" target="_blank">联系我们</a></div>
            	</td>
            </tr>
            <tr>
            	<td>
            		<span class="th">法定代表人：</span>
            	</td>
            	<td>
            		 <input name="legalname" alt="法定代表人" onfocus="mt.f_le(this)" onblur="mt.f_le(this)">
            	</td>
            </tr>
            <tr>
            	<td>
            		<span class="th">联系人姓名：</span>
            	</td>
            	<td>
            		 <input name="mname" alt="联系人姓名" onfocus="mt.f_mname(this)" onblur="mt.f_mname(this)"><span id="mname_info">
            	</td>
            </tr>
            <tr>
            	<td>
            		<span class="th">联系人电话：</span>
            	</td>
            	<td>
            		 <input name="tel" alt="联系人电话" onfocus="mt.f_belsellphone(this)" onblur="mt.f_belsellphone(this)">
            	</td>
            </tr>
            <tr>
            	<td>
            		<span class="th">电子邮箱：</span>
            	</td>
            	<td>
            		 <input name="email" alt="电子邮箱" onfocus="mt.f_email(this)" onblur="mt.f_email(this)" />
            	</td>
            </tr>
    </table>
    <table>
    	<tr>
			<td align="right" class="td01" nowrap="nowrap">
				<%=r.getString(h.language, "verificationcode")%>：
			</td>
			<td>
				<input style="text-transform: uppercase; width:93px;" alt="<%=r.getString(h.language, "verificationcode")%>" onfocus="mt.verifys()" onchange="value=value.toUpperCase()" maxlength="4" name="verify" autocomplete="off" class="input" style='width:100px'>
				<a href="javascript:mt.verifys()"><img id="img_verifys" src="/Imgs.do?act=verify&amp;t=0.8841180045674784" alt="" style="visibility: visible;"></a>
			</td>
		</tr>
    </table></div>
    <input name="tiaokuan" alt="<%=r.getString(h.language, "tiaokuan")%>"  type="checkbox"  /><label for="agree"><%=r.getString(h.language, "read")%></label><br>
 	<input name="murl" id="murl" type="hidden" />
	   	 《<a id="tk" href="javascript:void(0);" onclick="gotk()"><%=r.getString(h.language, "tiaokuan")%></a>》<div class="usersub">
	 		
    <input name="" type="submit" value="注册"  /></div>
</form>
<script>
lang=<%= h.language%>;
var tk = document.getElementById("murl");
/*  mt.reg(form2); */ 
function tabdiv(num){
	if(num==0){
		form2.act.value = "dpxreg";
		form2.action = "/Papcs.do";
		jQuery("#tab2").hide();
		jQuery("#tab3").hide();
		tk.value = '<%= tk[0] %>';
	}else if(num==1){
		form2.act.value = "dpxreg";
		form2.action = "/Papcs.do";
		//form2.act.value = "zjreg";
		jQuery("#tab2").show();
		jQuery("#tab3").hide();
		tk.value = '<%= tk[1] %>';
	}else if(num==2){
		form2.act.value = "reg";
		form2.action = "/SupSuppliers.do";
		jQuery("#tab2").hide();
		jQuery("#tab3").show();
		tk.value = '<%= tk[2] %>';
	}
}
onload = function(){
	form2.act.value = "dpxreg";
	form2.action = "/Papcs.do";
	jQuery("#tab2").hide();
	jQuery("#tab3").hide();
	tk.value = '<%= tk[0] %>';
}
 mt.verifys=function()
{
  var vcode=document.getElementById('img_verifys');
  vcode.setAttribute('src',vcode.src.replace(/t=[\d.]+/,'t='+Math.random()));
}; 

function gotk(){
	if(tk.value=="#"){
		return;
	}
	 window.open(tk.value,'_blank');
}

/* form2.send.onclick=function()
{
  var delay=60;
  this.disabled=true;
  this.value='发送中...';
  mt.send(form2.action+'?act=send&mobile='+encodeURIComponent(form2.mobile2.value),function(d)
  {
    mt.show(d);
  });
  var inter=setInterval(function()
  {
    form2.send.value=--delay+"秒后可重新发送";
    if(delay>0)return;

    form2.send.disabled=false;
    form2.send.value="重新发送验证码";
    clearInterval(inter);
  },1000);
}; */

/* var ftype=form2.type;
for(var i=0;i<ftype.length;i++)
{
  ftype[i].onclick=function()
  {
    for(var i=0;i<ftype.length;i++)
    {
      ftype[i].checked=i==this.value;

      var tr=document.all('type'+i);
      if(!tr)continue;
      if(!tr.length)tr=[tr];
      for(var j=0;j<tr.length;j++)tr[j].style.display=ftype[i].checked?'':'none';
    }
  };
}
ftype[0].click(); */

</script></div>
</body>
</html>