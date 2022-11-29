<%@page contentType="text/html;charset=UTF-8"%><%@page import="tea.ui.*" %>
<%
TeaSession teasession = new TeaSession(request);
if (teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode + "&nexturl=" + java.net.URLEncoder.encode(request.getRequestURI() + "?" + request.getQueryString(), "UTF-8"));
  return;
}

//https://testserver.zoosnet.net/

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<LINK href="/res/<%=teasession._strCommunity%>/cssjs/community.css" REL="stylesheet" TYPE="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<SCRIPT language=javascript src="/jsp/im/im.js"></SCRIPT>
</head>
<%--
<P class=sysfont id=firstp style="MARGIN-TOP: 30px; DISPLAY: none" align=center>正在呼叫在线客服人员，请稍候...<br/>
  <IMG src="imgs/loading.gif"></P>
<SCRIPT language=javascript><!--
var c0='您已退出对话,感谢您的垂询！';var c2='您已选择<b>%s1%</b>，请等待应答或总机为您转接..';var c3=unescape('%3cdiv%20style%3d%22margin-left%3a5px%3bcolor%3agreen%3b%22%3e%3cP%20style%3d%22FONT-SIZE%3a%209pt%3b%20FONT-FAMILY%3a%20Tahoma%22%3e%u6b22%u8fce%u5149%u4e34%u5927%u8fde%u5fe0%u4ed5%u8f6f%u4ef6%u6280%u672f%u6709%u9650%u516c%u53f8%uff01%3cBR%3e%u5982%u679c%u60a8%u5bf9%u6211%u4eec%u7684%u4ea7%u54c1%u6216%u8005%u670d%u52a1%u6709%u4efb%u4f55%u610f%u89c1%u6216%u8005%u5efa%u8bae%uff0c%u90fd%u53ef%u4ee5%u968f%u65f6%u4e0e%u6211%u4eec%u5728%u7ebf%u53d6%u5f97%u8054%u7cfb%uff01%u6211%u4eec%u7684%u5ba2%u670d%u4eba%u5458%u4f1a%u7ed9%u60a8%u8be6%u5c3d%u7ec6%u81f4%u7684%u89e3%u7b54%u3002%3c%2fP%3e%3c%2fdiv%3e%3cdiv%20id%3d%22servicekindlist%22%20style%3d%22margin-left%3a5px%3b%22%3e%3cfont%20style%3d%22color%3ared%3b%22%3e%u8bf7%u9009%u62e9%u4ee5%u4e0b%u90e8%u95e8%u6216%u670d%u52a1%u9879%u76ee%u5f00%u59cb%u5bf9%u8bdd%uff1a%3c%2ffont%3e%3cbr%3e%3ctable%20cellspacing%3d1%20cellpadding%3d1%20width%3d95%25%20border%3d0%20align%3dcenter%3e%3ctr%3e%3ctd%20style%3d%22margin-left%3a15px%22%3e%3ca%20href%3d%22%23%22%20onclick%3d%22return%20false%3b%22%20target%3d%22_self%22%3e%3cfont%20onclick%3dtestclick(1%2c%22%25u5e02%25u573a%25u90e8%22)%3b%3e%u5e02%u573a%u90e8%3cimg%20src%3d%22icon%2fonline.gif%22%20border%3d0%3e(%3cfont%20style%3d%22COLOR%3a%20red%22%3e%u5728%u7ebf%3c%2ffont%3e)%3c%2ffont%3e%3c%2fa%3e%3c%2ftd%3e%3ctd%20style%3d%22margin-left%3a15px%22%3e%3ca%20href%3d%22%23%22%20onclick%3d%22return%20false%3b%22%20target%3d%22_self%22%3e%3cfont%20onclick%3dtestclick(2%2c%22%25u6280%25u672f%25u90e8%22)%3b%3e%u6280%u672f%u90e8%3cimg%20src%3d%22icon%2fonline.gif%22%20border%3d0%3e(%3cfont%20style%3d%22COLOR%3a%20red%22%3e%u5728%u7ebf%3c%2ffont%3e)%3c%2ffont%3e%3c%2fa%3e%3c%2ftd%3e%3ctd%20style%3d%22margin-left%3a15px%22%3e%3ca%20href%3d%22%23%22%20onclick%3d%22return%20false%3b%22%20target%3d%22_self%22%3e%3cfont%20onclick%3dtestclick(3%2c%22%25u4ee3%25u7406%25u5546%25u670d%25u52a1%22)%3b%3e%u4ee3%u7406%u5546%u670d%u52a1%3cimg%20src%3d%22icon%2fonline.gif%22%20border%3d0%3e(%3cfont%20style%3d%22COLOR%3a%20red%22%3e%u5728%u7ebf%3c%2ffont%3e)%3c%2ffont%3e%3c%2fa%3e%3c%2ftd%3e%3c%2ftr%3e%3ctr%3e%3ctd%20style%3d%22margin-left%3a15px%22%3e%3ca%20href%3d%22%23%22%20onclick%3d%22return%20false%3b%22%20target%3d%22_self%22%3e%3cfont%20onclick%3dtestclick(4%2c%22%25u67e5%25u8be2%25u6c47%25u6b3e%22)%3b%3e%u67e5%u8be2%u6c47%u6b3e%3cimg%20src%3d%22icon%2fonline.gif%22%20border%3d0%3e(%3cfont%20style%3d%22COLOR%3a%20red%22%3e%u5728%u7ebf%3c%2ffont%3e)%3c%2ffont%3e%3c%2fa%3e%3c%2ftd%3e%3ctd%20style%3d%22margin-left%3a15px%22%3e%3ca%20href%3d%22%23%22%20onclick%3d%22return%20false%3b%22%20target%3d%22_self%22%3e%3cfont%20onclick%3dtestclick(5%2c%22%25u610f%25u89c1%25u548c%25u6295%25u8bc9%22)%3b%3e%u610f%u89c1%u548c%u6295%u8bc9%3cimg%20src%3d%22icon%2fonline.gif%22%20border%3d0%3e(%3cfont%20style%3d%22COLOR%3a%20red%22%3e%u5728%u7ebf%3c%2ffont%3e)%3c%2ffont%3e%3c%2fa%3e%3c%2ftd%3e%3ctd%20style%3d%22margin-left%3a15px%22%3e%3ca%20href%3d%22%23%22%20onclick%3d%22return%20false%3b%22%20target%3d%22_self%22%3e%3cfont%20onclick%3dtestclick(6%2c%22%25u8f6f%25u4ef6%25u54a8%25u8be2%22)%3b%3e%u8f6f%u4ef6%u54a8%u8be2%3cimg%20src%3d%22icon%2fonline.gif%22%20border%3d0%3e(%3cfont%20style%3d%22COLOR%3a%20red%22%3e%u5728%u7ebf%3c%2ffont%3e)%3c%2ffont%3e%3c%2fa%3e%3c%2ftd%3e%3c%2ftr%3e%3c%2ftable%3e%3c%2fdiv%3e%3cdiv%20style%3d%22margin-left%3a5px%3bcolor%3agreen%3b%22%3e%3cP%20style%3d%22FONT-SIZE%3a%209pt%3b%20FONT-FAMILY%3a%20Tahoma%22%3e%u5982%u679c%u5ea7%u5e2d%u5458%u5fd9%uff0c%u60a8%u5728%u8f83%u957f%u65f6%u95f4%u5185%u672a%u80fd%u83b7%u5f97%u5e94%u7b54%uff0c%u60a8%u4e5f%u53ef%u4ee5%u901a%u8fc7%u7535%u8bdd%u4e0e%u6211%u4eec%u8054%u7cfb%u3002%3cBR%3e%u7535%u8bdd%uff1a0411-88848971%2088848972%2088848973%2088848871%3cBR%3e%26nbsp%3b%26nbsp%3b%26nbsp%3b%26nbsp%3b%26nbsp%3b%26nbsp%3b%26nbsp%3b%26nbsp%3b%26nbsp%3b%26nbsp%3b%26nbsp%3b%26nbsp%3b%26nbsp%3b%26nbsp%3b%26nbsp%3b%26nbsp%3b%2088838730%2088838731%2088838732%2088848872%3cBR%3e%26nbsp%3b%26nbsp%3b%26nbsp%3b%26nbsp%3b%26nbsp%3b%26nbsp%3b%26nbsp%3b%26nbsp%3b%26nbsp%3b%26nbsp%3b%26nbsp%3b%26nbsp%3b%26nbsp%3b%26nbsp%3b%26nbsp%3b%26nbsp%3b%20%3cA%20href%3d%22http%3a%2f%2ftestserver.zoosnet.net%2fLR%2ffreetel.aspx%3fsiteid%3dLZA69557093%22%3e%u70b9%u51fb%u6b64%u5904%u53ef%u8fdb%u884c%u514d%u8d39%u7535%u8bdd%u63a5%u901a%3c%2fA%3e%3cBR%3e%u5168%u56fd%u514d%u8d39%u7535%u8bdd%3a800-915-1100%3c%2fP%3e%3c%2fdiv%3e');var c4='不能发送空讯息';var c5='没有在线的客服人员。';var c6='对话记录';var c7='此对话已结束。';var c8='您可以点击下面的按钮"保存"或"打印"保留本次对话记录';var c9='扩展名不正确！';var c10='Tahoma';var c11='<style type="text/css">body{margin: 0px; padding: 0px 0px 0px 0px; border: 0px;FONT-SIZE: 9pt; FONT-FAMILY: Tahoma;}td { font-family: Tahoma; font-size: 9pt; }p { margin-top:0px;margin-bottom:0px;FONT-SIZE: 9pt; FONT-FAMILY: Tahoma; }.sysfont{font-family: Tahoma; font-size: 9pt;color: Salmon;}.operatornamefont{FONT-SIZE: 9pt; FONT-FAMILY: Tahoma;color: Blue;}.operatorfont{FONT-SIZE: 12pt; FONT-FAMILY: Tahoma;color: Black;}.clientnamefont{FONT-SIZE: 9pt; FONT-FAMILY: Tahoma;color: Green;}.clientfont{FONT-SIZE: 12pt; FONT-FAMILY: Tahoma;color: Purple;}</style>';var c12='SKIN_iceblue';var c13='cn';var c14=17;var c15='<img src="SKIN_iceblue/3_cn.gif" usemap="#Map" border=0>';var c16='打印对话记录';var c17='保存对话记录';var c18='请选择文件！';var c19='选择表情';var c20='发送讯息';var c21='发送快捷键';var c22='正在发送讯息...';var c23='您';var c24='https://testserver.zoosnet.net/';var c25='69557093';var c26='上一条信息正在发送中,请稍候再试！';var c27='发送说明';var c28='发送文件';var c29='#000e66';var c30='';c30='<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="https://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=5,0,42,0" id="f1" width="125" height="300" VIEWASTEXT><param name="movie" value="https://testserver.zoosnet.net/lr/images/cn.swf"> <param name="bgcolor" value="#FFFFFF"><param name="quality" value="high"> <param name="allowscriptaccess" value="samedomain"> <embed type="application/x-shockwave-flash" pluginspage="https://www.macromedia.com/go/getflashplayer" width="125" height="300" name="f1" src="https://testserver.zoosnet.net/lr/images/cn.swf" bgcolor="#FFFFFF" quality="high" swLiveConnect="true" allowScriptAccess="samedomain" ></embed> </object>';var c31=0;var c32='';var c33='设置发送讯息快捷键';var c34='设置字体和样式';var c35='发送留言';var c36=1;var c37='文件类型:gif,jpg,zip,rar,doc,pdf,txt,xls,swf,ppt,cdr,ai,fla,限4兆';var c38=1;var c39=1;var c40='关闭';var c41='选择文件';var c42='文件说明';var c43='发送';var c44=1;var c45='正在等待您选择服务项目或等待客服总机转接...';var c46='LZA69557093';var c47='6335043782255187506759';var c48='6335043782255187506759';var c49='';c49='href="http://www.zoosnet.net/" target="_blank" alt="访问忠仕软件网站 http://www.zoosnet.net/"';var c50="http%3a%2f%2fwww.zoosnet.net%2findex.htm";var c51=escape("");var c52="%2525u6765%2525u81EA%2525u9996%2525u9875%2525u81EA%2525u52A8%2525u9080%2525u8BF7%2525u7684%2525u5BF9%2525u8BDD";var c53="";var c56=1;var c57=0;var c58='正在发送文件，请稍等...';var c59='取消';var c61='以上信息没有发送成功,请重新发送。';var c62='免费电话';var c63='屏幕截图';var c64='目前屏幕截图功只支持IE，请使用IE浏览器';var c65='打开截图';var c66='另存截图';var c67='发送截图失败';var c68='是否自动隐藏对话窗口，以截取对话窗口挡住的屏幕部分？';var c69=1;var c70='发送手机或小灵通短信';var c71='评价本次对话';var c72='非常满意|较好|一般|较差|恶劣';var c73=-1;var c75=1;var c76='您对本次对话的评价是';var c77='基本评价';var c78='详细描述';var c79='提交';var c80='取消';var c81='您还没有对本次对话作出评价';var c82=1;var c83='';var c84='';c84='<img src="'+c12+'/logo.gif"  width="125" height="72" border="0">';var c85='1';var duanxinurl='Duanxin.aspx?siteid='+c46+'&imgint='+c14+'&lng='+c13+'&cid='+c48+'&sid='+c47+'&p='+c50+'&e='+c52;var Telurl='FreeTel.aspx?siteid='+c46+'&imgint='+c14+'&lng='+c13+'&cid='+c48+'&sid='+c47+'&p='+c50+'&e='+c52;
//-->
</SCRIPT>
--%>

<DIV id=Pingjiaobj style="BORDER-RIGHT: #656f7b 1px solid; BORDER-TOP: #656f7b 1px solid; DISPLAY: none; Z-INDEX: 8999; LEFT: 10px; BORDER-LEFT: #656f7b 1px solid; WIDTH: 380px; BORDER-BOTTOM: #656f7b 1px solid; POSITION: absolute; TOP: 10px; HEIGHT: 240px; BACKGROUND-COLOR: #dde5fd">
  <TABLE id=Table_pingjia cellSpacing=5 cellPadding=0 align=center border=0>
    <TBODY>
      <TR>
        <TD height=25><B>您对本次对话的评价是</B></TD>
      </TR>
      <TR>
        <TD>基本评价</TD>
      </TR>
      <TR>
        <TD><INPUT id=pj0 type=radio CHECKED value=非常满意 name=pj>
          非常满意
          <INPUT id=pj1 type=radio value=较好 name=pj>
          较好
          <INPUT id=pj2 type=radio value=一般 name=pj>
          一般
          <INPUT id=pj3 type=radio value=较差 name=pj>
          较差
          <INPUT id=pj4 type=radio value=恶劣 name=pj>
          恶劣</TD>
      </TR>
      <TR>
        <TD vAlign=bottom height=25>详细描述</TD>
      </TR>
      <TR>
        <TD><TEXTAREA id=note style="BORDER-RIGHT: navy 1px solid; BORDER-TOP: navy 1px solid; FONT-SIZE: 12pt; BORDER-LEFT: navy 1px solid; WIDTH: 100%; BORDER-BOTTOM: navy 1px solid; HEIGHT: 75px" name=note rows=8 cols=42></TEXTAREA></TD>
      </TR>
      <TR>
        <TD height=5></TD>
      </TR>
      <TR>
        <TD id=td_19 align=middle><A onclick="return pingjia1()" href="#">提交</A> <A style="MARGIN-LEFT: 20px" onclick="return HidePingjiaobj();" href="#">取消</A> </TD>
      </TR>
    </TBODY>
  </TABLE>
</DIV>

<form name="form1" action="/servlet/EditImMessage" method="POST">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<textarea name="content" style="display:none"></textarea>

<TABLE id=table_01 style="HEIGHT: 455px" height=455 cellSpacing=0 cellPadding=0 width=630 align=center border=0>
  <TBODY>
    <TR>
      <TD vAlign=top width=9><TABLE id=table_03 style="HEIGHT: 455px" height="100%" cellSpacing=0 cellPadding=0 width=9 border=0>
          <TBODY>
            <TR>
              <TD id=td_02 style="BACKGROUND: url(/tea/image/im/4.gif)" height=48></TD>
            </TR>
            <TR>
              <TD id=td_05 style="BACKGROUND: url(/tea/image/im/5.gif)"></TD>
            </TR>
            <TR>
              <TD id=td_03 style="BACKGROUND: url(/tea/image/im/6.gif)" height=24></TD>
            </TR>
          </TBODY>
        </TABLE></TD>
      <TD id=td_main vAlign=top width=482><TABLE id=table_04 style="HEIGHT: 455px" cellSpacing=0 cellPadding=0 width=482 border=0>
          <TBODY>
            <TR>
              <TD><TABLE id=table_records style="HEIGHT: 343px" cellSpacing=0 cellPadding=0 width=482 border=0>
                  <TBODY>
                    <TR>
                      <TD id=td_08 style="BACKGROUND: url(/tea/image/im/7.gif)" vAlign=center><TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
                          <TBODY>
                            <TR>
                              <TD height=7></TD>
                            </TR>
                            <TR>
                              <TD id=td_prompt1 style="FONT-SIZE: 9pt; COLOR: #000e66; FONT-FAMILY: Tahoma"></TD>
                            </TR>
                          </TBODY>
                        </TABLE></TD>
                      <TD id=td_04 style="BACKGROUND: url(/tea/image/im/8.gif)" width=10 height=48>&nbsp;</TD>
                    </TR>
                    <TR>
                      <TD><div id="history"></div></TD>
                      <TD id=td_switchcontent style="BACKGROUND: url(/tea/image/im/9.gif)" vAlign=center align=right><A href="###"><IMG src="/tea/image/im/13-1.gif" swap="/tea/image/im/13-2.gif" onclick="im_left(this);" border=0></A></TD>
                    </TR>
                    <TR id=uploadobj style="DISPLAY: none" height=72>
                      <TD><IFRAME id=uploadFrame style="BORDER-TOP-STYLE: none; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; HEIGHT: 72px; BORDER-BOTTOM-STYLE: none" name=uploadFrame src="im.jsp" frameBorder=0 width=472 height=72></IFRAME></TD>
                      <TD id=td_06 style="BACKGROUND: url(/tea/image/im/9.gif)">&nbsp;</TD>
                    </TR>
                    <TR id=uploadobj1 style="DISPLAY: none" height=31>
                      <TD><TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
                          <TBODY>
                            <TR>
                              <TD>正在发送文件，请稍等...</TD>
                              <TD id=progressPmt align=middle></TD>
                              <TD align=right><A onclick="f31(false);return false;" href="#">取消</A>&nbsp;&nbsp;</TD>
                            </TR>
                          </TBODY>
                        </TABLE>
                        <DIV style="BORDER-RIGHT: #006000 1px solid; PADDING-RIGHT: 1px; BORDER-TOP: #006000 1px solid; PADDING-LEFT: 1px; FONT-SIZE: 1px; MARGIN-BOTTOM: 1px; PADDING-BOTTOM: 1px; MARGIN-LEFT: 3px; BORDER-LEFT: #006000 1px solid; WIDTH: 100%; MARGIN-RIGHT: 3px; PADDING-TOP: 1px; BORDER-BOTTOM: #006000 1px solid; HEIGHT: 15px">
                          <DIV id=progressBar style="WIDTH: 0%; HEIGHT: 100%; BACKGROUND-COLOR: #00a000" align=center></DIV>
                        </DIV></TD>
                      <TD id=td_061 style="BACKGROUND: url(/tea/image/im/9.gif)">&nbsp;</TD>
                    </TR>
                    <TR>
                      <TD id=toolbar_td style="BACKGROUND: url(/tea/image/im/10.gif)" vAlign=bottom align=left height=27><TABLE height=25 cellSpacing=0 cellPadding=0 border=0>
                          <TBODY>
                            <TR>
                              <TD>&nbsp;<A title=选择表情 onclick="im_open('SelSmile.jsp',248,170);" href="###"><IMG src="/tea/image/im/smile_cn.gif" border=0></A></TD>
                              <TD width=10></TD>
                              <TD><A title=设置字体和样式 onclick="im_open('SetFont.jsp',380,280);" href="###"><IMG src="/tea/image/im/font_cn.gif" border=0></A></TD>
                              <TD width=10></TD>
                              <%--
                              <TD><A title=发送文件 href="###"><IMG src="/tea/image/im/file_cn.gif" border=0  style="position:absolute"><input type="file" name=file0 style="position:absolute;width:10;cursor:hand;filter:Alpha(opacity=0)" onchange="f_click(this)"/></A>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
                              <TD width=10></TD>
                              <TD><A title=免费电话 href="file:///C:/Documents%20and%20Settings/Administrator/桌面/LR/FreeTel.aspx?siteid=LZA69557093&amp;imgint=17&amp;lng=cn&amp;cid=6335043782255187506759&amp;sid=6335043782255187506759&amp;p=http%3a%2f%2fwww.zoosnet.net%2findex.htm&amp;e=%2525u6765%2525u81EA%2525u9996%2525u9875%2525u81EA%2525u52A8%2525u9080%2525u8BF7%2525u7684%2525u5BF9%2525u8BDD" target=_blank><IMG src="/tea/image/im/freecall_cn.gif" border=0></A></TD>
                              <TD width=10></TD>
                              <TD><A title=发送留言 href="file:///C:/Documents%20and%20Settings/Administrator/桌面/LR/SendNote2.aspx?siteid=LZA69557093&amp;imgint=17&amp;lng=cn&amp;cid=6335043782255187506759&amp;p=http%3a%2f%2fwww.zoosnet.net%2findex.htm&amp;e=%2525u6765%2525u81EA%2525u9996%2525u9875%2525u81EA%2525u52A8%2525u9080%2525u8BF7%2525u7684%2525u5BF9%2525u8BDD" target=_blank><IMG src="/tea/image/im/note_cn.gif" border=0></A></TD>
                              <TD width=10></TD>
                              <TD><A title=发送手机或小灵通短信 href="file:///C:/Documents%20and%20Settings/Administrator/桌面/LR/Duanxin.aspx?siteid=LZA69557093&amp;imgint=17&amp;lng=cn&amp;cid=6335043782255187506759&amp;sid=6335043782255187506759&amp;p=http%3a%2f%2fwww.zoosnet.net%2findex.htm&amp;e=%2525u6765%2525u81EA%2525u9996%2525u9875%2525u81EA%2525u52A8%2525u9080%2525u8BF7%2525u7684%2525u5BF9%2525u8BDD" target=_blank><IMG src="/tea/image/im/dx_cn.gif" border=0></A></TD>
                              <TD width=10></TD>
                              <TD><A title=屏幕截图 onclick="Capture();return false;" href="###"><IMG src="/tea/image/im/Capture_cn.gif" border=0></A></TD>
                              <TD width=10></TD>
                              <TD><IMG alt="SSL 128 bit" src="/tea/image/im/secure.gif"></TD>
                              <TD width=10></TD>
                              <TD><A title=评价本次对话 onclick="pingjia();return false;" href="###"><IMG src="/tea/image/im/valuation_cn.gif" border=0></A></TD>
                              <TD width=10></TD>
                              --%>
                              <TD><A title=保存对话记录 onclick="im_save();" href="###"><IMG src="/tea/image/im/save_cn.gif" border=0></A></TD>
                              <TD width=10></TD>
                            </TR>
                          </TBODY>
                        </TABLE></TD>
                      <TD id=td_07 style="BACKGROUND: url(/tea/image/im/11.gif)">&nbsp;</TD>
                    </TR>
                  </TBODY>
                </TABLE></TD>
            </TR>
            <TR>
              <TD><TABLE id=table_input style="BACKGROUND: url(/tea/image/im/12.gif)" cellSpacing=0 cellPadding=0 width="100%" border=0>
                  <TBODY>
                    <TR>
                      <TD height=88><IFRAME id=FreeTextBox1_editor style="BORDER-TOP-STYLE: none; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BORDER-BOTTOM-STYLE: none" name=FreeTextBox1_editor src="about:blank" frameBorder=0 width=380 height=80></IFRAME></TD>
                      <TD id=td_send width=102 rowSpan=2><IMG id=Image1 src="/tea/image/im/13a_cn.gif" useMap=#Image1Map border=0 name=Image1 oSrc="/tea/image/im/13c_cn.gif"></TD>
                    </TR>
                    <TR>
                      <TD id=td_prompt2 style="FONT-SIZE: 9pt; COLOR: #000e66; FONT-FAMILY: Tahoma" height=24></TD>
                    </TR>
                  </TBODY>
                </TABLE></TD>
            </TR>
          </TBODY>
        </TABLE>
      </TD>
      <TD id=LeftContent vAlign=top width=139>
        <TABLE id=table_02 style="HEIGHT: 455px" cellSpacing=0 cellPadding=0 width=139 border=0>
          <TBODY>
            <TR>
              <TD id=td_x1 style="BACKGROUND: url(/tea/image/im/x1.gif)" colSpan=3 height=13></TD>
            </TR>
            <TR>
              <TD id=td_x2 style="BACKGROUND: url(/tea/image/im/x2.gif)" width=7></TD>
              <TD id=td_logo width=125 height=72><IMG height=72 src="/tea/image/im/logo.gif" width=125 border=0></TD>
              <TD id=td_x3 style="BACKGROUND: url(/tea/image/im/x3.gif)" width=7></TD>
            </TR>
            <TR>
              <TD id=td_x4 style="BACKGROUND: url(/tea/image/im/x4.gif)" colSpan=3 height=9></TD>
            </TR>
            <TR>
              <TD id=td_x5 style="BACKGROUND: url(/tea/image/im/x5.gif)" width=7></TD>
              <TD id=td_leftcontent vAlign=top width=125>
              <input name="tmember" type="radio" value="" checked />所有人
              </TD>
              <TD id=td_x6 style="BACKGROUND: url(/tea/image/im/x6.gif)" width=7></TD>
            </TR>
            <TR>
              <TD id=td_copyright colSpan=3 height=57><IMG src="/tea/image/im/3_cn.gif" useMap=#Map border=0></TD>
            </TR>
          </TBODY>
        </TABLE>
         </TD>
    </TR>
  </TBODY>
</TABLE>
</form>
<MAP name=Image1Map>
  <AREA onmouseover="im_swap('Image1','/tea/image/im/13b_cn.gif')" onclick=""; onmouseout="im_swap('Image1','/tea/image/im/13a_cn.gif')" shape=POLY alt=设置发送讯息快捷键 coords=57,106,98,67,97,107>
  <AREA onmouseover="im_swap('Image1','/tea/image/im/13c_cn.gif')" onclick="im_refresh(true);" onmouseout="im_swap('Image1','/tea/image/im/13a_cn.gif')" shape=CIRCLE alt=发送讯息 coords="49,44,44" accesskey="S">
</MAP>


<script>
var FreeTextBox1_editor=document.getElementById("FreeTextBox1_editor");
var editor=FreeTextBox1_editor.contentWindow.document;//
editor.designMode="on";
editor.write('<html><head><style type=\'text/css\'> body{margin: 0px; padding: 0px 0px 2px 5px; FONT-SIZE: 9pt; FONT-FAMILY: Tahoma;}p { margin-top:0px;margin-bottom:0px;FONT-SIZE: 9pt; FONT-FAMILY: Tahoma;}</style></head><body></body></html>');
//editor.contentEditable = true;
editor.focus();
//editor.designMode="off";
im_load();
</script>
