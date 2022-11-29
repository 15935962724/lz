<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.util.*"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="java.util.*"%>
<%@page import="tea.entity.netdisk.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.ui.TeaSession"%><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource("/tea/resource/FileCenter");

int base=Integer.parseInt(request.getParameter("base"));
int filecenter=Integer.parseInt(request.getParameter("filecenter"));

FileCenter obj=FileCenter.find(filecenter);
CommunityOffice co=CommunityOffice.find(teasession._strCommunity);
boolean valid=true;
String subject="",code="",version="",make="",unit="",content="",word;
String act=request.getParameter("act");
if("edit".equals(act))
{
  subject=obj.getSubject();
  code=obj.getCode();
  valid=obj.isValid();
  make=obj.getMakeToString();
  unit=obj.getUnit();
  word=obj.getWord();
  content=obj.getContent();
}else
{
  word=co.getTemplate();
}

boolean isFile=(obj.isType()||"upload".equals(act));

%><HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script>
var arr=new Array();
function f_click(obj)
{
  var table=document.all("tb");
  var tr = document.createElement("tr");
  tr.id="tr"+arr.length;
  //
  var td = document.createElement("td");
  var path=obj.value;
  var name=path.substring(path.lastIndexOf("\\")+1);
  var ex=name.substring(name.lastIndexOf(".")+1);
  td.innerHTML="<img src=/tea/image/netdisk/"+ex+".gif width='16' height='16' onerror=onerror=null;src='/tea/image/netdisk/defaut.gif'>"+name;
  tr.appendChild(td);
  //
  td = document.createElement("td");
  td.innerHTML="<a href=javascript:f_del("+arr.length+");>移除</a>";
  tr.appendChild(td);
  table.appendChild(tr);
  //
  arr.push(obj);
  var oInput=document.createElement("INPUT");
  oInput.type="file";
  oInput.name="file";
  oInput.size=1;
  oInput.style.cssText=obj.style.cssText;
  oInput.onchange=function(){f_click(this)};
  var tdadd=document.getElementById("tdadd");
  tdadd.appendChild(oInput);
}
function f_del(id)
{
  if(confirm("确认删除?"))
  {
    var tr=document.getElementById("tr"+id);
    tr.style.display="none";
    if(arr[id])
    {
      arr[id].disabled=true;
    }else
    {
      form1.fca.value+=id.substring(1)+"/";
    }
  }
}
//短信相关
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
function f_cb(id)
{
  var cbsms=$('cbsms');
  $('trname').style.display=((cbsms&&cbsms.checked)||$('cbmsg').checked)?'':'none';
  var cb=document.getElementById("cb"+id);
  document.getElementById("tr"+id).style.display=cb.checked?'':'none';
  var obj=eval("form1."+id);
  obj.disabled=!cb.checked;
  f_cb_ref();
}
function f_cb_ref()
{
  if(!form1.msg.change)form1.msg.value='公司OA平台有《'+form1.subject.value+'》的文件，请及时阅办。';
  if(!form1.sms.change)form1.sms.value='公司OA平台有《'+form1.subject.value+'》的文件，请及时阅办。';
}
//
var ocx=null;
function f_submit()
{
  if(submitText(form1.subject,"无效-主题")&&(!form1.sms || form1.sms.disabled || submitText(form1.sms,"无效-短信内容") ))
  {
    if(ocx)
    {
      ocx.SaveToURL(form1.action,'word','','newdoc.doc',0);
    }
    return true;
  }
  return false;
}

function f_unit(arr)
{
  var op=form1.selectunit.options;
  while(op.length>1)
  {
    op[1]=null;
  }
  for(var i=0;i<arr.length;i++)
  {
    op[op.length]=new Option(arr[i],arr[i]);
  }
}
</script>
</HEAD>
<body>

<h1><%=r.getString(teasession._nLanguage, "1218527464026")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><%=obj.getAncestor(base)%></td>
  </tr>
</table>

<form name="form1" action="/servlet/EditFileCenter" method="post" enctype="multipart/form-data" onSubmit="return f_submit();">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="repository" value="filecenter">
<input type="hidden" name="act" value="<%=act%>">
<input type="hidden" name="base" value="<%=base%>">
<input type="hidden" name="filecenter" value="<%=filecenter%>">
<input type="hidden" name="fca" value="/">


<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td width="15%" nowrap><%=r.getString(teasession._nLanguage, "Subject")%></td>
    <td><input name="subject" size="50" maxlength="100" value="<%=subject%>" onchange="f_cb_ref()"></td>
  </tr>
<%
if(isFile)
{
%>
<tr>
  <td nowrap><%=r.getString(teasession._nLanguage, "FileCenter.code")%></td>
  <td><input name="code" size="40" maxlength="50" value="<%=code%>"></td>
</tr>
<tr>
  <td nowrap><%=r.getString(teasession._nLanguage, "FileCenter.make")%></td>
  <td><input name="make" size="12" value="<%=make%>"/><input  onclick="showCalendar('form1.make')" type="button" value="" class="Calendar"></td>
</tr>
<tr>
  <td nowrap><%=r.getString(teasession._nLanguage, "FileCenter.unit")%></td>
  <td><input name="unit" maxlength="50" value="<%=unit%>">
<select name="selectunit" onChange="form1.unit.value=value;">
<option value="" >-------------</option>
<%
Enumeration e=FileCenterUnit.findNameByCommunity(teasession._strCommunity);
while(e.hasMoreElements())
{
  String str=(String)e.nextElement();
  out.print("<option value="+str+">"+str);
}
%>
</select><input type="button" value="<%=r.getString(teasession._nLanguage, "1218527464018")%>" onClick="window.open('/jsp/netdisk/FileCenterUnits.jsp?community=<%=teasession._strCommunity%>&field=form1.selectunit','','width=500,height=500,scrollbars=1');">  </td>
</tr>
<tr>
  <td nowrap><%=r.getString(teasession._nLanguage, "FileCenter.valid")%></td>
  <td><input type="radio" name="valid" value="true" checked/><%=r.getString(teasession._nLanguage, "1218527464020")%>
    <input type="radio" name="valid" value="false" <%if(!valid)out.print(" checked ");%> ><%=r.getString(teasession._nLanguage, "1218527464021")%></td>
</tr>
<%
FileCenterSet fcs=FileCenterSet.find(teasession._strCommunity);
if(obj.getPath().indexOf("/"+fcs.getDenysms()+"/")==-1)
{
%>
<tr>
  <td nowrap><%=r.getString(teasession._nLanguage, "Options")%></td>
  <td>
    <input type="checkbox" id="cbmsg" onClick="f_cb('msg')" /><label for="cbmsg">同时发送站内信提醒</label>
    <%
    if(CommunityOption.find(teasession._strCommunity).get("smstype")!=null)
    {
      out.print("<input type='checkbox' id='cbsms' onClick=\"f_cb('sms')\" /><label for='cbsms'>同时发送手机短信提醒</label>");
    }
    %>
</td>
</tr>
<input type="hidden" name="smsmember" value="/">
<input type="hidden" name="smsunit" value="/">
<tr id="trname" style="display:none">
  <td nowrap><%=r.getString(teasession._nLanguage, "发送到")%></td>
  <td>
    <textarea name="smsname" readonly cols="50" rows="2"></textarea>
    <input type="button" value="添加" onClick="f_open('sms');" />
    <input type="button" value="清空" onClick="f_clear('sms');" />
  </td>
</tr>
<tr id="trmsg" style="display:none">
  <td nowrap><%=r.getString(teasession._nLanguage, "站内信内容")%></td>
  <td><textarea name='msg' disabled="disabled" cols='50' rows='5' onchange="setAttribute('change',true)"></textarea></td>
</tr>
<tr id="trsms" style="display:none">
  <td nowrap><%=r.getString(teasession._nLanguage, "手机短信内容")%></td>
  <td><%=SMSMessage.contentToHtml(teasession,"sms")%></td>
</tr>
<%
}
}
%>
 <tr>
    <td colspan="2" nowrap>
<textarea name="content" style="display:none" cols="50" rows="5"><%=content%></textarea>
<iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=MySetting" width="720" height="200" frameborder="no" scrolling="no"></iframe>
<%--
<script>
  ocx=ActionX("<%=co.getProductCaption()%>","<%=co.getProductKey()%>");
  <%
  if(word==null||word.length()==0)
  {
    out.print("ocx.CreateNew('Word.Document');");
  }else
  {
    out.print("ocx.OpenFromURL('"+word+"');");
  }
  %>
</script>
--%>

</td>
</tr>
</table>

<%
if(isFile)
{
%>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tbody id="tb">
<tr>
  <td id="tdadd"><img src="/tea/image/public/addfile.gif" align="absmiddle"><input type="file" name="file" size="1" style="position:absolute;width:10px;cursor:hand;filter:alpha(opacity=0);opacity:0;margin-left:-80px;margin-top:2px;" onChange="f_click(this)"/></td>
</tr>
<tr id=tableonetr><td><%=r.getString(teasession._nLanguage, "1218527464023")%></td><td><%=r.getString(teasession._nLanguage, "1218527464024")%></td></tr>
<%
Enumeration e2=FileCenterAttach.findByFileCenter(filecenter);
while(e2.hasMoreElements())
{
  int fcaid=((Integer)e2.nextElement()).intValue();
  FileCenterAttach fca=FileCenterAttach.find(fcaid);
  out.println("<tr id=tra"+fcaid+"><td><img src=/tea/image/netdisk/"+fca.getEx()+".gif align=absmiddle onerror=onerror=null;src='/tea/image/netdisk/defaut.gif';>"+fca.getName());
  out.println("<td><a href=javascript:f_del('a"+fcaid+"');>"+r.getString(teasession._nLanguage, "CBDelete")+"</a>");//r.getString(teasession._nLanguage, "Clear")
}
%>
</tbody>
</table>

<input type="submit" name="safety" value="<%=r.getString(teasession._nLanguage, "1218527464025")%>">
<%}%>

<input type="submit" value="提交">
<input type="button" value="返回" onClick="history.back();">
</form>

</body>
</html>
