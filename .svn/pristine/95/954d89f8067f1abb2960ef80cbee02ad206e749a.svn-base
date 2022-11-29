<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.admin.orthonline.*"%>
<%@page import="java.util.Date"%>

<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession = new TeaSession(request);
if (teasession._rv == null) {
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}

tea.entity.site.Community community = tea.entity.site.Community.find(teasession._strCommunity);

String fname2 = teasession.getParameter("members");
String sql = teasession.getParameter("sql");
String doidstr="/";
if(fname2!=null&&fname2.length()>0)
{
  String fname[]  = teasession.getParameterValues("members");
  for(int i = 0;i<fname.length;i++)
  {
    doidstr=doidstr+fname[i]+"/";
  }
}

%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<script src="/jsp/admin/orthonline/eme.js" type="text/javascript"></script>
<title>发送会员信息邮件</title>
</head>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
<body id="bodynone">
<script>

   function f_submit()
   {
     if(form1.subject.value=='')
     {
       alert('邮件标题不能为空');
       form1.subject.focus();
       return false;
     }
     openNewDiv('newDiv');
     form1.action='/servlet/EditDoctor';
     form1.submit();
   }
</script>
<h1>发送医生信息邮件</h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <form action="?" name="form1"  method="POST" ><!--/servlet/EditDoctor-->
  <input type="hidden" name="doidstr" value="<%=doidstr%>" >
  <input type="hidden" name="sql" value="<%=sql%>" />
  <input type="hidden" name="act" value="MemberEmail">
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <TD nowrap align="right">会员名称：</TD>
      <TD nowrap>
          <select name="docname" multiple style="WIDTH:140px;" >
              <%
                 if(doidstr.split("/")!=null&&doidstr.split("/").length>0)
                 {
                   for(int i =1;i<doidstr.split("/").length;i++)
                   {
                     String did = doidstr.split("/")[i]; 
                     Profile pobj = Profile.find(did);
                     out.print("<option>");
                     if((pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage))!=null && (pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage)).length()>0)
                     {
                       out.print(pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage));
                     }else
                     {
                       out.print(pobj.getMember());
                     }
                     out.print("</option>");
                   } 
                 }else
                 {
                   out.print("<option>发送所查询条件的会员</option>");
                 }
              %>
          </select>
      </TD>
    </tr>

     <tr>
      <TD nowrap align="right">邮件标题：</TD>
      <TD nowrap><input type="text" name="subject" value="" size="60"> </TD>
    </tr>
     <tr>
      <TD nowrap align="right">邮件内容：</TD>
      <TD nowrap>

       <textarea  style="display:none"  name="content" rows="12" cols="90" class="edit_input"></textarea>
      <iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=<%=teasession._strCommunity%>" width="740" height="300" frameborder="no" scrolling="no"></iframe>
    </td>
    </tr>
  </table>
  <input type="button" value="发送电子邮件" onClick="f_submit();">&nbsp;
  <input type=button value="返回" onClick="javascript:history.back()">
  </form>
  <div id="head6"><img height="6" src="about:blank"></div>
    <SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
</body>
</html>
