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
//teasession._rv._strV ="webmaster";
SupplierMember sm=SupplierMember.find(teasession._strCommunity,teasession._rv._strV);
//String cex=sm.getCompanyEx();

//if(cex.length()<2)
//{
////  response.sendError(403);
////  return;
//}

Communityjob communityjob=Communityjob.find(community);


//StringBuffer sb=new StringBuffer();
//if(!License.getInstance().getWebMaster().equals(teasession._rv.toString())&&!teasession._rv.toString().equalsIgnoreCase(communityjob.getJobmember()))
//{
//  AdminUsrRole aur_obj=AdminUsrRole.find(community,teasession._rv._strV);
//  java.util.StringTokenizer tokenizer=new StringTokenizer(aur_obj.getCompany(),"/");
//  if(tokenizer.hasMoreTokens())
//  sb.append(" and (j.orgid="+tokenizer.nextToken());
//  while(tokenizer.hasMoreTokens())
//  {
//    sb.append(" OR j.orgid="+tokenizer.nextToken());
//  }
//  sb.append(") ");
//}
String nexturl = request.getRequestURI();
String member =request.getParameter("member");//区别那个用户用的权限
StringBuffer sb2=new StringBuffer();

String t=sm.getCompanyEx();
sb2.append(" AND j.orgid IN("+t.substring(1,t.length()-1).replace('/',',')+")");

if(member!=null && member.length()>0)
{
  sb2.append(" and n.rcreator = ").append(DbAdapter.cite(teasession._rv.toString()));
  nexturl = request.getRequestURI()+"?member="+member;

}
//职位名称搜索
String jobname=request.getParameter("jobname");
if(jobname!=null && jobname.length()>0 )
{
  sb2.append(" AND j.name =").append(DbAdapter.cite(jobname));
}
int company=0;
String tmp=request.getParameter("company");
if(tmp!=null&&tmp.length()>0)
{
  company=Integer.parseInt(tmp);
}

//sb2.append(" AND j.orgid IN ("+cex.substring(1,cex.length()-1).replaceAll("/",",")+")");
if(company!=0)
{
  sb2.append(" AND j.orgid="+company);
}
int hidden=-1;
tmp=request.getParameter("hidden");
if(tmp!=null&&tmp.length()>0)
{
  hidden=Integer.parseInt(tmp);
}
if(hidden!=-1)
{
  sb2.append(" AND n.hidden="+hidden);
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

int pos=0,pagesize=25;
tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}
int count=0;

//sb2.append(" AND rcreator = ").append(DbAdapter.cite(teasession._rv.toString()));
java.util.Vector vector2=new java.util.Vector();
DbAdapter db = new DbAdapter();
try
{
  count=db.getInt("SELECT COUNT(n.node) FROM Node n INNER JOIN Job j ON n.node=j.node WHERE n.type=50 AND n.community="+db.cite(community)+sb2.toString());
  db.executeQuery("SELECT n.node FROM Node n INNER JOIN Job j ON n.node=j.node WHERE n.type=50 AND n.community="+db.cite(community)+sb2.toString()+" ORDER BY n.sequence");
 // out.print("SELECT n.node FROM Node n INNER JOIN Job j ON n.node=j.node WHERE n.type=50 AND n.community="+db.cite(community)+sb2.toString()+" ORDER BY n.sequence");
  for (int l = 0; l < pos + pagesize && db.next(); l++)
  {
    if (l >= pos)
    {
      vector2.addElement(Integer.valueOf(db.getInt(1)));
    }
  }
} finally
{
  db.close();
}
java.util.Enumeration enumeration=vector2.elements();

Resource r=new Resource("/tea/resource/Job");

String info=request.getParameter("info");
if(info==null)
{
  info=r.getString(teasession._nLanguage,"1167443724812");//"职位管理";
}

String menuid=request.getParameter("id");

%><HTML>
<HEAD>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function f_load()
{
  <%
  //if(hidden!=null)out.print("form1.hidden.value='"+hidden+"';");
  %>
  form1.hidden.value='<%=hidden%>';
}
</script>
</HEAD>
<body onload="f_load()">
<h1 ><%=info%></h1>
<div id="head6"><img height="6" src="about:blank"></div>


<h2><%=r.getString(teasession._nLanguage,"1167443806359")%><!--查询--></h2>
<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menuid%>"/>

<input type="hidden" name="member" value="<%=member%>" />

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <%if(member!=null&& member.length()>0 && !"null".equals(member)){}else{%>
    <td>企业:<%=sm.toHtmlCompany(teasession._nLanguage,company)%></td>
    <%} %>
    <td>职位名称：<input type="text" name="jobname" value="<%if(jobname!=null)out.print(jobname);%>" /></td>
    <TD><%=r.getString(teasession._nLanguage, "职位状态")%><!--状态-->
      <select name="hidden">
      <option value="-1">----------------
      <option value="0"><%=r.getString(teasession._nLanguage, "1167449522921")%><!--招聘中-->
      <option value="1"><%=r.getString(teasession._nLanguage, "1167450232359")%><!--未发布-->
      </select>
    </TD>
    <td>
      <input type="submit" value="<%=r.getString(teasession._nLanguage,"1167445161546")%>"/>
      <!--查询-->
     <%--  <INPUT TYPE="BUTTON" value="<%=r.getString(teasession._nLanguage,"1167460447781")%>" onClick="window.open('/jsp/type/job/JobSearch.jsp?node=<%=teasession._nNode%>','_self');" />--%>
    </td>
  </tr>
</table>
</form>

<h2><%=r.getString(teasession._nLanguage,"1167443831593")+" ( "+count+" )"%><!--列表--></h2>
<form action="/servlet/EditAdminjob" name="operate">
<INPUT TYPE="hidden" name="nexturl" VALUE="<%=nexturl%>" /><!--request.getRequestURI()+"?"+request.getQueryString()-->
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr ID=tableonetr>
    <td nowrap>　</td>
    <%--    <td nowrap>职位编号</td>  --%>
    <td nowrap><%=r.getString(teasession._nLanguage,"1167443861406")%><!--职位名称--></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1167443881765")%><!--所属机构--></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1167444505750")%><!--发布时间--></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1167444537781")%><!--截止时间--></td>
    <%--
    <td nowrap><%=r.getString(teasession._nLanguage,"1167444560546")%><!--简历数量--></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1167444584125")%><!--应聘简历--></td>
    --%>
<!--    <td nowrap>暂停</td>-->
<td nowrap>职位状态</td>
    <td nowrap><%=r.getString(teasession._nLanguage,"操作")%><!--修改--></td>
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
    <td nowrap><A href="/jsp/type/job/yjobpreview.jsp?node=<%=node_id%>" target="_blank"><%=node.getSubject(teasession._nLanguage)%></A></td>
    <td nowrap><A href="/servlet/Company?node=<%=job.getOrgId()%>&language=<%=teasession._nLanguage%>" target="_blank"><%=Node.find(job.getOrgId()).getSubject(1)%></A></td>
    <td nowrap><%=node.getTimeToString()%></td>
    <td nowrap><%=job.getValidityDateToString()%></td>
    <%--//简历数量和应聘简历
    <td nowrap><%=JobApply.countByJob(node_id)%></td>
    <td nowrap><A href="/jsp/type/resume/JobApplyManage.jsp?job=<%=node_id%>"><%=r.getString(teasession._nLanguage,"1167444621250")%><!--查看--></A></td>
    --%>
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
    <td><%if(node.isHidden())out.print("未发布");else{out.print("招聘中");} %></td>
    <td nowrap>
    <%--
      <A href="/jsp/type/job/EditJob.jsp?node=<%=node_id%>&edit=alter&nexturl=<%=java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8")%>"><%=r.getString(teasession._nLanguage,"Update")%>
        <!--修改--></A>--%>
        <input type="button" value="修改" onclick="window.open('/jsp/type/job/EditJob.jsp?node=<%=node_id%>&edit=alter&nexturl=<%=java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8")%>','_self');">
</td>
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


<input type="BUTTON" value="<%=r.getString(teasession._nLanguage,"CBNewJob")%>" id="CBNewJob" class="in" onClick="window.open('/jsp/type/job/EditJob.jsp?NewNode=ON&Type=50&TypeAlias=0&node=<%=communityjob.getJob()%>&nexturl=<%=nexturl%>', '_self');"/>
<%
if(hidden==0)
{
  //暂停
  out.println("<INPUT TYPE=submit name=stop VALUE="+r.getString(teasession._nLanguage,"1167445239875")+" />");

  //未发布职位
  //out.println("<INPUT TYPE=BUTTON VALUE="+r.getString(teasession._nLanguage,"1167445331843")+"  onclick=\"window.open('"+request.getRequestURI()+"?hidden=1', '_self');\"/>");
}else
{
  //发布
  out.println("<INPUT TYPE=submit name=issue  VALUE="+r.getString(teasession._nLanguage,"1167453509015")+" />");

  //已发布职位
  //out.println("<INPUT TYPE=BUTTON VALUE="+r.getString(teasession._nLanguage,"1167445369281")+"  onclick=\"window.open('"+request.getRequestURI()+"?hidden=0', '_self');\"/>");
}
%>

   <INPUT TYPE="submit" name="delete" VALUE="<%=r.getString(teasession._nLanguage,"CBDelete")%>" ID="CBNewJob"  onClick="if(!confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>')){return false;}"/>


<%--
<!--导入SAP广告职位-->
<input type="button" value="<%=r.getString(teasession._nLanguage,"1167445399156")%>"  onClick="window.open('/jsp/type/resume/Input.jsp','_self');"><input  type="button" value="<%=r.getString(teasession._nLanguage,"1167445438343")%>" onClick="window.open('/jsp/type/job/yjobSap.jsp?node=<%=teasession._nNode%>','_self');"/>
--%>

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
