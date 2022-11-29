<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.bpicture.*" %>
<%@ page import="tea.entity.admin.mov.*"%>
<%@ page import="tea.entity.member.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="tea.entity.site.*" %>
<%@ page import = "tea.resource.Resource" %>
 


<%
TeaSession teasession =new TeaSession(request);

Resource r = new Resource("/tea/resource/Photography");


int membertype = 0;
if(teasession.getParameter("membertype")!=null && teasession.getParameter("membertype").length()>0)
{
  membertype = Integer.parseInt(teasession.getParameter("membertype"));
}




if(membertype!=1 && membertype!=2){
	out.print("<script>");
	out.print("alert('"+r.getString(teasession._nLanguage,"787514407")+"');");
	out.print("window.location.href='http://"+request.getServerName()+":"+request.getServerPort()+"';");
	out.print("</script>");
	  return;
}
String act = teasession.getParameter("act");
//int membertype_jy = 0;
//if(teasession.getParameter("membertype_jy")!=null && teasession.getParameter("membertype_jy").length()>0)
//{
//  membertype_jy = Integer.parseInt(teasession.getParameter("membertype_jy"));
//}

MemberType myobj = MemberType.find(membertype);
RegisterInstall riobj = RegisterInstall.find(membertype);
Describes dbobj = Describes.find(membertype);

//如果有已经登录
String MemberId=null;//用户名
String EnterPassword=null;//密码
String email = null;//电子邮件
String firstname=null;//昵称
boolean sex=false;//性别
String card = null;// 身份证号
Date birth=new Date();//生日
String city=null;//省份
String address=null;//地址
String phonenumber=null;//手机号
String zip =null;//邮政编码
String telephone=null;//联系电话
String fax = null;//传真号码
String position=null;//职称 
String organization=null;//单位
String section=null;//科室
String degree = null;//学历
String Country=null;//国籍
int identitys=-1;//目前身份

if(teasession._rv != null)
{
  Profile pobj = Profile.find(teasession._rv.toString());
   MemberId=pobj.getMember();//用户名
   EnterPassword=pobj.getPassword();//密码
   email = pobj.getEmail();//电子邮件
   firstname=pobj.getFirstName(teasession._nLanguage);//昵称
   sex=pobj.isSex();//性别
   card = pobj.getCard();// 身份证号
   birth=pobj.getBirth();//生日
   city=pobj.getCity(teasession._nLanguage);//省份
   address=pobj.getAddress(teasession._nLanguage);//地址
   phonenumber=pobj.getMobile();//手机号
   zip =pobj.getZip(teasession._nLanguage);//邮政编码
   telephone=pobj.getTelephone(teasession._nLanguage);//联系电话
   fax = pobj.getFax(teasession._nLanguage);////传真号码
   position=pobj.getTitle(teasession._nLanguage);//职称
   organization=pobj.getOrganization(teasession._nLanguage);//单位
   section=pobj.getSection(teasession._nLanguage);//科室
   degree = pobj.getDegree(teasession._nLanguage);//学历
   Country=pobj.getCountry(teasession._nLanguage);//国籍
   identitys=pobj.getIdentitys();//目前身份
}


tea.entity.site.Community community = tea.entity.site.Community.find(teasession._strCommunity);
%>

<html>
<head>
<title><%=r.getString(teasession._nLanguage,"9203379366") %></title><!-- 用户注册 -->
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/card.js" type="text/javascript"></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/load.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

</head>

<body>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
<h1><%=r.getString(teasession._nLanguage,"7100509896") %></h1>
<script>

function f_member()
{
  if(frmsrch.MemberId.value=='')
  {
    if(<%=riobj.getRestrictions()==0%>)
    {
      //alert("【<%=r.getString(teasession._nLanguage,"2969876073")%>】<%=r.getString(teasession._nLanguage,"9967733288")%>！");
      document.getElementById("show").innerHTML='<font color=red><%=r.getString(teasession._nLanguage,"2969876073")%><%=r.getString(teasession._nLanguage,"9967733288")%></font>'; 

    }
    else if(<%=riobj.getRestrictions()==1%>)
    {
        document.getElementById("show").innerHTML='<font color=red><%=r.getString(teasession._nLanguage,"0880765552")%></font>'; 
        frmsrch.MemberId.focus();
    }
    else if(<%=riobj.getRestrictions()==2%>)
    {
     // alert("【<%=r.getString(teasession._nLanguage,"6025158244")%>】<%=r.getString(teasession._nLanguage,"9967733288")%>！");
      document.getElementById("show").innerHTML='<font color=red><%=r.getString(teasession._nLanguage,"6025158244")%><%=r.getString(teasession._nLanguage,"9967733288")%></font>'; 
    }
     frmsrch.MemberId.focus();
    return false;
  } else{

    if(<%=riobj.getRestrictions()==1%>)
    {
      var strReg="";
      var r;
      var str = frmsrch.MemberId.value;
      strReg=/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/i;
      r=str.search(strReg);
      if(r==-1){
       // alert("请正确填写【邮箱地址】！");
        document.getElementById("show").innerHTML='<font color=red><%=r.getString(teasession._nLanguage,"0880765552")%></font>'; 
        frmsrch.MemberId.focus();
        return false;
      }
    }else if(<%=riobj.getRestrictions()==2%>)
    {
      var str = document.frmsrch.MemberId.value;
      var reg=/^(((13[0-9]{1})|150|151|152|153|154|155|156|157|158|159)+\d{8})$/;
      if(!reg.test(str)){
        alert("<%=r.getString(teasession._nLanguage,"9967925174")%>【<%=r.getString(teasession._nLanguage,"6025158244")%>】！");
        frmsrch.MemberId.focus();
        return false;
      }
    }

  }
  return true;
}
function f_ajax()
{
  var value = frmsrch.MemberId.value;
  if(f_member()){
    var name ="MemberId";
    currentPos = "show";
    send_request("/jsp/mov/member_ajax.jsp?value="+encodeURIComponent(value)+"&name="+name);
  }else
  {
    return false;
  }
} 
//检查昵称不能重复
function f_firstnameajax()
{
	   var value = frmsrch.firstname.value;
	  // currentPos = "show2";
      // send_request("/jsp/mov/member_ajax.jsp?value="+encodeURIComponent(value)+"&name=f_firstnameajax");
       
       
       sendx("/jsp/mov/member_ajax.jsp?value="+encodeURIComponent(value)+"&name=f_firstnameajax",
		 function(data)
		 {
		   if(data!=''&&data.length>0)//如果有这个用户  则写入Cookie
		   {
				document.getElementById("show2").innerHTML=data.trim();
				if(data.indexOf('red')==-1){
					document.getElementById("submits").disabled=false;
				}else{
					document.getElementById("submits").disabled=true;
				}
		   }
		 }
		 );
}


function f_edit()
{
  if(f_member()){

    if(frmsrch.EnterPassword.value.length<6 || frmsrch.EnterPassword.value.length>18)
    {
        //alert("");
        document.getElementById("passwordshow").innerHTML='<font color=red><%=r.getString(teasession._nLanguage,"1602371535")%><%=r.getString(teasession._nLanguage,"7281183400")%>.</font>';
        frmsrch.EnterPassword.focus();
        return false;
    }
     document.getElementById("passwordshow").innerHTML='';
  
    if(frmsrch.ConfirmPassword.value!=frmsrch.EnterPassword.value)
    { 
       document.getElementById("confirmpasswordshow").innerHTML='<font color=red><%=r.getString(teasession._nLanguage,"7564207487")%><%=r.getString(teasession._nLanguage,"1602371535")%><%=r.getString(teasession._nLanguage,"3537376961")%>.</font>';
       frmsrch.ConfirmPassword.focus();
       return false;
   }
    	document.getElementById("confirmpasswordshow").innerHTML='';
   
 

    if(<%=riobj.isInspect("inspectemail") && riobj.getRestrictions()!=1%>){
      var strReg="";
      var r;
      var str = frmsrch.email.value;
      strReg=/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/i;
      r=str.search(strReg);
      if(r==-1){
       // alert("<%=r.getString(teasession._nLanguage,"9967925174")%>【<%=r.getString(teasession._nLanguage,"2879086592")%>】！"); 
        	document.getElementById("emailid").innerHTML='<font color=red><%=r.getString(teasession._nLanguage,"9967925174")%>【<%=r.getString(teasession._nLanguage,"2879086592")%>】！</font>';
           frmsrch.email.focus();  
        return false; 
      }
    }  

    if(<%=riobj.isInspect("inspectfirstname")%>)
    {
      if(frmsrch.firstname.value=='')
      {
         // alert("【】！");
         var fn = document.getElementById("firstnameid").innerHTML;
         document.getElementById("show2").innerHTML='<font color=red><%=r.getString(teasession._nLanguage,"Pleasefillin")%>'+fn+'</font>';
          frmsrch.firstname.focus();
          return false;
      }
      document.getElementById("show2").innerHTML='';
    } 
    if(<%=riobj.isInspect("inspectcard")%>)
    {
      var sID = frmsrch.card.value;
      if(!(/^\d{15}$|^\d{18}$|^\d{17}[xX]$/.test(sID)))
      {
        alert("【<%=r.getString(teasession._nLanguage,"4489414705")%>】<%=r.getString(teasession._nLanguage,"0109386076")%>！");
        frmsrch.card.focus();
        return false;
      }
    }
    if(<%=riobj.isInspect("inspectstate")%>)
    {
      var sID = frmsrch.State.value;
      var sID2=frmsrch.City.value;
      if(sID=='' || sID2=='')
      {
        alert("<%=r.getString(teasession._nLanguage,"Pleaseselect")%>【<%=r.getString(teasession._nLanguage,"8452461289")%>】！");
         frmsrch.State.focus();
        return false;
      }
    }

    if(<%=riobj.isInspect("inspectaddress")%>)
    {
      if(frmsrch.address.value=='')
      {
         //alert("<%=r.getString(teasession._nLanguage,"Pleasefillin")%>【<%=r.getString(teasession._nLanguage,"1475973085")%>】！");
        //frmsrch.address.value 
        var an = document.getElementById("addressid").innerHTML;
         document.getElementById("addressshow").innerHTML='<font color=red><%=r.getString(teasession._nLanguage,"Pleasefillin")%>'+an+'</font>';
        frmsrch.address.focus();
        return false; 
      }
       
    }

    if(<%=riobj.isInspect("inspectphonenumber") && riobj.getRestrictions()!=2%>)
    {
      var sPhonenumber = document.frmsrch.phonenumber.value;
      var reg=/^(((13[0-9]{1})|150|151|152|153|154|155|156|157|158|159|189)+\d{8})$/;
      if(!reg.test(sPhonenumber)){
       // alert("<%=r.getString(teasession._nLanguage,"9967925174")%>【<%=r.getString(teasession._nLanguage,"6025158244")%>】！");
        
         document.getElementById("phonenumbershow").innerHTML='<font color=red><%=r.getString(teasession._nLanguage,"9967925174")%><%=r.getString(teasession._nLanguage,"6025158244")%></font>';
        frmsrch.phonenumber.focus();
        return false;
      }
    }
    if(<%=riobj.isInspect("inspectzip")%>)
    {
      var sZip = document.frmsrch.zip.value
      if(sZip=='')
      {
       // alert("【<%=r.getString(teasession._nLanguage,"9939561778")%>】<%=r.getString(teasession._nLanguage,"9967733288")%>！");
        document.getElementById("zipshow").innerHTML='<font color=red>【<%=r.getString(teasession._nLanguage,"9939561778")%>】<%=r.getString(teasession._nLanguage,"9967733288")%>！</font>';
           frmsrch.zip.focus();
        return false;
      }
      if(isNaN(document.all.frmsrch.zip.value))
      {
        //alert("<%=r.getString(teasession._nLanguage,"2428288986")%>【<%=r.getString(teasession._nLanguage,"9939561778")%>】<%=r.getString(teasession._nLanguage,"1270829338")%>！");
         document.getElementById("zipshow").innerHTML='<font color=red><%=r.getString(teasession._nLanguage,"2428288986")%>【<%=r.getString(teasession._nLanguage,"9939561778")%>】<%=r.getString(teasession._nLanguage,"1270829338")%>！</font>';  
        frmsrch.zip.focus();
        return false;
      }
      if(sZip.length!=6)
      {
        //alert("<%=r.getString(teasession._nLanguage,"2428288986")%>【<%=r.getString(teasession._nLanguage,"9939561778")%>】<%=r.getString(teasession._nLanguage,"7265990411")%>！");
         document.getElementById("zipshow").innerHTML='<font color=red><%=r.getString(teasession._nLanguage,"2428288986")%>【<%=r.getString(teasession._nLanguage,"9939561778")%>】<%=r.getString(teasession._nLanguage,"1270829338")%>！</font>';
            frmsrch.zip.focus();
        return false;
      }
    } 

    if(<%=riobj.isInspect("inspecttelephone")%>)
    {
    	var pn = document.getElementById("telephoneid").innerHTML;
      var sTelephone =frmsrch.telephone.value;
      if(sTelephone=='')
      {
       // alert("【<%=r.getString(teasession._nLanguage,"3156528885")%>】<%=r.getString(teasession._nLanguage,"9967733288")%>！");
        //telephoneshow
          document.getElementById("telephoneshow").innerHTML='<font color=red>'+pn+'<%=r.getString(teasession._nLanguage,"9967733288")%></font>';
            frmsrch.telephone.focus();
        return false;
      }
      if(isNaN(document.all.frmsrch.telephone.value))
      {
       // alert("<%=r.getString(teasession._nLanguage,"2428288986")%>【<%=r.getString(teasession._nLanguage,"3156528885")%>】<%=r.getString(teasession._nLanguage,"1270829338")%>！");
         document.getElementById("telephoneshow").innerHTML='<font color=red>'+pn+'<%=r.getString(teasession._nLanguage,"3156528885")%><%=r.getString(teasession._nLanguage,"1270829338")%></font>';
            frmsrch.telephone.focus();
        return false; 
      }
      document.getElementById("telephoneshow").innerHTML='';
    }
    if(<%=riobj.isInspect("inspectfax")%>)
    {
      var sFax =frmsrch.fax.value;
      if(sFax=='')
      {
        alert("【<%=r.getString(teasession._nLanguage,"2947693613")%>】<%=r.getString(teasession._nLanguage,"9967733288")%>！");
            frmsrch.fax.focus();
        return false;
      }
      if(isNaN(document.all.frmsrch.fax.value))
      {
        alert("<%=r.getString(teasession._nLanguage,"2428288986")%>【<%=r.getString(teasession._nLanguage,"2947693613")%>】<%=r.getString(teasession._nLanguage,"1270829338")%>！");
         frmsrch.fax.focus();
        return false;
      }
    }
// 职位inspectposition
if(<%=riobj.isInspect("inspectposition")%>)
{

  var sPosition =frmsrch.position.value;
if(sPosition=='')
  {
	    var pns = document.getElementById("positionid").innerHTML;
    //alert("【】<%=r.getString(teasession._nLanguage,"9967733288")%>！");
    //document.getElementById("positionid").innerHTML
      document.getElementById("positionshow").innerHTML='<font color=red>'+pns+'<%=r.getString(teasession._nLanguage,"9967733288")%></font>';
    frmsrch.position.focus();
    return false;
  }

}
//单位
if(<%=riobj.isInspect("inspectorganization")%>)
{
	
  var sOrganization =frmsrch.organization.value;
  

  if(sOrganization=='') 
  {
	   var orgn = document.getElementById("organizationid").innerHTML;
	  
    //alert("【<%=r.getString(teasession._nLanguage,"2207673367")%>】<%=r.getString(teasession._nLanguage,"9967733288")%>！");
    document.getElementById("organizationshow").innerHTML='<font color=red>'+orgn+'<%=r.getString(teasession._nLanguage,"9967733288")%></font>';
      frmsrch.organization.focus();
    return false;
  }
  
}
//科室 部门
if(<%=riobj.isInspect("inspectsection")%>)
{
  var sSection =frmsrch.section.value;
  if(sSection=='')
  {
    alert("【<%=r.getString(teasession._nLanguage,"0096636886")%>】<%=r.getString(teasession._nLanguage,"9967733288")%>！");
    frmsrch.section.focus();
    return false;
  }
}
//学历
if(<%=riobj.isInspect("inspectdegree")%>)
{
  var sDegree =frmsrch.degree.value;
  if(sDegree=='')
  {
    alert("【<%=r.getString(teasession._nLanguage,"4563340752")%>】<%=r.getString(teasession._nLanguage,"9967733288")%>！");
    frmsrch.degree.focus();
    return false;
  }
}     
//国籍Country
if(<%=riobj.isInspect("inspectCountry")%>)
{
  var sCountry =frmsrch.Country.value;
  if(sCountry=='AA')
  {
   // alert("<%=r.getString(teasession._nLanguage,"Pleaseselect")%>【<%=r.getString(teasession._nLanguage,"8438735291")%>】！");
   // Country
     document.getElementById("countryshow").innerHTML='<font color=red><%=r.getString(teasession._nLanguage,"Pleaseselect")%><%=r.getString(teasession._nLanguage,"8438735291")%></font>';
    frmsrch.Country.focus();
    return false;
  }
   document.getElementById("countryshow").innerHTML='';
}
//目前身份
if(<%=riobj.isInspect("inspectidentitys")%>)
{
  var sidentitys =frmsrch.identitys.value;
  if(sidentitys==-1)
  {
  
     document.getElementById("identitysshow").innerHTML='<font color=red><%=r.getString(teasession._nLanguage,"请选择目前身份")%></font>';
    frmsrch.identitys.focus();
    return false;
  }
   document.getElementById("identitysshow").innerHTML='';
}

    if(<%=riobj.isInspect("inspectvertify")%>)
    {
      if(frmsrch.vertify.value=='')
      {
        alert("<%=r.getString(teasession._nLanguage,"2549850593")%><%=r.getString(teasession._nLanguage,"9967733288")%>！");
        frmsrch.vertify.focus();
        return false;
      }
      if(isNaN(document.all.frmsrch.vertify.value))
      {
        alert("<%=r.getString(teasession._nLanguage,"2428288986")%><%=r.getString(teasession._nLanguage,"2549850593")%><%=r.getString(teasession._nLanguage,"1270829338")%>！");
           frmsrch.vertify.focus();
        return false;
      }
    } 
    document.getElementById("submits").disabled=true;
    document.getElementById("submits").value='<%=r.getString(teasession._nLanguage,"Submit") %>...';
    
  }else
  {
    return false; 
  }


}
</script>

<p><%=tea.entity.admin.mov.RegisterInstall.getNavigation(membertype,teasession._nLanguage,"zccg",2) %></p>
<form name="frmsrch" method="POST" action="/servlet/EditMember" onSubmit="return f_edit(this);">
  <input type="hidden" name="membertype" value="<%=membertype%>"/>
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="act" value="Clssnregister"/>
<input type="hidden" name="act2" value="<%=act%>" >

<table  border="0" cellpadding="0" cellspacing="0" id="tablecenter">

<%

if(riobj.getRestrictions()==0)
{
  out.print("<tr><td  align=\"right\">&nbsp;"+r.getString(teasession._nLanguage,"2969876073")+"：");
}else if(riobj.getRestrictions()==1)
{
  out.print("<tr><td align=\"right\" nowrap>&nbsp;"+r.getString(teasession._nLanguage,"2879086592")+"：");
  //out.print("<td><input type=text name=MemberId value=\"\"/>&nbsp;&nbsp;&nbsp;&nbsp;");
}else if(riobj.getRestrictions()==2)
{
  out.print("<tr><td nowrap align=\"right\">&nbsp;"+r.getString(teasession._nLanguage,"6025158244")+"：");
}
out.print("<td><input type=text name=MemberId value=");
if(MemberId!=null)
{
  out.print(MemberId);
  out.print("  readonly ");//变灰，修改信息时候不能修改用户名
}else{
	out.println(" \"\" ");
}
out.print(" onkeyup=\"f_ajax();\">&nbsp;&nbsp;");
//out.print("<input type=\"button\"  value=\"账号检测\" onClick=\"f_ajax();\"");
//if(MemberId!=null)
///{
  // out.print(" disabled ");//变灰，修改信息时候不能修改用户名
//}
//out.print(">&nbsp;&nbsp;&nbsp;&nbsp;");
out.println("<span id=\"show\">&nbsp;</span></td>");
out.print("<td>");
if(dbobj.getMember()!=null && dbobj.getMember().length()>0){
  out.print(dbobj.getMember());
}
out.print("</td>"); 
out.print("</tr>");
%>
<tr><td nowrap align="right" ></td>
  <td width="620" align="left" colspan="2"><span style="line-height:22px;font-size:12px;"><%=r.getString(teasession._nLanguage,"8416031938") %>。</span></td>
</tr>
<tr> 
  <td nowrap align="right">&nbsp;<%=r.getString(teasession._nLanguage,"1602371535") %>：</td>
  <td><input type="password" name="EnterPassword" autocomplete="off" value="<%if(EnterPassword!=null)out.print(EnterPassword);%>"/>&nbsp;&nbsp;<span id="passwordshow">&nbsp;</span>
  </td>
  <td >
    <%
    if(dbobj.getPassword()!=null && dbobj.getPassword().length()>0)
    {
      out.print(dbobj.getPassword());
    }
    %>
    </td>
</tr>
<tr><td nowrap align="right" ></td> 
  <td align="left" ><span style="line-height:22px;font-size:12px;"><%=r.getString(teasession._nLanguage,"1103690000") %></span></td></tr>
<tr>
  <td nowrap  align="right">&nbsp;<%=r.getString(teasession._nLanguage,"8839077814") %>：</td>
  <td><input type="password" name="ConfirmPassword" autocomplete="off"  value="<%if(EnterPassword!=null)out.print(EnterPassword); %>"/>&nbsp;&nbsp;<span id="confirmpasswordshow">&nbsp;</span></td>
   <td>
  <%if(dbobj.getConfirmpassword()!=null && dbobj.getConfirmpassword().length()>0)
  {
    out.print(dbobj.getConfirmpassword());
  }
    %> </td> 
</tr>

<%
//  restrictions
if(riobj.isRegister("email") && riobj.getRestrictions()!=1)
{
  out.print("<tr><td align=\"right\">");
  if(riobj.isInspect("inspectemail"))
  out.print("*&nbsp;");
  out.print(r.getString(teasession._nLanguage,"2879086592")+"：</td><td>");
  out.print("<input type=\"text\" name=email value= ");
  if(email!=null&&email.length()>0)
  {
    out.print(email);
  }
  out.print(" > ");
  out.print("<span id=emailid>&nbsp;</span>");
  out.print("</td>");
  if(dbobj.getEmail()!=null && dbobj.getEmail().length()>0){
    out.print("<td>"+dbobj.getEmail()+"</td>");
  }
  out.print("</tr>");
}
if(riobj.isRegister("phonenumber") && riobj.getRestrictions()!=2)
{
  out.print("<tr><td align=\"right\">");
  if(riobj.isInspect("inspectphonenumber"))
  out.print("*&nbsp;");
  out.print(r.getString(teasession._nLanguage,"6025158244")+"：</td><td>");
  out.print(" <input type=text  name=phonenumber value=\"");
  if(phonenumber!=null&&phonenumber.length()>0)
  {
    out.print(phonenumber);
  }
  out.print("\" maxlength=\"11\"> ");
  out.print("<span id=phonenumbershow></span>");
  out.print("</td>");
  if(dbobj.getPhonenumber()!=null && dbobj.getPhonenumber().length()>0){
    out.print("<td>"+dbobj.getPhonenumber()+"</td>");
  }
  out.print("</tr>");
}


if(riobj.isRegister("firstname"))
{
  out.print("<tr><td align=\"right\">");
  if(riobj.isInspect("inspectfirstname"))
  out.print("*&nbsp;");
  out.print("<span id=firstnameid>"+r.getString(teasession._nLanguage,"5477641348")+"</span>：</td><td>");
  out.print("<input type=\"text\" id=\"firstname\" name=\"firstname\" ");
  if(firstname!=null&&firstname.length()>0)
  {
    out.print(" value=\""+firstname+"\" ");
  }
 
  Community cobj = Community.find(teasession._strCommunity);
  if(cobj.getIscheck()!=null && cobj.getIscheck().indexOf("/4/")!=-1){
	   
	  out.println("  onkeyup=f_firstnameajax(); ");
  }
  
  
  out.print(" > ");
  out.println("<span id=\"show2\">&nbsp;</span></td>");
  out.print("</td>");
  if(dbobj.getFirstname()!=null && dbobj.getFirstname().length()>0){
    out.print("<td>"+dbobj.getFirstname()+"</td>");
  }
  out.print("</tr>");
}
if(riobj.isRegister("sex"))
{
  out.print("<tr><td align=\"right\">");

  //if(riobj.isInspect("inspectsex"))
  out.print("*&nbsp;");
  out.print(r.getString(teasession._nLanguage,"0966659109")+"：</td><td>");
  out.print("<input type=\"radio\" name=\"sex\" value=\"1\" ");
  if(!sex)
  {
    out.print(" checked ");
  }
  out.print(" > "+r.getString(teasession._nLanguage,"4872416891"));
  out.print("<input type=\"radio\" name=\"sex\" value=\"0\" ");
  if(sex)
  {
     out.print(" checked ");
  }
  out.print(" /> "+r.getString(teasession._nLanguage,"1050228713"));
  out.print("</td>");
  if(dbobj.getSex()!=null && dbobj.getSex().length()>0){
    out.print("<td>"+dbobj.getSex()+"</td>");
  }
  out.print("</tr>");
}

if(riobj.isRegister("card"))
{
  out.print("<tr><td align=\"right\">");
  if(riobj.isInspect("inspectcard"))
  out.print("*&nbsp;");
  out.print(r.getString(teasession._nLanguage,"4489414705")+"：</td><td>");
  out.print("<input type=\"text\" name=card value= ");
  if(card!=null&&card.length()>0)
  {
    out.print(card);
  }
  out.print(" > ");
  out.print("</td>");
  if(dbobj.getCard()!=null && dbobj.getCard().length()>0){
    out.print("<td>"+dbobj.getCard()+"</td>");
  }
  out.print("</tr>");
}
if(riobj.isRegister("birthyear"))
{
  out.print("<tr><td align=\"right\">");
  //if(riobj.isInspect("inspectbirthyear"))
  out.print("*&nbsp;");
  out.print(r.getString(teasession._nLanguage,"4990592852")+"：</td><td>");
  java.util.Calendar c= java.util.Calendar.getInstance();
  c.set(java.util.Calendar.YEAR,c.get(java.util.Calendar.YEAR)-30);
  if(birth==null)
  {
    birth =c.getTime();
  }
  out.print(new tea.htmlx.TimeSelection("Birth", birth));
  out.print("</td>");
  if(dbobj.getBirthyear()!=null && dbobj.getBirthyear().length()>0){
    out.print("<td>"+dbobj.getBirthyear()+"</td>");
  }
  out.print("</tr>");
}

if(riobj.isRegister("state"))
{
  out.print("<tr><td align=\"right\">");
  if(riobj.isInspect("inspectstate"))
  out.print("*&nbsp;");
  out.print(r.getString(teasession._nLanguage,"8452461289")+"：</td><td>");
  if(city!=null&&city.length()>0)
  {

  }else
  {
	  
     city ="null";
  }

  out.print(" <script>selectcard('State','City',null,'"+city+"');</script>");
  out.print("</td>");
  if(dbobj.getState()!=null && dbobj.getState().length()>0){
    out.print("<td>"+dbobj.getState()+"</td>");
  }
  out.print("</tr>");
}

if(riobj.isRegister("address"))
{
  out.print("<tr><td nowrap align=\"right\">");
  if(riobj.isInspect("inspectaddress"))
  out.print("*&nbsp;");
  out.print("<span id=addressid>"+r.getString(teasession._nLanguage,"1475973085")+"</span>：</td><td>");
  out.print(" <input type=text size=50 name=address value=\"");
  if(address!=null&&address.length()>0)
  {
    out.print(address);
  }
  out.print("\" >");
  out.print("&nbsp;&nbsp;<span id=addressshow>&nbsp;</span>");
  out.print("</td>");
  if(dbobj.getAddress()!=null && dbobj.getAddress().length()>0){
    out.print("<td>"+dbobj.getAddress()+"</td>");
  }
  out.print("</tr>");
}



if(riobj.isRegister("zip"))
{
  out.print("<tr><td align=\"right\">");
  if(riobj.isInspect("inspectzip"))
  out.print("*&nbsp;");
  out.print(r.getString(teasession._nLanguage,"9939561778")+"：</td><td>");
  out.print(" <input type=text  name=zip value=\"");
  if(zip!=null&&zip.length()>0)
  {
    out.print(zip);
  }
  out.print("\" maxlength=\"6\" > ");
  out.print("<span id=zipshow></span>");
  out.print("</td>");
  if(dbobj.getZip()!=null && dbobj.getZip().length()>0){
    out.print("<td>"+dbobj.getZip()+"</td>");
  }
  out.print("</tr>");
}

if(riobj.isRegister("telephone"))
{
  out.print("<tr><td nowrap align=\"right\">");
  if(riobj.isInspect("inspecttelephone"))
  out.print("*&nbsp;");
  out.print("<span id=telephoneid>"+r.getString(teasession._nLanguage,"3156528885")+"</span>：</td><td>");
  out.print(" <input type=text  name=telephone value=\"");
  if(telephone!=null&&telephone.length()>0)
  {
    out.print(telephone);
  } 
  out.print("\" maxlength=\"12\">&nbsp;&nbsp;<span id=telephoneshow>&nbsp;</span>");
  out.print("</td>");
  if(dbobj.getTelephone()!=null && dbobj.getTelephone().length()>0){
    out.print("<td>"+dbobj.getTelephone()+"</td>");
  }
  out.print("</tr>");
}
if(riobj.isRegister("fax"))
{
  out.print("<tr><td align=\"right\">");
  if(riobj.isInspect("inspectfax"))
  out.print("*&nbsp;");
  out.print(r.getString(teasession._nLanguage,"2947693613")+"：</td><td>");
  out.print(" <input type=text  name=fax value=\"");
  if(fax!=null&&fax.length()>0)
  {
    out.print(fax);
  }
  out.print("\" maxlength=\"12\"> ");
  out.print("</td>");
  if(dbobj.getFax()!=null && dbobj.getFax().length()>0){
    out.print("<td>"+dbobj.getFax()+"</td>");
  }
  out.print("</tr>");
}
//单位,organization

if(riobj.isRegister("organization"))
{
  out.print("<tr><td align=\"right\">");
  if(riobj.isInspect("inspectorganization"))
  out.print("*&nbsp;");
  out.print("<span id=organizationid>"+r.getString(teasession._nLanguage,"2207673367")+"</span>：</td><td>");

  out.print(" <input type=text  name=organization value= ");
  if(organization!=null&&organization.length()>0)
  {
    out.print(organization);
  }
  out.print(" > ");
  out.print("<span id =organizationshow></span>");
  out.print("</td>");
  out.print("<td>");
  if(dbobj.getOrganization()!=null && dbobj.getOrganization().length()>0){
    out.print(dbobj.getOrganization());
  }
  out.print("</td>");
  out.print("</tr>");
}


if(riobj.isRegister("position"))
{
   out.print("<tr><td align=\"right\">");
  if(riobj.isInspect("inspectposition"))
  out.print("*&nbsp;");
  out.print("<span id=positionid>"+r.getString(teasession._nLanguage,"0707364430")+"</span>：</td><td>");
 // out.print("<select  name=position>");
  out.print("<input type=text  name=position value=");
  if(position!=null&&position.length()>0)
  {
    out.print(position);
  }

  out.print("> ");
  out.print("<span id=positionshow></span>");
  out.print("</td>");
  if(dbobj.getPosition()!=null && dbobj.getPosition().length()>0){
    out.print("<td>"+dbobj.getPosition()+"</td>");
  }
  out.print("</tr>");
}

//科室 部门section
if(riobj.isRegister("section"))
{
  out.print("<tr><td align=\"right\">");
  if(riobj.isInspect("inspectsection"))
  out.print("*&nbsp;");
  out.print(r.getString(teasession._nLanguage,"0096636886")+"：</td><td>");
  out.print(" <input type=text  name=section value= ");
  if(section!=null&&section.length()>0)
  {
    out.print(section);
  }
  out.print(" > ");
  out.print("</td>");
  out.print("<td>");
  if(dbobj.getSection()!=null && dbobj.getSection().length()>0){
    out.print(dbobj.getSection());
  }
  out.print("</td>");
  out.print("</tr>");
}
//学历
if(riobj.isRegister("degree"))
{
  out.print("<tr><td align=\"right\">");
  if(riobj.isInspect("inspectdegree"))
  out.print("*&nbsp;");
  out.print(r.getString(teasession._nLanguage,"4563340752")+"：</td><td>");
  out.print(" <input type=text  name=degree value= ");
  if(degree!=null&&degree.length()>0)
  {
    out.print(degree);
  }
  out.print(" > ");
  out.print("</td>");
  out.print("<td>");
  if(dbobj.getDegree()!=null && dbobj.getDegree().length()>0){
    out.print(dbobj.getDegree());
  }
  out.print("</td>");
  out.print("</tr>");
}
//国籍
if(riobj.isRegister("Country"))
{
  out.print("<tr><td align=\"right\">");
  if(riobj.isInspect("inspectCountry"))
  out.print("*&nbsp;");
  out.print(r.getString(teasession._nLanguage,"8438735291")+"：</td><td>");
  
  out.print(new tea.htmlx.CountrySelection("Country",teasession._nLanguage,Country));

	out.print("&nbsp;&nbsp;<span id=countryshow>&nbsp;</span>");
  out.print("</td>");
  out.print("<td>");
  if(dbobj.getCountry()!=null && dbobj.getCountry().length()>0){
    out.print(dbobj.getCountry());
  } 
  out.print("</td>");
  out.print("</tr>");
}

//目前身份
if(riobj.isRegister("identitys"))
{
  out.print("<tr><td align=\"right\">");
  if(riobj.isInspect("inspectidentitys"))
  out.print("*&nbsp;");
  out.print(r.getString(teasession._nLanguage,"目前身份")+"：</td><td>");
   
  out.print("<select name=identitys>");
  out.print("<option value=-1>-目前身份-</option>");
  for(int i=0;i<Profile.IDENTITYS_TYPE.length;i++)
  {
	  out.print("<option value="+i);
	  out.print(">"+Profile.IDENTITYS_TYPE[i]);
	  out.print("</option>");
  }
  out.print("</select>");

	out.print("&nbsp;&nbsp;<span id=identitysshow>&nbsp;</span>");
  out.print("</td>");
  out.print("<td>");
  if(dbobj.getIdentitys()!=null && dbobj.getIdentitys().length()>0){
    out.print(dbobj.getIdentitys());
  } 
  out.print("</td>");
  out.print("</tr>");
}

//验证码
if(riobj.isRegister("vertify"))
{
  out.print("<tr><td align=\"right\">");
  if(riobj.isInspect("inspectvertify"))
  out.print("*&nbsp;");
  out.print(r.getString(teasession._nLanguage,"2549850593")+"：</td><td>");
  out.print("<input type=\"text\"  name=vertify value=\"\" maxlength=\"4\"> <img src=\"/jsp/user/validate.jsp\" id=vcodeImg alt=\"vertify\"  style=\"cursor:pointer\" align=\"absmiddle\" class=\"CodeImg\" onClick=\"reloadVcode();\">");
 	out.print("&nbsp;&nbsp;<a href=\"###\"   style=\"cursor:pointer\"  onClick=\"reloadVcode();\">");
	out.print(r.getString(teasession._nLanguage,"4249463039")+"</a>");
  out.print("</td>");
  if(dbobj.getVertify()!=null && dbobj.getVertify().length()>0){
    out.print("<td>"+dbobj.getVertify()+"</td>");
  }
  out.print("</tr>");
} 
%>
</table>
<%
//if(riobj.getClause()==1)//如果有服务条款 就显示上一步
//{
 // out.print("<input type=button value=上一步 onclick=window.open('/jsp/mov/SigUp.jsp?membertype="+membertype+"','_self'); > &nbsp;&nbsp;&nbsp;&nbsp;");
//}
%>
<script>
function reloadVcode()//点击更换验证码
         {
           var vcode = document.getElementById('vcodeImg'); 
           vcode.setAttribute('src','/jsp/user/validate.jsp?r='+Math.random());
         }
</script>
&nbsp;&nbsp;&nbsp;&nbsp;
<input type="submit" id="submits" value="<%=r.getString(teasession._nLanguage,"Submit") %>" style="width:80px;height:20px;margin:10px 0;"/>&nbsp;&nbsp;
<input type="reset" value="<%=r.getString(teasession._nLanguage,"8116755623") %>" style="width:80px;height:20px;margin:10px 0;""/>
</form>
 <SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
</body>  

</html>

