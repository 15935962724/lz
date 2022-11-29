<%@page contentType="text/html;charset=UTF-8" %>
<%
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
tea.entity.node.Node node=tea.entity.node.Node.find(teasession._nNode);
String member=node.getCreator()._strV;
tea.entity.member.BLOGProfile bp =tea.entity.member.BLOGProfile.find(member);
String subject=node.getSubject(teasession._nLanguage);
%>
<html>
<head>
<title><%=subject%></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="read_mode.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--

.html
{
	text-align:center;
}
body
{
	margin:auto;
	padding:auto;
	width:100%;
	overflow:hidden;
	text-align:center;
	padding-bottom: 20px;
	background:url('/images/bodyBG.gif') repeat top;
}
-->
</style>
</head>
<body>
<div id="menu" class="readModeTopBox" ondblclick="javascript:cancel_bubble(event);" onmousedown="javascript:cancel_bubble(event);">
	<div>
		<select id="no1" class="readModeBgColor" onchange="setBgColor(this.options[this.selectedIndex].value)">
			<option value="#eef9fc" class="readModeDefault">文章背景</option>
			<option value="#ffffff" class="readModeWhite">&nbsp; 雪白</option>
			<option value="#E4EBF1" class="readModeBabyBlue">&nbsp; 淡蓝</option>
			<option value="#eef9fc" class="readModeEEF9FC">&nbsp; 蓝色</option>
			<option value="#EEEEEE" class="readModeGrayEEE">&nbsp; 淡灰</option>
			<option value="#E4E1D8" class="readModeGrayE4E">&nbsp; 深灰</option>
			<option value="#E6E6E6" class="readModeGray6E6">&nbsp; 暗灰</option>
			<option value="#EEFAEE" class="readModeEEFAEE">&nbsp; 淡绿</option>
			<option value="#FFFFED" class="readModeYellow">&nbsp; 明黄</option>


			<option value="black" class="readModeBlack">&nbsp; &nbsp;黑</option>
			<option value="green" class="readModeGreen">&nbsp; &nbsp;绿</option>
			<option value="darkred" class="readModeDarkred">&nbsp; 暗红</option>
			<option value="darkslateblue" class="readModeDarkslateblue">&nbsp; 深蓝</option>
			<option value="teal" class="readModeTeal">&nbsp; 鸭绿</option>
			<option value="indigo" class="readModeIndigo">&nbsp; 靛青</option>
			<option value="brown" class="readModeBrown">&nbsp; 褐色</option>
		</select>
		&nbsp; &nbsp; &nbsp; &nbsp
		<span style="font-size:20px;">A</span>
		<select id="no2" onchange="setFontStyle(this.options[this.selectedIndex].value)">
			<option value="宋体">宋体</option>
			<option value="黑体">黑体</option>
			<option value="楷体_GB2312">楷体</option>
			<option value="仿宋_GB2312">仿宋</option>
			<option value="隶书">隶书</option>
			<option value="幼圆">幼圆</option>
		</select>
		<select id="no3" onchange="setFontSize(this.options[this.selectedIndex].value)">
			<option value="32px">二号</option>
			<option value="24px">三号</option>
			<option value="18px" selected="selected">四号</option>
			<option value="16px">小四</option>
			<option value="14px">五号</option>
			<option value="12px">小五</option>
		</select>
		<select id="no4" onchange="setFontColor(this.options[this.selectedIndex].value)">>
			<option value="black" class="readModeBlack">&nbsp;</option>
			<option value="green" class="readModeGreen">&nbsp;</option>
			<option value="darkred" class="readModeDarkred">&nbsp;</option>
			<option value="darkslateblue" class="readModeDarkslateblue">&nbsp;</option>
			<option value="teal" class="readModeTeal">&nbsp;</option>
			<option value="indigo" class="readModeIndigo">&nbsp;</option>
			<option value="brown" class="readModeBrown">&nbsp;</option>

			<option value="#ffffff" class="readModeWhite">&nbsp;</option>
			<option value="#E4EBF1" class="readModeBabyBlue">&nbsp;</option>
			<option value="#eef9fc" class="readModeEEF9FC">&nbsp;</option>
			<option value="#EEEEEE" class="readModeGrayEEE">&nbsp;</option>
			<option value="#E4E1D8" class="readModeGrayE4E">&nbsp;</option>
			<option value="#E6E6E6" class="readModeGray6E6">&nbsp;</option>
			<option value="#EEFAEE" class="readModeEEFAEE">&nbsp;</option>
			<option value="#FFFFED" class="readModeYellow">&nbsp;</option>
		</select>
		&nbsp; &nbsp;
		鼠标双击滚屏
		<select id="no5" onchange="setStep(this.options[this.selectedIndex].value)">
			<option value="400">10</option>
			<option value="300">09</option>
			<option value="200">08</option>
			<option value="150">07</option>
			<option value="120">06</option>
			<option value="100" selected="selected">05</option>
			<option value="50">04</option>
			<option value="40">03</option>
			<option value="30">02</option>
			<option value="10">01</option>
		</select>
		<span style="color:#737373">(1-10,1最快,10最慢)</span>
		&nbsp; &nbsp;
		<input type="button" value="保存设置" class="readModeSave" onclick="saveMode()" alt="save" />
		&nbsp; &nbsp;
		<input type="button" value="关闭" class="readModeSave" onclick="javascript:window.close()" alt="close" />
	</div>
</div>
<div id="readModeTxt" class="readModeTxtBox">
  <div id="ArticleTitle"><%=subject%></div>
  <div id="AuthorReadMode"><span id="Author">作者：<%=bp.getNickname(teasession._nLanguage)%></span><span id="PublicTime"><%=node.getTimeToString()%></span></div>
  <div id="Content" style="word-wrap:break-word;word-break:break-all;overflow:hidden;" onselectstart="return false;">



  <%if ((node.getOptions() & 0x40) == 0)out.print(tea.html.Text.toHTML(node.getText(teasession._nLanguage)));else out.print(node.getText(teasession._nLanguage));%>




  </div>
  <div id="Declare">本文仅为提供更多信息，不代表本站同意其观点或描述。如需转载请注明出处。</div>
  <div id="CloseButton"><table align="right"><tr>
  <td><span style="text-align: right;"><a href="javascript:close();" style="text-decoration: none; font-size: 12px;">关闭阅读模式</a></span></td>
    </tr></table>
  </div>
</div>

<script language="javascript" src="read_mode.js" type=""></script>
</body>
</html>

