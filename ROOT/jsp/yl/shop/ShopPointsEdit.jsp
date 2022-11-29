<%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.yl.shop.ShopMyPoints"%>
<%@page import="tea.entity.Http"%>
<%@page contentType="text/html;charset=UTF-8" %>
<%
Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
String act=h.get("act");
int member=h.getInt("member");
if(request.getMethod().equals("POST")){
	if("edit".equals(act)){
		int integral=h.getInt("integral",0);
		String content=h.get("content");
		int status= ShopMyPoints.creatPoint(member, content, integral, null);
		out.print("<script>parent.mt.close();parent.mt.show('"+ShopMyPoints.STATUS[status]+"',1,'/jsp/yl/user/DeptSeqs.jsp')</script>");
		return;
		
	}
}
%>
<!DOCTYPE html><html>
<head>

<title>积分设置</title>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/tea/mt.js" type="text/javascript"></script>
<script type="text/javascript">

</script>
<style type="text/css">
#nt_step_2{ padding-left:20px; }
#nt_step_3{ padding-left:40px; }
</style>
</head>
<body >

<form name="form1" method="post" action="?" onsubmit="return mt.check(this)">
<input type="hidden" name="act" value="edit">
<input type="hidden" name="member" value="<%=member%>">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

  <tr>
    <td align="right" nowrap width='100' style='text-align:right'><b>会员用户名：</b></td>
    <tD><%=Profile.find(member).getMember() %></tD>
  </tr>
 <tr>
 <td align="right" nowrap style='text-align:right'><b>加减积分：</b></td>
    <td><input type="text" alt="加减积分" name="integral" value="" onkeyup="value=value.match(/^-?[0-9]\d*$/)||value.match(/-?/)" size="4"></td>
 </tr>
 <tr>
 <td align="right" style='text-align:right'><b>注：</b></td>
 <td>&nbsp;如果加分直接填写数字，例如加10 就填写10；<br>
    &nbsp;如果减分则要加入“-”号，例如减10 就填写-10。</td>
    </tr>
    <tr>
  <td align="right" nowrap style='text-align:right'><b>加减分原因：</b></td>
    <td><textarea rows="2" cols="50" alt="加分原因" name="content"></textarea></td>
 </tr>
  
<tr>


</table>
<br/>


<input type="submit" id="buttonid" class="btn btn-primary" value="提交" >


<input type="button" id="closeid" class="btn btn-default" value="关闭" onclick="parent.mt.close()">
</form>

</body>
</html>
