<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.*" %>
<%@ page import="tea.entity.bpicture.*" %>
<%@ page import="tea.entity.admin.mov.*"%>
<%@ page import="tea.entity.member.*"%>
<%@ page import="java.util.Date"%>
<%
Http h=new Http(request);



Resource r = new Resource("/tea/ui/util/SignUp");

tea.entity.site.Community community = tea.entity.site.Community.find(h.community);
if(community.isExists())return;

String ss = community.getTerm(h.language);
String act = h.get("act");
String invite=h.get("invite");
int membertype = h.getInt("membertype");


%>

<html>
<head>
<title>用户注册</title>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/card.js" type="text/javascript"></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/load.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

</head>


<body>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(h.language)%>" type="text/javascript"></SCRIPT>
<div class="RegProcess"><div class="Process00">注册流程：</div><div class="Process01">会员类型选择</div><div class="Process02" id="ProcessSpecial">用户协议</div><div class="Process03">填写基本信息</div><div class="Process04">注册成功</div></div>
<%=ss %>
<%
String action="";
if( membertype!=0)
action="/jsp/orth/register.jsp";
//else
//action="/jsp/orth/update.jsp";
 %>
<form name="frmsrch" method="POST" action="<%=action%>">
<input type="hidden" name="membertype" value="<%=membertype%>"/>
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="act" value="register"/>
<input type="hidden" name="act2" value="<%=act%>"/>
<input type="hidden" name="invite" value="<%=invite%>"/>
 <input type=SUBMIT id="regyes" class="edit_Agree" VALUE="">　　
  <!--  <input type=SUBMIT id="regno"class="edit_button" name="DoNotAgree" VALUE="" onClick="javascript:location.href='/servlet/Node?node=<%=h.node%>';return(false);"> -->
	<input class="edit_Leave" type="button" value=""  onClick="javascript:window.close();">
 </form>
 <SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(h.language)%>" type="text/javascript"></SCRIPT>
</body>

</html>

