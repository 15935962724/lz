<%@page contentType="text/html;charset=UTF-8"  %><%@page import="java.util.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.db.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.ui.*" %><%@page import="tea.resource.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.node.*" %><%request.setCharacterEncoding("UTF-8"); %>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}
String community=teasession._strCommunity;

int hidden=0;
if(request.getParameter("hidden")!=null)
{
  hidden=Integer.parseInt(request.getParameter("hidden"));
}

Communityjob communityjob=Communityjob.find(community);
/*
tea.entity.node.Purview purview=tea.entity.node.Purview.find(teasession._rv.toString(),community);
if(!purview.isJob()&&!License.getInstance().getWebMaster().equals(teasession._rv.toString())&&!teasession._rv.toString().equalsIgnoreCase(communityjob.getJobmember()))
{
    response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("你没有权限,访问本页.","UTF-8"));
    return;
}
*/
int pagesize=25;
int pos= request.getParameter("pos")==null?0:Integer.parseInt(request.getParameter("pos"));
int count=0;

//Purview purview=Purview.find(teasession._rv.toString());
StringBuffer sb=new StringBuffer();
StringBuffer sb2=new StringBuffer();
String orgid= request.getParameter("orgid");

if(!License.getInstance().getWebMaster().equals(teasession._rv.toString())&&!teasession._rv.toString().equalsIgnoreCase(communityjob.getJobmember()))
{
  AdminUsrRole aur_obj=AdminUsrRole.find(community,teasession._rv._strV);
  java.util.StringTokenizer tokenizer=new StringTokenizer(aur_obj.getCompany(),"/");
  if(tokenizer.hasMoreTokens()){
    sb.append(" and (j.orgid="+tokenizer.nextToken());
    while(tokenizer.hasMoreTokens())
    {
      sb.append(" OR j.orgid="+tokenizer.nextToken());
    }
    sb.append(") ");
  }
}

if(orgid!=null&&Integer.parseInt(orgid)!=0)
{
    sb2.append(" AND j.orgid="+orgid);
}
String txtStartDate=request.getParameter("txtStartDate");
if(txtStartDate!=null&&txtStartDate.length()>0)
{
    sb2.append(" AND n.time>="+tea.db.DbAdapter.cite(txtStartDate));
}
String txtEndDate=request.getParameter("txtEndDate");
if(txtEndDate!=null&&txtEndDate.length()>0)
{
    sb2.append(" AND n.time<"+tea.db.DbAdapter.cite(txtEndDate));
}
String keyword=request.getParameter("keyword");
if(keyword!=null&&keyword.length()>0)
{
  keyword=tea.db.DbAdapter.cite("%"+keyword+"%");
  String FIELD[]={"j.name","j.refcode","j.jobtype","j.occid","j.salaryid","j.locid","j.reqdeg","j.jobduty"};
  sb2.append(" AND ("+FIELD[0]+" LIKE "+keyword);
  for(int index=1;index<FIELD.length;index++)
  sb2.append(" OR "+FIELD[index]+" LIKE "+keyword);
  sb2.append(")");
}
String refcode=request.getParameter("refcode");
if(refcode!=null&&refcode.length()>0)
{
  sb2.append(" AND j.refcode LIKE "+tea.db.DbAdapter.cite("%"+refcode+"%"));
}



java.util.Vector vector2=new java.util.Vector();
DbAdapter dbadapter = new DbAdapter();
try
{
  System.out.println(sb.toString());
  count=dbadapter.getInt("SELECT COUNT(n.node) FROM Node n INNER JOIN Job j ON n.node=j.node WHERE n.hidden="+hidden+" AND n.type=50 AND n.community="+dbadapter.cite(community)+sb.toString()+sb2.toString());

  dbadapter.executeQuery("SELECT n.node FROM Node n INNER JOIN Job j ON n.node=j.node WHERE n.hidden="+hidden+" AND n.type=50 AND n.community="+dbadapter.cite(community)+sb.toString()+sb2.toString()+" ORDER BY n.sequence");
  for (int l = 0; l < pos + pagesize && dbadapter.next(); l++)
  {
    if (l >= pos)
    {
      vector2.addElement(Integer.valueOf(dbadapter.getInt(1)));
    }
  }
} finally
{
  dbadapter.close();
}
java.util.Enumeration enumeration=vector2.elements();

Resource r=new Resource("/tea/resource/Job");


String info=request.getParameter("info");
if(info==null)
{
  info=r.getString(teasession._nLanguage,"1167443724812");//"职位管理";
}

%><html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>
<h1 ><%=info+"("+count+") -> "+r.getString(teasession._nLanguage,(hidden==0)?"1167445369281":"1167445331843")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<h2><%=r.getString(teasession._nLanguage,"1167443806359")%><!--查询--></h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr><td>
<SELECT NAME="orgid" STYLE="WIDTH: 292px;" onChange="window.open('<%=request.getRequestURI()+"?community="+community%>&orgid='+this.value,'_self')">
<OPTION VALUE="0">---------------</OPTION>
<%
DbAdapter dbadapter2 = new DbAdapter();
try
{
  dbadapter2.executeQuery("SELECT DISTINCT(j.orgid) FROM Node n INNER JOIN Job j ON n.node=j.node WHERE n.hidden=0 AND n.type=50 AND n.community="+DbAdapter.cite(community)+sb.toString());
  while (dbadapter2.next())
  {
    int id=dbadapter2.getInt(1);
    out.print("<option value="+id+" >"+Node.find(id).getSubject(teasession._nLanguage));
  }
}finally
{
  dbadapter2.close();
}
%>
</SELECT>
<%--
<form action="EditJobMailmsg.jsp" method="get" style="float:left">
<input type="hidden" name="community" value="<%=community%>"/>
<input type=hidden name=nexturl value="<%=request.getRequestURI()+"?"+request.getQueryString()%>">
<input type="checkbox" name="jobmailmsg"    <%if(tea.entity.member.Profile.find(teasession._rv._strR,community).isJobMailMsg())out.print(" CHECKED ");  %> onClick="submit();"  value="checkbox">是否接收邮件
</form>
--%>
    </td>
  </tr>
</table>
<h2><%=r.getString(teasession._nLanguage,"1167443831593")%><!--列表--></h2>
<form action="/servlet/EditAdminjob" name="operate">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr ID=tableonetr>
    <td nowrap>　</td>
    <%--    <td nowrap>职位编号</td>  --%>
    <td nowrap><%=r.getString(teasession._nLanguage,"1167443861406")%><!--职位名称--></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1167443881765")%><!--所属机构--></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1167444505750")%><!--发布时间--></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1167444537781")%><!--截止时间--></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1167444560546")%><!--简历数量--></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1167444584125")%><!--应聘简历--></td>
<!--    <td nowrap>暂停</td>-->
    <td nowrap><%=r.getString(teasession._nLanguage,"1167444621250")%><!--修改--></td>
<!--    <td nowrap>删除</td>-->
  </tr>
<%
while(enumeration.hasMoreElements())
{
int node_id =((Integer)enumeration.nextElement()).intValue();
Job job=Job.find(node_id,teasession._nLanguage);
Node node=Node.find(node_id);
%>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
   <td nowrap><input type="checkbox" name="checkbox" value="<%=node_id%>"/>    </td>
    <%--
    <td nowrap>
        <div align="center"><Span ID=JobIDJobCode><%=job.getTxtRefCode()%></Span></div>
    </td>
    --%>
    <td nowrap><A href="/jsp/type/job/yjobpreview.jsp?node=<%=node_id%>" target="_blank"><%=job.getName()%></A></td>
    <td nowrap><A href="/servlet/Node?node=<%=job.getOrgId()%>"><%=Node.find(job.getOrgId()).getSubject(1)%></A></td>
    <td nowrap><%=node.getTimeToString()%></td>
    <td nowrap><%=job.getValidityDateToString()%></td>
    <td nowrap><%=JobApply.countByJob(node_id)%></td>
    <td nowrap><A href="/jsp/type/resume/yjobapplymanage.jsp?applyAmount=<%=node_id%>"><%=r.getString(teasession._nLanguage,"1167444621250")%><!--查看--></A></td>
<%--            <td nowrap>
        <div align="center"><Span ID=JobIDAlterCopy>
               <form action="/servlet/SetVisible" method="POST">
                <input type="hidden" name="Node" value="<%=node_id%>"/>
                <input type="hidden" name=NodeOHidden value=ON  />
                <input type="hidden" name="nexturl" value="/jsp/type/job/cnoocjobjobmanage.jsp?node=15542"/>
            <A HREF="#" onclick="submit()">暂停</A>
            </form>
        </Span>
        </div>
    </td>--%>
    <td nowrap><A href="/jsp/type/job/EditJob.jsp?node=<%=node_id%>&edit=alter&nexturl=<%=java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8")%>"><%=r.getString(teasession._nLanguage,"Update")%><!--修改--></A></td>
<%--    <td nowrap>
        <div align="center"><Span ID=JobIDDelete>
            <A onClick="if(confirm('确认删除')){window.open('/servlet/DeleteNode?node=<%=node_id%>&nexturl=<%=request.getRequestURI()+"?"+request.getQueryString()%>', '_self')};" HREF="#">删除</A>
        </Span>
        </div></td>--%>
</tr>
<%}%>
<tr><td colspan="2"><input type="checkbox" onClick="javascript:fselectall(this)" /><%=r.getString(teasession._nLanguage,"1167445122937")%><!--全选--></td>
<td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+"?community="+teasession._strCommunity+"&pos=",pos,count)%></td>
</tr>
 </table>



   <INPUT TYPE="hidden" name="nexturl" VALUE="<%=request.getRequestURI()+"?"+request.getQueryString()%>" />
<!--查询-->
   <INPUT TYPE="BUTTON" name="query" VALUE="<%=r.getString(teasession._nLanguage,"1167445161546")%>" ID="CBNewJob" onClick="location='JobSearch.jsp?node=<%=teasession._nNode%>'" CLASS="in"/>
<%
if(hidden==0)
{
  //暂停
  out.println("<INPUT TYPE=submit name=stop VALUE="+r.getString(teasession._nLanguage,"1167445239875")+" />");

  //未发布职位
  out.println("<INPUT TYPE=BUTTON VALUE="+r.getString(teasession._nLanguage,"1167445331843")+"  onclick=\"window.open('"+request.getRequestURI()+"?hidden=1', '_self');\"/>");
}else
{
  //发布
  out.println("<INPUT TYPE=submit name=issue  VALUE="+r.getString(teasession._nLanguage,"1167453509015")+" />");

  //已发布职位
  out.println("<INPUT TYPE=BUTTON VALUE="+r.getString(teasession._nLanguage,"1167445369281")+"  onclick=\"window.open('"+request.getRequestURI()+"?hidden=0', '_self');\"/>");
}
%>

   <INPUT TYPE="submit"  name="delete" VALUE="<%=r.getString(teasession._nLanguage,"CBDelete")%>" ID="CBNewJob" CLASS="in" onClick="if(!confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>')){return false;}"/>
   <input type="BUTTON" value="<%=r.getString(teasession._nLanguage,"CBNewJob")%>" id="CBNewJob" class="in" onClick="window.open('/jsp/type/job/EditJob.jsp?NewNode=ON&Type=50&TypeAlias=0&node=<%=communityjob.getJob()%>&nexturl=<%=request.getRequestURI()%>', '_self');"/>

<!--导入SAP广告职位-->
<!--<input type="button" value="<%=r.getString(teasession._nLanguage,"1167445399156")%>" CLASS="in" onClick="window.open('/jsp/type/resume/Input.jsp','_self');"><input CLASS="in" type="button" value="<%=r.getString(teasession._nLanguage,"1167445438343")%>" onClick="window.open('/jsp/type/job/yjobSap.jsp?node=<%=teasession._nNode%>','_self');"/>-->

</form>
<script>
function fselectall(obj)
{
  for(var counter=0;counter<operate.elements.length;counter++)
  {
    if(operate.elements[counter].type=="checkbox")
    {
      operate.elements[counter].checked=obj.checked;
    }
  }
}
</script>

<div id="head6"><img height="6" src="about:blank"></div>
<br>
</body>
</html>

