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
int adminunitid = Integer.parseInt(teasession.getParameter("adminunitid"));

MeetingApplicants yma = MeetingApplicants.find(id);

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
function f_cz(isStay)
{
	if(isStay==1)
	{
		document.getElementById('isStay').style.display='none';
	}
	else if(isStay==0)
	{
		document.getElementById('isStay').style.display='';
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
<input type="hidden" name="adminunitid" value="<%=adminunitid%>">
<input type="hidden" name="act" value="edit">
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
      <td align="right"><%=r.getString(teasession._nLanguage, "联系电话")%>：</td>
      <td>
        <input type="text" class="edit_input"  name="tel" value="<%=yma.getTel()!=null?yma.getTel():""%>">
      </td>
    </tr>
    
    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "是否安排餐饮")%>：</td>
      <td>
        <input type="radio" name="catering" value="0" <%if(yma.getCatering()==0){out.println(" checked");} %>>&nbsp;是　
        <input type="radio" name="catering" value="1" <%if(yma.getCatering()==1){out.println(" checked");} %>>&nbsp;否
      </td>
    </tr>
     <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "是否安排住宿")%>：</td>
      <td>
        <input type="radio" name="stay" value="0" <%if(yma.getStay()==0){out.println(" checked");} %> onclick="f_cz(0)">&nbsp;是　
        <input type="radio" name="stay" value="1" <%if(yma.getStay()==1){out.println(" checked");} %> onclick="f_cz(1)">&nbsp;否
      </td>
    </tr>
    <tr id="isStay" <%if(yma.getStay()==1)out.print("style='display:none'");%>>
      <td></td>
      <td>
        	酒店名称：<input type="text" class="edit_input" name="hotelname" value="<%=yma.getHotelname()!=null?yma.getHotelname():""%>">&nbsp;&nbsp;
        	酒店地址：<input type="text" class="edit_input" name="hoteladdress" value="<%=yma.getHoteladdress()!=null?yma.getHoteladdress():""%>">
      </td>
    </tr>
     <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "是否安排接送")%>：</td>
      <td>
        <input type="radio" name="shuttle" value="0" <%if(yma.getShuttle()==0){out.println(" checked");} %>>&nbsp;是
        <input type="radio" name="shuttle" value="1" <%if(yma.getShuttle()==1){out.println(" checked");} %>>&nbsp;否
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

