<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.site.*" %><%@page import="java.io.*" %><%@page import="java.util.*" %><%@page import="tea.html.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.entity.admin.*" %><%@page import="java.math.*" %><%@page import="tea.entity.*" %><%@page import="tea.db.DbAdapter"%><%@page import="tea.resource.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Http h=new Http(request);

int flowbusiness=h.getInt("flowbusiness");
int flowprocess=60;//综合部制作

if("POST".equals(request.getMethod()))
{
  String reason=h.get("reason");
  String[] nm=h.getValues("member");

  Flowbusiness fb=Flowbusiness.find(flowbusiness);
  Flowprocess fp=Flowprocess.find(fb.getFlow(),fb.getStep());
  Flowview fv=Flowview.find(flowbusiness,fp.getFlowprocess(),teasession._rv._strR);
  fv.setState(2);

  fb.setReason(reason);
  fb.next(nm,flowprocess,0);
  out.println("<script>window.returnValue=true; window.close();</script>");
  return;
}

Flowprocess fp=Flowprocess.find(flowprocess);
StringBuffer sb=new StringBuffer();
Enumeration e=Flowview.find(flowbusiness,flowprocess);
while(e.hasMoreElements())
{
  int id=((Integer)e.nextElement()).intValue();
  String str=Flowview.find(id).getTransactor();
  sb.append(str+"、<input type='hidden' name='member' value=\""+str+"\" />");
}

%><html>
<head>
<title>不符合上报要求</title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script LANGUAGE=JAVASCRIPT src="/tea/tea.js" type="text/javascript"></script>
<script LANGUAGE=JAVASCRIPT src="/tea/mt.js" type="text/javascript"></script>
<style type="text/css">
<!--
body
{
 margin-left: 0px;
 margin-top: 0px;
 margin-right: 0px;
 margin-bottom: 0px;
 border:0px;
 background-color:menu;
}
-->
</style>
<script>
var opener=opener?opener:dialogArguments;
function f_submit()
{

}
</script>
</head>
<body class="Pop_up">
<form name="form1" action="?" method="post" onSubmit="return submitText(this.reason,'“原因”不能为空！')&&f_submit();">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="flowbusiness" value="<%=flowbusiness%>"/>

  <table border='0' cellpadding='0' cellspacing='0' id="TableAnnex" >
    <tr><td class="TableAnnextitle">回退到:</td><td class="TableAnnextitle">回退给:</td></tr>
    <tr><td><%=fp.getName(teasession._nLanguage)%></td><td colspan="2"><%=sb.toString()%></td></tr>
    <tr><td colspan="2" class="TableAnnextitle">写明回退原因:</td></tr>
    <tr>
      <td colspan="2"><textarea name="reason" cols="48" rows="15"></textarea></td>
      <td valign='top' id="inputbutton">
        <input type='submit' value=' 确 定 '/><br/>
        <input type='button' onclick='window.close();' value=' 取 消 '/>
      </td>
    </tr>
  </table>
</form>


</body>
</html>
