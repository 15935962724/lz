<%@page contentType="text/html;charset=UTF-8"  %>
<%@include file="/jsp/Header.jsp"%>
<%

/* if(!AccessMember.find(node._nNode, teasession._rv._strV).isProvider(37))
{
  response.sendError(403);
  return;
} */
 r.add("/tea/resource/Event");

String nexturl=teasession.getParameter("nexturl");

int id = Integer.parseInt(teasession.getParameter("id"));
int node = Integer.parseInt(teasession.getParameter("node"));

MeetingApplicants yma = MeetingApplicants.find(id);
Profile pf = Profile.find(yma.getTel());
int language = teasession._nLanguage;
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<script src="/tea/city2.js" type="text/javascript"></script>
<script type="text/javascript">

function f_load()
{
  form1.name.focus();
}
function f_sub()
{
	  if(form1.name.value==''){
		  alert('请填写姓名');
		  form1.name.focus();
		  return false;
	  }
	  if(form1.tel.value=='')
		  {
		  	alert("请填写联系电话");
		  	form1.tel.focus();
		  	return false;
	  }
	  if(form1.stay.value==0){
		  if(form1.hotelname.value=='')
			{
			  	alert("请填写酒店名称");
			  	form1.hotelname.focus();
			  	return false;

			}
		  if(form1.hoteladdress.value=='')
		  {
		  	alert("请填写酒店地址");
		  	form1.hoteladdress.focus();
		  	return false;
		  }
	  }
}

//点击操作显示
function f_cz(catering)
{
	if(catering==1)
	{
		document.getElementById('catering').style.display='none';
	}
	else if(catering==0)
	{
		document.getElementById('catering').style.display='';
	}
}

mt.refresh=function(url){
	window.location.href=url;
};
</script>
</head>
<body onload="f_load()">
<h1>报名人员编辑</h1>
  <div id="head6"><img height="6" src="about:blank"></div>


<form name="form1" method="post" action="/servlet/EditMeetingApplicants"  ENCtype=multipart/form-data target="_ajax" onSubmit="return f_sub();">
<input type="hidden" name="id" value="<%=id%>">
<input type="hidden" name="node" value="<%=node%>">
<input type="hidden" name="adminunitid" value="0">
<input type="hidden" name="act" value="edit2">
<input type="hidden" name="nexturl" value="<%=nexturl%>">
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td align="right" width="160">姓名：</td>
      <td>
        <input type="text" class="edit_input" name="name" value="<%=yma.getName()!=null?yma.getName():""%>">
      </td>
    </tr>
	
	<tr>
      <td align="right">性别：</td>
      <td>
      	<input type="radio" name="sex" value="0" <%if(yma.getSex()==0){out.println(" checked");} %>>&nbsp;女
        <input type="radio" name="sex" value="1" <%if(yma.getSex()==1){out.println(" checked");} %>>&nbsp;男　
      </td>
    </tr> 
    
    <tr>
      <td align="right" width="160">职务：</td>
      <td>
        <input type="text" class="edit_input" name="job" value="<%=pf.getJob(language)!=null?pf.getJob(language):""%>">
      </td>
    </tr>
    
    <tr>
      <td align="right" width="160">职称：</td>
      <td>
        <input type="text" class="edit_input" name="title" value="<%=pf.getTitle(language)!=null?pf.getTitle(language):""%>">
      </td>
    </tr>
    
    <tr>
      <td align="right" width="160">工作单位：</td>
      <td>
        <input type="text" class="edit_input" name="section" value="<%=pf.getSection(language)!=null?pf.getSection(language):""%>">
      </td>
    </tr>
    
    <tr>
      <td align="right" width="160">固话：</td>
      <td>
        <input type="text" class="edit_input" name="telephone" value="<%=pf.getTelephone(language)!=null?pf.getTelephone(language):""%>">
      </td>
    </tr>

   <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "联系电话")%>：</td>
      <td>
        <input type="text" class="edit_input"  name="tel" value="<%=yma.getTel()!=null?yma.getTel():""%>">
      </td>
    </tr>
    
    <tr>
      <td align="right" width="160">电子邮箱：</td>
      <td>
        <input type="text" class="edit_input" name="email" value="<%=pf.getEmail()!=null?pf.getEmail():""%>">
      </td>
    </tr>
    
  </table>
  <br>
  <center>
  <INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">&nbsp;
  <input type="button" name="reset" value="返回"  onclick="window.open('<%=teasession.getParameter("nexturl")%>','_self');">

</center></form>
  <%-- <div id="language"><%=new Languages(teasession._nLanguage,request)%>  </div> --%>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

