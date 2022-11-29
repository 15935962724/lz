<%@page contentType="text/html;charset=utf-8" %>
<%
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
tea.entity.node.Node node=tea.entity.node.Node.find(teasession._nNode);
tea.resource.Resource r=new tea.resource.Resource();
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "TravelShopping")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<form name="shouhuoxx" method="post" action="/servlet/EditTravelShopping?node=<%=teasession._nNode%>" onsubmit="ssxx">
  <%
   int id = Integer.parseInt(request.getParameter("travelshopping"));

  %>
  <input type="hidden" name="travelshopping" value="<%=id%>"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td  align="center" colspan="20">请正确填写以下收货信息</td>
    </tr>
    <tr >
      <td  align="right" class="table-xia">*真实姓名：</TD>
      <td  style="PADDING-LEFT: 20px" class="table-xia"><input name="name" class="wenbenkuang" type="text" id="name" size="16" >
        性别：
        <select class="wenbenkuang" name="sex" id="shousex">
          <option value="true" >男</option>
          <option value="false" >女</option>
        </select>
      </td>
    </tr>
    <tr >
      <td width="30%" height="30" align="right" class="table-xia">*详细地址：</TD>
      <td width="70%" height="30" style="PADDING-LEFT: 20px" class="table-xia"><input class="wenbenkuang" name="address" type="text" id="address" size="50" value=>
      </td>
    </tr>
    <tr >
      <td width="30%" height="30" align="right" class="table-xia">邮政编码：</TD>
      <td width="70%" height="30" style="PADDING-LEFT: 20px" class="table-xia"><input class="wenbenkuang" name="postalcode" type="text" id="postalcode" size="16" value="" ONKEYPRESS="event.returnValue=IsDigit();"></td>
    </tr>
    <tr >
      <td width="30%" height="30" align="right" class="table-xia">*联系电话：</TD>
      <td width="70%" height="30" style="PADDING-LEFT: 20px" class="table-xia"><input class="wenbenkuang" name="phone" type="text" id="phone" size="16" value=>
      </td>
    </tr>
    <tr >
      <td width="30%" height="30" align="right" class="table-xia">*电子邮件：</TD>
      <td width="70%" height="30" style="PADDING-LEFT: 20px" class="table-xia"><input class="wenbenkuang" name="email" type="text" id="email" size="30" value=>
      </td>
    </tr>
    <tr >
      <td width="30%" height="30" align="right" class="table-xia">*支付方式：</TD>
      <td width="70%" height="30" style="PADDING-LEFT: 20px" class="table-xia"><select name=payment id="payment" style='width:180px'>
          <option value=16>邮局汇款</option>
          <option value=6>交通银行汇款</option>
          <option value=5>建设银行汇款</option>
          <option value=24>农业银行</option>
          <option value=23>工商银行</option>
          <option value=25>其它银行汇款</option>
        </select>
      </td>
    </tr>
    <tr >
      <td width="30%" height="30" align="right" class="table-xia">其它说明：</TD>
      <td width="70%" height="30" style="PADDING-LEFT: 20px" class="table-xia"><textarea name="request" cols="50" rows="5"></textarea>
      </td>
    </tr>
    <tr >
      <td height="40" colspan="2" align=center><input class="go-wenbenkuang" type="button" name="Submit2" value="上一步" onclick="javascript:history.go(-1)">
        <input class="go-wenbenkuang" type="submit" name="Submit4" value="OK,下一步" onclick='return ssxx();'>
      </td>
    </tr>
  </table>
</form>
<SCRIPT LANGUAGE="JavaScript">
<!--
function IsDigit()
{
  return ((event.keyCode >= 48) && (event.keyCode <= 57));
}
function checkspace(checkstr) {
  var str = '';
  for(i = 0; i < checkstr.length; i++) {
    str = str + ' ';
  }
  return (str == checkstr);
}

function ssxx()
{
   if(checkspace(document.shouhuoxx.name.value)) {
    alert("对不起，请填写收货人姓名！");
	document.shouhuoxx.name.focus();
	return false;
  }
  if(checkspace(document.shouhuoxx.address.value)) {
    alert("对不起，请填写收货人详细收货地址！");
	document.shouhuoxx.address.focus();
	return false;
  }
  /*
  if(checkspace(document.shouhuoxx.postalcode.value)) {
	document.shouhuoxx.postalcode.focus();
    alert("对不起，请填写邮编！");
	return false;
  }
  if(document.shouhuoxx.youbian.value.length!=6) {
	document.shouhuoxx.youbian.focus();
    alert("对不起，请正确填写邮编！");
	return false;
  }*/
    if(checkspace(document.shouhuoxx.phone.value)) {
    alert("对不起，请留下您的电话！");
	document.shouhuoxx.phone.focus();
	return false;
  }

  if(document.shouhuoxx.email.value.length!=0)
  {
    if (document.shouhuoxx.email.value.charAt(0)=="." ||
         document.shouhuoxx.email.value.charAt(0)=="@"||
         document.shouhuoxx.email.value.indexOf('@', 0) == -1 ||
         document.shouhuoxx.email.value.indexOf('.', 0) == -1 ||
         document.shouhuoxx.email.value.lastIndexOf("@")==document.shouhuoxx.email.value.length-1 ||
         document.shouhuoxx.email.value.lastIndexOf(".")==document.shouhuoxx.email.value.length-1)
     {
      alert("Email地址格式不正确！");
      document.shouhuoxx.email.focus();
      return false;
      }
   }
 else
  {
   alert("Email不能为空！");
   document.shouhuoxx.email.focus();
   return false;
   }

}
//-->
        </script>
</TD>
</TR>
</TABLE>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>

