<%@page contentType="text/html;charset=UTF-8"  %>
<html>
<head>
<TITLE>应聘管理</TITLE>

<LINK REL=StyleSheet HREF>
<script src="/tea/tea.js" type="text/javascript"></script><LINK href="/tea/CssJs/18.css" REL="stylesheet" TYPE="text/css">
<SCRIPT LANGUAGE="JAVASCRIPT" SRC="/tea/CssJs/18.js"></SCRIPT><LINK href="/tea/CssJs/19.css" REL="stylesheet" TYPE="text/css">
<SCRIPT LANGUAGE="JAVASCRIPT" SRC="/tea/CssJs/19.js"></SCRIPT><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></head>
<BODY>
<DIV ID=Body>
  <DIV ID="Header">
    <table border="0" width="100%" cellspacing="0" cellpadding="0">
      <tr>
        <td width="282" rowspan="2">
          <img border="0" src="/tea/image/section/11436.gif">
        </td>
        <td align="left">
          <br>
          <img src="/tea/image/section/11454.jpg">
        </td>
        <td align="right" valigh=bottom style="padding-right:30px">
          <br>
          　　　
          <a href="/jsp/type/job/cnoocjobindex.jsp?node=15483" target="_blank">　::管理首页::</a>
          <a href="/servlet/Folder?node=15433" target="_blank">　　　::招聘首页::</a>
          <a href="/servlet/Logout">　　　::退出登陆::</a>
          　　　　
        </td>
      </tr>
    </table>
    <table border="0" height="6px" cellspacing="0" cellpadding="0">
      <tr>
        <td>        </td>
      </tr>
    </table>
    <div id=biaoti2wai>
      <div id="biaoti2nei">
        <ul id=biaoti2list>
            <%
            if(purview.isCompany()||License.getInstance().getWebMaster().equals(teasession._rv.toString())){
            %>
            <LI>::　<Span ID=NodeTitle><A href="/jsp/type/company/cnoocjobcompanymanage.jsp?node=15537" ID=Listing5817>机构设置</A></Span></LI>
<%          }
if(teasession._rv.toString().equalsIgnoreCase("cnooc")||License.getInstance().getWebMaster().equals(teasession._rv.toString())){
%>
          <LI>::　<Span ID=NodeTitle><A href="/jsp/community/cnoocjobsubscribers.jsp?node=15538" ID=Listing5817>用户管理</A></Span></LI>
          <%}
          if(purview.isJob()||License.getInstance().getWebMaster().equals(teasession._rv.toString())){%>
          <LI>::　<Span ID=NodeTitle><A href="/jsp/type/job/cnoocjobjobmanage.jsp?node=15542" ID=Listing5817>职位管理</A></Span></LI>
          <%}
          if(purview.isApply()||License.getInstance().getWebMaster().equals(teasession._rv.toString())){%>
          <LI>::　<Span ID=NodeTitle><A href="/jsp/type/resume/cnoocjobapplymanage.jsp?node=15542" ID=Listing5817>应聘管理</A></Span></LI>
          <%}
          if(purview.isResume()||License.getInstance().getWebMaster().equals(teasession._rv.toString())){%>
          <LI>::　<Span ID=NodeTitle><A href="/jsp/type/resume/cnoocjobresumemanage.jsp?node=15544" ID=Listing5817>简历管理</A></Span></LI>
<%}
%>
          <LI>::　<Span ID=NodeTitle><A href="/jsp/type/job/cnoocjobtalkback.jsp?node=15545" ID=Listing5817>反馈信息</A></Span>  </LI>
      <LI>::　<Span ID=NodeTitle>当前用户：<%=teasession._rv%></Span>  </LI>   </ul>
      </div>
    </div>
  </DIV>
</DIV>
</BODY>
</html>

