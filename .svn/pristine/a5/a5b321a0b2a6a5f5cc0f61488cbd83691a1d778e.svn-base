<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource"  %>
<%@page import="tea.entity.admin.*" %><%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.util.*" %>
<%@page import ="java.io.*" %>
<%@page import="java.net.*" %>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


String community=teasession._strCommunity;

//新建时随机生成个ID
int bulletin=-teasession._rv._strV.charAt(0);
String tmp = teasession.getParameter("bulletin");
if(tmp!=null)
{
  bulletin=Integer.parseInt(tmp);
}

String caption=null,content=null,tmember="/",tunit="/",to=null;
java.util.Date time_s=null,time_e=null,issuetime=null;

if(bulletin>0)
{
  Bulletin obj = Bulletin.find(bulletin);
  caption = obj.getCaption();
  content = obj.getContent();
  time_s = obj.getTime_s();
  time_e = obj.getTime_e();
  issuetime=obj.getIssuetime();
  tmember=obj.getTMember();
  tunit=obj.getTUnit();
  to=obj.getTo(teasession._nLanguage);
}

Resource r=new Resource();

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/image/ig/ig_iframe.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<script>
function f_open(v)
{
  window.open('/jsp/user/list/SelMembers2.jsp?community=<%=teasession._strCommunity%>&member=form1.'+v+'member&unit=form1.'+v+'unit&name=form1.'+v+'name','','width=450px,height=350px,top=300px,left=400px');
}
function f_clear(v)
{
  document.all(v+"member").value="/";
  document.all(v+"unit").value="/";
  document.all(v+"name").value="";
}
</script>
<h1>新建公告通知</h1>
<div id="head6"><img height="6" src="about:blank" alt=""></div>
<br>

<form  name="form1" METHOD="post" action="/servlet/EditBulletin" onSubmit="return(submitText(this.caption, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>')&&(this.sms.disabled||submitText(this.sms, '<%=r.getString(teasession._nLanguage, "无效-短信内容")%>')) );">
<input type="hidden" name="act" value="">
<input type="hidden" name="bulletin" value="<%=bulletin%>" >
<input type="hidden" name="tmember" value="<%=tmember%>">
<input type="hidden" name="tunit" value="<%=tunit%>">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td nowrap>发布范围：</td>
    <td>
    <textarea name="tname" readonly cols="50" rows="2"><%if(to!=null)out.print(to);%></textarea>
    <input type="button" value="添加" onClick="f_open('t');" />
    <input type="button" value="清空" onClick="f_clear('t');" />
    </td>
  </tr>
  <tr>
    <td nowrap>标题：</td>
    <td><input type="text" name="caption" value="<%if(caption!=null)out.print(caption);%>" size="100"></td>
  </tr>
  <input type="hidden" name="time_s" size="7" ><input type="hidden"  name="time_e" size="7" >
      <%--  <tr><td nowrap>有效期：</td>
        <td>生效日期<input name="time_s" size="7"  " value="<%if(time_s!=null)out.print(time_s); if(time_ss!=null && !time_ss.equals("null")){out.print(time_ss);}%>"><A href="###"><img onClick="showCalendar('form1.time_s');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
          终止日期  <input name="time_e" size="7"  value="<%if(time_e!=null)out.print(time_e); if(time_es!=null && !time_es.equals("null")) {out.print(time_es);}%>"><A href="###"><img onClick="showCalendar('form1.time_e');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
      </td></tr>--%>
      <tr>
        <td nowrap>附件</td>
        <td>
          <iframe id="attach" src="/jsp/admin/flow/NewBullfile.jsp?community=<%=teasession._strCommunity%>&bulletin=<%=bulletin%>" style="width:100%; height:25px;" frameborder="0" scrolling="no"></iframe>
        </td>
      </tr>
      <tr>
        <td>内容:</td>
        <td>
          <textarea name="content" style="display:none" rows="8" cols="70" class="edit_input"><%if(content!=null)out.print(content);%></textarea>
          <iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=MySetting" width="700" height="300" frameborder="no" scrolling="no"></iframe>
        </td>
      </tr>
      <tr>
        <td>发布时间:</td>
        <td><%=new tea.htmlx.TimeSelection("issuetime", issuetime)%></td>
      </tr>
      <tr>
        <td>选项:</td>
        <td>
          <%
          if(CommunityOption.find(teasession._strCommunity).get("smstype")!=null)
          {
            out.print("<input type='checkbox' onclick=\"trsms.style.display=checked?'':'none'; form1.sms.disabled=!checked; form1.sms.value='公司OA平台有《'+form1.caption.value+'》的公告，请及时阅办。';\" />同时发送短信提醒");
          }
          %>
          <input type="checkbox" name="message" />同时发送内部邮件提醒
        </td>
      </tr>
      <tbody id="trsms" style="display:none">
      <input type="hidden" name="smsmember" value="/">
      <input type="hidden" name="smsunit" value="/">
      <tr>
        <td>发送到:</td>
        <td>
          <textarea name="smsname" readonly cols="50" rows="2"></textarea>
          <input type="button" value="添加" onClick="f_open('sms');" />
          <input type="button" value="清空" onClick="f_clear('sms');" />
        </td>
      </tr>
      <tr>
        <td>短信内容:</td>
        <td><%=SMSMessage.contentToHtml(teasession,"sms")%></td>
      </tr>
      </tbody>
</table>

<input type="Submit" name="" value="发布"><input type="button" name="" value="重填" onClick="location='/jsp/admin/flow/NewBulletin.jsp'"><input type="button" name="" value="返回" onClick="location='/jsp/admin/flow/Bulletin.jsp?community=<%=community %>'" >
</FORM>

    <br>
    <div id="head6"><img height="6" src="about:blank"></div>
  </body>
</HTML>
