<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
java.util.Enumeration enumeration=Orders.findByMember(teasession._rv.toString());
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="../css/css.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="/admin/style.css" type="text/css">
<style type="text/css">
<!--
.fltext {
	color: #20208E;
}
.nr-18line-z {
	font-family: "Verdana", "Arial", "Helvetica", "sans-serif";
	font-size: 12px;
	line-height: 20px;
	color: 20208E;
}
-->
</style>
<script language="VBScript" src="../admin/normal.vbs"></script>
<script language="JavaScript" type="text/JavaScript">
<!--
function before_submit()
{
	for (i=0;i<document.form1.elements.length;i++)
		if (document.form1.elements[i].name.indexOf('_must')>=0 && document.form1.elements[i].value == "")
		{
			alert('请将带星号的内容全部填写完毕!');
			document.form1.elements[i].select();
			return false;
		}
	var regstr = /^\w(\w*\.*)*@(\w+\.)+\w{2,3}$/;
	if (!regstr.test(document.form1.MbEmail_must.value))
	{
		alert('Email格式不正确!');
		document.form1.MbEmail_must.select();
		return false;
	}
	if (IfTooBig(document.form1.MbBrief.value,500))
	{
		alert('简介过长，请限制在200字以内!');
		document.form1.MbBrief.select();
		return false;
	}
	return ;
}
function gotopage(page)
{
	pageform.action = 'chaxun.asp?page='+page;
	pageform.submit();
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
//-->
</script>
</head>
<body topmargin="0" marginwidth="0" marginheight="0">
<div align="center"><script language="javascript">
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
</style></head>


<div align="center">
</div>
<table width="770" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><iframe src="http://www.5irose.com/top.asp" name="top" id="top" scrolling="no" width="770" height="72" marginwidth="0" marginheight="0" frameborder="0" align="default"></iframe></td>
  </tr>
</table>
<table width="770" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#990000">
  <tr>
    <td height="4"></td>
  </tr>
</table>
<table width="770" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="673" align="right" valign="bottom" ><table width="770" border="0" align="right" cellpadding="0" cellspacing="0">
        <tr>
          <!--<td width="226" rowspan="3" ><a href="../index.asp"><img src="../images/sy.gif"  border="0"></a></td>-->
          <td colspan="6" align="right" class=p ><img src="img/gwd_t_top.jpg" ></td>
          <td align="right" class=p ><a href="../member" class="9p" >会员登录</a>
            <font color="#008000">/</font> <a href="../member/chaxun.asp" class="9p">订单查询</a>
            <font color="#008000">/</font> <a href="../member/favo_list.asp" class="9p">我的收藏</a>
            <font color="#008000">/</font> <a href="../member/index.asp" class="9p">我的账号</a>
            <font color="#008000">/</font>  <a href="../member/car_list.asp" class="9p">购物车</a></td>
        </tr>
        <tr>
          <td colspan="7" valign="bottom"  style="border-top:1px #FAE8B1 solid;"><div align="left"></div>
            <table width="210"  border="0" align="right" cellpadding="0" cellspacing="0">
              <form name="form2" method="post" action="../shop/search.asp?ProID=">
                <tr >
                  <td  ><input name="Key" type="text" class="form" size="20" value=""></td>
                  <td  align="right" ><INPUT type="hidden" value="2" name="image">
                    <input name="image" style="border-width:0px" type="image" src="../shop/img/search.gif" align="right"></td>
                </tr>
              </form>
            </table></td>
        </tr>
      </table></td>
  </tr>
</table>
<table width="770" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="3"><img src="" height=2 border=0></td>
  </tr>
</table>

<table width="761" height="0" border="0" align="center" cellpadding="0" cellspacing="0" ><tr><td>
<div  style="position:relative;left:0;top=0;height:0 ;z-index=-2" >
          <div  style="position:absolute;left: 0px; top: -21px;height:0 ;z-index=-2"">
            <table width="600" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="160"></td>
                <td width=440 class=9phui> <a href="../index.asp" class=9phui>首页</a>
                  &gt; 订单查询</td>
              </tr>
            </table>
          </div>
        </div></table>

  <table width="761" border="0" cellspacing="0" cellpadding="0">
    <tr>


      <td colspan="2" valign="top" >
        <table width="137" border="1" cellpadding="0" cellspacing="0" bordercolor="#B90909">
          <tr>
            <td height="22" bgcolor="#B90909" class="9pbai1"><div align="left"><strong>　　　会员专区</strong></div></td>
          </tr>
          <tr>
            <td align="right"><script language=javascript>
function exit()
{
if(!confirm('确认退出？'))
return;
url ="/member/quit.asp"
window.location.href =url
}
</script>
<table width="150" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="7" colspan="2"></td>
  </tr>
  <tr>
    <td width="53" height="20" align="right" class="nr-18line"> <font color="#FFFFFF"><img src="../images/arrow_1.gif" width="10" height="10">&nbsp;</font></td>
    <td width="97" class="nr-18line"><a href="/member/index.asp"><font color="B90909">会员信息</font></a></td>
  </tr>
  <tr>
    <td height="20" align="right" class="nr-18line"><font color="#FFFFFF"><img src="../images/arrow_1.gif" width="10" height="10">&nbsp;</font></td>
    <td height="20" class="nr-18line"><a href="/member/password.asp"><font color="B90909">密码修改</font></a></td>
  </tr>
  <tr>
    <td height="20" align="right" class="nr-18line"><font color="#FFFFFF"><img src="../images/arrow_1.gif" width="10" height="10">&nbsp;</font></td>
    <td height="20" class="nr-18line"><a href="/index.asp"><font color="B90909">我要购物</font></a></td>
  </tr>
  <tr>
    <td height="20" align="right" class="nr-18line"><font color="#FFFFFF"><img src="../images/arrow_1.gif" width="10" height="10">&nbsp;</font></td>
    <td height="20" class="nr-18line"><a href="/member/car_list.asp"><font color="B90909">购物车</font></a></td>
  </tr>
  <tr>
    <td height="20" align="right" class="nr-18line"><font color="#FFFFFF"><img src="../images/arrow_1.gif" width="10" height="10">&nbsp;
      </font></td>
    <td height="20" class="nr-18line"><a href="/member/chaxun.asp"><font color="B90909">订单查询</font></a></td>
  </tr>
  <tr>
    <td height="20" align="right" class="nr-18line"><font color="#FFFFFF"><img src="../images/arrow_1.gif" width="10" height="10">&nbsp;</font></td>
    <td height="20" class="nr-18line"><a href="/member/chaozuo.asp"><font color="B90909">订单操作</font></a></td>
  </tr>
  <tr>
    <td height="20" align="right" class="nr-18line"><font color="#FFFFFF"><img src="../images/arrow_1.gif" width="10" height="10">&nbsp;</font></td>
    <td height="20" class="nr-18line"><a href="/member/buy_list.asp"><font color="B90909">购买记录</font></a></td>
  </tr>
  <tr>
    <td height="20" align="right" class="nr-18line"><font color="#FFFFFF"><img src="../images/arrow_1.gif" width="10" height="10">&nbsp;</font></td>
    <td height="20" class="nr-18line"><a href="/member/favo_list.asp"><font color="B90909">我的收藏</font></a></td>
  </tr>
  <tr>
    <td height="10" align="right"><font color="#FFFFFF"><span class="nr-18line"><img src="../images/arrow_1.gif" width="10" height="10">&nbsp;</span></font></td>
    <td height="10"><span class="nr-18line"><a href="javascript:exit();"><font color="B90909">退出登录</font></a></span></td>
  </tr>
</table>
</td>
          </tr>
        </table>
        <p align="center">&nbsp; </p></td>
      <td width="601" align="center" valign="top">
		<form name="form1" method="post" action="reg2.asp?action=edit" onSubmit="javascript:return before_submit();">
          <table width="601" border="0" cellspacing="0" cellpadding="0" >
            <tr>
              <td><table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
                  <tr>
                    <td ><table width="100%" border="0" cellspacing="0" cellpadding="0" class=huiditable>
                      <tr>
                       <td height="24" align="center" bgcolor="#B90909" class="9pbai1" style="border: 1 solid #FFFFFF;">订单号</td>
                        <td align="center" bgcolor="#B90909" class="9pbai1"  style="border: 1 solid #FFFFFF;">订单状态</td>
                        <td align="center" bgcolor="#B90909" class="9pbai1"  style="border: 1 solid #FFFFFF;">下单时间</td>
                        </tr>
                      <%
                      while(enumeration.hasMoreElements())
                      {
                    Date time=(Date)enumeration.nextElement();
//                    Orders order=Orders.find(teasession._rv.toString(),time);
                      %>
                      <tr>
                        <td align="center" style="border-bottom: 1 solid #EEEEEE"><a href="order.asp?OrdNum=20050317091837437" ><%=time.getTime()%></a></td>
                        <td align="center" style="border-bottom: 1 solid #EEEEEE">
                          <span class="huititable">
                          失效订单
                          </span>                        </td>
                        <td style="border-bottom: 1 solid #EEEEEE"><div align="center"><%=new java.text.SimpleDateFormat("yyyy-MM-dd").format(time)%></div></td>
					    </tr>
                      <%}%>
                    </table></td>
                  </tr>
                </table></td>
            </tr>
          </table>
          </form><br>
        <form name="pageform" method="post" action="">
          <table width="500" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td align="right"></td>
            </tr>
          </table>
        </form>
        </td>

    </tr>
  </table><table width="761" height="100" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td bgcolor="B90909"> <table width="770"  border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td bgcolor="#960101" width="209" height="5"><img src="" width=1 height=1></td>
          <td bgcolor="#960101" width="5"  ><img src="" width=1 height=1></td>
          <td bgcolor="#960101" width="345"><img src="" width=1 height=1></td>
          <td bgcolor="#960101" width="5"  ><img src="" width=1 height=1></td>
          <td width=4 bgcolor=#960101></td>
          <td bgcolor="#960101" width="197"><img src="" width=1 height=1></td>
          <td width=5 bgcolor=#960101></td>
        </tr>
      </table>
      <div align="center"> </div>
      <table width="770" height="36" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td><TABLE cellSpacing=0 cellPadding=0 width=770 align=center border=0>
              <TBODY>
                <TR>
                  <TD align=middle width=108 bgColor=B90909 height=32><a href="/other/5irose/2-gywm-gsjj.htm" target="_parent"><font color="#FFFFFF">关于我们</font></a></TD>
                  <TD width=1><IMG height=32 src="../img/index_153.gif"
      width=1></TD>
                  <TD align=middle width=108 bgColor=B90909><a href="/other/5irose/2-fkfs.htm" target="_parent"><font color="#FFFFFF">购物须知</font></a></TD>
                  <TD width=1><IMG height=32 src="../img/index_153.gif"
      width=1></TD>
                  <TD align=middle width=108 bgColor=B90909><a href="/other/5irose/2-sczs-xmbj.htm" target="_parent"><font color="#FFFFFF">商城招商</font></a></TD>
                  <TD width=1><IMG height=32 src="../img/index_153.gif"
      width=1></TD>
                  <TD align=middle width=108 bgColor=B90909><a href="/other/5irose/2-ggfu-ggfu.htm" target="_parent"><font color="#FFFFFF">广告服务</font></a></TD>
                  <TD width=1><IMG height=32 src="../img/index_153.gif"
      width=1></TD>
                  <TD align=middle width=108 bgColor=B90909><a href="/other/5irose/2-cpyc-cpyc.htm" target="_parent"><font color="#FFFFFF">诚聘英才</font></a></TD>
                  <TD width=1><IMG height=32 src="../img/index_153.gif"
      width=1></TD>
                  <TD align=middle width=108 bgColor=B90909><a href="mailto:service@5irose.com"><font color="#FFFFFF">客户投诉</font></a></TD>
                  <TD width=1><IMG height=32 src="../img/index_153.gif"
      width=1></TD>
                  <TD align=middle width=107 bgColor=B90909><a href="/other/5irose/2-lxwm-lxwm.htm" target="_parent"><font color="#FFFFFF">联系我们</font></a></TD>
                </TR>
              </TBODY>
            </TABLE></td>
        </tr>
      </table>
      <TABLE class=table-zuoyou cellSpacing=0 cellPadding=0 width=770 align=center
border=0>
        <TBODY>
          <TR>
            <TD width="100%"
    background=../img/bg_foor.gif
    colSpan=2 height=2></TD>
          </TR>
        </TBODY>
      </TABLE>
      <table width="770" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height="4"></td>
        </tr>
      </table>
      <table width="770" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height="4" align="center"><font color="#FFFFFF">Copyright &copy; 2005</font> <a href="http://www.5irose.com"><font color="#FFFFFF">5irose.com</font></a>
            <font color="#FFFFFF">Inc. All rights reserved. 玫瑰坊网络商城 版权所有</font></td>
        </tr>
      </table>
      <TABLE width="692" border=0 align=center cellPadding=4 cellSpacing=0>
        <TBODY>
          <TR>
            <TD width="48" rowspan="2" vAlign=top></TD>
            <TD colspan="2" align=right style="LINE-HEIGHT: 22px"><font color="#FFFFFF">热线电话：
              010-84905300</font> <br/> </TD>
            <TD width="299" align=left style="LINE-HEIGHT: 22px"><a class=blue
      href="mailto:webmaster@5irose.com"><font color="#FFFFFF"
      class=ui_engl> E-mail：webmaster@5irose.com</font></a></TD>
            <TD width="57" rowspan="2" align="right"><IMG SRC="/images/gongshang.gif" width="40" height="48"
      border=0 align=absMiddle></TD>
          </TR>
          <TR>
            <TD width="130" align=right style="LINE-HEIGHT: 22px">&nbsp;</TD>
            <TD width="171" align=right style="LINE-HEIGHT: 22px"><font color="#FFFFFF">800-890-7989</font>
              <br/> </TD>
            <TD align=left style="LINE-HEIGHT: 22px"><a href="/icp.htm" target="_blank">
              <font color="#FFFFFF">京ICP证 041045号</font></a></TD>
          </TR>
        </TBODY>
      </TABLE></td>
  </tr>
</table>
</div>
</body>
</html>

