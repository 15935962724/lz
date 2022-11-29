<%@page contentType="text/html;charset=UTF-8" %>




<html>
<head>
<link href="/res/cpcc/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<title>使用者详细资料</title>
<style>
#notpass{width:100%;font-size:16px;text-align:center;color:#ff0000;font-weight:bold;line-height:40px;}
</style>
</head>
<body id="bodynone">

<div id="jspbefore" style="display:none"></div>

<div id="tablebgnone">
  <form id="form1" name="form1" method="post" action="">
<div style="text-align:center;margin-top:20px;margin-bottom:20px;font-size:18px;font-weight:bold;">使用者详细资料
</div>

<table border="0" cellpadding="0" cellspacing="1" id="tablecenterup">
	<tr>
		<td>作品使用者编码</td>
	    <td><input type="text" name="textfield16"></td>
	<tr>	</tr>	
	    <td>作品使用者名称</td>
	    <td><input type="text" name="textfield"></td>
	</tr>
	<tr>
	  <td>单位性质</td>
	  <td><input type="text" name="textfield2"></td>
	<tr>	</tr>
	  <td>主管单位</td>
	  <td><input type="text" name="textfield3"></td>
	</tr>
	<tr>
	  <td>主办单位</td>
	  <td><input type="text" name="textfield4"></td>
	<tr>	</tr>
	  <td>地址</td>
	  <td><input type="text" name="textfield5"></td>
	</tr>
	<tr>
	  <td>邮编</td>
	  <td><input type="text" name="textfield6"></td>
	<tr>	</tr>	  
	  <td>法定代表人</td>
	  <td><input type="text" name="textfield7"></td>
	</tr>
	<tr>
	  <td>业务联系人</td>
	  <td><input type="text" name="textfield8"></td>
	<tr>	</tr>
	  <td>业务范围</td>
	  <td><input type="text" name="textfield9"></td>
	</tr>
	<tr>
	  <td>电话</td>
	  <td><input type="text" name="textfield10"></td>
	<tr>	</tr>	  
	  <td>手机</td>
	  <td><input type="text" name="textfield11"></td>
	</tr>
	<tr>
	  <td>传真</td>
	  <td><input type="text" name="textfield12"></td>
	<tr>	</tr>
	  <td>网址</td>
	  <td><input type="text" name="textfield13"></td>
	</tr>
	<tr>
	  <td>电子信箱</td>
	  <td><input type="text" name="textfield14"></td>
	<tr>	</tr>
	  <td>是否订立委托合同</td>
	  <td><input type="text" name="textfield15"></td>
	</tr>
	<tr>
	  <td>合同签字日期</td>
	  <td><input type="text" name="signs"><script>document.write("<input type=button value=... onclick=showCalendar('form1.signs'); >");</script></td>
	<tr>	</tr>
	  <td>合同生效时间</td>
	  <td><input type="text" name="effects"><script>document.write("<input type=button value=... onclick=showCalendar('form1.effects'); >");</script></td>
	</tr>
	<tr>
	  <td>合同有效期</td>
	  <td><input type="text" name="textfield18"></td>
	</tr>
</table>

<div style="text-align:center;margin-top:20px;"><input type="submit" name="Submit" value="提交"><input type="submit" name="Submit" value="返回">
</div>
  </form>
</div>



</body>
</html>


