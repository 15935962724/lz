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
<%
Resource r = new Resource();

TeaSession teasession=new TeaSession(request);

int node=teasession._nNode;
int language=teasession._nLanguage;

Node n=Node.find(node);



%>
<script>
function f_ref()
{
	var imgv=document.getElementById("imgv");
	imgv.src="/NFasts.do?act=verify&t="+new Date().getTime();
}
function f_trv()
{
	var trv=document.getElementById("trv").style;
	if(form_celerity.member&&form_celerity.member[0].checked)
	{
		trv.display="none";
	}else if(trv.display=="none")
	{
		trv.display="";
		f_ref();
	}
}
</script>
 <FORM NAME=form_celerity METHOD=POST action="/servlet/EditBBSReply" target="_ajax"  onSubmit="return mt.check(this);">
   <input type="hidden" name="community" value="<%=teasession._strCommunity%>">
   <input type="hidden" name="node" value="<%=node%>">
   <input type="hidden" name="bbsreply" value="0">
   <input type="hidden" name="hint" value="0">
  <INPUT type="hidden" name=nonuse VALUE="ON">
  <TABLE CELLSPACING=0 CELLPADDING=0 border="0" class="section">
     <TR>
      <Td nowrap="nowrap"><%=r.getString(language, "Subject")%>:</Td>
      <TD nowrap><input name="subject" onfocus="f_trv()" size="40" value="回复: <%=n.getSubject(language)%>" alt="<%=r.getString(language, "Subject")%>"></TD>
      <td><a href="###" onclick="window.open('/jsp/type/bbs/EditBBSReply.jsp?node=<%=node%>','_self')">高级回复</a></td>
    </TR>
     <TR>
      <Td nowrap="nowrap"><%=r.getString(language, "Text")%>:</Td>
      <TD nowrap>
<%
if(request.getServerName().endsWith(".westrac.com.cn"))
{
  out.print("<textarea name='content' style='display:none'></textarea><iframe id='editor' src='/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=MyBBS' width='500' height='200' frameborder='no' scrolling='no'></iframe>");
}else
{
  out.print("<textarea name='content' onfocus='f_trv()' cols=70 rows=10 alt='"+r.getString(language,"Text")+"'></textarea>");
}
%>
      </TD>
    </TR>
    <TR>
      <Td nowrap="nowrap"><%=r.getString(language, "图片/视频链接")%>:</Td>
      <TD nowrap><input name="anchor" onfocus="f_trv()" size="40" value="http://"></TD>
    </TR>
    <%
   // out.print("<tr ID=forumid><td nowrap>"+r.getString(teasession._nLanguage, "附件")+":</td><td nowrap style='height:100px'><iframe src='/jsp/type/bbs/EditBBSAttach.jsp?type=false&bbsid=0&node="+forum+"' allowtransparency='true' scrolling='no' id='ba' height='100px' width='100%' frameborder='0'></iframe></td></tr>");
   out.print("<tr><td nowrap>"+r.getString(teasession._nLanguage, "附件")+":</td><td nowrap><iframe src='/jsp/type/bbs/EditBBSAttach.jsp?type=true&bbsid=0&node="+n.getFather()+"' scrolling='no' id='ba' height='20px' width='100%' allowtransparency='true' frameborder='0'></iframe></td></tr>");
   if(teasession._rv!=null)
   {
     tea.entity.member.ProfileBBS p = tea.entity.member.ProfileBBS.find(teasession._strCommunity ,teasession._rv.toString());

     out.print("<tr id=trcurrentlyuser><td id=cuuser>用户名:</td><td><span id=currentlyuser> <input  name=member type=radio onclick=f_trv() checked />"+p.getTitle(teasession._nLanguage)+" </span><span id=anonymity> <input   name=member type=radio onclick=f_trv() value='"+RV.ANONYMITY+"' >匿名发表</span></td></tr>");
   }
    %>
    <TR id="trv" style="display:none">
      <Td nowrap="nowrap"><%=r.getString(language, "验证码")%>:</Td>
      <TD nowrap><input name="vertify" size="8"><img id="imgv" src="about:blank" align="top" width="60" height="20"><a href="javascript:f_ref()">看不清?</a></TD>
    </TR>

   </TABLE>
  <center>
     <INPUT TYPE=SUBMIT VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
   </center>
</FORM>
