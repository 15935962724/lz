<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter" %><%@page import="tea.entity.node.*" %><%@page import="java.util.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.resource.Resource" %><%@page import="tea.entity.admin.*" %><%@page import="tea.ui.TeaSession" %><%!



%><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession.getParameter("community");
String nexturl=teasession.getParameter("nexturl");
int flow=Integer.parseInt(teasession.getParameter("flow"));
int dynamic=Integer.parseInt(teasession.getParameter("dynamic"));
int flowbusiness=Integer.parseInt(teasession.getParameter("flowbusiness"));

int step=1;
if(flowbusiness>0)
{
  Flowbusiness obj=Flowbusiness.find(flowbusiness);
  step=obj.getStep();
}

Flowprocess flowprocess_obj=Flowprocess.find(flow,step);

Flow flow_obj=Flow.find(flow);

//如果是"固定流程" 并 经办人中不存在当前会员
if(flow_obj.getType()==0&&flowprocess_obj.getMember().indexOf("/"+teasession._rv._strV+"/")==-1)
{
  response.sendError(403);
  return;
}
int flowitem=0;
if(request.getParameter("flowitem")!=null && request.getParameter("flowitem").length()>0)
{
  flowitem = Integer.parseInt(request.getParameter("flowitem"));
}
Flowitem fobj = Flowitem.find(flowitem);
StringBuffer sbcheck=new StringBuffer();

Resource r=new Resource();

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/tea/tea.js" type="text/javascript"></script>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body onload="">
<h1>工作接收/办理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name=form1 action="/servlet/EditFlowdynamicvalue" method="post" enctype=multipart/form-data onsubmit="javascript:return fcheck();">
<input type="hidden" name="community" value="<%=community%>">
<input type="hidden" name="Node" value="<%=teasession._nNode%>">
<input type="hidden" name="flowbusiness" value="<%=flowbusiness%>">
<input type="hidden" name="dynamic" value="<%=dynamic%>">
<input type="hidden" name="flow" value="<%=flow%>">
<input type=hidden name="flowitem" value="<%=flowitem %>">
<%
if(nexturl!=null)
{
	out.print("<input type=hidden name=nexturl value="+nexturl+">");
}
if(flowbusiness<1)
{
   out.print("<table border=0 cellpadding=0 cellspacing=0 id=tablecenter><tr><td>项目:</td><td>");
  out.print(fobj.getName(teasession._nLanguage));

   out.print("</td></tr></table>");
  // sbcheck.append("&&submitText(form1.flowitem,'"+r.getString(teasession._nLanguage, "InvalidParameter")+"-项目')");
}

    java.util.Enumeration enumeration=DynamicType.findByDynamic(dynamic);
    int id=0;
    while(enumeration.hasMoreElements())
    {
      id=((Integer)enumeration.nextElement()).intValue();
      tea.entity.site.DynamicType dt_obj=tea.entity.site.DynamicType.find(id);
      if(dt_obj.isHidden())
      {
        if(dt_obj.isNeed()&&flow_obj.getType()==0&&flowprocess_obj.getDynamictype().indexOf("/"+id+"/")!=-1)
        {
          sbcheck.append("&&submitText(form1.dynamictype"+id+", '"+r.getString(teasession._nLanguage, "InvalidParameter")+"-"+dt_obj.getName(teasession._nLanguage)+"')");
          //           out.print("*&#12288;");
        }
        out.print(dt_obj.getText(application,teasession,-flowbusiness));
      }
    }
    %>

  <script type="">
<%
    //如果是固定流程
    if(flow_obj.getType()==0)
    {
%>
  var array="<%=flowprocess_obj.getDynamictype()%>".split("/");
  for(var counter=0;counter<form1.elements.length;counter++)
  {
    if(form1.elements[counter].name.indexOf("dynamictype")!=-1)
    {
      form1.elements[counter].disabled=true;
      form1.elements[counter].style.background="#CCCCCC";
      for(var i=0;i<array.length;i++)
      {
        if(form1.elements[counter].name=="dynamictype"+array[i]||form1.elements[counter].name=="dynamictype_checkbox"+array[i])
        {
          form1.elements[counter].disabled=false;
          form1.elements[counter].style.background='';
          continue;
        }
      }
    }
  }
  <%}%>
  function fcheck()
  {
    return true<%=sbcheck.toString()%>;
  }
  </script>
  <div align="center">
    <input type="submit" value="提交">
    <input type="reset" value="重置" onClick="">
    <input type="button" value="返回" onClick="history.back();">
  </div>
</form>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>


