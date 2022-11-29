<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="../css/css.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.CB1{BORDER-RIGHT: #9bb7cc 1px solid; BACKGROUND-POSITION: left center; BORDER-TOP: #9bb7cc 1px solid; PADDING-LEFT: 15px; BACKGROUND-IMAGE: url(img/edit_GoFinish.gif); MARGIN: 0px 3px 3px 0px; BORDER-LEFT: #9bb7cc 1px solid; LINE-HEIGHT: 12px; PADDING-TOP: 3px; BORDER-BOTTOM: #9bb7cc 1px solid; BACKGROUND-REPEAT: no-repeat; BACKGROUND-COLOR: white
}
-->

<!--
.fltext {
	color: #20208E;
}
-->
</style>
<script language="VBScript" src="../admin/normal.vbs"></script>
<script language="JavaScript" src="area.js"></script>
<SCRIPT LANGUAGE = JavaScript>
var s=["s1","s2","s3"];
var opt0 = ["省份","地级市","市、县级市、县"];
function setup()
{
	for(i=0;i<s.length-1;i++)
		document.getElementById(s[i]).onchange=new Function("change("+(i+1)+")");
	change(0);
}
//-->
</SCRIPT>

<script language="JavaScript" type="text/JavaScript">
<!--
function before_submit()
{
		if (document.form2.InType.value == '' && document.form2.PriceLow.value == '' && document.form2.PriceHigh.value == '')
			return false;
		if (document.form2.PriceLow.value != '')
		{
			if (isNaN(parseFloat(document.form2.PriceLow.value)))
			{
				alert("请输入一个数字!")
				document.form2.PriceLow.focus();
				return false;
			}
		}
		if (document.form2.PriceHigh.value != '')
		{
			if (isNaN(parseFloat(document.form2.PriceHigh.value)))
			{
				alert("请输入一个数字!")
				document.form2.PriceHigh.focus();
				return false;
			}
		}

		return true;
}

function On_Form3()
{for (i=0;i<document.form3.elements.length;i++)
		if (document.form3.elements[i].name.indexOf('_must')>=0 && document.form3.elements[i].value == "")
		{
			alert('请将带星号的内容全部填写完毕!');
			document.form3.elements[i].focus();
			return false;
		}
	if ((document.form3.s1.value=="省份")&&(document.form3.UserPro.value==""))
	{
		alert('请选择省份!');
		return false;
	}
	return true;
}

function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_showHideLayers() { //v6.0
  var i,p,v,obj,args=MM_showHideLayers.arguments;
  for (i=0; i<(args.length-2); i+=3) if ((obj=MM_findObj(args[i]))!=null) { v=args[i+2];
    if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v=='hide')?'hidden':v; }
    obj.visibility=v; }
}

function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}
//-->
</script>
</head>

<body topmargin="0" marginwidth="0" marginheight="0" onLoad="setup()">
<div align="center"><div align="center"><script language="javascript">
function headform_submit()
{
	if (document.headform.MbCode.value=='' || document.headform.MbPwd.value=='')
	{
		alert('请输入您的用户名和密码!');
		document.headform.MbCode.focus();
		return false;
	}
	return true;
}
</script>
<script language="JavaScript" type="text/JavaScript">

<!--
function open_win2(url2,title2,height2,width2)
{
	window.open(url2,title2,'height='+height2+',width='+width2+',left=250,top=150,resizable=no,scrollbars=no,toolbar=no,location=no,directories=no,status=no,menubar=no');
}
function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_showHideLayers() { //v6.0
  var i,p,v,obj,args=MM_showHideLayers.arguments;
  for (i=0; i<(args.length-2); i+=3) if ((obj=MM_findObj(args[i]))!=null) { v=args[i+2];
    if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v=='hide')?'hidden':v; }
    obj.visibility=v; }
}
//-->
</script><head>

<link href="../css/css.css" rel="stylesheet" type="text/css">
<link href="/admin/style.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
        <form name="form3" method="post" action="/servlet/EditOrders" onSubmit="javascript:return On_Form3();">

          <br>
          <TABLE class=lantable cellSpacing=1 cellPadding=2 width="601" border=0  >
            <TBODY>
              <TR bgColor=#f9f9f9>
                <TD class=font9 width="35%" height=2> <DIV align=center>用户名称：
                  </DIV></TD>
                <TD class=FontBlackBold width="65%" height=2><%=teasession._rv.toString()%></TD>
              </TR><%--
              <TR bgColor=#f9f9f9>
                <TD class=font9 height=26><div align="center">送货区域：</div></TD>
                <TD height=26><span class="huititable">
                  <input name="UserPro" type="text" id="UserPro" value="安徽省安庆市枞阳县" size="20">
                  <input name="MbNation" type="hidden" id="MbNation" value="安徽省">
                  <input name="MbCity" type="hidden" id="MbCity" value="安庆市">
                  <input name="MbZone" type="hidden" id="MbZone" value="枞阳县">
                  <input name="TotleInte" type="hidden" id="TotleInte" value="">
                  <br>
                  <select name="s1" id="s1">
                  </select>
                  <select name="s2" id="s2">
                  </select>
                  <select name="s3" id="s3">
                  </select>
                  <FONT
                        color=#ff0000>***</FONT> 不改时不选</span></TD>
              </TR>--%>
              <TR bgColor=#f9f9f9>
                <TD class=font9 width="35%" height=26> <DIV align=center>送货地址：</DIV></TD>
                <TD width="65%" height=26><INPUT class=tfbd
                        maxLength=100 size=35 name=SendAddr_must value="">
                  <FONT
                        color=#ff0000>***</FONT> </TD>
              </TR>
              <TR bgColor=#f9f9f9>
                <TD class=font9 height=26><div align="center">邮政编码：</div></TD>
                <TD height=26><INPUT name=SendPost_must class=tfbd id="SendPost_must" value="" size=35
                        maxLength=100>
                  <FONT
                        color=#ff0000>***</FONT> </TD>
              </TR>
              <TR bgColor=#f9f9f9>
                <TD class=font9 width="35%"> <DIV align=center>联系人：</DIV></TD>
                <TD width="65%"><INPUT class=tfbd maxLength=50 size=35
                        name=SendLink_must value=""> <FONT color=#ff0000>***</FONT>
                </TD>
              </TR>
              <TR bgColor=#f9f9f9>
                <TD width="35%" align="center" class=font9>联系电话：</TD>
                <TD width="65%"><INPUT class=tfbd maxLength=50 size=35 name=SendTel_must value="">
                  <FONT color=#ff0000>***</FONT></TD>
              </TR>
			  <TR bgColor=#f9f9f9>
                <TD class=font9 width="35%"> <DIV align=center>支付方式：</DIV></TD>
                <TD width="65%" class=FontBlackBold><select name="SendBType1" id="SendBType1">
                  <option value="货到付款" selected>货到付款</option>
				  <option value="上门收款">上门收款</option>
                  <option value="邮局汇款">邮局汇款</option>
                  <option value="银行汇款">银行汇款</option>
				  <option value="支票付款">支票付款</option>
                  <option value="在线支付">在线支付</option>
                                                </select>
                <FONT color=#ff0000>***　</FONT>(<a href="PaymentExplain.html" target="_blank">支付方式说明</a>)</TD>
              </TR>
			  <TR bgColor=#f9f9f9>
                <TD class=font9 width="35%"> <DIV align=center>缺货等待：</DIV></TD>
                <TD class=FontBlackBold width="65%"><select name="Waittime" id="Waittime">
                  <option value="0" selected>不等待</option>
                  <option value="3">等待3天</option>
                  <option value="7">等待一星期</option>
                  <option value="14">等待半个月</option>
                  <option value="30">等待一个月</option>
                                                </select>
                <FONT color=#ff0000>***</FONT> (部分缺货则取消订单的用户，请选择不等待）</TD>
              </TR>
              <TR bgColor=#f9f9f9>
                <TD class=font9 width="35%"> <DIV align=center>期望送货时间：</DIV></TD>
                <TD width="65%"><INPUT class=tfbd maxLength=50 size=35
                        name=SendTime> </TD>
              </TR>
              <TR bgColor=#f9f9f9>
                <TD align="center" class=font9>发票种类：</TD>
                <TD class=FontBlackBold><select name="SendBType" id="SendBType">
                    <option value="普通发票" selected>普通发票</option>
                    <option value="增值税发票">增值税发票</option>
                    <option value="不开票">不开票</option>
                  </select></TD>
              </TR>
              <TR bgColor=#f9f9f9>
                <TD class=font9 width="35%"> <DIV align=center>税号：</DIV></TD>
                <TD class=FontBlackBold width="65%"><INPUT class=tfbd
                        maxLength=50 size=35 name=SendTax value="">
                </TD>
              </TR>
              <TR bgColor=#f9f9f9>
                <TD class=font9 width="35%"> <DIV align=center>帐号：</DIV></TD>
                <TD class=FontBlackBold width="65%"><INPUT class=tfbd
                        maxLength=50 size=35 name=SendAcc value="">
                </TD>
              </TR>
              <TR bgColor=#f9f9f9>
                <TD class=font9 width="35%"> <DIV align=center>开票抬头：</DIV></TD>
                <TD class=FontBlackBold width="65%"><INPUT class=tfbd
                        maxLength=50 size=35 name=SendBill value="">
                </TD>
              </TR>
              <TR bgColor=#f9f9f9>
                <TD class=font9 width="35%"> <DIV align=center>开票地址：</DIV></TD>
                <TD class=FontBlackBold width="65%"><INPUT class=tfbd
                        maxLength=50 size=35 name=SendBAddr value="">
                </TD>
              </TR>

              <TR bgColor=#f9f9f9>
                <TD class=font9 vAlign=top width="35%"> <P align=center><br/>
                    其他要求：<br/>
                    (100字以内)</P></TD>
                <TD width="65%"><TEXTAREA name=SendRemark cols=35 rows=5 wrap="VIRTUAL" class=tfbd></TEXTAREA>
                </TD>
              </TR>
              <TR bgColor=#f9f9f9>
                <TD class=font9 vAlign=top><div align="center">电子邮箱：</div></TD>
                <TD><input name="SendMail" type="text" id="SendMail" value="xxxxxxxxx@163.com" size="35"></TD>
              </TR>
              <TR align=middle>
                <TD colSpan=2> <DIV align=center>
                    <input name="MbGetInt" type="hidden" id="MbGetInt" value="false">
                    <input name="MbUseInt" type="hidden" id="MbUseInt" value="0">
                    <input type="submit" name="edit" value="修改" class="CB1">
                    <IMG height=17 src="images/cancel.gif" width=60 border=0 style="cursor:hand" onClick="javascript:history.go(-1);">
                    <input name="HasFinished" type="hidden" id="HasFinished" value="true">
                    <input name="MbName" type="hidden" id="MbName" value="">
</DIV></TD>
              </TR>
              <TR align=middle>
                <TD colSpan=2><TABLE class=9p cellSpacing=6 cellPadding=3 width="100%"
                  align=left border=0>
                    <TBODY>
                      <TR bgColor=#ffffff>
                        <TD> <P><FONT color=#000000>注：1.带<FONT
                        color=#ff0000>***</FONT>的框为必填项。请用户正确填写以上表单，本网站在核对您的信息后会及时与您取得联系。</FONT>
                          <br><FONT color=#000000>&nbsp;&nbsp;&nbsp;&nbsp;2.联系人请使用中文名字，以便我们与您取得联系。</FONT></TD>
                      </TR>
                    </TBODY>
                  </TABLE></TD>
              </TR>
            </TBODY>
          </TABLE>
        </form>

</body>
</html>

