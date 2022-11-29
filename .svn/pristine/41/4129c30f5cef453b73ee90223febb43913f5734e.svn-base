<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.io.*" %>
<%@page import="tea.resource.*" %>
<%@page import="javax.servlet.ServletConfig" %>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.ui.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.html.HtmlElement"%>
<%!
String getCheck(boolean bool)
{
	return bool?" CHECKED ":" ";
}
String getCheck(int value)
{
	return value!=0?" CHECKED ":" ";
}
String getNull(String strNull)
{	return strNull==null?"":strNull;
}%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
Resource r = new Resource();TeaSession teasession = new TeaSession(request);
Node   node=Node.find(teasession._nNode);
int nodes = 0;
if(teasession.getParameter("nodes")!=null && teasession.getParameter("nodes").length()>0)
{
  nodes = Integer.parseInt(teasession.getParameter("nodes"));
}
else
{
  nodes = teasession._nNode;
}
%>

<script language="javascript">
         function reloadVcode()//点击更换验证码
         {
           var vcode = document.getElementById('vcodeImg'); 
           vcode.setAttribute('src','/jsp/user/addValidate.jsp?r='+Math.random());
         }
</script>
<!--h1><%=r.getString(teasession._nLanguage, "EditInterlocutionReply")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div-->

  <div id="suibian">
  <FORM NAME=foEdit METHOD=POST action="/servlet/EditInterlocution"  onSubmit="">

    <INPUT TYPE=HIDDEN NAME=Node VALUE="<%=nodes%>">
 <INPUT TYPE=HIDDEN NAME=act VALUE="editreply">
    <TABLE border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter_back">
    <input  id="radio" type="hidden" name=TextOrHtml value=0  >
    <!-- 
      <tr>

        <td><input  id="radio" type="radio" name=TextOrHtml value=0  checked="checked" >
          <%=r.getString(teasession._nLanguage, "TEXT")%>
          <input  id="radio" type="radio" name=TextOrHtml value=1 >
          HTML</td>
      </tr>
       -->
      <TR>

        <TD nowrap><textarea name="Text"  rows="8" cols="70" class="edit_input"></textarea>
        </TD>
      </TR>
        <TR>

        <TD nowrap>
        验证码：
        <img class="CodeImg" id="vcodeImg" style="cursor: pointer" alt="点击更换验证码" align="absMiddle" onClick="reloadVcode();" src="/jsp/user/addValidate.jsp" />
           &nbsp;<input size="5" name="vertify" type="text" />&nbsp;
           <a href="###" onclick="reloadVcode();">点击这里更换验证码</a>
       
        </TD>
      </TR>

    </TABLE>
      <div id="huid_wt">回答即可得2分，回答被采纳则获得悬赏分以及奖励20分,回答字数在10000字以内。 <a href="/html/category/<%=teasession.getParameter("jfnode") %>-<%=teasession._nLanguage %>.htm" target="_blank">积分规则</a></div>
      <INPUT TYPE=SUBMIT onClick="return(submitText(foEdit.Text, '<%=r.getString(teasession._nLanguage,"InvalidParameter")%>'));" class="edit_button" VALUE="提交回答">
  </FORM></div>



