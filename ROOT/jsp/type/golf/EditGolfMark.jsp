<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.*" %><%

Http h=new Http(request);

String nu=request.getParameter("nexturl");



%><html>
<head>
<title>球场点评</title>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1>球场点评</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" method="post" action="/servlet/EditGolf">
<input type="hidden" name="node" value="<%=h.node%>"/>
<%if(nu!=null)out.print(new tea.html.HiddenField("nexturl",nu));%>
<input type="hidden" name="mark" value="ON"/>

<table id="tablecenter" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td nowrap width="4%">整体印象</td>
    <td width="30%">
      <input name="holisticMark"  id="radio" type="radio" value="5" checked="true" />5分
      <input  id="radio" type="radio" name="holisticMark" value="4" />4分
      <input  id="radio" type="radio" name="holisticMark" value="3" />3分
      <input  id="radio" type="radio" name="holisticMark" value="2" />2分
      <input  id="radio" type="radio" name="holisticMark" value="1" />1分
    </td>
  </tr>
  <tr>
    <td nowrap>交通条件</td>
    <td>
      <input name="relaxMark"  id="radio" type="radio" value="5" checked="true" />5分
      <input  id="radio" type="radio" name="relaxMark" value="4" />4分
      <input  id="radio" type="radio" name="relaxMark" value="3" />3分
      <input  id="radio" type="radio" name="relaxMark" value="2" />2分
      <input  id="radio" type="radio" name="relaxMark" value="1" />1分
    </td>
  </tr>
  <tr>
    <td nowrap>球场景观</td>
    <td>
      <input name="auraMark"  id="radio" type="radio" value="5" checked="true" />5分
      <input  id="radio" type="radio" name="auraMark" value="4" />4分
      <input  id="radio" type="radio" name="auraMark" value="3" />3分
      <input  id="radio" type="radio" name="auraMark" value="2" />2分
      <input  id="radio" type="radio" name="auraMark" value="1" />1分
    </td>
  </tr>
  <tr>
    <td nowrap>会所印象</td>
    <td><input name="lamplightMark"  id="radio" type="radio" value="5" checked="true" />5分
      <input  id="radio" type="radio" name="lamplightMark" value="4" />4分
      <input  id="radio" type="radio" name="lamplightMark" value="3" />3分
      <input  id="radio" type="radio" name="lamplightMark" value="2" />2分
      <input  id="radio" type="radio" name="lamplightMark" value="1" />1分 </td>
  </tr>
  <tr>
    <td nowrap>前台服务</td>
    <td><input name="serveMark"  id="radio" type="radio" value="5" checked="true" />5分
      <input  id="radio" type="radio" name="serveMark" value="4" />4分
      <input  id="radio" type="radio" name="serveMark" value="3" />3分
      <input  id="radio" type="radio" name="serveMark" value="2" />2分
      <input  id="radio" type="radio" name="serveMark" value="1" />1分 </td>
  </tr>
  <tr>
    <td nowrap>餐厅与饮食</td>
    <td><input name="temperatureMark"  id="radio" type="radio" value="5" checked="true" />5分
      <input  id="radio" type="radio" name="temperatureMark" value="4" />4分
      <input  id="radio" type="radio" name="temperatureMark" value="3" />3分
      <input  id="radio" type="radio" name="temperatureMark" value="2" />2分
      <input  id="radio" type="radio" name="temperatureMark" value="1" />1分 </td>
  </tr>
  <tr>
    <td nowrap>球场难度</td>
    <td><input name="musicMark"  id="radio" type="radio" value="5" checked="true" />5分
      <input  id="radio" type="radio" name="musicMark" value="4" />4分
      <input  id="radio" type="radio" name="musicMark" value="3" />3分
      <input  id="radio" type="radio" name="musicMark" value="2" />2分
      <input  id="radio" type="radio" name="musicMark" value="1" />1分 </td>
  </tr>
  <tr>
    <td nowrap>更衣间</td>
    <td><input name="airMark"  id="radio" type="radio" value="5" checked="true" />5分
      <input  id="radio" type="radio" name="airMark" value="4" />4分
      <input  id="radio" type="radio" name="airMark" value="3" />3分
      <input  id="radio" type="radio" name="airMark" value="2" />2分
      <input  id="radio" type="radio" name="airMark" value="1" />1分 </td>
  </tr>
  <tr>
    <td nowrap>球童水平</td>
    <td><input name="crowdMark"  id="radio" type="radio" value="5" checked="true" />5分
      <input  id="radio" type="radio" name="crowdMark" value="4" />4分
      <input  id="radio" type="radio" name="crowdMark" value="3" />3分
      <input  id="radio" type="radio" name="crowdMark" value="2" />2分
      <input  id="radio" type="radio" name="crowdMark" value="1" />1分 </td>
  </tr>
  <tr>
    <td nowrap>洗手间</td>
    <td><input name="safetyMark"  id="radio" type="radio" value="5" checked="true" />5分
      <input  id="radio" type="radio" name="safetyMark" value="4" />4分
      <input  id="radio" type="radio" name="safetyMark" value="3" />3分
      <input  id="radio" type="radio" name="safetyMark" value="2" />2分
      <input  id="radio" type="radio" name="safetyMark" value="1" />1分 </td>
  </tr>
  <tr>
    <td nowrap>消费客户群素质</td>
    <td><input name="drinkMark"  id="radio" type="radio" value="5" checked="true" />5分
      <input  id="radio" type="radio" name="drinkMark" value="4" />4分
      <input  id="radio" type="radio" name="drinkMark" value="3" />3分
      <input  id="radio" type="radio" name="drinkMark" value="2" />2分
      <input  id="radio" type="radio" name="drinkMark" value="1" />1分 </td>
  </tr>
  <tr>
    <td nowrap>心情指数</td>
    <td><input name="belleMark"  id="radio" type="radio" value="5" checked="true" />5分
      <input  id="radio" type="radio" name="belleMark" value="4" />4分
      <input  id="radio" type="radio" name="belleMark" value="3" />3分
      <input  id="radio" type="radio" name="belleMark" value="2" />2分
      <input  id="radio" type="radio" name="belleMark" value="1" />1分 </td>
  </tr>
  <tr>
    <td nowrap>草坪</td>
    <td><input name="deliMark"  id="radio" type="radio" value="5" checked="true" />5分
      <input  id="radio" type="radio" name="deliMark" value="4" />4分
      <input  id="radio" type="radio" name="deliMark" value="3" />3分
      <input  id="radio" type="radio" name="deliMark" value="2" />2分
      <input  id="radio" type="radio" name="deliMark" value="1" />1分 </td>
  </tr>
  <tr>
    <td nowrap>沙坑</td>
    <td><input name="priceMark"  id="radio" type="radio" value="5" checked="true" />5分
      <input  id="radio" type="radio" name="priceMark" value="4" />4分
      <input  id="radio" type="radio" name="priceMark" value="3" />3分
      <input  id="radio" type="radio" name="priceMark" value="2" />2分
      <input  id="radio" type="radio" name="priceMark" value="1" />1分 </td>
  </tr>
  <%-- <tr>
    <td>卫生间</td>
    <td><input name="toiletMark"  id="radio" type="radio" value="5" checked="true" />5分
      <input  id="radio" type="radio" name="toiletMark" value="4" />4分
      <input  id="radio" type="radio" name="toiletMark" value="3" />3分
      <input  id="radio" type="radio" name="toiletMark" value="2" />2分
      <input  id="radio" type="radio" name="toiletMark" value="1" />1分 </td>
</tr>--%>
</table>
<input name="Input" type="submit" value="提交" />
<input type="button" value="关闭" onclick="window.close();"/>
</form>

</body>
</html>
