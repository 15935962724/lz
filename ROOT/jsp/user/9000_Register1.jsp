<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.site.*" %>
<%@ page import="tea.entity.member.*" %>
<%

TeaSession teasession = new TeaSession(request);
Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");

Community community=Community.find(teasession._strCommunity);

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/card.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function submitCheck(form1)
{
	return(
	submitText(form1.code,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>')
	&&submitText(form1.password,'<%=r.getString(teasession._nLanguage, "InvalidPassword")%>')
	);
}
</script>
</head>
<body id="bodynone" >

<div id="jspbefore" style="display:none">
<%=community.getJspBefore(teasession._nLanguage)%>
</div>


<div id="tablebgnone" class="register">

<div id="head6"><img height="6" src="about:blank"></div>


<FORM name=form1 METHOD=POST ACTION="9000_Register2.jsp" onSubmit="return submitCheck(this);">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="Node" value="<%=teasession._nNode%>"/>



<div id="toptu"><img src="/res/9000gw/u/0708/070841922.jpg"></div><div id="biankuang">
<div id="toptitle"><img src="/res/9000gw/u/0707/070710526.jpg" align="absmiddle"></div>
<div id="center">注 册 信 息</div><div id="topwei"><img src="/res/9000gw/u/0707/070710527.jpg" align="absmiddle"></div></div>
<div id="dlkuang">

<div id="denglu">
用户名:  <input type="text" name="code" class="in"><br><br>
密　码:  <input type="password" name="password" class="in"><br><br>
<input type="image" src="/res/9000gw/u/0707/070710532.jpg" >

</div>
</div></div>


  </FORM>
<SCRIPT>document.form1.code.focus();</SCRIPT>

<div><img height="6" src="about:blank"></div></div>

<div id="jspafter" style="display:none"><%=community.getJspAfter(teasession._nLanguage)%></div>
<script>
if(top.location==self.location)
{
  jspbefore.style.display='';
  jspafter.style.display='';
}
</script>

</body>
</html>
