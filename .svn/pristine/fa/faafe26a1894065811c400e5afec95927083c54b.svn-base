<%@page contentType="text/html;charset=UTF-8"  %>
<%@page import="tea.entity.site.*"%>
<%

tea.ui.TeaSession teasession =new tea.ui.TeaSession(request);
tea.entity.node.Node node=tea.entity.node.Node.find(teasession._nNode);

String community=request.getParameter("community");
if(community==null)
{
  community=node.getCommunity();
}
tea.entity.node.Purview purview=tea.entity.node.Purview.find(teasession._rv.toString(),community);
%>
<html>
<head>
<TITLE>应聘管理</TITLE>

<LINK REL=StyleSheet >
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></head>
<style type="text/css">
<!--
*{font-size:9pt;}
body{text-align:center;padding:0;margin:0;}


-->
</style>

<BODY>
<DIV ID=Body>
  <DIV ID="Header">

		 <table  border="0" cellspacing="0" cellpadding="0">
  <tr>

  <%
            if(purview.isCompany()||License.getInstance().getWebMaster().equals(teasession._rv.toString())){
            %>
    <td><table width="100%"  border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td id="l1"><img src="spacer.gif" width="1" height="1"></td>
        <td id="l3"> <A href="/jsp/type/company/yjobcompanymanage.jsp" target="mainFrame" ID=Listing5817>机构设置</A></td>
        <td id="l2"><img src="spacer.gif" width="1" height="1"></td>
      </tr>
    </table></td>

	<%          }
   tea.entity.site.Communityjob   communityObj=  tea.entity.site.Communityjob.find(teasession._strCommunity);

if(teasession._rv.toString().equalsIgnoreCase(communityObj.getJobmember())||License.getInstance().getWebMaster().equals(teasession._rv.toString())){
%>
    <td><table width="100%"  border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td id="l1"><img src="spacer.gif" width="1" height="1"></td>
        <td id="l3"> <A href="/jsp/community/yjobsubscribers.jsp" target="mainFrame"  ID=Listing5817>用户管理</A></td>
        <td id="l2"><img src="spacer.gif" width="1" height="1"></td>
      </tr>
    </table></td>

	<%}
          if(purview.isJob()||License.getInstance().getWebMaster().equals(teasession._rv.toString())){%>
    <td><table width="100%"  border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td id="l1"><img src="spacer.gif" width="1" height="1"></td>
        <td id="l3"> <A href="/jsp/type/job/yjobjobmanage.jsp" target="mainFrame"  ID=Listing5817>职位管理</A></td>
        <td id="l2"><img src="spacer.gif" width="1" height="1"></td>
      </tr>
    </table></td>
    <%}
          if(purview.isApply()||License.getInstance().getWebMaster().equals(teasession._rv.toString())){%>


    <td><table width="100%"  border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td id="l1"><img src="spacer.gif" width="1" height="1"></td>
        <td id="l3"><A href="/jsp/type/resume/yjobapplymanage.jsp"  target="mainFrame"  ID=Listing5817>应聘管理</A></td>
        <td id="l2"><img src="spacer.gif" width="1" height="1"></td>
      </tr>
    </table></td>
   <%}
          if(purview.isResume()||License.getInstance().getWebMaster().equals(teasession._rv.toString())){%>


    <td><table width="100%"  border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td id="l1"><img src="spacer.gif" width="1" height="1"></td>
        <td id="l3"><A href="/jsp/type/resume/yjobresumemanage.jsp" target="mainFrame"  ID=Listing5817>简历管理</A></td>
        <td id="l2"><img src="spacer.gif" width="1" height="1"></td>
      </tr>
    </table></td>
	<%}
%>

    <td><table width="100%"  border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td id="l1"><img src="spacer.gif" width="1" height="1"></td>
        <td id="l3"><A href="/jsp/type/job/yjobtalkback.jsp"  target="mainFrame"  ID=Listing5817>反馈信息</A></td>
        <td id="l2"><img src="spacer.gif" width="1" height="1"></td>
      </tr>
    </table></td>
  </tr>
</table>
  </div>

</DIV>
</BODY>
</html>

