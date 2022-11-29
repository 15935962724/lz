<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter"%><%@ page import="tea.resource.Resource"%><%@ page import="tea.entity.*" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.entity.site.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8"); response.setHeader("Cache-Control", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


Resource r=new Resource();

StringBuffer sql=new StringBuffer();

int flow=Integer.parseInt(request.getParameter("flow"));;
Flow f=Flow.find(flow);

String menuid=request.getParameter("id");

if(flow<1)
{
  sql.append(" AND flow IN( SELECT flow FROM Flow WHERE community=").append(DbAdapter.cite(teasession._strCommunity)).append(")");
}

String name=request.getParameter("name");
if(name!=null&&name.length()>0)
{
  sql.append(" AND flowprocess IN( SELECT flowprocess FROM FlowprocessLayer WHERE name LIKE "+DbAdapter.cite("%"+name+"%")+")");
}

String member=request.getParameter("member");
if(member!=null&&member.length()>0)
{
  sql.append(" AND member LIKE "+DbAdapter.cite("%"+member+"%"));
}

Http h=new Http(request);


%><%!
public String field(Http h,String[] arr)throws Exception
{
  StringBuffer sb=new StringBuffer();
  for(int j=1;j<arr.length;j++)
  {
    if("tape".equals(arr[j]))
    sb.append("发文文件<br>");
    else if("down".equals(arr[j]))
    sb.append("正文下载<br>");
    else if("print".equals(arr[j]))
    sb.append("正文打印<br>");
    else
    {
      int dtid=Integer.parseInt(arr[j]);
      DynamicType dt=DynamicType.find(dtid);
      if(dt.isExists())sb.append((h.debug?dtid+"、":"")+dt.getName(h.language)+"<br>");
    }
  }
  return sb.toString();
}
%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">em{color:#999999;}</style>
<script>
function f_submit(act,v,f)
{
  if(act=="edit")
    act="";
  else if(act=="member")
  form1.action="/jsp/admin/flow/EditFlowprocessMember.jsp";
  else if(act=="write")
  form1.action="/jsp/admin/flow/EditFlowprocessDynamictype.jsp";
  else if(act=="delete")
  {
    if(!confirm('确定删除?'))return;
    form1.target="_ajax";
  }
  form1.flowprocess.value=v;
  if(f)form1.flow.value=f;
  form1.act.value=act;
  form1.submit();
}
</script>
</head>
<body>

<h1>管理流程步骤 ( <%=f.getName(teasession._nLanguage)%> )</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<h2>查询</h2>
<form action="?">
<input type=hidden name="community" value="<%=teasession._strCommunity%>">
<input type=hidden name="menuid" value="<%=menuid%>">
<input type=hidden name="flow" value="<%=flow%>">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>名称<input name="name" value="<%if(name!=null)out.print(name);%>"></td>
      <td>经办人<input name="member" value="<%if(member!=null)out.print(member);%>"></td>
        <td><input type="submit" value="查询"/></td>
  </tr>
</table>
</form>

<h2>列表</h2>
<!--注:当有事务正在使用该流程办理时，不能对流程进行修改。-->
<form name="form1" action="/jsp/admin/flow/EditFlowprocess.jsp">
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<input type=hidden name="flow" value="<%=flow%>"/>
<input type=hidden name="flowprocess" value="0"/>
<input type=hidden name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>"/>
<input type=hidden name="act">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td nowrap>序号</td>
    <td nowrap>流程步骤名称</td>
    <td nowrap>经办人</td>
    <td nowrap>可填字段</td>
    <td>&nbsp;</td>
  </tr>
<%
java.util.Enumeration e=Flowprocess.find(flow,sql.toString());
for(int i=1;e.hasMoreElements();i++)
{
  int flowprocess=((Integer)e.nextElement()).intValue();
  Flowprocess obj=Flowprocess.find(flowprocess);
  String ms[]=obj.getMember().split("/");
  String dtws[]=obj.getDTWrite().split("/");
  String dtrs[]=obj.getDTRead().split("/");
  int seq=obj.getStep();
  out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''");
  if(i!=seq&&sql.length()==0)//没有搜索的情况下才校检
  {
    i=seq;
    out.print(" style='color:red' title='错误：顺号不连续'");
  }
  out.print("><td>"+seq+"</td>");
  out.print("<td>"+(h.debug?flowprocess+"、":"")+obj.getName(teasession._nLanguage));
  if(f.getType()==2&&flowprocess==f.getMainProcess())out.print("<em>『主控』</em>");
  if(flowprocess==f.stampprocess)out.print("<em>『盖章』</em>");
  if(flowprocess==f.getDistProcess())out.print("<em>『分发』</em>");
  out.print("&nbsp;<td>");
  for(int j=1;j<ms.length;j++)
  {
    Profile p=Profile.find(ms[j]);
    out.print(p.getName(teasession._nLanguage)+"<br>");
  }
  out.print("&nbsp;<td>"+field(h,dtws)+"<hr size=1>"+field(h,dtrs));
//  out.write("<td>");
//  if(i>0)out.write("<a href=javascript:f_submit('"+flowprocess+"',true,'move')><img src=/tea/image/public/arrow_up.gif></a>");
//  if(e.hasMoreElements())out.write("<a href=javascript:f_submit('"+flowprocess+"',false,'move')><img src=/tea/image/public/arrow_down.gif></a>");
    out.print("<td><input type=button value=编辑属性 onclick=f_submit('edit',"+flowprocess+","+obj.getFlow()+");> ");
    out.print("<input type=button value=编辑经办人 onclick=f_submit('member',"+flowprocess+");> ");
    out.print("<input type=button value=编辑可写/读字段 onclick=f_submit('write',"+flowprocess+");> ");
    out.print("<input type=button value=删除 onclick=f_submit('delete',"+flowprocess+");> ");
}
%>
</table>
<%
if(flow>0)
{
  out.print("<input type=button name=new value="+r.getString(teasession._nLanguage,"CBNew")+" onClick=\"f_submit('edit',0,"+flow+");\"> <input type='button' value='返回' onclick=location.href='/jsp/admin/flow/Flows.jsp?community="+teasession._strCommunity+"' />");
}else
{
  out.print("<h2>创建流程步骤</h2>");
  out.print("<table border=0 cellpadding=0 cellspacing=0 id=tablecenter>");
  e=Flow.find(teasession._strCommunity,"");
  while(e.hasMoreElements())
  {
    int i=((Integer)e.nextElement()).intValue();
    out.print("<tr><td><input type=button name=new value="+Flow.find(i).getName(teasession._nLanguage)+" onClick=\"f_submit('edit',0,"+i+");\"></td></tr>");
  }
  out.print("</table>");
}
//if(f.isRun()&&!request.getServerName().equals("127.0.0.1"))
//{
//  out.print("<script>var els=form1.elements;for(var i=0;i<els.length;i++)if(els[i].type=='button')els[i].disabled=true;</script>");
//}
%>
</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
