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

YzMeetingApplicants yma = YzMeetingApplicants.find(id);

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
</script>
</head>
<body onload="f_load()">
<h1>报名人员查看</h1>
  <div id="head6"><img height="6" src="about:blank"></div>


<form name="form1" method="post" action="/servlet/EditYzMeetingApplicants"  ENCtype=multipart/form-data target="_ajax" onSubmit="return f_sub();">
<input type="hidden" name="act" value="edit">
<input type="hidden" name="nexturl" value="<%=nexturl%>">
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td align="right" width="160">姓名：</td>
      <td>
        <%=yma.getName()!=null?yma.getName():""%>
      </td>
    </tr>
	
	<tr>
      <td align="right">性别：</td>
      <td>
      <%if(yma.getSex()==0){out.println("女");}else{out.println("男");} %>
      </td>
    </tr> 

   <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "联系电话")%>：</td>
      <td>
        <%=yma.getTel()!=null?yma.getTel():""%>
      </td>
    </tr>
    
    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "是否安排餐饮")%>：</td>
      <td>
      <%if(yma.getCatering()==0){out.println("是");}else{out.println("否");} %>
      </td>
    </tr>
     <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "是否安排住宿")%>：</td>
      <td>
      <%if(yma.getStay()==0){out.println("是");}else{out.println("否");} %>
      </td>
    </tr>
    <tr id="catering" <%if(yma.getStay()==1)out.print("style='display:none'");%>>
      <td></td>
      <td>
        	酒店名称：<%=yma.getHotelname()!=null?yma.getHotelname():""%>&nbsp;&nbsp;
        	酒店地址：<%=yma.getHoteladdress()!=null?yma.getHoteladdress():""%>
      </td>
    </tr>
     <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "是否安排接送")%>：</td>
      <td>
      <%if(yma.getShuttle()==0){out.println("是");}else{out.println("否");} %>
      </td>
    </tr>  

  </table>
  <br>
  <center>
  <%-- <input type="button" name="reset" value="返回"  onclick="window.open('<%=teasession.getParameter("nexturl")%>','_self');"> --%>

</center></form>
  <%-- <div id="language"><%=new Languages(teasession._nLanguage,request)%>  </div> --%>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

