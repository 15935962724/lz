<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"  %>
<%@ page import="tea.resource.Resource" %>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.entity.*" %>
<%@ page import="tea.entity.site.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@page import="java.net.URLEncoder"%><%
request.setCharacterEncoding("UTF-8");

Http h=new Http(request);
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

Community obj=Community.find(h.community);
String ce = "你好,MemberId( email ): <BR><BR>感谢您注册 <A href=sn>webn</A> 帐户。请按下面的说明操作，确认您注册了此帐户，如果您没有注册，请取消此帐户。<BR><BR><BR>确认帐户<BR>为了有助于防止未经授权的帐户创建，我们需要确认您的新帐户的电子邮件地址，这样还可以确保我们发送给您的重要信息能够到达您的帐户，此外，我们网站上的一些服务也可能需要经过确认的电子邮件地址 。<BR><BR>若要确认此电子邮件地址，请选择并复制下列链接。打开浏览器窗口并将其粘贴到地址栏中，然后按键盘上的 Enter 或回车键，然后按照显示的指令操作。<BR><BR><A href=affirm_d&affirm=ON\">affirm_d&affirm=ON</A><BR><BR><BR>取消帐户<BR>如果您没有将此电子邮件地址注册为帐户，并希望取消此帐户，请选择并复制下列链接。打开浏览器窗口并将其粘贴到地址栏中，然后按键盘上的 Enter 或回车键，然后按照显示的指令操作。<BR><BR><A href=affirm_d&cancel=ON\">affirm_d&cancel=ON</A><BR><BR><BR>要点<BR>为了有助于保证您个人信息的安全，webn 建议您永远不要单击未经请求的电子邮件中的链接，该链接可能会要求您输入您的凭据（电子邮件和密码），不要单击此类链接，而要将其复制并粘贴到网络浏览器的地址栏中。我们也可能会向您发送包含链接的电子邮件，该链接是为了便于您使用而提供的。";


if(request.getMethod().equals("POST"))
{
  obj.set("ischeck",obj.ischeck=h.get("ischeck","|").replace('|','/'));
  obj.set("media",String.valueOf(obj.media=h.getInt("media")));
  obj.set("subjectnode",String.valueOf(obj.subjectnode=h.getInt("subjectnode")));
  obj.setLayer(h.language,"locus",teasession.getParameter("locus"));
  obj.setLayer(h.language,"tips",teasession.getParameter("tips"));
  obj.setLayer(h.language,"ruleshelp",teasession.getParameter("ruleshelp"));
  obj.setLayer(h.language,"communityemail",teasession.getParameter("communityemail"));

  String desktop=request.getParameter("desktop");
  int dynamicdesktop=h.getInt("dynamicdesktop");
  int messageboard=h.getInt("messageboard");
  obj.setOther(h.getInt("login"),h.getInt("bglogin"),h.getBool("session"),h.getBool("lunique"),desktop,dynamicdesktop,messageboard);

  response.sendRedirect("/jsp/info/Succeed.jsp?nexturl="+URLEncoder.encode(request.getRequestURI()+"?community="+h.community,"UTF-8"));
  return;
}
Resource r=new Resource("/tea/resource/Other");

%><html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(h.language, "SetOther")%></h1>
<div id="head6"><img height="6" src="about:blank" ></div>

<form name="form1" method="post" action="?" onSubmit="return (submitInteger(form1.login,'<%=r.getString(h.language,"InvalidNodeNumber")%>')&&submitInteger(form1.dynamicdesktop,'<%=r.getString(h.language,"InvalidNodeNumber")%>'));">
<input type="hidden" name="community" value="<%=h.community%>"/>
 <table cellpadding="0" cellspacing="0" border="0" id="tablecenter">
 <tr id="TableCaption">
    <td colspan="3"><%=r.getString(h.language,"SetOther")%></td>
 </tr>
  <tr>
    <td align="right" nowrap><%=r.getString(h.language,"FrontLoginNode")%>：</td>
    <td nowrap><input name="login"  class="edit_input" value="<%=obj.getLogin()%>" mask="int"></td>
    <td nowrap></td>
  </tr>
  <tr>
    <td align="right" nowrap><%=r.getString(h.language,"BackgroundLoginNode")%>：</td>
    <td nowrap><input name="bglogin"  class="edit_input" value="<%=obj.getBgLogin()%>" mask="int"></td>
    <td nowrap></td>
  </tr>
  <tr>
    <td align="right" nowrap><%=r.getString(h.language,"SessionType")%>：</td>
    <td nowrap>
      <input name="session" type="radio" class="edit_input" value="0" checked="checked">
      Cookie
      <input name="session" type="radio" class="edit_input" value="1" <%if(obj.isSession())out.print(" checked='checked'");%>>
      Session    </td>
    <td nowrap>Cookie: 跨域并且不存在登陆超时问题　Session:不跨域而且存在登陆超时问题</td>
  </tr>
  <tr>
    <td align="right" nowrap><%=r.getString(h.language,"唯一登陆")%>：</td>
    <td nowrap>
      <input name="lunique" type="radio" class="edit_input" value="0" checked="checked">
      否
      <input name="lunique" type="radio" class="edit_input" value="1" onClick="form1.session[1].checked=true;" <%if(obj.isLUnique())out.print(" checked='checked'");%>>
      是    </td>
    <td nowrap></td>
  </tr>
  <tr>
    <td align="right" nowrap><%=r.getString(h.language,"BgDesktop")%>：</td>
    <td nowrap><input name="desktop" value="<%=obj.getDesktop()%>" size="40"></td>
    <td nowrap></td>
  </tr>
  <tr>
    <td align="right" nowrap><%=r.getString(h.language,"动态桌面节点")%>：</td>
    <td nowrap><input name="dynamicdesktop" value="<%=obj.getDynamicdesktop()%>" mask="int"></td>
    <td nowrap></td>
  </tr>
  <tr>
    <td align="right" nowrap><%=r.getString(h.language,"帮助留言节点")%>：</td>
    <td nowrap><input name="messageboard" value="<%=obj.getMessageboard()%>" mask="int"></td>
    <td nowrap></td>
  </tr>
  <tr>
    <td align="right" nowrap><%=r.getString(h.language,"选项是否使用")%>：</td>
    <td colspan="2" nowrap><%=h.checks(Community.ISCHECK_TYPE,"ischeck",obj.getIscheck().replace('/','|'))%></td>
  </tr>
 <tr>
   <td align="right" nowrap><%=r.getString(h.language,"新闻名称去重节点")%>：</td>
   <td nowrap ><input name="subjectnode"  type="text" value="<%=obj.getSubjectnode() %>">
    &nbsp;(注：请输入排除判重的栏目节点号，输入0则本站任何节点都提示重复)
 </tr>
 <tr>
    <td align="right" nowrap><%=r.getString(h.language,"媒体名称默认")%>：</td>
    <td nowrap>
      <input type="text" name="media" value="<%=obj.getMedia() %>">
      &nbsp;(注：此处填写是媒体名称的id号)</td>
  </tr>
   <tr>
    <td align="right" nowrap><%=r.getString(h.language,"地点别名")%>：</td>
    <td nowrap>
      <input type="text" name="locus" value="<%if(obj.getLocus(teasession._nLanguage)!=null&&obj.getLocus(teasession._nLanguage).length()>0)out.print(obj.getLocus(teasession._nLanguage));else{out.print("地点");} %>">
      &nbsp;(注：此处在添加新闻时候 地点的别名，默认为地点)</td>
  </tr>

   <tr>
    <td align="right" nowrap><%=r.getString(h.language,"个人投稿提示")%>：</td>
    <td colspan="2" nowrap>
      <textarea rows="15" cols="80" name="tips"><%if(obj.getTips(teasession._nLanguage)!=null){out.print(obj.getTips(teasession._nLanguage));} %></textarea>
    </td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td align="right" nowrap><%=r.getString(h.language,"投稿要求说明")%>：</td>
    <td colspan="2" nowrap>
      <textarea rows="15" cols="80" name="ruleshelp"><%if(obj.getRuleshelp(teasession._nLanguage)!=null){out.print(obj.getRuleshelp(teasession._nLanguage));} %></textarea>
    </td>
    <td>&nbsp;</td>
  </tr>

   <tr>
    <td align="right" nowrap><%=r.getString(h.language,"注册确认邮件")%>：</td>
    <td colspan="2" nowrap>
      <textarea rows="15" cols="80" name="communityemail"><%if(obj.getCommunityemail(teasession._nLanguage)!=null){out.print(obj.getCommunityemail(teasession._nLanguage));}else{out.println(ce);} %></textarea>
    </td>
    <td>&nbsp;</td>
  </tr>
</table>

<input type="submit"  class="edit_input"  name="Submit" value="<%=r.getString(h.language,"Submit")%>">
</form>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(h.language,request)%></div>
</body>
</html>
