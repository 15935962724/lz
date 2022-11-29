<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter"%><%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.admin.*" %><%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.site.*" %><%@page import="tea.entity.*" %>
<%@page import="tea.entity.node.*" %><%@page import="java.util.*" %><%@page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");
response.setHeader("Cache-Control", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Http h=new Http(request);
Resource r=new Resource();
String member=teasession._rv.toString();

//分发步骤ID
StringBuffer sbdp=new StringBuffer();
Enumeration edp=Flow.find(teasession._strCommunity," AND distprocess>0");
while(edp.hasMoreElements())
{
  Flow f=Flow.find(((Integer)edp.nextElement()).intValue());
  sbdp.append(","+f.getDistProcess());
}

StringBuffer sql=new StringBuffer();
sql.append(" AND step>0 AND fb.flowbusiness IN( SELECT flowbusiness FROM Flowview f1 WHERE flowprocess IN("+sbdp.substring(1)+")");
//{member}可以办理的事务//
sql.append(" AND (state<2 AND(transactor="+DbAdapter.cite(member)+" OR consign="+DbAdapter.cite(member)+") AND EXISTS(SELECT * FROM (SELECT flowbusiness,MAX(step) AS step FROM Flowview WHERE flowprocess!=0 GROUP BY flowbusiness) AS f2 WHERE f1.flowbusiness=f2.flowbusiness AND f1.step=f2.step)           )");
sql.append(")");


String tmp;

int flow=0,flow2=0;



int flowitem=0;
String _strFlowitem=request.getParameter("flowitem");
if(_strFlowitem!=null&&_strFlowitem.length()>0)
{
  flowitem=Integer.parseInt(_strFlowitem);
  sql.append(" AND flowitem="+flowitem);
}
sql.append(" ORDER BY flowbusiness DESC");

//int state=-1;
//tmp=request.getParameter("state");
//if(tmp!=null&&tmp.length()>0)
//{
//  state=Integer.parseInt(tmp);
//}

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>

<h1>待阅文件</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>




<form name="form1" action="/jsp/admin/flow/EditFlowbusiness.jsp">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="flowitem" value="<%=flowitem%>">
<input type="hidden" name="flowbusiness" value="0">
<input type="hidden" name="flowprocess" value="0">
<input type="hidden" name="dynamic" value="0">
<input type="hidden" name="flow" value="<%=flow%>">
<input type="hidden" name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>">
<table border='0' cellpadding='0' cellspacing='0' id='tablecenter'>
<tr id='tableonetr'>
<td nowrap>序号</td>
<td nowrap>分发日期</td>
<td nowrap>文件字号</td>
<td nowrap>文件标题</td>
<td nowrap>发起人</td>
<td nowrap>操作</td>
</tr>
<%
boolean none=true;
StringBuffer js=new StringBuffer();



//列表////
Enumeration efb=Flowbusiness.findByCommunity(teasession._strCommunity,sql.toString());
if(!efb.hasMoreElements())
out.print("<tr><td colspan='10' align='center'>暂无待阅文件!</td></tr>");
else
{
  none=false;
  boolean th=false;//隐藏标题
  StringBuilder tth=new StringBuilder();
  for(int j=1;efb.hasMoreElements();j++)
  {
    int flowbusiness=((Integer)efb.nextElement()).intValue();
    Flowbusiness fb=Flowbusiness.find(flowbusiness);
    Flow f=Flow.find(fb.getFlow());
    int step=fb.getStep(),dyn=f.getDynamic();
    Flowprocess fp=Flowprocess.find(fb.getFlow(),step);
    int flowprocess=fp.getFlowprocess();
    Flowview fv=Flowview.find(flowbusiness,flowprocess,member);

    js.append("case ").append(j).append(":");
    js.append("form1.dynamic.value=").append(dyn).append(";");
    js.append("form1.flowbusiness.value=").append(flowbusiness).append(";");
    js.append("form1.flowprocess.value=").append(flowprocess).append(";");
    js.append("form1.flowitem.value=").append(fb.getFlowitem()).append(";");
    js.append("form1.flow.value=").append(fb.getFlow()).append(";");
    js.append("break;\r\n");

    out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
    out.print("<td width=20 align=center>"+j);
    out.print("<td align=center nowrap>"+fv.getTimeToString());
    out.print("<td nowrap>"+fb.getCode());
    out.print("<td nowrap><a href='###' onClick=f_click("+j+",'/jsp/admin/xny/FlowbusinessEdit.jsp');form1.submit();>"+MT.f(fb.name,"无")+"</a>");    //事务名称
    //
    out.print("<td nowrap>"+fb.getCreator());
    out.print("<td nowrap>");
    out.print("<input type=submit value=办理 onClick=f_click("+j+",'/jsp/admin/xny/FlowbusinessEdit.jsp');></td></tr>");

  }
}
%>
</table>
</form>

<script>
function f_click(i,url)
{
  switch(i)
  {
    <%=js.toString()%>
  }
  if(url)
  {
    form1.action=url;
    if(url.indexOf("?")!=-1)
    {
      form1.method="post";
    }
  }
}
</script>


<br>
<div id="head6"><img height="6" src="about:blank" ></div>
</body></html>
