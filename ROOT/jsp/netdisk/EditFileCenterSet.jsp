<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.io.*" %><%@ page import="java.util.*" %><%@ page import="tea.entity.netdisk.*" %><%@ page import="java.math.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.site.*" %><%@ page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

FileCenterSet obj = FileCenterSet.find(teasession._strCommunity);

int newday=obj.getNewday();
int denysms=obj.getDenysms();
String filecenter=obj.getFileCenter();
if(request.getMethod().equals("POST"))
{
  newday=Integer.parseInt(request.getParameter("newday"));
  filecenter=request.getParameter("filecenter");
  String tmp=request.getParameter("denysms");
  denysms=tmp==null?0:Integer.parseInt(tmp);
  obj.set(newday,filecenter,denysms);

  response.sendRedirect("/jsp/info/Succeed.jsp");
  return;
}

StringBuffer sb=new StringBuffer();
Enumeration e1=FileCenter.find(teasession._strCommunity," AND father="+FileCenter.getRootId(teasession._strCommunity)+" AND type=0",null,false);
while(e1.hasMoreElements())
{
  int id=((Integer)e1.nextElement()).intValue();
  FileCenter fc=FileCenter.find(id);
  sb.append("<option value="+id+">"+fc.getSubject());
}


String strid=request.getParameter("id");

Resource r=new Resource("/tea/resource/FileCenter");

String title=r.getString(teasession._nLanguage,"1218527464027");

%><html>
<HEAD>
<title><%=title%></title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function f_load()
{
  var v=form1.filecenter.value;
  var o1=form1.filecenter1.options;
  var o2=form1.filecenter2.options;
  for(var i=0;i<o2.length;i++)
  {
    if(v.indexOf("/"+o2[i].value+"/")!=-1)
    {
      o1[o1.length]=new Option(o2[i].text,o2[i].value);
      o2[i]=null;
      i--;
    }
  }
  form1.newday.focus();
}

function f_submit(form1)
{
  var fc="/";
  var op=form1.filecenter1.options;
  for(var i=0;i<op.length; i++)
  {
    fc=fc+op[i].value+"/";
  }
  form1.filecenter.value=fc;
  return(submitInteger(form1.newday, '<%=r.getString(teasession._nLanguage,"无效-天数")%>'));
}
</script>
</HEAD>
<body onLoad="f_load()">

<h1><%=title%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="?" method="post" onSubmit="return f_submit(this);">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="filecenter" value="<%=filecenter%>">
<input type="hidden" name="id" value="<%=strid%>">

<h2><%=r.getString(teasession._nLanguage,"1218527464030")%></h2>
<table border="0" cellspacing="0" cellpadding="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage,"1218527464028")%>:</td>
    <td><input type="text" name="newday" value="<%=newday%>">天数</td>
  </tr>
  <tr>
    <td nowrap><%=r.getString(teasession._nLanguage, "1218527464029")%>:</td>
    <td colspan="3">
    <table>
    <tr><td>已选</td><td>&nbsp;</td><td>备选</td></tr>
      <tr>
        <td>
          <select name="filecenter1" size="10" multiple style="WIDTH:140px;" ondblclick="move(form1.filecenter1,form1.filecenter2,true);">
          </select>
          <td>
            <input type="button" value=" ← " onClick="move(form1.filecenter2,form1.filecenter1,true);" >
            <br>
            <input type="button" value=" → "  onClick="move(form1.filecenter1,form1.filecenter2,true);"></td>
            <td>
              <select name="filecenter2" size="10" multiple style="WIDTH:140px;" ondblclick="move(form1.filecenter2,form1.filecenter1,true);">
              <%=sb.toString()%>
              </select>
            </td>
      </tr>
    </table>
        </td>
  </tr>
</table>

<%
if(CommunityOption.find(teasession._strCommunity).get("smstype")!=null)
{
%>
<h2><%=r.getString(teasession._nLanguage,"1218527464032")%></h2>
<table border="0" cellspacing="0" cellpadding="0" id="tablecenter">
  <tr>
    <td nowrap><%=r.getString(teasession._nLanguage, "1218527464033")%>:</td>
    <td>
      <select name="denysms" style="WIDTH:140px;">
      <option value="0">-----------------------</option>
        <%=sb.toString()%>
      </select>
    </td>
  </tr>
</table>

<%
out.print("<script>form1.denysms.value='"+denysms+"';</script>");
}
%>
<input type="submit" value="<%=r.getString(teasession._nLanguage,"CBSubmit")%>">
</form>

<br>
注: 最新文件范围 如果不定义，则表示所有目录~
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
