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

int node = teasession.getParameter("node")!=null?Integer.parseInt(teasession.getParameter("node")):0;
int adminunitid = teasession.getParameter("adminunitid")!=null?Integer.parseInt(teasession.getParameter("adminunitid")):0;
MeetingInvite ymi = MeetingInvite.find(node,adminunitid);
int num = 0;
if(teasession.getParameter("num")!=null && teasession.getParameter("num").length()>0)
{
	num = Integer.parseInt(teasession.getParameter("num"));
}

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<script src="/tea/city2.js" type="text/javascript"></script>
<script>var pmt=parent.mt;</script>
<script type="text/javascript">

function f_load()
{
  form1.num.focus();
}
function f_sub()
{
	var num = form1.num.value;
	if(num>0){
		for(var i=0;i<num;i++){
			if(form1['name'+i].value=='')
			{
				  alert('请填写姓名');
				  form1['name'+i].focus();
				  return false;
			}
			if(form1['tel'+i].value=='')
			{
				  alert("请填写联系电话");
				  form1['tel'+i].focus();
				  return false;
			}
			if(form1['stay'+i].value==0){
				if(form1['hotelname'+i].value=='')
				{
					  alert("请填写酒店名称");
					  form1['hotelname'+i].focus();
					  return false;

				}
				if(form1['hoteladdress'+i].value=='')
				{
				 	alert("请填写酒店地址");
				  	form1['hoteladdress'+i].focus();
				  	return false;
				}
			}
		}
		form1.act.value="registration";
		form1.nexturl.value=location;
		form1.target="_ajax";
		form1.action="/servlet/EditMeetingApplicants";
		form1.submit();
	}else{
		alert("报名人员不能小于1！");
	}
}

//点击操作显示
function f_cz(isStay,num)
{
	if(isStay==1)
	{
		document.getElementById('isStay'+num).style.display='none';
	}
	else if(isStay==0)
	{
		document.getElementById('isStay'+num).style.display='';
	}
}

function f_add()
{
	var re = /^[0-9]+.?[0-9]*$/;   //判断字符串是否为数字     //判断正整数 /^[1-9]+[0-9]*]*$/  
	if(!re.test(form1.num.value))
	{
		document.getElementById('accqid').innerHTML='输入的必须是数字';
		form1.num.focus();
		form1.num.value=1;
		return false;
	}
	
	if(form1.num.value>10)
	{
		document.getElementById('accqid').innerHTML='只能输入10';
		form1.num.focus();
		form1.num.value=1;
		//return false;
	}
	form1.submit();	
}

mt.closeRegistration=function(){
	alert("报名成功");
	parent.mt.close();
};
</script>

</head>
<body onload="f_load()">
<!-- <h1>添加报名人员</h1> -->
  <div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" method="post" action="?" >
<input type="hidden" name="node" value="<%=node%>">
<input type="hidden" name="adminunitid" value="<%=adminunitid%>">
<input type="hidden" name="state" value="1">
<input type="hidden" name="act" value="edit">
<input type="hidden" name="nexturl" value="<%=nexturl%>">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td align="right" width="160">报名人数：</td>
      <td>
        <input type="text" class="edit_input" name="num" value="<%=num%>" onkeyup="f_add()"><span id="accqid"></span>
      </td>
    </tr>
</table>

<%
for(int i=0;i<num;i++)
{
%>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td align="right" width="160">姓名：</td>
      <td>
        <input type="text" class="edit_input" name="name<%=i%>" value=""/>
      </td>
    </tr>
	
	<tr>
      <td align="right">性别：</td>
      <td>
      	<input type="radio" name="sex<%=i%>" value="0" checked="checked"/>&nbsp;女
        <input type="radio" name="sex<%=i%>" value="1"/>&nbsp;男　
      </td>
    </tr> 

   <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "联系电话")%>：</td>
      <td>
        <input type="text" class="edit_input"  name="tel<%=i%>" value=""/>
      </td>
    </tr>
    
    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "是否安排餐饮")%>：</td>
      <td>
        <input type="radio" name="catering<%=i%>" value="0" checked="checked"/>&nbsp;是　
        <input type="radio" name="catering<%=i%>" value="1">&nbsp;否
      </td>
    </tr>
     <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "是否安排住宿")%>：</td>
      <td>
        <input type="radio" name="stay<%=i%>" value="0" checked="checked" onclick="f_cz(0,<%=i%>)">&nbsp;是　
        <input type="radio" name="stay<%=i%>" value="1" onclick="f_cz(1,<%=i%>)">&nbsp;否
      </td>
    </tr>
    <tr id="isStay<%=i%>">
      <td></td>
      <td>
        	酒店名称：<input type="text" class="edit_input" name="hotelname<%=i%>" value="">&nbsp;&nbsp;
        	酒店地址：<input type="text" class="edit_input" name="hoteladdress<%=i%>" value="">
      </td>
    </tr>
     <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "是否安排接送")%>：</td>
      <td>
        <input type="radio" name="shuttle<%=i%>" value="0" checked="checked">&nbsp;是
        <input type="radio" name="shuttle<%=i%>" value="1">&nbsp;否
      </td>
    </tr>  

  </table>
<%
}
%>
  <br>
  <center>
  <%
  if(num>0)
  {
  %>
  <INPUT TYPE=button name="GoFinish" ID="edit_GoFinish" class="edit_button" onclick="f_sub()" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">&nbsp;
  <%
  }
  %>
  <input type="button" name="reset" value="关闭"  onclick="javascript:parent.mt.close();">

</center></form>
  <%-- <div id="language"><%=new Languages(teasession._nLanguage,request)%>  </div> --%>
<script language="javascript">
<%
if(!ymi.isExist()||ymi.getState()!=0)
{
out.println("mt.closeRegistration();");
}
%>
</script>
</body>
</html>

