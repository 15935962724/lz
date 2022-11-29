<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter" %><%@page import="tea.resource.Resource" %><%@page import="tea.entity.admin.*" %><%@page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8"); response.setHeader("Cache-Control", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=request.getParameter("community");
String nexturl=request.getParameter("nexturl");

int flow=Integer.parseInt(request.getParameter("flow"));
int flowprocess=Integer.parseInt(request.getParameter("flowprocess"));

Flow f=Flow.find(flow);

String act=request.getParameter("act");
if(act.length()>0)
{
  String info="修改";
  if("move".equals(act))
  {
    response.sendRedirect(nexturl);
  }else if("delete".equals(act))
  {
    Flowprocess obj=Flowprocess.find(flowprocess);
    obj.delete();
    info="删除";
  }else
  {
    int step=Integer.parseInt(request.getParameter("step"));
    String name=request.getParameter("name");
    boolean checkbox=Boolean.parseBoolean(request.getParameter("checkbox"));
    boolean serial=request.getParameter("serial")!=null;
    boolean csign=request.getParameter("csign")!=null;
    if(flowprocess==0)
    {
      flowprocess=Flowprocess.create(flow,step,"/","/","/",checkbox,serial,csign,teasession._nLanguage,name);
    }else
    {
      Flowprocess obj=Flowprocess.find(flowprocess);
      obj.set(step,checkbox,serial,csign,teasession._nLanguage,name);
    }
    f.set(flowprocess,request.getParameter("mainprocess")!=null,request.getParameter("distprocess")!=null,request.getParameter("stampprocess")!=null);
  }
  out.print("<script>alert('"+info+"成功！');window.open('"+nexturl+"','_parent');</script>");
  return;
}


Resource r=new Resource();

String name=null;
int step=1;
boolean checkbox=false,serial=false,csign=false;
if(flowprocess!=0)
{
  Flowprocess obj=Flowprocess.find(flowprocess);
  name=obj.getName(teasession._nLanguage);
  step=obj.getStep();
  checkbox=obj.isCheckbox();
  serial=obj.isSerial();
  csign=obj.isCsign();
}else
{
  name="";
  step=Flowprocess.getMaxSequenceByFlow(flow)+1;
}

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT SRC="/tea/mt.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function defaultfocus()
{
  form1.name.focus();
}
function f_change(obj)
{
  if(obj.type=="checkbox")
  {
    if(obj.checked)
    form1.checkbox[1].checked=true;
  }else if(form1.mainprocess)
  {
    form1.mainprocess.checked=false;
  }
}
</script>
</head>
<body onLoad="defaultfocus();">

<h1>新建流程步骤</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<BR>
<form name="form1" action="?" method="post" target="_ajax" onSubmit="return submitInteger(this.step, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-序号')&&submitText(this.name, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-流程名称')&&submitText(this.flow, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-流程')">
<input type=hidden name="flowprocess" value="<%=flowprocess%>"/>
<input type=hidden name="community" value="<%=community%>"/>
<input type=hidden name="nexturl" value="<%=nexturl%>"/>
<input type=hidden name="act" value="edit">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>序号</td>
    <td nowrap><input name="step" type="text" value="<%=step%>" ></td>
  </tr>
  <tr>
    <td>名称</td>
    <td nowrap><input name="name" type="text" value="<%=name%>" size="40"></td>
  </tr>
  <tr>
    <td>是否多选</td>
    <td nowrap>
      <input name="checkbox" type="radio" value="true" checked onclick='f_change(this)'>是
      <input name="checkbox" type="radio" value="false" <%if(!checkbox)out.print(" checked ");%> >否
    </td>
  </tr>
  <%
  if(flow>0)
  {
    out.print("<input type=hidden name=flow value="+flow+">");
    if(f.getType()==2)
    {
      out.print("<tr><td>选项</td><td><input name=mainprocess type=checkbox onclick='f_change(this)' id=mainprocess");
      if(flowprocess>0&&flowprocess==f.getMainProcess())out.print(" checked");
      out.println("><label for=mainprocess>主控流程</label>");
      //
      out.print("<input name=serial type=checkbox id=serial");
      if(serial)out.print(" checked");
      out.println("><label for=serial>不回主控步骤</label>");
      //
      out.print("<input name=csign type=checkbox id=csign");
      if(csign)out.print(" checked");
      out.println("><label for=csign>设置候选会签部门/人员</label>");
      //

      out.print("<input name=distprocess type=checkbox id=distprocess");
      if(flowprocess>0&&flowprocess==f.getDistProcess())out.print(" checked");
      out.println("><label for=distprocess>分发流程</label>");

      out.print("<input name=stampprocess type=checkbox id=stampprocess");
      if(flowprocess>0&&flowprocess==f.stampprocess)out.print(" checked");
      out.println("><label for=stampprocess>盖章流程</label>");
    }
  }else
  {
    out.print("<tr><td>流程</td><td><select name=flow><option value=\"\">---------</option>");
    java.util.Enumeration e=Flow.find(teasession._strCommunity,"");
    while(e.hasMoreElements())
    {
      int i=((Integer)e.nextElement()).intValue();
      out.print("<option value="+i+" >"+Flow.find(i).getName(teasession._nLanguage));
    }
    out.print("</td></tr>");
  }
  %>
  </table>
  <input type="submit" value="提交">
  <input type="reset" value="重置" onClick="defaultfocus();">
  <input type="button" value="返回" onClick="history.back();">
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>注:</td>
  </tr>
  <tr>
    <td>1.主控流程 不能是多选.</td>
  </tr>
</table>

</body>
</HTML>
