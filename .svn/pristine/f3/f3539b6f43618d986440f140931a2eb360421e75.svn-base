<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.node.*" %><%@page import="tea.ui.*" %><%@page import="tea.db.DbAdapter" %><% request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

tea.resource.Resource r=new tea.resource.Resource();

String nexturl=request.getRequestURI()+"?"+request.getQueryString();

Node node=Node.find(teasession._nNode);
if(node.getCreator()==null)
{
  response.sendError(404);
  return;
}
Interlocution mb=Interlocution.find(teasession._nNode,teasession._nLanguage);

int replyid = 0,nodeid;
if(teasession.getParameter("id")!=null && teasession.getParameter("id").length()>0)
{
  nodeid = teasession._nNode;
  replyid = Integer.parseInt(teasession.getParameter("id"));
  InterlocutionReply.updateBack(replyid,1,nodeid);
}

String bg = "XX";
if(teasession.getParameter("bg")!=null && teasession.getParameter("bg").length()>0)
{
  bg = teasession.getParameter("bg");
}

boolean falg=false;



%><html>
<head>
  <script src="/tea/tea.js" type="text/javascript"></script>
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1>问答中心回复管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <br>

  <form name="form1" action="/servlet/EditInterlocution">
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>" />
  <INPUT TYPE=HIDDEN NAME=Node VALUE="<%=teasession._nNode%>">
    <INPUT TYPE=HIDDEN NAME=nexturl VALUE="<%=nexturl%>">
      <INPUT TYPE=HIDDEN NAME=act VALUE="deletereply">

        <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
          <tr><td>主题:　　 <%=node.getSubject(teasession._nLanguage)%></td></tr>
          <tr><td>用户名:　 <%=node.getCreator()%></td></tr>
          <tr><td>姓名:　　 <%=mb.getName()%></td></tr>
          <tr><td>悬赏积分:　　 <%=mb.getOfferintegral()%></td></tr>
          <tr><td>电话号码: <%=mb.getPhone()%></td></tr>
          <tr><td>手机号:　 <%=mb.getMobile()%></td></tr>
          <tr><td>E-Mail:　 <%=mb.getEmail()%></td></tr>
          <tr><td>回复次数: <%=InterlocutionReply.count(teasession._nNode,teasession._nLanguage)%></td></tr>
          <tr><td>发表时间: <%=node.getTimeToString()%></td></tr>
          <tr><td colspan="2"><hr size="1" /></td></tr>
          <tr><td colspan="2"><%=node.getText(teasession._nLanguage)%></td></tr>
          <tr><td colspan="2">&nbsp;</td></tr>
          <%
          //mb.getHint()
          int i = 1;
          java.util.Enumeration e=InterlocutionReply.findold(teasession._nNode,teasession._nLanguage);
          while(e.hasMoreElements())
          {
            int id=((Integer)e.nextElement()).intValue();
            InterlocutionReply mbr=InterlocutionReply.find(id);
            int backstatics = 0;
            backstatics=mbr.getBackstatic();
            falg =InterlocutionReply.rebackstatic(mbr.getNode(),1);
            %>

            <%
            if(!falg && i==1)
            {
              %>
              <tr id="tableonetr_good"><td><%=InterlocutionReply.BACKSTATIC[mbr.getBackstatic()]%><input name=interlocutionreply type=checkbox value="<%=id%>" >回复人:<%=mbr.getMember()%></td><td>时间:<%=mbr.getTimeToString()%></td><td>

              <%
              i=2;
            }
            else
            {
              %>
              <tr id="tableonetr"><td><%=InterlocutionReply.BACKSTATIC[mbr.getBackstatic()]%><input name=interlocutionreply type=checkbox value="<%=id%>" >回复人:<%=mbr.getMember()%></td><td>时间:<%=mbr.getTimeToString()%></td><td>

              <%

            }

            if(falg)
            {
              %>
              <input  value="设置为最佳答案" type="button"  onclick="window.open('/jsp/type/interlocution/InterlocutionReplyManage.jsp?id=<%=id%>&nexturl=<%=nexturl%>','_self');">
              <%
              }
              else
              {

              }
              %>
              </td>
              <tr><td colspan="3"><%=mbr.getText()%></td></tr>

              <tr><td colspan="3">&nbsp;</td></tr>
              <%


            }%>


             <%if(bg.equals("on"))
            {
             %>
               <tr><td><input type="checkbox" onclick="if(form1.interlocutionreply){form1.interlocutionreply.checked=this.checked;for(var i=form1.interlocutionreply.length;i>0;i--)form1.interlocutionreply[i-1].checked=this.checked; }" /><%=r.getString(teasession._nLanguage,"全选")%>
             　<input type="submit" value="<%=r.getString(teasession._nLanguage,"CBDelete")%>" onClick="return(confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>'));"></td>



             <%
             }
             %>


</tr>
        </table>
</FORM>

<FORM NAME=foEdit METHOD=POST action="/servlet/EditInterlocution"  onSubmit="">
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>" />
  <INPUT TYPE=HIDDEN NAME=Node VALUE="<%=teasession._nNode%>">
    <INPUT TYPE=HIDDEN NAME=nexturl VALUE="<%=nexturl%>">
      <INPUT TYPE=HIDDEN NAME=act VALUE="editreply">
        <TABLE border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
          <tr>
            <TD> </TD>
            <td><input id="radio" type="radio" name=TextOrHtml value=0  checked="checked" ><%=r.getString(teasession._nLanguage, "TEXT")%>
              <input id="radio" type="radio" name=TextOrHtml value=1 >HTML</td>
          </tr>
          <TR>
            <td nowrap><%=r.getString(teasession._nLanguage, "Text")%>:</TD>
            <TD nowrap><textarea name="Text"  rows="8" cols="70" class="edit_input"></textarea>
</TD>
          </TR>
          <TR>
            <td nowrap><%=r.getString(teasession._nLanguage, "Options")%>:</TD>
            <TD nowrap><input type="radio" name="hidden" value="false" checked /><%=r.getString(teasession._nLanguage, "所有人可见")%>
              <input type="radio" name="hidden" value="true" /><%=r.getString(teasession._nLanguage, "只有留言者可见")%>
              &nbsp;<input type="checkbox" name="send" value="true" checked/>同时回复到该会员的内部邮箱中
            </TD>
          </TR>
        </TABLE>

        <INPUT TYPE=SUBMIT onClick="return(submitText(foEdit.Text, '<%=r.getString(teasession._nLanguage,"InvalidParameter")%>'));" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
</FORM>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>

