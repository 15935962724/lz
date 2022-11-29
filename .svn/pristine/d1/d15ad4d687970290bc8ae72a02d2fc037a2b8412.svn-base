<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%

r.add("/tea/ui/node/type/chat/SendChat");
 


%>


<html>
<head>
<META HTTP-EQUIV=Content-Type CONTENT="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<script>
	function f_sub()
	{
		if(foSend.buffer.value=='')
		{
			alert('内容不能为空');
			foSend.buffer.focus();
			return false;
		}

		
		setTimeout("sendx('/servlet/Ajax?act=http.length',function(a){a=parseInt(a)/1048576;if(a<=0.5)return;alert('您上传的附件大小为:'+a.toFixed(2)+'M\\n\\r附件的大小限制为:0.5M');location.reload();});",1000);
		
		  
	}
</script>
<body onload="foSend.buffer.focus();">
<!-- this.to.value=parent.frChatMembers.foChatMembers.Member.value;this.action.value=parent.frChatMembers.foChatMembers.Action.value;this.text.value=this.buffer.value;this.buffer.value='';return(true); -->
<FORM name=foSend METHOD=POST action="send_edit.jsp"  ENCtype=multipart/form-data onsubmit=f_sub();><!-- ENCtype=multipart/form-data  --> 
<input type='hidden' name="node" value="<%=teasession._nNode%>"> 
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type='hidden' name="to" value="">


<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>


<td align="right"><%=r.getString(teasession._nLanguage, "请输入聊天内容")%>：</td>
<td><SELECT name="action">
<%
for(int i=2;i<Chat.CHAT_ACTION.length;i++)
{
  out.print("<option value="+i+">"+r.getString(teasession._nLanguage, Chat.CHAT_ACTION[i]));
}
%> 
</SELECT>
<input type=text size =70  name="buffer">
<input name="submit" type=SUBMIT class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>" ><!-- onclick=f_sub(); -->
<!-- <input name="Leave" type=BUTTON class="edit_button" onClick="window.location='/servlet/LeaveChat'" VALUE="<%=r.getString(teasession._nLanguage, "Leave")%>">-->
</td>

</tr>
<tr><td align="right"><%=r.getString(teasession._nLanguage, "附件")%>：</td>
<td COLSPAN=6><input type="file" name="attach" class="edit_input"/>
</td></tr>

</tr>
</table>
</form>

</body>
</html>
