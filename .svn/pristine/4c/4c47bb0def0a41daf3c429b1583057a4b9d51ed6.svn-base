<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.bpicture.*" %>
<%@ page import="tea.entity.admin.mov.*"%>
<%@ page import="tea.entity.member.*"%>
<%@ page import="java.util.Date"%>
<%
TeaSession teasession =new TeaSession(request);
String invite=teasession.getParameter("invite");
if (invite==null) invite="0";
int membertype = 0;
if(teasession.getParameter("membertype")!=null && teasession.getParameter("membertype").length()>0)
{
  membertype = Integer.parseInt(teasession.getParameter("membertype"));
}
String act = teasession.getParameter("act");
tea.entity.site.Community community = tea.entity.site.Community.find(teasession._strCommunity);
%>

<html>
<head>
<title>用户注册</title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/card.js" type="text/javascript"></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/load.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

</head>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>

<body bgcolor="#ffffff">
<div class="RegProcess"><div class="Process00">注册流程：</div><div class="Process01" id="ProcessSpecial">会员类型选择</div><div class="Process02">用户协议</div><div class="Process03">填写基本信息</div><div class="Process04">注册成功</div></div>
<table border="0" cellpadding="0" cellspacing="0" class="tabletop">

<tr>
<td class="tdtop">会员您好！原骨科在线会员首次登录时系统默认为普通会员，请查询积分或登记状况并升级。<br>如有问题，请联系我们。</td></tr></table>

<div class="RegType">
<div class="top"><img src="/res/orth/0911/0911996.gif"></div>
<div class="General"><span>普通会员　　<a href="#" onClick="frmsrch.submit();">马上注册</a></span>
 只填写简单信息 即可完成普通会员注册，并获得20个积分。<a href="/html/node/2204515-1.htm" target="_blank">积分管理规则</a></div>
<div class="Advanced"><span>高级会员　　<a href="#" onClick="frmsrch1.submit();">马上升级</a></span>
积分达到100分的普通用户可以升级为高级会员，或在骨科医生登记系统登记的医生可自动成为高级会员并获得100个积分
</div></div>
<form name="frmsrch" method="POST" action="/jsp/orth/agreement.jsp">
<input type="hidden" name="membertype" value="<%=membertype%>"/>
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="act" value="register"/>
<input type="hidden" name="act2" value="<%=act%>"/>
<input type="hidden" name="invite" value="<%=invite%>"/>
 </form>
<form name="frmsrch1" method="POST" action="/jsp/orth/agreement.jsp">
<input type="hidden" name="membertype" value="<%=membertype%>"/>
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="act" value="register"/>
<input type="hidden" name="act2" value="<%=act%>"/>
<input type="hidden" name="invite" value="<%=invite%>"/>
 </form>
</body>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
</html>

