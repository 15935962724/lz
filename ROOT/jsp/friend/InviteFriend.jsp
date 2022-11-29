<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%

if(request.getMethod().equals("POST"))
{
  String mail[]=request.getParameterValues("mail");
  tea.entity.site.Community community=tea.entity.site.Community.find(teasession._strCommunity);
  String web=community.getWebName();
  String webn=community.getName(teasession._nLanguage);
  String conent=request.getParameter("MailContent");
  String str=request.getParameter("MailTitle");
  for(int index=0;index<mail.length;index++)
  {
    if(mail[index].length()>0)
    {
      int k = tea.entity.member.Message.create(teasession._strCommunity,null, community.getEmail(), 0, 0, 2, 0, teasession._nLanguage, str, conent,null,null,"",null,mail[index],null,null, null, null, 0, 0);
      try
      {
        tea.service.Robot.activateRoboty(teasession._nNode,k);
      } catch (Exception _ex)
      {}
    }
  }
  out.print("<script>alert('发送完毕');</script>");
  return ;
}
%>
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
  function submitpre(form)
  {

    bool=false;
    for(index=0;index<    form.mail.length;index++)
    {
      if(  form.mail[index].value.lengTD>0)
      {
        if(!submitEmail( form.mail[index],'<%=r.getString(teasession._nLanguage, "InvalidEmailAddress")%>'))
        return false;
        bool=true;
      }
    }
    if(!bool)
    {    alert('最少填写一个E-Mail');
    form.mail[0].focus();
    return false;
  }else
if(!  submitText(form.MailTitle, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>'))
return false;
else
return true;
}

  </script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "CBNewFriend")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<form name="Form1" method="post" action="" id="Form1" onSubmit="return submitpre(this)">
  <script language="javascript">
<!--
	function __doPostBack(eventTarget, eventArgument) {
		var theform;
		if (window.navigator.appName.toLowerCase().indexOf("netscape") > -1) {
			theform = document.forms["Form1"];
		}
		else {
			theform = document.Form1;
		}
		theform.__EVENTTARGET.value = eventTarget.split("$").join(":");
		theform.__EVENTARGUMENT.value = eventArgument;
		theform.submit();
	}
// -->
</script>
  <FONT face="宋体"> <FONT face="宋体"></FONT>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
                <TR>
                  <TD vAlign="top" ><table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
                      <TR>
                        <TD><div class="bluefont">通过 <span id="FriendCount" class="redfont">0</span>位朋友，您拥有 <span id="FriendNetWork" class="redfont">0</span>位朋友。<br/>
                            直接朋友: <span id="FriCount1" class="redfont">0</span>位<br/>
                            二级朋友: <span id="FriCount2" class="redfont">0</span>位<br/>
                            三级朋友: <span id="FriCount3" class="redfont">0</span>位</div></TD>
                      </TR>
                      <TR>
                        <TD><div class="bluefont">邀请那些你现实生活中信赖的朋友加入你的好友列表，你会看到你的人际网络以令你惊喜地速度扩展，这些朋友将是你在HeiYou可以得到的最大财富！</div></TD>
                      </TR>
                      <TR>
                        <TD><div class="bluefont">有 <span id="InviteSuc" class="redfont">0</span>位 朋友接受了你的邀请 <a id="HyperLink1" href="/Mail/SendInviteEvent.aspx">查看发出的邀请</a><br/>
                            您还有 <span id="Inviteuc" class="redfont">0</span>个未响应的邀请 <a id="HyperLink2" href="/Mail/ReceiveInviteEvent.aspx">查看收到的邀请</a></div></TD>
                      </TR>
                    </TABLE></TD>
                  <TD vAlign="top"><table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
                      <TR>
                        <TD><span id="TopMsg" class="bluefont">您可以直接告诉您的朋友来注册，在注册页介绍人里填入你的Email: ffffffffffff@163.com 即可</span></TD>
                      </TR>
                    </TABLE>
                 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
                      <TR>
                        <TD align="center"><IMG src="../images/button_to_right.gif" width="21" height="21"></TD>
                        <TD align="left"><span class="bluefont">你可以通过粘贴此链接到MSN或QQ邀请您的朋友</span></TD>
                      </TR>
                      <TR>
                        <TD style="PADDING-RIGHT: 5px; PADDING-LEFT: 5px; PADDING-BOTTOM: 5px; PADDING-TOP: 5px" align="left" colSpan="2"><input name="textInviteLink" type="text" value="http://www.heiyou.com/regist.aspx?InviteKey=07c6bcb9-b4b8-475e-8ee2-a51cb72dd786" size="100" id="textInviteLink" class="msninput" /></TD>
                      </TR>
                    </TABLE>
              <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
                      <tr>
                        <td colSpan="4"><table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
                            <TR>
                              <TD align="left"><IMG src="../images/button_to_right.gif" width="21" height="21"></TD>
                              <TD>邀请站外的朋友(请输入朋友的Email) </TD>
                            </TR>
                          </TABLE></td>
                      </tr>
                      <TR>
                        <TD align="center"><input name="mail" type="text" size="30" id="Mail1" class="msninput" />
                          <span id="Msg1" class="redfont"></span></TD>
                        <TD align="center"><input name="mail" type="text" size="30" id="Mail4" class="msninput" />
                          <span id="Msg4" class="redfont"></span></TD>
                      </TR>
                      <TR>
                        <TD align="center"><input name="mail" type="text" size="30" id="Mail2" class="msninput" />
                          <span id="Msg2" class="redfont"></span></TD>
                        <TD align="center"><input name="mail" type="text" size="30" id="Mail5" class="msninput" />
                          <span id="Msg5" class="redfont"></span></TD>
                      </TR>
                      <TR>
                        <TD align="center"><input name="mail" type="text" size="30" id="Mail3" class="msninput" />
                          <span id="Msg3" class="redfont"></span></TD>
                        <TD align="center"><input name="mail" type="text" size="30" id="Mail6" class="msninput" />
                          <span id="Msg6" class="redfont"></span></TD>
                      </TR>
                    </TABLE>
                  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
                      <TR>
                        <TD><table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
                            <TR>
                              <TD>Email主题:</TD>
                              <TD><input name="MailTitle" type="text" value="aaaaaaaaaaaaaaaaaa邀请您加入HeiYou" size="40" id="MailTitle" class="msnInput" /></TD>
                            </TR>
                          </TABLE></TD>
                      </TR>
                      <TR>
                        <TD><div id="type3">
                         <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
                              <TR>
                                <TD><IMG src="../images/button_to_right.gif" align="absMiddle" width="21" height="21">邀请信</TD>
                              </TR>
                            </TABLE>
                          </div></TD>
                      </TR>
                      <TR>
                        <TD align="center"><br>
                          <textarea name="MailContent" rows="10" cols="111" id="MailContent" class="msninput">多个朋友多条路，我最近一直在上www.heiyou.com。它和一般网站不太一样，可以通过朋友认识新朋友，交友又安全又快速，一眨眼，我的朋友圈就有0人了，而且很多和我们谈得来的朋友。这里可以创建各种部落，还有很多有意思的文章和Flash游戏，大家一起交流一起玩，挺有意思的
赶快来吧，这里注册很快，而且特别注重保护个人隐私。我会把我有趣的朋友介绍给你，你也可以把你的朋友介绍给我, 帮我们扩大一下朋友圈.</textarea></TD>
                      </TR>
                      <TR>
                        <TD><table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
                            <TR>
                              <TD>&nbsp;</TD>
                              <TD><input type="submit" name="btnSendMail" value="发送信件" id="btnSendMail" class="picbutton" /></TD>
                              <TD></TD>
                            </TR>
                          </TABLE></TD>
                      </TR>
                    </TABLE></TD>
                </TR>
              </TABLE>
         
  </FONT>
</form>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
<!-- 执行时间 0.0625 秒 -->

