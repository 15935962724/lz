<%@page contentType="text/html;charset=UTF-8"  %><%@page import="java.util.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.db.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.ui.*" %><%@page import="tea.resource.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.node.*" %><%request.setCharacterEncoding("UTF-8"); %>
<%
TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

String community=teasession._strCommunity;

int hidden=0;
if(request.getParameter("hidden")!=null)
{
  hidden=Integer.parseInt(request.getParameter("hidden"));
}
String resumesorttype=request.getParameter("resumesorttype");


int pagesize=25;
int pos= request.getParameter("pos")==null?0:Integer.parseInt(request.getParameter("pos"));
int count=0;

StringBuffer sb=new StringBuffer();


Communityjob communityjob=Communityjob.find(community);
if(!License.getInstance().getWebMaster().equals(teasession._rv.toString())&&!teasession._rv.toString().equalsIgnoreCase(communityjob.getJobmember()))
{
  AdminUsrRole aur_obj=AdminUsrRole.find(teasession._strCommunity,teasession._rv._strV);
  java.util.StringTokenizer tokenizer=new StringTokenizer(aur_obj.getCompany(),"/");
  if(tokenizer.hasMoreTokens())
  sb.append(" AND ( j.orgid="+tokenizer.nextToken());
  while(tokenizer.hasMoreTokens())
  {
    sb.append(" OR j.orgid="+tokenizer.nextToken());
  }
  sb.append(" ) ");
}


java.util.Vector vector2=new java.util.Vector();
DbAdapter dbadapter = new DbAdapter();
try
{
  count=dbadapter.getInt("SELECT COUNT(n.node) FROM Node n INNER JOIN Job j ON n.node=j.node WHERE n.finished=1 AND n.hidden="+hidden+" AND n.type=50 AND n.community="+dbadapter.cite(community)+sb.toString());
  dbadapter.executeQuery("SELECT n.node FROM Node n INNER JOIN Job j ON n.node=j.node WHERE n.finished=1 AND n.hidden="+hidden+" AND n.type=50 AND n.community="+dbadapter.cite(community)+sb.toString()+" ORDER BY n.sequence");
  for (int l = 0; l < pos + pagesize && dbadapter.next(); l++)
  {
    if (l >= pos)
    {
      vector2.addElement(Integer.valueOf(dbadapter.getInt(1)));
    }
  }
}finally
{
  dbadapter.close();
}
java.util.Enumeration enumeration=vector2.elements();

Resource r=new Resource("/tea/resource/Job");

String info=request.getParameter("info");
if(info==null)
{
  info=r.getString(teasession._nLanguage,"1167454679312");//"应聘管理";
}

%><HTML>
<HEAD>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</HEAD>
<body>

<%@ include file="/jsp/type/resume/ApplyManageHeader.jsp" %>
<h2><%=r.getString(teasession._nLanguage,"1167443831593")%></h2>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr ID=tableonetr>
    <td nowrap><%=r.getString(teasession._nLanguage,"1167454369765")%><!--职位编号--></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1167454389921")%><!--职位名称--></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1167454444890")%><!--所属机构--></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1167444505750")%><!--发布时间--></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1167444537781")%><!--截止时间--></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1167444560546")%><!--简历数量--></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1167444584125")%><!--应聘简历--></td>
  </tr>
<%
while(enumeration.hasMoreElements())
{
  int node_id =((Integer)enumeration.nextElement()).intValue();
  Job job=Job.find(node_id,teasession._nLanguage);
  Node node_obj=Node.find(node_id);
  int countByJob=Apply.countByJob(node_id);
%>
<tr onmouseover="javascript:this.bgColor='#BCD1E9'" onmouseout="javascript:this.bgColor=''" >
    <td nowrap><%=job.getTxtRefCode()%></td>
    <td nowrap><A href="/jsp/type/job/yjobpreview.jsp?node=<%=node_id%>" target="_blank"><%=job.getName()%></A></td>
    <td nowrap><A href="/servlet/Node?node=<%=job.getSltOrgId()%>"><%=Node.find(job.getSltOrgId()).getSubject(teasession._nLanguage)%></A></td>
    <td nowrap><%=node_obj.getTimeToString()%></td>
    <td nowrap><%=job.getValidityDateToString()%></td>
    <td nowrap><%=countByJob%></td>
    <td nowrap>
    <%
    out.print("<input type=button onclick=\"window.open('/jsp/type/resume/yjobapplymanage.jsp?applyAmount="+node_id+"','_self');\" value="+r.getString(teasession._nLanguage,"1167444621250"));//查看
    if(countByJob<1)
    {
      out.print(" disabled ");
    }
    out.print(" >");
    %></td>
</tr>
<% }%>
 </table>

<%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+"?community="+teasession._strCommunity+"&pos=",pos,count)%>

<!--统计-->
<input type="button" name="stat" value="<%=r.getString(teasession._nLanguage,"1167454879453")%>" onclick="window.open('/jsp/type/resume/yjobapplymanage3.jsp?hidden=<%=hidden%>','_self');" CLASS="in" />
<%
if(hidden==0)
{
  //查看未发布
  out.print("<input type=button  value="+r.getString(teasession._nLanguage,"1167454926218")+" onclick=\"window.open('/jsp/type/resume/yjobapplymanage2.jsp?hidden=1','_self');\" />");
}else
{
  //查看已发布
  out.print("<input type=button  value="+r.getString(teasession._nLanguage,"1167454935437")+" onclick=\"window.open('/jsp/type/resume/yjobapplymanage2.jsp?hidden=0','_self');\" />");
}
%>


<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

