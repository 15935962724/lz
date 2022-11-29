<%@page contentType="text/html;charset=UTF-8"  %>
<%@page import="java.io.*" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.commentreview.CommentReview"%>
<%@page import="tea.entity.pm.PoFamousComment"%>
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
	int crid = 0;
	if (teasession.getParameter("crid") != null
			&& teasession.getParameter("crid").length() > 0) {
		crid = Integer.parseInt(teasession.getParameter("crid"));
	}
	CommentReview obj = CommentReview.find(crid);
	String title = "";
	PoFamousComment pfc = new PoFamousComment();
	if(obj.getType()==0){
		pfc = PoFamousComment.find(obj.getFkeyid());
		title = pfc.getTitle();
	}
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
	   if(form1.subject.value=='')
	   {
		   alert('请填写主题!');
		   form1.subject.focus();
		   return false;
	   }
	   if(form1.content.value=='')
	   {
		   alert('请填写内容!');
		   form1.content.focus();
		   return false;
	   }
	   if(form1.state.value==-1){
		   alert("请选择评论状态!");
		   form1.state.focus();
		   return false;
	   }

	   form1.action="/EditCommentReview.do";
	   form1.submit();
   }
</script>

<h1><%=r.getString(teasession._nLanguage, "评论审核")%></h1>
<div id="head6"><img height="6" src="about:blank" alt=""></div>




    <FORM NAME="form1" METHOD=POST action="?" onSubmit="return f_submit();">
    <INPUT type="hidden" name="node" value="<%=teasession._nNode%>">
   <input type='hidden' name='nexturl' value="<%=nexturl%>">
   <input type='hidden' name='act' value="EditCommentReview">
   <input type="hidden" name="crid" value="<%=crid %>"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

	<tr>
		<td align="right">作品名:</td>
		<td><%=title%></td>
	</tr>
	<tr>
		<td align="right">请求人员:</td>
		<td><%
		tea.entity.member.Profile pobj = tea.entity.member.Profile.find(obj.getCreator().toString());
    	String pname = pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage);
    	String cname = obj.getCreator().toString();
    	if(pname!=null && pname.length()>0){
    		cname = pname;
    	}
		if(obj.getCreator().toString()!=null&&obj.getCreator().toString().length()==32){out.print("游客");}else{out.print(cname);}
		%></td>
	</tr>
	<tr>
		<td align="right">请求时间:</td>
		<td><%=obj.getTimeToString() %></td>
	</tr>
    <tr><td align="right"><%=r.getString(teasession._nLanguage, "Hint")%>:</td>
      <td>
      <%
      	for (int i = 1; i < 11; i++) {
      		out.print("<input id=radio"+i+" type=radio name=hint value=" + i);
      		if (obj.getHint() == i) {
      			out.print(" checked ");
      		}
      		out.print(">");
            out.print("<img src=/tea/image/hint/"+i+".gif");
            out.print(" style=cursor:pointer  onclick=document.getElementById('radio"+i+"').checked=true  title="+CommentReview.getHintString(i,teasession._nLanguage));
            out.print(">");
      	}
      %></td>
      </tr>
      <tr style="display:none">
        <td align="right"><font color="red">*</font>&nbsp;<%=r.getString(teasession._nLanguage, "Subject")%>:</td>
        <td><INPUT NAME="subject" TYPE=TEXT class="edit_input" VALUE="<%=obj.getNULL(obj.getSubject(teasession._nLanguage)) %>" SIZE=80 MAXLENGTH=255></td>
      </tr>
      <tr>
        <td align="right"><font color="red">*</font>&nbsp;<%=r.getString(teasession._nLanguage, "Content")%>:</td>
        <td><TEXTAREA id="status"   NAME="content" COLS=60 ROWS=8 class="edit_input" ><%=obj.getNULL(obj.getContent(teasession._nLanguage)) %></TEXTAREA></td>
      </tr>

      <%-- <%if("audit".equals(teasession.getParameter("act"))){ %>
       <tr>
        <td align="right"><font color="red">*</font>&nbsp;<%=r.getString(teasession._nLanguage, "评论状态")%>:</td>
        <td><select name="state">
        	<option value="-1">-评论状态-</option>
        	<option value="1" <%if(obj.getState()==1)out.print(" selected "); %>>-审核通过-</option>
        	<option value="2" <%if(obj.getState()==2)out.print(" selected "); %>>-拒绝评论-</option>

        </select></td>
      </tr>
      <%}else if("edit".equals(teasession.getParameter("act"))){

    	  out.print("<input type=hidden name=state value=0>");
      } %> --%>
      
       <tr>
        <td align="right"><font color="red">*</font>&nbsp;<%=r.getString(teasession._nLanguage, "评论状态")%>:</td>
        <td><select name="state">
        	<option value="-1">-评论状态-</option>
        	<option value="1" <%if(obj.getState()==1)out.print(" selected "); %>>-审核通过-</option>
        	<option value="2" <%if(obj.getState()==2)out.print(" selected "); %>>-拒绝评论-</option>

        </select></td>
      </tr>


      <tr>
      <td align="center" colspan="2"><input type="submit" value="　提交　">&nbsp;<input type="button" value="　返回　" onClick="window.open('<%=nexturl %>','_self');"/></td>
      </tr>
  </table>

      </form>

<div id="head6"><img height="6" src="about:blank" alt=""></div>
<div id="language"><%=new Languages(teasession._nLanguage, request)%></div>
</body>
</html>
