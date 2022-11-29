<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.member.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.ui.TeaSession" %>
<% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

int flowbusiness=Integer.parseInt(teasession.getParameter("flowbusiness"));

if("POST".equals(request.getMethod()))
{
  String subject=request.getParameter("subject");
  String content=request.getParameter("content");

  Flowbusiness fb=Flowbusiness.find(flowbusiness);
  Flowprocess fp=Flowprocess.find(fb.getFlow(),fb.getStep());
  int flowprocess=fp.getFlowprocess();
  Enumeration e=Flowview.find(flowbusiness,flowprocess);
  while(e.hasMoreElements())
  {
    int flowview=((Integer)e.nextElement()).intValue();
    Flowview fv=Flowview.find(flowview);
    if(fv.getState()<2)
    {
      Message.create(teasession._strCommunity,teasession._rv._strV,fv.getTransactor(),teasession._nLanguage,subject,content);
    }
  }
  //当前步骤存在的"会签"
//  Flow f=Flow.find(fb.getFlow());
//  String str=fp.getDTWrite();
//  e=DynamicType.findByDynamic(f.getDynamic()," AND type='csign' AND dynamictype IN("+str.replace('/',',').substring(1,str.length()-1)+")",0, Integer.MAX_VALUE);
//  while(e.hasMoreElements())
//  {
//    int id=((Integer)e.nextElement()).intValue();
//    Enumeration e2=Flowview.find(flowbusiness,flowprocess);
//    while(e2.hasMoreElements())
//    {
//      int flowview=((Integer)e2.nextElement()).intValue();
//      Flowview fv2=Flowview.find(flowview);
//      String tmp=fv2.getTransactor();
//      DynamicCsign dc=DynamicCsign.find(-flowbusiness,tmp);
//      if(!dc.isExists())
//      {
//        Message.create(teasession._strCommunity,teasession._rv._strV,tmp,teasession._nLanguage,subject,content);
//      }
//    }
//  }
  //response.sendRedirect("/jsp/info/Succeed.jsp?community="+teasession._strCommunity);
  out.print("<script>alert('消息发送成功！');window.close();</script>");
  return;
}

Resource r=new Resource();

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/tea/tea.js" type="text/javascript"></script>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body onload="form1.subject.focus();">
<h1>催办</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="?" method="post" onSubmit="return submitText(this.subject,'无效-主题')&&submitText(this.content,'无效-内容');">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="flowbusiness" value="<%=flowbusiness%>">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage,"Subject")%></td>
    <td><input name="subject" value="" size="40" ></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage,"Text")%></td>
    <td><textarea name="content" cols="50" rows="8" ></textarea></td>
  </tr>
</table>

<input type="submit" value="提交">
<input type="button" value="关闭" onClick="window.close();">

</form>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
