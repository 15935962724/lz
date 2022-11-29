<%@page contentType="text/html;charset=UTF-8"  %>
<%@include file="/jsp/Header.jsp"%>
<%

/* if(!AccessMember.find(node._nNode, teasession._rv._strV).isProvider(37))
{
  response.sendError(403);
  return;
} */
 r.add("/tea/resource/Event");

String nexturl=teasession.getParameter("nexturl");

int id = Integer.parseInt(teasession.getParameter("id"));
int node = Integer.parseInt(teasession.getParameter("node"));

MeetingNotice mn = MeetingNotice.find(id);

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<script src="/tea/city2.js" type="text/javascript"></script>
<script type="text/javascript">

function f_load()
{
  form1.name.focus();
}
function f_sub()
{
	  if(form1.title.value==''){
		  alert('请填写标题');
		  form1.title.focus();
		  return false;
	  }
}
mt.refresh=function(url){
	window.location.href=url;
};
</script>
</head>
<body onload="f_load()">
<h1>会议通知编辑</h1>
  <div id="head6"><img height="6" src="about:blank"></div>


<form name="form1" method="post" action="/servlet/EditMeetingNotices"  ENCtype=multipart/form-data target="_ajax" onSubmit="return f_sub();">
<input type="hidden" name="id" value="<%=id%>">
<input type="hidden" name="node" value="<%=node%>">
<input type="hidden" name="act" value="edit">
<input type="hidden" name="nexturl" value="<%=nexturl%>">
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td align="right" width="160">标题：</td>
      <td>
        <input type="text" class="edit_input" name="title" value="<%=mn.getTitle()!=null?mn.getTitle():""%>">
      </td>
    </tr>
	
	<tr >
    <td nowrap align="right"><%=r.getString(teasession._nLanguage, "内容")%>:</TD>
    <td nowrap><input  id="radio" type="radio" name=TextOrHtml value=0 checked="checked">
      <%=r.getString(teasession._nLanguage, "文本")%>
      <input  id="radio" type="radio" name=TextOrHtml value=1  >HTML

      <input  id="CHECKBOX" type="checkbox" name="nonuse" value="checkbox" onClick="f_editor(this)"><label for="nonuse"><%=r.getString(teasession._nLanguage, "不使用多媒体编辑器")%></label>
        <input type="checkbox" name="srccopy"/>源网站的图片贴入本地
<%
boolean isFtp=new File(application.getRealPath("/res/"+teasession._strCommunity+"/ftp/")).exists();
if(isFtp)
out.print("<input type='button' value='选择图片' onclick=window.open('/jsp/site/FFtps.jsp?community="+teasession._strCommunity+"&oby=2','_blank','width=680px,height=400px,resizable=1'); />");
%>
    </td>
  </tr>
  <tr >
<td></td>
    <td nowrap >

      <textarea style="display:none" name="content" rows="12" cols="90" class="edit_input"><%=mn.getContent()!=null?HtmlElement.htmlToText(mn.getContent()):""%></textarea>
      <iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=<%=teasession._strCommunity%>" width="740" height="300" frameborder="no" scrolling="no"></iframe>

    </td>
  </tr>

  </table>
  <br>
  <center>
  <INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">&nbsp;
  <input type="button" name="reset" value="返回"  onclick="window.open('<%=teasession.getParameter("nexturl")%>','_self');">

</center></form>
  <%-- <div id="language"><%=new Languages(teasession._nLanguage,request)%>  </div> --%>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

