<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.*"  %>
<%@ page  import="tea.entity.admin.*" %>
<%@ page  import="tea.htmlx.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.entity.admin.*" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}




int alid = 0;
if(teasession.getParameter("alid")!=null && teasession.getParameter("alid").length()>0)
{
  alid = Integer.parseInt(teasession.getParameter("alid"));
}

Already alobj = Already.find(alid);
Flowitem fobj = Flowitem.find(alobj.getFlowitem());
Workproject wobj = Workproject.find(alobj.getWorkproject());


java.math.BigDecimal amount =null;
String project = null,membera=null,memberb=null,timemoney =null;
int way = 0,invoice=0;

if(alid>0)
{
  timemoney=alobj.getTimemoneyToString();
  amount=alobj.getAmount();
  project=alobj.getProject();
  membera=alobj.getMembera();
  memberb=alobj.getMemberb();
  way = alobj.getWay();
  invoice=alobj.getInvoice();
}
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>
<script type="">
window.name='tar';
</script>

<h1>项目收款记录</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
   <form name=form1 method="POST" action="?"  target="tar">

     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
         <td>所属客户：</td>
         <td><%=wobj.getName(teasession._nLanguage)%></td>
       </tr>
        <tr>
         <td>所属项目：</td>
         <td><%=fobj.getName(teasession._nLanguage)%></td>
       </tr>
       <tr>
         <td>收款金额：</td>
         <td><%if(amount!=null)out.print(amount);%></td>
       </tr>
        <tr>
         <td>收款日期：</td>
         <td><%=timemoney%></td>
       </tr>
       <tr>
         <td>收款项目：</td>
         <td><%if(project!=null)out.print(project);%></td>
       </tr>
        <tr>
         <td>收款方式：</td>
         <td>
         <%=Already.WAY_TYPE[alobj.getWay()]%>

         </td>
       </tr>
       <tr>
         <td>甲方经办人：</td>
         <td>
         <%
         if(membera!=null){
           tea.entity.member.Profile profile=tea.entity.member.Profile.find(membera);
           out.print(profile.getLastName(teasession._nLanguage)+profile.getFirstName(teasession._nLanguage));
         }
         %>
         </td>
       </tr>
          <tr>
         <td>乙方经办人：</td>
         <td>
               <%
               if(memberb!=null){
                 tea.entity.member.Profile profile=tea.entity.member.Profile.find(memberb);
                 out.print(profile.getLastName(teasession._nLanguage)+profile.getFirstName(teasession._nLanguage));
               }
         %>
         </td>
       </tr>
        <tr>
         <td>发票情况：</td>
         <td><%
         if(invoice==0){
           out.print("未开");
         }
         if(invoice==1){
           out.print("已开");
         }
         %> </td>
       </tr>
     </table>
<br>
<input type="button" value="关闭"  onClick="javascript:window.close();">

</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>



