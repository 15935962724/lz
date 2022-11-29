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
<link href="print.css" rel="stylesheet" type="text/css" />

<style type="text/css">
.vbbcss_codetitle2      {margin:auto; text-align:left; font:11px Verdana; font-weight:bold; line-height:14px;}
.vbbcss_codewinbg2      {margin:auto; border:1px dashed; padding:4px; width:660px; text-align:left; font:12px Verdana; line-height:16px; word-wra
</style>

<script language="VBScript" type="text/vbscript">
dim hkey_root, hkey_path, hkey_key
dim head, foot, left, right, top, bottom
dim url, first_click
url = "http://news.sina.com.cn/c/2004-12-10/01314481022s.shtml"
first_click = 0
hkey_root = "HKEY_CURRENT_USER"
hkey_path = "\Software\Microsoft\Internet Explorer\PageSetup"

'// 设置网页打印的设置
function pagesetup_set()
    on error resume next

	If first_click = 0 Then
		pagesetup_get()
		first_click = 1
	End If

    Set RegWsh = CreateObject("WScript.Shell")
    hkey_key = "\header"
    RegWsh.RegWrite hkey_root & hkey_path & hkey_key , ""
    hkey_key = "\footer"
    RegWsh.RegWrite hkey_root & hkey_path & hkey_key , url & "&b&p/&P页"
	' 左右上下 20mm  10mm 4.19mm 10mm
    hkey_key = "\margin_left"
    RegWsh.RegWrite hkey_root & hkey_path & hkey_key , "0.78740"
    hkey_key = "\margin_right"
    RegWsh.RegWrite hkey_root & hkey_path & hkey_key , "0.39370"
	hkey_key = "\margin_top"
    RegWsh.RegWrite hkey_root & hkey_path & hkey_key , "0.16500"
	hkey_key = "\margin_bottom"
    RegWsh.RegWrite hkey_root & hkey_path & hkey_key , "0.39370"
end function

'// 恢复网页打印设置为原来的值
function pagesetup_default()
    on error resume next
    Set RegWsh = CreateObject("WScript.Shell")
    hkey_key="\header"
    RegWsh.RegWrite hkey_root & hkey_path & hkey_key , head
    hkey_key="\footer"
    RegWsh.RegWrite hkey_root & hkey_path & hkey_key , foot
    hkey_key = "\margin_left"
    RegWsh.RegWrite hkey_root & hkey_path & hkey_key , left
    hkey_key = "\margin_right"
    RegWsh.RegWrite hkey_root & hkey_path & hkey_key , right
	hkey_key = "\margin_top"
    RegWsh.RegWrite hkey_root & hkey_path & hkey_key , top
	hkey_key = "\margin_bottom"
    RegWsh.RegWrite hkey_root & hkey_path & hkey_key , bottom
end function

'// 读取网页打印设置
function pagesetup_get()
    on error resume next
    Set RegWsh = CreateObject("WScript.Shell")
    hkey_key="\header"
	head = RegWsh.RegRead(hkey_root+hkey_path & hkey_key)
    hkey_key="\footer"
    foot = RegWsh.RegRead(hkey_root+hkey_path & hkey_key)
    hkey_key = "\margin_left"
    left = RegWsh.RegRead(hkey_root+hkey_path & hkey_key)
    hkey_key = "\margin_right"
    right = RegWsh.RegRead(hkey_root+hkey_path & hkey_key)
	hkey_key = "\margin_top"
    top = RegWsh.RegRead(hkey_root+hkey_path & hkey_key)
	hkey_key = "\margin_bottom"
    bottom = RegWsh.RegRead(hkey_root+hkey_path & hkey_key)
end function
</script>

<script language="javascript" type="text/javascript">
function printsetup()
{
	// 打印页面设置
	wb.execwb(8, 1);
}
function printpreview()
{
	// 打印页面预览	　　
	wb.execwb(7, 1);
}
function printit()
{
	if (confirm('确定打印吗？'))
	{
		wb.execwb(6, 6)
	}
}
function setFontSize(size)
{
	document.getElementById('content_div').style.fontSize = size;
}
</script>
</head>

<body>

<object classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2" height="0" id="wb" name="wb" width="0"></object>
<!--
<input type="button" name="button_print" value="打印" onclick="javascript:printit()" />
<input type="button" name="button_setup" value="打印页面设置" onclick="javascript:printsetup();" />
<input type="button" name="button_show" value="打印预览" onclick="javascript:printpreview();" />
<input type="button" value="设置A4打印" onclick="pagesetup_set()" />
<input type="button" value="恢复页面" onclick="pagesetup_default()" />
-->

<!-- 打印的页头 -->
<div style="text-align:center;">
	<div style="width:650px;">
	<span id="sinablog" style="float:left; font-size:14px;"><img src="/tea/image/section/BLOG/50304.gif" align="bottom" /> <%=subject%></span>
<span id="PageLink" style="float:right;"><img src="/images/null.gif" align="bottom" width="1" height="30" />http://blog.wotrip.com/</span><span id="PagePrint" style="float:right; line-height:16px;">字号：<a href="javascript:setFontSize('18px');">大</a> <a href="javascript:setFontSize('14px');">中</a> <a href="javascript:setFontSize('12px');">小</a> <a href="javascript:print()">打印</a> <a href="javascript:close();">关闭</a></span>
	</div>
	<hr style="width:650px;" />
	<div id="title_div"><%=subject%></div>
  	<div id="author_div"><span id="author"><%=bp.getNickname(teasession._nLanguage)%></span><span id="time"><%=node.getTimeToString()%></span></div>
	<div id="content_div" style="width:640px; text-align:left;word-wrap:break-word;word-break:break-all;overflow:hidden;">


  <%if ((node.getOptions() & 0x40) == 0)out.print(tea.html.Text.toHTML(node.getText(teasession._nLanguage)));else out.print(node.getText(teasession._nLanguage));%>


        </div>
</div>

</body>
</html>

