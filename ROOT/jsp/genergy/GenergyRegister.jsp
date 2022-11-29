<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.*" %>
<%@ page import="tea.entity.member.*" %>
<%
	Resource r=new Resource("/tea/resource/Genergy");
	Http h=new Http(request,response);
%>
<script type="text/javascript">
function checkMail(){
	var mail=form1.email;
	if(mail.value==''||mail.value.trim()==''){
		document.getElementById("emailid").innerHTML="<font color='red'><%=r.getString(h.language, "email") +r.getString(h.language, "cbe")%>!</font>";
		mail.focus();
		return false;
	}else{
		var strReg="";
		strReg=/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/i;
		var sresult;
		 sresult=mail.value.search(strReg);
		if(sresult==-1){
			document.getElementById("emailid").innerHTML="<font color='red'><%=r.getString(h.language, "email") +r.getString(h.language, "invalid")%>!</font>";
			mail.focus();
			return false;
		}
		document.getElementById("emailid").innerHTML='';
		return true;

	}
}

function checkPwd(){
	var mail=form1.password;
	if(mail.value==''||mail.value.trim()==''){
		document.getElementById("passwordid").innerHTML="<font color='red'><%=r.getString(h.language, "password") +r.getString(h.language, "cbe")%>!</font>";
		mail.focus();
		return false;
	}
		document.getElementById("passwordid").innerHTML='';
		return true;
	
}
function checkPwd2(){
	var mail=form1.qpassword;
	var mail2=form1.password.value;
	if(mail.value!=mail2){
		document.getElementById("qpasswordid").innerHTML="<font color='red'><%=r.getString(h.language,"pnc")%>!</font>";
		mail.focus();
		return false;
	}
		document.getElementById("qpasswordid").innerHTML='';
		return true;
	
}
function checkContent(c,id){
	if(c.value==''||c.value.trim()==''){
		document.getElementById(id).innerHTML="<font color='red'>"+c.alt+"<%=r.getString(h.language, "cbe")%>!</font>";
		c.focus();
		return false;
	}
		document.getElementById(id).innerHTML='';
		return true;
}
function checkArea(){
	var ars=document.getElementsByName("ifield");
	var count=0;
	for(var i=0;i<ars.length;i++){
		if(ars[i].checked==true){
			count=count+1;
		}
	}
	if(count<=0){
		document.getElementById("ifieldid").innerHTML="<font color='red'><%=r.getString(h.language, "ifield") +r.getString(h.language, "cbe")%>!</font>";
		return false;
	}else{
		document.getElementById("ifieldid").innerHTML='';
		return true;
	}
}
</script>
<h1 id="hs"><%=r.getString(h.language,"register") %></h1>
<form action="/servlet/EditMember" name="form1"  onsubmit="return checkMail()&&checkPwd()&&checkPwd2()&&checkContent(form1.name,'nameid')&&checkContent(form1.unit,'unitid')&&checkContent(form1.position,'positionid')&&checkArea()">
<input type="hidden" name="act" value="GenergyRegister"/>
<input type="hidden" name="nexturl" value=""/>
<input type="hidden" name="membertype" value="17"/>
<script>
	form1.nexturl.value=window.location.href;
</script>
<table id="rtable">
	<tr>
		<td><%=r.getString(h.language, "email") %>:</td>
		<td class="bor"><input type="text" value="" name="email"/></td>
		<td><span id="emailid"></span></td>
	</tr>
	<tr>
		<td><%=r.getString(h.language, "password") %>:</td>
		<td class="bor"><input type="password" value="" name="password"/></td>
		<td><span id="passwordid"></span></td>
	</tr>
	<tr>
		<td><%=r.getString(h.language, "qpassword") %>:</td>
		<td class="bor"><input type="password" value="" name="qpassword"/></td>
		<td><span id="qpasswordid"></span></td>
	</tr>
	</table>
	<table id="ntable">
	<tr>
		<td class="textleft"><em>*</em> <%=r.getString(h.language, "name") %>:</td>
		<td class="bor"><input type="text" value="" name="name"   alt="<%=r.getString(h.language, "name") %>"  /><span id="nameid"></span></td>
	</tr>
	<tr>
		<td class="textleft"><em>*</em> <%=r.getString(h.language, "unit") %>:</td>
		<td class="bor"><input type="text" value="" name="unit"   alt="<%=r.getString(h.language, "unit") %>"  /><span id="unitid"></span></td>
	</tr>
	<tr>
		<td class="textleft"><em>*</em> <%=r.getString(h.language, "position") %>:</td>
		<td class="bor"><input type="text" value="" name="position"   alt="<%=r.getString(h.language, "position") %>"  /><span id="positionid"></span></td>
	</tr>
	<tr>
		<td class="textleft"><%=r.getString(h.language, "pnumber") %>:</td>
		<td class="bor"><input type="text" value="" name="pnumber"/><span id="pnumberid"></span></td>
	</tr>
	<tr>
		<td class="textleft"><em>*</em> <%=r.getString(h.language, "ifield") %>:</td>
		<td>
		<%
			for(int i=0;i<Profile.FIELD_EN_TYPE.length;i++){
				out.print("<input type='checkbox' value='"+(i+1)+"' name='ifield' id='ifield"+(i+1)+"'><label for='ifield"+(i+1)+"'>"+r.getString(h.language, Profile.FIELD_EN_TYPE[i]) +"</label>");
				if((i+1)%5==0){
					out.print("<br>");
				}
			}
		%>
		<br>
		<span id="ifieldid"></span>
		</td>
	</tr>
	<tr><td colspan="2" class="ceb"><input type="submit"   name="fsubmit" value="注册"/></td></tr>
	</table>
	</form>