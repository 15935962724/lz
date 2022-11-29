<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.admin.*" %>
<%@include file="/jsp/Header.jsp"%>
<%


if(!node.isCreator(teasession._rv)&&!AccessMember.find(node._nNode, teasession._rv._strV).isProvider(3))
{
  response.sendError(403);
  return;
}
String nexturl=teasession.getParameter("nexturl");

String subject="";
long len_picture=0,len_filename=0,len_repic=0;
String picture=null,filename=null,content=null,repic=null;
Date stoptime = null;
if(node.getType()>1)
{
  subject=node.getSubject(teasession._nLanguage);
  picture = node.getPicture(teasession._nLanguage);
  if(picture!=null && picture.length()>0){
	  len_picture = new java.io.File(application.getRealPath(picture)).length();
  }
  filename = node.getFileName(teasession._nLanguage);
  if(filename!=null && filename.length()>0){
	  len_filename = new java.io.File(application.getRealPath(filename)).length();
  }

  repic = node.getRepic(teasession._nLanguage);
  if(repic!=null && repic.length()>0){
	  len_repic= new java.io.File(application.getRealPath(repic)).length();
  }
  stoptime = node.getStopTime();
  content=node.getText(teasession._nLanguage);

}


r.add("/tea/ui/node/type/poll/EditPoll");
int i = node.getOptions1();

Poll2 p2=Poll2.find(node._nNode);



%><html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body onload="foEdit.subject.focus();">
<h1><%=r.getString(teasession._nLanguage, "Poll")%><%=r.getString(teasession._nLanguage, "Edit")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<form name="foEdit" METHOD="POST" action="/servlet/EditPoll" target="_ajax" ENCtype="multipart/form-data" onsubmit="return mt.check(this)">
<input type='hidden' name="node" value="<%=teasession._nNode%>">
<input type='hidden' name="act" value="edit">
<%
if(nexturl!=null)out.print("<input type='hidden' name='nexturl' value='"+nexturl+"' >");
%>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td align="right"><%=r.getString(teasession._nLanguage, "Subject")%>：</td>
  <td><input name="subject" value="<%=subject%>" size="40" alt="<%=r.getString(teasession._nLanguage, "Subject")%>"/></td>
</tr>
<tr>
  <TD align="right"><%=r.getString(teasession._nLanguage, "Options")%>：</TD>
  <td>
    <input id="PollOShowTime" type="CHECKBOX" name=PollOShowTime value=null <%=getCheck((i & 0x40000000) != 0)%>><label for="PollOShowTime"><%=r.getString(teasession._nLanguage, "PollOShowTime")%></label>
<!--
    <input id="CHECKBOX" type="CHECKBOX" name=PollOHideResult value=null <%=getCheck((i & 0x20000000) != 0)%>><%=r.getString(teasession._nLanguage, "PollOHideResult")%>
-->
    <input id="PollOUnanonymous" type="CHECKBOX" name="PollOUnanonymous" onclick="$('t_area').style.display=checked?'':'none'" <%=getCheck((i & 0x10000000) != 0)%>><label for="PollOUnanonymous"><%=r.getString(teasession._nLanguage, "PollOUnanonymous")%></label>

    <input id="PollOMultiple" type="CHECKBOX" name=PollOMultiple value=null <%=getCheck((i & 0x8000000) != 0)%>><label for="PollOMultiple"><%=r.getString(teasession._nLanguage, "PollOMultiple")%></label>
    <input id="result" type="CHECKBOX" name="result" value=null <%=getCheck((i & 0x4000000) != 0)%>><label for="result"><%=r.getString(teasession._nLanguage, "允许查看结果")%></label>
  </td>
</tr>
<tr id="t_area">
<td align="right">投票范围：</td>
<td>
<%
ArrayList e=AdminRole.find(" AND community="+DbAdapter.cite(teasession._strCommunity),0,200);
for(int j=0;j<e.size();j++)
{
  AdminRole ar=(AdminRole)e.get(j);
  int arid=ar.id;
  out.print("<input name='role' type='checkbox' value='"+arid+"'"+(p2.role.indexOf("|"+arid+"|")!=-1?" checked":"")+" id='_role"+arid+"' /><label for='_role"+arid+"'>"+ar.getName()+"</label>　");
}
%>
<br/><input name="member" value="<%=p2.member.substring(1).replace('|','；')%>" readonly="readonly" size="40"/> <input type="button" value="选择..." onclick="mt.show('/jsp/user/list/MemberSelUnit.jsp?field=foEdit.member&member='+encodeURIComponent(foEdit.member.value),1,'选择投票范围',500,350)"/>
</td>
</tr>
<tr>
<td align="right">简介图片：</td>
<td><input type="file" name="picture" value=""/>
<%
if(len_picture > 0)
{
  out.print("<a href='###' onclick=\"mt.img('"+picture+"')\">查看原图&nbsp;("+len_picture + r.getString(teasession._nLanguage, "Bytes")+")</a>");
  out.print("<input id='checkbox' type='checkbox' name='clearpicture' onclick='foEdit.picture.disabled=this.checked'>"+r.getString(teasession._nLanguage, "Clear"));
}
%>
</td>
</tr>
<tr>
<td align="right">显示月份图片：</td>
<td><input type="file" name="filename" value=""/>
<%
if(len_filename > 0)
{
  out.print("<a href='###' onclick=\"mt.img('"+filename+"')\">查看原图&nbsp;("+len_filename + r.getString(teasession._nLanguage, "Bytes")+")</a>");
  out.print("<input id='checkbox' type='checkbox' name='clearfilename' onclick='foEdit.filename.disabled=this.checked'>"+r.getString(teasession._nLanguage, "Clear"));
}
%>
</td>
</tr>
   <tr>
	<td align="right">相关图片：</td>
	<td><input type="file" name="repic" value=""/>
	<%
    if(len_repic > 0)
    {
      out.print("<a href='###' onclick=\"mt.img('"+repic+"')\">查看原图&nbsp;("+len_repic + r.getString(teasession._nLanguage, "Bytes")+")</a>");
      out.print("<input id='checkbox' type='checkbox' name='clearrepic' onclick='foEdit.repic.disabled=this.checked'>"+r.getString(teasession._nLanguage, "Clear"));
    }
%>
	</td>
</tr>


  <tr>
  	<td align="right">截止日期：</td>
  	<td>
  	<input id="stoptime" name="stoptime" size="7"  value="<%if(stoptime!=null)out.print(tea.entity.Entity.sdf.format(stoptime)); %>"  style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('foEdit.stoptime');">
    <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('foEdit.stoptime');" />

  	</td>
  </tr>
  <tr>
  	<td align="right">简介：</td>
  	<td><textarea rows="4" cols="60" name="content"><%if(content!=null)out.print(content); %></textarea></td>
  </tr>

</table>
<P ALIGN=CENTER>
  <input type="submit" name="GoBack" id="edit_GoBack" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "GoBack")%>">
  <input type="submit" name="next" id="edit_GoBack" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "CBNext")%>">
  <input type=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Finish")%>">
</P>
</form>

<script>
foEdit.PollOUnanonymous.onclick();
</script>


<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>
