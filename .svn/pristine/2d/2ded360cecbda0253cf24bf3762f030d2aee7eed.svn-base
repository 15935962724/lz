<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.eon.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.io.*" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String menuid=teasession.getParameter("id");

int index=-1;
String tmp=teasession.getParameter("index");
if(tmp!=null)
{
  index=Integer.parseInt(tmp);
}

EonTeleset et = EonTeleset.find(teasession._strCommunity,teasession._rv._strV);
String ms[]=et.getMessage();

Resource r=new Resource();


%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function defaultfocus()
{
  form1.nexturl.value=location;
  form1.file.focus();
}
function f_act(act,id)
{
  form1.act.value=act;
  form1.index.value=id;
  if(act=='message')
  {
    form1.method="GET";
    form1.action="?";
    form1.nexturl.disabled=true;
  }else
  {
    if(act=='delmessage'&&!confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>'))
    {
      return false;
    }
  }
  form1.submit();
}
function f_eon()
{
  window.open('/servlet/EonRecords?act=outbound&community=<%=teasession._strCommunity%>&member=<%=java.net.URLEncoder.encode(teasession._rv._strV, "UTF-8")%>&processnum=3','','width=500,height=400,scrollbars=1');
}
</script>
</head>
<body onLoad="defaultfocus();">

<h1>留言管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<form name="form1" action="/servlet/EditEonTeleset" method="post" enctype="multipart/form-data" onSubmit="return submitText(this.file, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-留言')">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<input type="hidden" name="nexturl" >
<input type="hidden" name="act" value="message"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <TD>索引</TD>
    <TD>留言</TD>
    <TD>&nbsp;</TD>
  </tr>
<%
for(int i=0;i<ms.length;i++)
{
  if(ms[i]!=null&&ms[i].length()>0)
  {
    out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
    out.print("<td>"+i);
    out.print("<td><a href=javascript:f_act('downmessage',"+i+")>"+ms[i]+"</a>");
    out.print("<td><input type=button value="+r.getString(teasession._nLanguage,"CBEdit")+" onclick=f_act('message',"+i+");>");
    out.print("<input type=button value="+r.getString(teasession._nLanguage,"CBDelete")+" onclick=f_act('delmessage',"+i+");>");
  }else if(index==-1)
  {
    index=i;
  }
}
%>
</table>

<%
if(index!=-1)
{
%>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>索引</td>
    <td><input type="text" name="index" value="<%=index%>" readonly style="color:#999999" size="5"></td>
  </tr>
  <tr>
    <td>留言</td>
    <td><input type="file" name="file" size="40">上传文件必须是VOX格式.</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td nowrap><input type="submit" value="提交"></td>
  </tr>
</table>
<%
}
%>
</form>
<input type="button" value="电话留言" onclick="f_eon();">

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
