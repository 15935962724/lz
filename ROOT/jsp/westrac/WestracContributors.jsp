<%@page contentType="text/html;charset=UTF-8"  %>
<%@page import="java.io.*" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.ui.*"%>
<%@page import="java.util.*"%>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.db.*"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
//参数 node  为文件夹节点号
//参数 membertype 0 为会员 1 可以不是 会员


int membertype = 0;
/*
if(teasession.getParameter("membertype")!=null)
{
   try 
   {
     membertype = Integer.parseInt(teasession.getParameter("membertype"));
   }catch(Exception e)
   {
     out.print("您的参数不正确");
     return;
   }
}
*/
String nexturl = teasession.getParameter("nexturl");

//如果是会员  必须登录
if(teasession._rv==null)
{
 out.print("<script>");
 out.print("alert('您还没有登录，请登录之后投稿！');");
 out.print("window.location.href='/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+nexturl+"';");
 out.print("</script>");
  //response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8"));
  return;
}

 
Profile pobj = Profile.find(teasession._rv._strR);
//判断用户数是否禁止投稿了
if(pobj.getNocontributors()==1)
{
	out.print(pobj.getContributorsreason(teasession._nLanguage));
	return;
}
 

String member = session.getId();
if(teasession._rv!=null)
{
  member = teasession._rv._strR;
}


int nid = 0;
if(teasession.getParameter("nid")!= null && teasession.getParameter("nid").length()>0)
{
  nid = Integer.parseInt(teasession.getParameter("nid"));
}
Node nobj = Node.find(nid);
 

int father = Integer.parseInt(teasession.getParameter("father"));


if(father==0)
{
	out.print("您的操作不正确，请确认");
	return;
}

Report robj = Report.find(nid);
tea.entity.site.Community community=tea.entity.site.Community.find(teasession._strCommunity);
%>




<script>
var html='<input name=filepath type=file class=edit_input style=width:418px onchange=f_checkinput("form1.filepath");>'; 
function f_submit(igd)
{ 
	form1.act2.value=igd;
	if(form1.name.value=='')
	{
		alert('姓名不能为空.'); 
		form1.name.focus();
		return false;
	}
	if(form1.units.value=='')
	{
		alert('工作单位不能为空.');
		form1.units.focus();
		return false;
	}
	if(form1.email.value=='')
	{
		alert('邮箱不能为空.');
		form1.email.focus();
		return false;
	}else
	{
		  var temp = document.getElementById("email");
		  //对电子邮件的验证
		  var myreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
		  if(!myreg.test(temp.value))
		  {
		    alert('请输入有效的邮箱！');
		    document.form1.email.focus();
		    document.form1.email.value='';
		    return false;
		  }
	}
	if(form1.mobile.value=='')
	{

		alert('手机不能为空不能为空.');
		form1.mobile.focus();
         return false;
	}
    if(form1.mobile.value!=''){
      var sMobile = form1.mobile.value;
      if(!(/^1[3|4|5|8][0-9]\d{4,8}$/.test(sMobile))){
        alert("不是完整的11位手机号或者正确的手机号前七位");
        form1.mobile.focus();
        return false;
      }
    }
//	if(form1.address.value=='')
//	{
//		 Alert('提示','地址不能为空.','300','100');
//		return false;
//	}

  if(form1.father.value==0)
  {
	  alert('请选择投稿栏目.');
	  
    form1.father.focus();
    return false;
  }
  if(form1.subject.value=='')
  {
	  alert('请填写投稿主题.');
	  form1.subject.focus();
    return false;
  }
  if(form1.keywords.value=='')
  {
	  alert('请填写关键词.');
	  form1.keywords.focus();
	  return false;
  }
  
  // document.getElementById("GoFinishBut").disabled=true;
   // document.getElementById("GoFinishBut").value='信息提交中...';
    document.getElementById("GoFinishBut").style.display='none';
    document.getElementById("GoFinish2But").style.display='none';
    
      document.getElementById("buttonspanid").style.display='';
  // document.getElementById("GoFinish2But").disabled=true;
  // document.getElementById("GoFinish2But").value='信息提交中...';
    form1.submit();

}

function f_checkinput(obj){
  var sUploadAllowedExtensions  = ".rar .zip" ;//".doc,.docx,.xls,.xlsx" ;.doc .docx .txt 
  var sExt = eval(obj).value.match( /.[^.]*$/ ) ; 
  sExt = sExt ? sExt[0].toLowerCase() : "." ;
  if ( sUploadAllowedExtensions.indexOf( sExt ) < 0 )
  {
    alert("对不起, 只有下面的格式才能上传:" + sUploadAllowedExtensions + ",请重新选择.");
    document.getElementById('uploadSpan').innerHTML=html; 
    return false;  
  }
}
function f_te()
{
	if(document.getElementById('Contributors_uploadspan').style.display=='none'){

		document.getElementById('Contributors_uploadspan').style.display='';
	}else
		{
		
		document.getElementById('Contributors_uploadspan').style.display='none';
		}
	

}
</script>
<style>
#tablecenter{width:710px;border:1px solid #4ABCFE;margin-top:5px;background:#F8FCFF;}
#tablecenter #tabletr{font-size:14px;font-weight:bold;color:#413E3F;padding:10px 0px 0px 30px;}
#tablecenter td{font-size:14px;color:#146B9E;padding:5px 3px;}
#tablecenter td input,#tablecenter td textarea{border:1px solid #8EA9C2;}
#tablecenter #Contributors_2 input,#tablecenter #Contributors_7 input,#tablecenter #Contributors_6 input,#tablecenter #Contributors_5 input,#tablecenter #Contributors_4 input,#tablecenter #Contributors_8 input,#tablecenter #Contributors_9 input{width:415px;}
#tablecenter #Contributors_9 td div{font-size:12px;color:#8A8A8A;padding-top:15px;}
#tablecenter td input.GoFinish{border:0px;width:94px;height:33px;background:url(/res/Home/1006/100699122.gif) no-repeat left top;margin-top:20px;cursor:pointer;}
#tablecenter td input#GoFinishBut{border:0px;width:124px;height:33px;background:url(/res/Home/1009/10099928.gif) no-repeat left top;}
#tablecenter td input#GoFinish2But{border:0px;width:163px;height:33px;background:url(/res/Home/1009/10099931.gif) no-repeat left top;}
#tablecenter td input#GoFinish3But{bodrer:0px;width:99px;height:33px;background:url(/res/Home/1009/10099930.gif) no-repeat left top;}
</style>
<form name="form1" METHOD=POST action="/servlet/EditContributors" enctype="multipart/form-data">
<input type='hidden' name="community" value="<%=teasession._strCommunity%>">
<input type='hidden' name="repository" value="contributors">
<input type="hidden"   name="member" value="<%=member%>">
<input type='hidden' name="nexturl" value="<%=nexturl%>">
<input type="hidden" name="node" value="<%=teasession._nNode%>"/>
<input type="hidden" name="nid" value="<%=nid%>"/>
<input type="hidden" name="membertype" value="<%=membertype%>"/>
<input type="hidden" name="act" value="EditContributors">
<input type="hidden" name="act2" value="">



<table border="0" align="center" cellpadding="0" cellspacing="0" id="tablecenter" height="10">
<tr>
	<td colspan="2" id="tabletr"> 个人信息</td>
</tr>
<tr>
	<td align="right">*&nbsp;姓名：</td>
	<td><input type="text" name="name" value="<%if(robj.getName(teasession._nLanguage)!=null&&robj.getName(teasession._nLanguage).length()>0){out.println(robj.getName(teasession._nLanguage));}else{out.print(Entity.getNULL(pobj.getFirstName(teasession._nLanguage)));} %>"/></td>
	<td align="right">*&nbsp;工作单位：</td>
	<td><input type="text" name="units" value="<%if(robj.getUnits(teasession._nLanguage)!=null&&robj.getUnits(teasession._nLanguage).length()>0){out.println(robj.getUnits(teasession._nLanguage));}else{out.print(Entity.getNULL(pobj.getOrganization(teasession._nLanguage)));} %>"/></td>
</tr>
<tr>
	<td align="right">*&nbsp;邮箱：</td>
	<td><input type="text" name="email" id="email" value="<%if(robj.getEmail(teasession._nLanguage)!=null&&robj.getEmail(teasession._nLanguage).length()>0){out.println(robj.getEmail(teasession._nLanguage));}else{out.print(Entity.getNULL(pobj.getEmail()));} %>"/></td>
	<td align="right">*&nbsp;手机：</td>
	<td><input type="text" name="mobile" value="<%if(robj.getMobile(teasession._nLanguage)!=null&&robj.getMobile(teasession._nLanguage).length()>0){out.println(robj.getMobile(teasession._nLanguage));}else{out.print(Entity.getNULL(pobj.getMobile()));} %>"/></td>
</tr>
<tr>
<td align="right">&nbsp;地址：</td>
<td ><input type="text" name="address" class="address" value="<%if(robj.getAddress(teasession._nLanguage)!=null&&robj.getAddress(teasession._nLanguage).length()>0){out.println(robj.getAddress(teasession._nLanguage));}else{out.print(Entity.getNULL(pobj.getAddress(teasession._nLanguage)));} %>"></td>
<td align="right">&nbsp;办公电话：</td>
<td colspan="3"><input type="text" id="telephone" name="telephone"  value="<%if(robj.getTelephone(teasession._nLanguage)!=null&&robj.getTelephone(teasession._nLanguage).length()>0){out.println(robj.getTelephone(teasession._nLanguage));}else{out.print(Entity.getNULL(pobj.getTelephone(teasession._nLanguage)));} %>"></td>

</tr> 
</table>

<table border="0" align="center" cellpadding="0" cellspacing="0" id="tablecenter" height="10">
<tr id="Contributors_1">
    <td nowrap align="right">*&nbsp;投稿栏目：</td>
    <td nowrap align="left">
    <input type="hidden" name="father" value="<%=father %>">
    <%
    	out.print(Node.find(father).getSubject(teasession._nLanguage));
    %>
    </td>
  </tr>
   <tr id="Contributors_7">
    <td nowrap align="right">引题：</TD><!--引题-->
    <td nowrap align="left"><input type="text" class="edit_input"  name="kicker" value="<%if(robj.getKicker(teasession._nLanguage)!=null)out.print(robj.getKicker(teasession._nLanguage)); %>"  maxlength="255"></td>
  </tr>
  <tr id="Contributors_2">
    <td nowrap align="right">*&nbsp;主题：<!--标题--></TD>
    <td nowrap align="left"><input name="subject"  maxlength=200 class="edit_input" value="<%if(nobj.getSubject(teasession._nLanguage)!=null)out.print(nobj.getSubject(teasession._nLanguage)); %>"/></td>
  </tr>
  
    <tr id="Contributors_6">
    <TD align="right">副标题：<!--副标题--></TD>
    <td align="left"><input type="text" class="edit_input"  name="subhead" value="<%if(robj.getSubhead(teasession._nLanguage)!=null)out.print(robj.getSubhead(teasession._nLanguage)); %>"  maxlength="255"></td>
  </tr>

    <tr id="Contributors_5">
    <TD align="right">*&nbsp;关键词：</TD>
    <td align="left"><input type="text" class="edit_input"  name="keywords" value="<%if(nobj.getKeywords(teasession._nLanguage)!=null)out.print(nobj.getKeywords(teasession._nLanguage)); %>"  maxlength="255">
    </td>
  </tr>
<!-- 
  <tr id="Contributors_3">
    <td nowrap align="right">图片(缩略图)：</TD>
    <td nowrap align="left">
      <input name="picture" type="file" class="edit_input" style="width:418px">
      <%
      int len = 0;
      if(robj.getPicture(teasession._nLanguage)!=null&&robj.getPicture(teasession._nLanguage).length()>0)
      {
        len= (int)new java.io.File(application.getRealPath(robj.getPicture(teasession._nLanguage))).length();
      }
      if(len > 0)
      {
        out.print("<a href='"+robj.getPicture(teasession._nLanguage)+"' target='_blank'>"+len +"Bytes</a>");
        out.print("<input id='checkbox' type='checkbox' name='clearpicture' onclick='form1.picture.disabled=this.checked'>&nbsp;清除");
      }
      %>
    </td>
  </tr>
 
  <tr id="Contributors_4">
    <td nowrap align="right">地点：</TD>
    <td nowrap align="left"><input name="locus"   class="edit_input" value="<%if(robj.getLocus(teasession._nLanguage)!=null)out.print(robj.getLocus(teasession._nLanguage)); %>"/></td>
  </tr>


  <tr id="Contributors_8">
    <td nowrap align="right">导语：</TD>
    <td nowrap align="left"> <textarea name="logograph" rows="8" style="width:616px" class="edit_input"><%if(robj.getLogograph(teasession._nLanguage)!=null)out.print(robj.getLogograph(teasession._nLanguage)); %></textarea>    </td>
  </tr>
   -->
  <tr id="Contributors_9">
    <td nowrap align="right">正文：</TD><td><span id="z_Contributors_9"></span>(正文区可粘贴图片+文字，字数限2000字以内，图片宽度小于550像素，多张图片可打包压缩，以附件形式上传。粘贴请点击<img src="/tea/image/Pasted.jpg" /> ，上传图片请点击<img src="/tea/image/Upload.jpg" /> ，自动排版请点击<img src="/tea/image/Setting.jpg" /> 。)</td></tr>
    <tr>
    <td align="center" colspan=2>
      
    
       <textarea style="display:none" name="content" rows="12" cols="90" class="edit_input"> <%
	     if(nobj.getText(teasession._nLanguage)!=null)
	     {
	    	 out.print(Report.getHtml(nobj.getText(teasession._nLanguage))); 
	     }
     %></textarea>
      <iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=<%=teasession._strCommunity%>" width="690" height="450" frameborder="no" scrolling="no"></iframe>
      
     </td></tr>
     
     <tr id="tsid" >
     <td colspan="2">　如果你上传的稿件是组图，请点击<A href = "###" onclick=f_te();>这里</A></td>
     </tr>
      <tr id="Contributors_uploadspan" style="display:none">
      <td nowrap align="right" valign="top">附件：</td>
      <td nowrap align="left" valign="top">
      <span id='uploadSpan'>  
      <input name="filepath" type="file" class="edit_input" style="width:418px" onchange="f_checkinput('form1.filepath');">
      </span>
       <% 
  
      
   
      int len2 = 0;
      if(nobj.getFile(teasession._nLanguage)!=null&&nobj.getFile(teasession._nLanguage).length()>0)
      {
        len2= (int)new java.io.File(application.getRealPath(nobj.getFile(teasession._nLanguage))).length();
      }
      if(len2 > 0)
      {
        out.print("<a href='"+nobj.getFile(teasession._nLanguage)+"' target='_blank'>查看附件&nbsp;("+len2 +"Bytes)</a>"); 
       
        out.print("<input id='checkbox2' type='checkbox' name='clearpicture2' onclick='form1.filepath.disabled=this.checked'>&nbsp;清除");
      }
    
      %>
      <div>附件只支持 压缩文件（.ZIP、.RAR）。多图附件上传务必打包压缩！否则无法收到。<br><!-- WORD文档（.DOC）、纯文本（.TXT）和 -->
      	文字、图片请在正文编辑区上传。</div>
      </td>
      </tr>
      <tr> <td align="center" colspan="2">
      <input type="button" name="GoFinish"  id="GoFinishBut" value="" onclick="f_submit('YEScon');">　 <!--class="GoFinish"  -->
      <input type="button" name="GoFinish2"  id="GoFinish2But" value=""  onclick="f_submit('NOcon');">　 
      <span id="buttonspanid" style="display:none" >信息提交中.....</span>
  
      </td></tr>
</table>
</form>

