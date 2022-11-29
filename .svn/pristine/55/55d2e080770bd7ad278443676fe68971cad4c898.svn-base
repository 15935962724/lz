<%@page contentType="text/html;charset=UTF-8"  %><%@page import="tea.entity.admin.*"%>
<%@include file="/jsp/Header.jsp"%>
<%
/*
tea.entity.node.Purview purview=tea.entity.node.Purview.find(teasession._rv.toString());
if(!purview.isJob()&&!License.getInstance().getWebMaster().equals(teasession._rv.toString())&&!teasession._rv.toString().equalsIgnoreCase(tea.entity.site.Community.find(teasession._nNode).getJobMember()))
{
    ts.outText(response,1, "你没有权�?访问本页.");
    return;
}
*/

int pagesize=15;


String community=teasession._strCommunity;
Communityjob communityjob=Communityjob.find(community);
//
//Purview purview=Purview.find(teasession._rv.toString());
StringBuffer sb=new StringBuffer();
StringBuffer sb2=new StringBuffer();
//String purviewNode=purview.getNode();
String orgid= request.getParameter("orgid");

if(!License.getInstance().getWebMaster().equals(teasession._rv.toString())&&!teasession._rv.toString().equalsIgnoreCase(communityjob.getJobmember()))
{
	AdminUsrRole aur_obj=AdminUsrRole.find(community,teasession._rv._strV);
    java.util.StringTokenizer tokenizer=new StringTokenizer(aur_obj.getCompany(),"/");
    if(tokenizer.hasMoreTokens())
    sb.append(" and (Job.orgid="+tokenizer.nextToken());
    while(tokenizer.hasMoreTokens())
    {
        sb.append(" OR Job.orgid="+tokenizer.nextToken());
    }
    sb.append(") ");
}
if(orgid!=null&&Integer.parseInt(orgid)!=0)
{
    sb2.append(" AND Job.orgid="+orgid);
}
String txtStartDate=request.getParameter("txtStartDate");
if(txtStartDate!=null&&txtStartDate.length()>0)
{
    sb2.append(" AND Node.time>="+tea.db.DbAdapter.cite(txtStartDate));
}
String txtEndDate=request.getParameter("txtEndDate");
if(txtEndDate!=null&&txtEndDate.length()>0)
{
    sb2.append(" AND Node.time<"+tea.db.DbAdapter.cite(txtEndDate));
}
String keyword=request.getParameter("keyword");
if(keyword!=null&&keyword.length()>0)
{
  keyword=tea.db.DbAdapter.cite("%"+keyword+"%");
  String FIELD[]={"Job.name","Job.refcode","Job.jobtype","Job.occid","Job.salaryid","Job.locid","Job.reqdeg","Job.jobduty"};
  sb2.append(" AND ("+FIELD[0]+" LIKE "+keyword);
  for(int index=1;index<FIELD.length;index++)
  sb2.append(" OR "+FIELD[index]+" LIKE "+keyword);
  sb2.append(")");
}
String refcode=request.getParameter("refcode");
if(refcode!=null&&refcode.length()>0)
{
    sb2.append(" AND Job.refcode LIKE "+tea.db.DbAdapter.cite("%"+refcode+"%"));
}


java.util.Vector vector=new java.util.Vector();
java.util.Vector vector2=new java.util.Vector();
tea.db.DbAdapter dbadapter = new tea.db.DbAdapter();
try
{
  //System.out.println("SELECT Distinct( Job.orgid) FROM Node,Job  WHERE Node.hidden=0 AND Node.node=Job.node and type=50 AND community="+dbadapter.cite(community)+sb.toString()+" ORDER BY sequence");

  dbadapter.executeQuery("SELECT Distinct( Job.orgid) FROM Node,Job  WHERE Node.hidden=2 AND Node.node=Job.node and type=50 AND community="+dbadapter.cite(community)+sb.toString());
  for (; dbadapter.next(); vector.addElement(new Integer(dbadapter.getInt(1))));

  dbadapter.executeQuery("SELECT Node.node FROM Node,Job  WHERE  Node.hidden=2 AND Node.node=Job.node and type=50 AND community="+dbadapter.cite(community)+sb.toString()+sb2.toString()+" ORDER BY sequence");
  for (; dbadapter.next(); vector2.addElement(new Integer(dbadapter.getInt(1))));
} catch (Exception exception)
{
  exception.printStackTrace();
} finally
{
  dbadapter.close();
}

int count=vector2.size();
int pos= request.getParameter("pos")==null?0:Integer.parseInt(request.getParameter("pos"))-1;


int nodeCode;
%><html>
<head>
<TITLE>职位管理</TITLE>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>

<h1>职位管理(<%=vector2.size()%>->SAP广告职位</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td align="left" style="padding:5px "><span style="float:left">
<%if(vector2.size()<=0){
  %>你所管理的机构下没有正在招聘中的职位<br>
         <input type="BUTTON" value="创建职位" id="CBNewJob" class="in" onClick="window.open('/jsp/type/job/EditJob.jsp?NewNode=ON&Type=50&TypeAlias=0&node=<%=communityjob.getJob()%>&nexturl=<%=request.getRequestURI()%>', '_self');"/>
  <INPUT TYPE="BUTTON" VALUE="末发布职�? ID="CBNewJob" CLASS="in" onClick="window.open('/jsp/type/job/yjobendissue.jsp', '_self');"/>
<%
return;}
%>
      &nbsp;您所管辖的机构下正在招聘的职位有<%=vector2.size()%> �? 请选择机构
<SELECT NAME="orgid" STYLE="WIDTH: 292px;" onChange="window.open('<%=request.getRequestURI()%>?orgid='+orgid.options[orgid.selectedIndex].value,'_self')">
<OPTION VALUE="0">--请选择招聘机构--</OPTION>
<%
//tea.entity.node.Job.findCompanyByMember(teasession._rv._strR,teasession._nNode,teasession._nLanguage);//
java.util.Enumeration enumerationOrgid=vector.elements();

while(enumerationOrgid.hasMoreElements())
{
    nodeCode=((Integer)enumerationOrgid.nextElement()).intValue()//Job.find( ((Integer)enumerationOrgid.nextElement()).intValue(),1).getSltOrgId()
   ;
if(tea.entity.node.Node.isExisted(nodeCode))
{
%>
<OPTION VALUE="<%=nodeCode%>"><%=Node.find(nodeCode).getSubject(1)%></OPTION>
<%}}%>
</SELECT>
</span>
<form action="EditJobMailmsg.jsp" method="get" style="float:left">
<input type=hidden name=nexturl value="<%=request.getRequestURI()+"?"+request.getQueryString()%>">
<input type="checkbox" name="jobmailmsg"    <%if(tea.entity.member.Profile.find(teasession._rv._strR).isJobMailMsg())out.print(" CHECKED ");  %> onClick="submit();"  value="checkbox">是否接收邮件
</form>
</td>
  </tr></table>

<form action="cnoocjoboperate.jsp" name="operate">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr id="tableonetr">
    <td nowrap><input type="checkbox" onClick=" javascript:fselectall(this)" /></td>
<%--    <td nowrap>职位编号</td> --%>
    <td nowrap>职位名称</td>
    <td nowrap>所属机�?/td>
    <td nowrap>发布时间</td>
    <td nowrap>截止时间</td>
    <td nowrap>简历数�?/td>
    <td nowrap>应聘简�?/td>
<!--    <td nowrap>暂停</td>-->
    <td nowrap>修改</td>
<!--    <td nowrap>删除</td>-->
  </tr>
<%

java.util.Enumeration enumeration=vector2.elements();
for(int len=0;(len<(pos*pagesize))&&enumeration.hasMoreElements();enumeration.nextElement(),len++);

for(int len=0;len<pagesize&&enumeration.hasMoreElements();len++)
{
nodeCode =((Integer)enumeration.nextElement()).intValue();
Job job=Job.find(nodeCode,1);
Node node=    Node.find(nodeCode);
%>
<tr>
   <td nowrap>
        <div align="center"><Span ID=JobIDJobCode><input type="checkbox" name="checkbox" value="<%=nodeCode%>"/></Span></div>
    </td>
    <%--
    <td nowrap>
        <div align="center"><Span ID=JobIDJobCode><%=job.getTxtRefCode()%></Span></div>
    </td>
    --%>
    <td nowrap><A href="/jsp/type/job/yjobpreview.jsp?node=<%=nodeCode%>" target="_blank">　<%=job.getName()%></A></td>
    <td nowrap><A href="/servlet/Node?node=<%=job.getSltOrgId()%>">　<%=Node.find(job.getSltOrgId()).getSubject(1)%></A></td>
    <td nowrap><%=node.getTimeToString()%></td>
    <td nowrap><%=job.getValidityDateToString()%></td>
    <td nowrap><%=tea.entity.member.Apply.countByJob(nodeCode)%></td>
    <td nowrap><A href="/jsp/type/resume/yjobapplymanage.jsp?applyAmount=<%=nodeCode%>">查看</A></td>
<%--            <td nowrap>
        <div align="center"><Span ID=JobIDAlterCopy>
               <form action="/servlet/SetVisible" method="POST">
                <input type="hidden" name="Node" value="<%=nodeCode%>"/>
                <input type="hidden" name=NodeOHidden value=ON  />
                <input type="hidden" name="nexturl" value="/jsp/type/job/cnoocjobjobmanage.jsp?node=15542"/>
            <A HREF="#" onclick="submit()">暂停</A>
            </form>
        </Span>
        </div>
    </td>--%>
    <td nowrap><A href="/jsp/type/job/EditJob.jsp?node=<%=nodeCode%>&edit=alter&nexturl=<%=java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8")%>">修改</A></td>
<%--    <td nowrap>
        <div align="center"><Span ID=JobIDDelete>
            <A onClick="if(confirm('确认删除')){window.open('/servlet/DeleteNode?node=<%=nodeCode%>&nexturl=<%=request.getRequestURI()+"?"+request.getQueryString()%>', '_self')};" HREF="#">删除</A>
        </Span>
        </div></td>--%>
</tr>
<% }%>
 </table>
<li ID="PageNum">
<%=new tea.htmlx.FPNL(teasession._nLanguage,"?node="+teasession._nNode+("&"+request.getQueryString()).replaceFirst("pos=","")+"&pos=",pos,count,pagesize)

//int sum=count/pagesize;
//if(count%pagesize!=0)
//sum=sum+1;
//if(count>pagesize)
//{
//    if(pos>0)
//    out.print("<A HREF="+request.getRequestURI()+"?node="+teasession._nNode+"&pos="+pos+"&"+request.getQueryString()+" >上一�?/A> ");
//
//    for(int len=1;len<=sum;len++)
//    {
//        if((pos+1)==len)
//        out.println("<span>"+len+"</span> ");
//        else
//        out.print("<A HREF="+request.getRequestURI()+"?node="+teasession._nNode+"&pos="+len+"&"+request.getQueryString()+">"+len+"</A> ");
//    }
//    if((pos+2)<=sum)
//    out.print("<A HREF="+request.getRequestURI()+"?node="+teasession._nNode+"&pos="+(pos+2)+"&"+request.getQueryString()+">下一�?/A> ");
//}
%>
</li>

<div style="TEXT-ALIGN: center;padding-top:10px">
   <INPUT TYPE="hidden" name="nexturl" VALUE="<%=request.getRequestURI()+"?"+request.getQueryString()%>" />

   <INPUT TYPE="BUTTON" name="query" VALUE="查询" ID="CBNewJob" onClick="location='JobSearch.jsp?node=<%=teasession._nNode%>'" CLASS="in"/>
   <INPUT TYPE="submit" name="stop" VALUE="暂停" ID="CBNewJob" CLASS="in"/>
   <INPUT TYPE="submit"  name="delete" VALUE="删除" ID="CBNewJob" CLASS="in" onClick="if(!confirm('确认删除')){return false;}"/>
   <input type="BUTTON" value="创建职位" id="CBNewJob" class="in" onClick="window.open('/jsp/type/job/EditJob.jsp?NewNode=ON&Type=50&TypeAlias=0&node=<%=communityjob.getJob()%>&nexturl=<%=request.getRequestURI()%>', '_self');"/>
  <INPUT TYPE="BUTTON" VALUE="未发布职�? ID="CBNewJob" CLASS="in" onClick="window.open('/jsp/type/job/yjobjobmanage.jsp?hidden=1', '_self');"/>
  <input type="button" value="导入SAP广告" CLASS="in" onClick="window.open('/jsp/type/resume/Input.jsp','_self');">
</div>
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
</div>
</body></html>

