<%@page contentType="text/html;charset=UTF-8"  %>
<%@page import="java.io.*" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.ui.*"%><%@page import="tea.db.*"%>
<%@page import="java.util.*"%>
<%@page import="tea.htmlx.*"%>
<%
	response.setHeader("Expires", "0");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");

	TeaSession teasession = new TeaSession(request);
	if (teasession._rv == null) {
		response.sendRedirect("/servlet/StartLogin?node="
				+ teasession._nNode + "&nexturl="
				+ request.getRequestURI() + "?"
				+ request.getQueryString());
		return;
	}
	String nexturl = teasession.getParameter("nexturl");
	Resource r = new Resource("/tea/ui/node/talkback/Talkbacks");
	//评论主题
	int tkid = 0;
	if (teasession.getParameter("tkid") != null&& teasession.getParameter("tkid").length() > 0) {
		tkid = Integer.parseInt(teasession.getParameter("tkid"));
	}
	Talkback tkobj = Talkback.find(tkid);
	
	//回复的
	int trid = 0;
	if (teasession.getParameter("trid") != null&& teasession.getParameter("trid").length() > 0) {
		trid = Integer.parseInt(teasession.getParameter("trid"));
	}
	TalkbackReply obj = TalkbackReply.find(trid);
%>
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">

</head>
<body>

<script type="text/javascript">
   function f_submit()
   {

	   if(form1.reply.value=='')
	   {
		   alert('请填写评论内容!');
		   form1.reply.focus();
		   return false;
	   }
	   if(form1.hidden.value==-1){
		   alert("请选择评论状态!");
		   form1.hidden.focus();
		   return false;
	   }
	   
	   form1.action="/servlet/EditTalkbackReply";
	   form1.submit();
   }
</script>

<h1><%=r.getString(teasession._nLanguage, "评论回复审核")%></h1>
<div id="head6"><img height="6" src="about:blank" alt=""></div>




    <FORM NAME="form1" METHOD=POST action="?" onsubmit="return f_submit();">
    <INPUT type="hidden" name="node" value="<%=teasession._nNode%>">
   <input type='hidden' name='nexturl' value="<%=nexturl%>">
   <input type='hidden' name='act' value="EditTalkbackReply">
   <input type="hidden" name="trid" value="<%=trid%>"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

	<tr style="display:none">
		<td align="right">评论主题:</td>
		<td><%=tkobj.getSubject(teasession._nLanguage)%></td>
	</tr>
	
		<tr>
		<td align="right"><font color="red">*</font>&nbsp;回复内容:</td>
		<td><textarea rows="5" cols="50" name="reply"><%=obj.getText() %></textarea></td>
	</tr>
	<tr>
		<td align="right">回复人员:</td>
		<td><%
			tea.entity.member.Profile pobj = tea.entity.member.Profile.find(obj.getMember());
	    	String pname = pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage);
			String cname = obj.getMember();
			if(pname!=null)
			{
				cname = pname;
			}
			if (obj.getMember() != null&& obj.getMember().length() == 32) {
				out.print("游客");
			} else {
				out.print(cname);
			}
		
		%></td>
	</tr>
	<tr>
			<td align="right">回复时间:</td>
			<td><%=obj.sdf2.format(obj.getTime())%></td>
	</tr>
	
     
    
      
      <%
            	if ("audit".equals(teasession.getParameter("act"))) {
            %>
       <tr>
        <td align="right"><font color="red">*</font>&nbsp;<%=r.getString(teasession._nLanguage, "评论状态")%>:</td>
        <td><select name="hidden">
        	<option value="-1">-评论状态-</option>
        	<option value="1" <%if (obj.getHidden() == 1)
					out.print(" selected ");%>>-审核通过-</option>
        	<option value="2" <%if (obj.getHidden() == 2)
					out.print(" selected ");%>>-拒绝评论-</option>
        	
        </select></td>
      </tr>
      <%
      	} else if ("edit".equals(teasession.getParameter("act"))) {

      		out.print("<input type=hidden name=hidden value=0>");
      	}
      %>
      
      
      <tr>
      <td align="center" colspan="2"><input type="submit" value="　提交　">&nbsp;<input type="button" value="　返回　" onclick="window.open('<%=nexturl%>','_self');"/></td>
      </tr>
  </table>

      </form>
  
<div id="head6"><img height="6" src="about:blank" alt=""></div>
<div id="language"><%=new Languages(teasession._nLanguage, request)%></div>
</body>
</html>
