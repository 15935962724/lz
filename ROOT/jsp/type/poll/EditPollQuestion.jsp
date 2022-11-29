<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
 r.add("/tea/ui/node/type/poll/EditPoll");
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body>
<h1><%=r.getString(teasession._nLanguage, "Question")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<form action="/servlet/EditPoll" METHOD="POST" enctype="multipart/form-data" target="_ajax" name="form1">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr ID=tableonetr>
      <TD></TD>
      <TD><%=r.getString(teasession._nLanguage, "Text")%></TD>
      <TD><%=r.getString(teasession._nLanguage, "Type")%></TD>
      <TD><%=r.getString(teasession._nLanguage, "Sequence")%></TD>
      <td><%=r.getString(teasession._nLanguage, "Point")%></td>
      <TD></TD>
    </tr>
    <%
java.util.Enumeration enumer=Poll.findByNode(teasession._nNode,teasession._nLanguage,0,Integer.MAX_VALUE);
for(int i=1;enumer.hasMoreElements();i++)
{
  int id=((Integer)enumer.nextElement()).intValue();
  Poll obj=Poll.find(id);

  String q=tea.html.HtmlElement.htmlToText(obj.getQuestion());

  %>
    <tr onMouseOver="javascript:this.bgColor='#FFFFCA'" onMouseOut="javascript:this.bgColor=''">
      <td width="1"><%=i%></td>
      <td><%=q%></td>
      <td><%=r.getString(teasession._nLanguage,obj.TYPE_TEXT[obj.getType()])%></td>
      <td><%=obj.getSequence()%></td>
      <td><%=obj.getPoint()%></td>
      <td><input type="button" <%if(obj.getType()>1)out.print("disabled");%> onClick="window.location='EditPollChoice.jsp?node=<%=teasession._nNode%>&Poll=<%=id%>';" value="<%=r.getString(teasession._nLanguage,"Choice")%>">
        <input type="button" name="" onClick="form1.Poll.value=<%=id%>;form1.type[<%=obj.getType()%>].checked=true;form1.need.disabled=<%=obj.getType()==0%>;form1.need.checked=<%=obj.getType()==0||obj.isNeed()%>; form1.sequence.value=<%=obj.getSequence()%>; form1.top.value=<%=obj.getTop()%>;form1.question.value='<%=q.replaceAll("\r\n","\\\\r\\\\n").replaceAll("'","‘")%>';form1.point.value='<%=obj.getPoint()%>'; form1.question.focus();form1.nodeid.value='<%=obj.getNodeid()%>';" value="<%=r.getString(teasession._nLanguage,"Edit")%>">
        <input type="submit" name="delete"  onclick="if(confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>')){form1.Poll.value=<%=id%>;}else return false;" value="<%=r.getString(teasession._nLanguage,"Delete")%>"></td>
    </tr>
<%
}
%>
  </table>
  <input type="hidden" name="act" value="Question"  >
  <input type="hidden" name="Poll" value="0">
  <input type="hidden" name="node" value="<%=teasession._nNode%>">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <TD align="right"><%=r.getString(teasession._nLanguage, "投票内容")%>：</TD>
      <td><TEXTAREA name=question ROWS=3 COLS=60 alt="投票内容"></TEXTAREA>
      </td>
    </TR>
    <TR>
      <TD align="right"><%=r.getString(teasession._nLanguage, "Type")%>：</TD>
      <td><input name="type"  id="radio" type="radio" onclick="form1.need.disabled=this.checked;" value="0" checked/><%=r.getString(teasession._nLanguage, "Radio")%>
        <input  id="radio" type="radio" name="type" onclick="form1.need.disabled=!this.checked;" value="1"/><%=r.getString(teasession._nLanguage, "Checkbox")%>
        <input  id="radio" type="radio" name="type" onclick="form1.need.disabled=!this.checked;"  value="2"/><%=r.getString(teasession._nLanguage, "InputText")%>
        <input  id="radio" type="radio" name="type" onclick="form1.need.disabled=!this.checked;"  value="3"/><%=r.getString(teasession._nLanguage, "Textarea")%>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="need" type="checkbox" value="" disabled checked /><%=r.getString(teasession._nLanguage, "1171354677726")%>
    </td>
    </TR>
    <tr>
      <TD align="right"><%=r.getString(teasession._nLanguage, "Sequence")%>：</TD>
      <td><input name="sequence" class="edit_input" value="<%//=poll.getTop()%>" mask="int"/></td>
    </tr>
    <tr>
      <TD align="right"><%=r.getString(teasession._nLanguage, "ResultPicture")%>：</TD>
      <td><input type=FILE name="picture" class="edit_input" ><input onclick="form1.picture.disabled=this.checked;"  id="CHECKBOX" type="CHECKBOX" name=clear value=null><%=r.getString(teasession._nLanguage, "Clear")%>
      </td>
    </tr>
    <tr>
      <TD align="right"><%=r.getString(teasession._nLanguage, "1171354294179")%>：</TD>
      <td><input  name="top" class="edit_input" value="<%//=poll.getTop()%>" mask="int"/></td>
    </tr>
    <tr>
      <TD align="right"><%=r.getString(teasession._nLanguage, "Point")%>：</TD>
      <td><input  name="point" class="edit_input" value="0" mask="int"/></td>
    </tr>
    <tr>
      <TD align="right"><%=r.getString(teasession._nLanguage, "页面链接ID号")%>：</TD>
      <td><input  name="nodeid" class="edit_input" value="0">&nbsp;&nbsp;(链接页面中引用的jsp文件:/jsp/type/poll/PollbigPic.jsp)</td>
    </tr>
    <tR>
      <TD></TD>
      <td><input name="Input" type="submit" value="<%=r.getString(teasession._nLanguage, "Submit")%>" onclick="return mt.check(form1)"></td>
    </tr>
  </table>
  <input type="button" onClick="window.location='/jsp/type/poll/EditPoll.jsp?node=<%=teasession._nNode%>';" name="GoBack" id="edit_GoBack" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "GoBack")%>">
  <input type=button name="GoFinish" onClick="window.location='/html/poll/<%=teasession._nNode%>-<%=teasession._nLanguage%>.htm';" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Finish")%>">
</form>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>

