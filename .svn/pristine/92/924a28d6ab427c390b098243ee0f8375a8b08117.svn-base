<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.entity.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.site.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

boolean callback=request.getParameter("callback")!=null;//null:回上一步,true:收回
String community=teasession._strCommunity;
String nexturl=teasession.getParameter("nexturl");
int flow=Integer.parseInt(request.getParameter("flow"));
int flowbusiness=Integer.parseInt(request.getParameter("flowbusiness"));

String member=teasession._rv._strV;

Flowbusiness fb=Flowbusiness.find(flowbusiness);
Flow f=Flow.find(fb.getFlow());

if(request.getMethod().equals("POST"))
{
  //回传上一步骤
  String ms0[]=request.getParameterValues("members0");
  String ms1[]=request.getParameterValues("members1");
  //[回上一步]删除已经填写的意见和签名   [收回]不删除记录
  String[] dt=request.getParameter("dt").split("/");
  for(int i=1;i<dt.length;i++)
  {
    int id=Integer.parseInt(dt[i]);
    DynamicValue.find(-flowbusiness,teasession._nLanguage,id).delete();
    DynamicCsign.find(-flowbusiness,id,member).delete();
  }
  fb.back(member,ms0,ms1);
  if(ms1!=null)
  {
    //发送邮件和短信/////
    String subject="您有《"+fb.name+"》工作需要办理！";
    String content=request.getParameter("content");
    fb.setReason(content);

    boolean isMessage=request.getParameter("message")!=null;
    String sms=request.getParameter("sms");

    Flowprocess fp=Flowprocess.find(fb.getFlow(),fb.getStep());
    StringBuffer sb=new StringBuffer();
    sb.append("提交人:").append(teasession._rv);
    sb.append("<br>第").append(fb.getStep()).append("步");
    if(f.getType()!=1)//如果不是自由流程
    sb.append(fp.getName(teasession._nLanguage));
    sb.append("<br>内　容:").append(content);
    String url="/jsp/admin/xny/FlowbusinessEdit.jsp?community="+community+"&flowbusiness="+flowbusiness+"&flow="+flow+"&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8");
    sb.append("<br><br><a href='"+url+"' class='Flowbusiness_here' target='m' onclick='opener=null;window.close();'>点这里进行办理</a>");

    Enumeration e=Flowview.find(flowbusiness, fp.getFlowprocess());
    while(e.hasMoreElements())
    {
      int id = ((Integer) e.nextElement()).intValue();
      Flowview fv = Flowview.find(id);
      String m=fv.getTransactor();
      if(sms!=null)
      {
        Profile p=Profile.find(m);
        SMSMessage.create(teasession._strCommunity,member,p.getMobile(),teasession._nLanguage,sms);
      }
      if(isMessage)Message.create(teasession._strCommunity,member,m,teasession._nLanguage,subject,sb.toString());
    }
  }
  response.sendRedirect(nexturl);
  return;
}


%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/tea/tea.js" type="text/javascript"></script>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script type="">
function f_load()
{
  if(form1.sb)
  {
    form1.sb.disabled=false;
  }
}
</script>
</head>
<body onload="">
<h1>回上一步骤</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<%=fb.getFlowviewToHtml(teasession._nLanguage)%>

<form name="form1" action="?" method="POST">
<input type="hidden" name="flowbusiness" value="<%=flowbusiness%>"/>
<input type="hidden" name="flow" value="<%=flow%>"/>
<input type="hidden" name="community" value="<%=community%>"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="dt" value="/" />

<%
if(callback)
{
  int step=fb.getStep();
  Flowprocess fp=Flowprocess.find(fb.getFlow(),step);
  int flowprocess=fp.getFlowprocess();
%>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td>收回:</td>
  <td>
<%
Enumeration e=Flowview.find(flowbusiness,flowprocess);
while(e.hasMoreElements())
{
  int flowview=((Integer)e.nextElement()).intValue();
  Flowview fv2=Flowview.find(flowview);
  member=fv2.getTransactor();
  int hc=member.hashCode();
  out.print("<input name='members0' type='checkbox' value='"+member+"' id='"+hc+"'><label for='"+hc+"'>"+member+"</label><br>");//+": "+Flowbusiness.STATE_TYPE[fv2.getState()]
}
%>
</table>

<input name="callback" type="submit" value="提交" onclick="return submitCheckbox(form1.members0,'至少要选择一个收回对象!!!');">

<%
}else//////////////////////////////////////////////////////////////////////////////////////
{
  Flowprocess fp=Flowprocess.find(fb.getFlow(),fb.getStep());
  String dtw=fp.getDTWrite();
  boolean isEC=true;//是否存在"意见"
  //Flowbusiness_1031.jsp
  if(dtw.indexOf("/75/")!=-1)
  dtw="/75/76/77/";
  else if(dtw.indexOf("/78/")!=-1)
  dtw="/78/79/80/";
  else if(dtw.indexOf("/603/")!=-1)
  dtw="/603/604/605/";
  else if(dtw.indexOf("/96/")!=-1)
  dtw="/96/";
  else if(dtw.indexOf("/584/")!=-1)
  dtw="/584/";
  //Flowbusiness_1032.jsp
  else if(dtw.indexOf("/100/")!=-1)
  dtw="/100/101/102/";
  else if(dtw.indexOf("/103/")!=-1)
  dtw="/103/104/105/";
  else if(dtw.indexOf("/109/")!=-1)
  dtw="/109/";
  else if(dtw.indexOf("/106/")!=-1)
  dtw="/106/";
  //Flowbusiness_1033.jsp
  else if(dtw.indexOf("/118/")!=-1)
  dtw="/118/119/120/";
  else if(dtw.indexOf("/121/")!=-1)
  dtw="/121/122/123/";
  else if(dtw.indexOf("/124/")!=-1)
  dtw="/124/";
  else if(dtw.indexOf("/127/")!=-1)
  dtw="/127/";
  else if(dtw.indexOf("/131/")!=-1)
  dtw="/131/";
  else if(dtw.indexOf("/135/")!=-1)
  dtw="/135/";
  //Flowbusiness_1034.jsp
  else if(dtw.indexOf("/141/")!=-1)
  dtw="/141/142/143/";
  else if(dtw.indexOf("/146/")!=-1)
  dtw="/146/";
  //Flowbusiness_1055.jsp
  else if(dtw.indexOf("/560/")!=-1)
  dtw="/560/561/562/";
  //Flowbusiness_1056.jsp
  else if(dtw.indexOf("/591/")!=-1)
  dtw="/591/592/593/";
  else if(dtw.indexOf("/594/")!=-1)
  dtw="/594/595/596/";
  else if(dtw.indexOf("/597/")!=-1)
  dtw="/597/598/599/";
  else if(dtw.indexOf("/600/")!=-1)
  dtw="/600/";
  else if(dtw.indexOf("/610/")!=-1)
  dtw="/610/";
  else if(dtw.indexOf("/613/")!=-1)
  dtw="/613/";
  else if(dtw.indexOf("/611/")!=-1)
  dtw="/611/";
  else
  isEC=false;
  if(isEC)
  {
    int dt=Integer.parseInt(dtw.split("/")[1]);
    isEC=DynamicValue.find(-flowbusiness, teasession._nLanguage,dt).isExists()||DynamicCsign.find(-flowbusiness,dt,member).isExists();
  }
%>
<script>
function f_submit()
{
  if(!submitCheckbox(form1.members1,'“退给”至少要选一个！')||!submitText(form1.content,'“内容”不能为空！'))return false;
  if(<%=isEC%>)
  {
    if(confirm('是否删除已经填写的意见和签名？'))
    form1.dt.value="<%=dtw%>";
  }else
  {
    return confirm('确认要回传该工作至上一步骤么？');
  }
}
</script>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td>退给:</td>
  <td>
  <%
  int last0=0,last1=0;
  DbAdapter db = new DbAdapter();
  try
  {
    db.executeQuery("SELECT flowprocess,transactor FROM Flowview WHERE flowbusiness=" + flowbusiness + " ORDER BY flowview DESC");
    if(db.next())//最后一步
    {
      last0=db.getInt(1);
    }
    while (db.next())
    {
      int j=db.getInt(1);
      if(last1!=0&&last1!=j)//如果不是最后一步&&也不是倒数第二步///
      {
        break;
      }
      if(j!=last0)//如果不是最后一步
      {
        last1=j;
        member=db.getString(2);
        int hc=member.hashCode();
        out.print("<input name='members1' type='checkbox' value="+member+" checked id='"+hc+"'><label for='"+hc+"'>"+member+"</label><br>");
      }
    }
  } finally
  {
    db.close();
  }
  %>
</tr>
<tr>
  <td width="20%">发送:</td>
  <td><input name="message" type="checkbox" checked="checked" id="message"><label for='message'>站内信</label><!--  onclick="trmsg.style.display=checked?'':'none';" -->
  <%
  CommunityOption co = CommunityOption.find(community);
  if(co.get("smstype")!=null)
  {
    out.println("<input type=checkbox onclick=\"trsms.style.display=checked?'':'none'; form1.sms.disabled=!checked;\">手机短信");
  }
  %>
  </td>
</tr>
<tr id="trsms" style="display:none">
  <td>短信内容:</td>
  <td>
    <%=SMSMessage.contentToHtml(teasession,"sms")%>
    <script type="">form1.sms.value="工作流提醒:您还没有办理完！";</script>
  </td>
</tr>
<tr id="trmsg">
  <td>内容:</td>
  <td><textarea name="content" cols="60" rows="6">您还没有办理完....</textarea></td>
</tr>
</table>

<input name="sb" type="submit" value="提交" onclick="return f_submit();">

<%
}
%>


<input type="button" value="返回" onclick='window.history.back();'>

</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

