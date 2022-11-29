<%@page contentType="text/html;charset=UTF-8" %>




<html>
<head>
<link href="/res/cpcc/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<title>报刊使用作品详细资料</title>
<style>
#notpass{width:100%;font-size:16px;text-align:center;color:#ff0000;font-weight:bold;line-height:40px;}
</style>
</head>
<body id="bodynone">

<div id="jspbefore" style="display:none"></div>

<div id="tablebgnone">
  <form id="form1" name="form1" method="post" action="">
<div style="text-align:center;margin-top:20px;margin-bottom:20px;font-size:18px;font-weight:bold;">
报刊使用作品详细资料
</div>

<table cellpadding="0" cellspacing="1" border="0" id="tablecenterup">
	<tr>
		<td>作品编码</td>
		<td><input name="textfield14" type="text" /></td>
	<tr>	</tr>	
        <td>著作权人编码</td>
        <td><input name="textfield" type="text" /></td>
	</tr>
	<tr>
	  <td>著作权人名称</td>
	  <td><input name="textfield2" type="text" /></td>
	<tr>	</tr>
	  <td>作者署名</td>
	  <td><input name="textfield3" type="text" /></td>
	</tr>
	<tr>
	  <td>作品名称</td>
	  <td><input name="textfield4" type="text" /></td>
	<tr>	</tr>
	  <td>原发报刊</td>
	  <td><input name="textfield5" type="text" /></td>
	</tr>
	<tr>
	  <td>原发日期</td>
	  <td><input name="textfield6" type="text" /></td>
	<tr>	</tr>
	  <td>原发刊次</td>
	  <td><input name="textfield7" type="text" /></td>
	</tr>
	<tr>
	  <td>转发报刊</td>
	  <td colspan="3"><input name="textfield8" type="text" /></td>
	  </tr>
	<tr>
	  <td>转发日期</td>
	  <td colspan="3"><input name="textfield9" type="text" /></td>
	  </tr>
	<tr>
	  <td>转发时名称</td>
	  <td colspan="3"><input name="textfield10" type="text" /></td>
	  </tr>
	<tr>
	  <td>转发署名</td>
	  <td colspan="3"><input name="textfield11" type="text" /></td>
	</tr>
	<tr>
	  <td>使用数量</td>
	  <td colspan="3"><input name="textfield12" type="text" /></td>
	  </tr>
	<tr>
	  <td>稿酬</td>
	  <td><input name="textfield13" type="text" /></td>
	<tr>	</tr>	  
	  <td>入库日期</td>
	  <td><input name="dates" type="text" />
	  <script>document.write("<input type=button value=... onclick=showCalendar('form1.dates'); >");</script></td>
	</tr>
	<tr>
	  <td>备注</td>
	  <td colspan="3"><textarea name="textarea" cols="50" rows="5"></textarea></td>
	  </tr>
	<tr>
	  <td>确认标志</td>
	  <td colspan="3"><input name="textfield16" type="text" /></td>
	</tr>
</table>

<div style="text-align:center;margin-top:20px;"><input type="submit" name="Submit" value="提交">
</div>
  </form>
</div>



</body>
</html>


