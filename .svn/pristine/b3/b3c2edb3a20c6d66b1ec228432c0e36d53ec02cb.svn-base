<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.entity.site.*"%>
<%@ page import="tea.entity.node.*"%>
<%@ page import="tea.resource.*"%>
<%@ page import="tea.html.*"%>
<%@ page import="java.io.*"%>
<%@ page import="tea.ui.*"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

String nexturl = teasession.getParameter("nexturl");
int xmlid = 0;
if(teasession.getParameter("xmlid")!=null && teasession.getParameter("xmlid").length()>0)
{
  xmlid = Integer.parseInt(teasession.getParameter("xmlid"));
}
CommunityXml cxobj = CommunityXml.find(xmlid);



%>
<html>
<head>
<title>编辑社区XML设置</title>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<script>
function f_submit()
{
   if(form1.subject.value=='')
   {
     alert('xml的名称不能为空');
     form1.subject.focus();
     return false;
   }
    if(form1.content.value=='')
   {
     alert('xml的内容不能为空');
     form1.content.focus();
     return false;
   }
}
function f_subject()
{
  //alert('/servlet/EditCommunityXml?xmlid='+form1.xmlid.value+'&act=EditCommunityXmlAjax&subject='+encodeURIComponent(form1.subject.value));
  sendx("/servlet/EditCommunityXml?xmlid="+form1.xmlid.value+"&act=EditCommunityXmlAjax&subject="+encodeURIComponent(form1.subject.value),
  function(data)
  {
    if(data!='')
    {
      alert(data);
      form1.subject.value='';
    }

  }
  );
}
</script>
<h1>编辑社区XML设置</h1>
<div id="head6"><img height="6" alt=""></div>
  <br>
  <FORM name=form1 METHOD=POST action="/servlet/EditCommunityXml" onSubmit="return f_submit();" >
    <input type="hidden" name="act" value="EditCommunityXml">
    <input type="hidden" name="nexturl" value="<%=nexturl%>">
    <input type="hidden" name="community" value="<%=teasession._strCommunity%>">
    <input type="hidden" name="xmlid" value="<%=xmlid%>">

    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <td align="right" nowrap>XML名称:</td>
        <td><input type="text" name="subject" value="<%if(cxobj.getSubject()!=null)out.print(cxobj.getSubject());%>" size="50" maxlength="50" onBlur="f_subject();"></td>
      </tr>
      <tr>
        <td align="right" nowrap>XML内容:</td>
        <td><textarea cols="80" rows="12" name="content"><%if(cxobj.getContent()!=null)out.print(cxobj.getContent()); %></textarea></td>
      </tr>
      <tr>
        <td align="right" nowrap>字符集:</td>
        <td><select name="charset"><option value="GBK">GBK</option><option value="UTF-8" <%="UTF-8".equals(cxobj.getCharset())?" selected":""%>>UTF-8</option></select></td>
      </tr>
    </table>
    <br>
    <input type="submit" value="提交" />&nbsp;<input type=button value="返回" onClick="javascript:history.back()">
  </FORM>
</body>
</html>
