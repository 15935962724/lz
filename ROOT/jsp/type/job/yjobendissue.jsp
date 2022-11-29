<%@page contentType="text/html;charset=utf-8"  %>
<%@include file="/jsp/Header.jsp"%>
<%
Purview purview=Purview.find(teasession._rv.toString());
if(!purview.isJob()&&!License.getInstance().getWebMaster().equals(teasession._rv.toString())&&!teasession._rv.toString().equalsIgnoreCase(tea.entity.site.Community.find(teasession._nNode).getJobMember()))
{
    ts.outText(response,1, "你没有权限,访问本页.");
    return;
}
int pagesize=16;



String community=Node.find(teasession._nNode).getCommunity();//
//Purview purview=Purview.find(teasession._rv.toString());
StringBuffer sb=new StringBuffer();
StringBuffer sb2=new StringBuffer();
String purviewNode=purview.getNode();
String orgid= request.getParameter("orgid");

if(!License.getInstance().getWebMaster().equals(teasession._rv.toString())&&!teasession._rv.toString().equalsIgnoreCase(tea.entity.site.Community.find(teasession._nNode).getJobMember()))
{
    java.util.StringTokenizer tokenizer=new StringTokenizer(purview.getNode(),"/");
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

java.util.Vector vector=new java.util.Vector();java.util.Vector vector2=new java.util.Vector();
DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT Distinct Job.orgid FROM Node,Job  WHERE Node.hidden=1 AND finished=1 and Node.node=Job.node and type=50 AND community="+dbadapter.cite(community)+sb.toString());//+" ORDER BY sequence"
            for (; dbadapter.next(); vector.addElement(new Integer(dbadapter.getInt(1))));

            dbadapter.executeQuery("SELECT Node.node FROM Node,Job  WHERE  Node.hidden=1 AND Node.node=Job.node and type=50 AND community="+dbadapter.cite(community)+sb.toString()+sb2.toString()+" ORDER BY sequence");
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
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<TITLE>职位管理</TITLE>
<LINK REL=StyleSheet HREF>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<h1 align="left" style="margin-bottom:0px;">职位管理</h1> 
<div id="head6"><img height="6" src="about:blank"></div> 
<br> 
<table border="0" cellspacing="0" cellpadding="0" id="tablecenter"> 
  <tr> 
    <td> <h2><%if(vector.size()<=0){%> 
      你所管理的机构下没有未发布的职位</h2><br> 
      <INPUT TYPE="BUTTON" VALUE="创建职位" ID="CBNewJob" CLASS="in" onClick="window.open('/jsp/type/job/EditJob.jsp?NewNode=ON&Type=50&TypeAlias=0&node=<%=tea.entity.site.Community.find(teasession._nNode).getJobNode()%>&nexturl=/jsp/type/job/yjobendissue.jsp', '_self');"/> 
      <INPUT TYPE="BUTTON" VALUE="发布职位" ID="CBNewJob" CLASS="in" onClick="window.open('/jsp/type/job/yjobjobmanage.jsp', '_self');"/> 
      <%return;}%> 
      <span >&nbsp;您所管辖的机构下未发布的职位 <%=vector.size()%> 个。 请选择机构
      <SELECT NAME="orgid" STYLE="WIDTH: 292px;" onchange="window.open('/jsp/type/job/yjobendissue.jsp?orgid='+orgid.options[orgid.selectedIndex].value,'_self')"> 
        <OPTION VALUE="">--请选择招聘机构--</OPTION> 
        <%
java.util.Enumeration enumerationOrgid=vector.elements();

while(enumerationOrgid.hasMoreElements())
{
//    nodeCode=    Job.find( ((Integer)enumerationOrgid.nextElement()).intValue(),1).getSltOrgId()
 nodeCode=    ((Integer)enumerationOrgid.nextElement()).intValue()
   ;
if(tea.entity.node.Node.isExisted(nodeCode))
{
%> 
        <OPTION VALUE="<%=nodeCode%>"><%=Node.find(nodeCode).getSubject(1)%></OPTION> 
        <%}}%> 
      </SELECT> 
      </span></td> 
  </tr> 
</table> 
<form action="cnoocjoboperate.jsp" name="operate"> 
  <table border="0" cellspacing="0" cellpadding="0" id="tablecenter"> 
    <tr id="tableonetr"> 
      <td nowrap><input  id="CHECKBOX" type="CHECKBOX" onclick=" javascript:fselectall(this)" /></td> 
      <td nowrap>职位编号</td> 
      <td nowrap>职位名称</td> 
      <td nowrap>所属机构</td> 
      <td nowrap>发布时间</td> 
      <td nowrap>截止时间</td> 
      <td nowrap>简历数量</td> 
      <td nowrap>应聘简历</td> 
      <%--    <td nowrap>发布</td>--%> 
      <td nowrap>修改</td> 
      <%--    <td nowrap>删除</td>--%> 
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
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''"> 
      <td nowrap> <div align="center"><Span ID=JobIDJobCode> 
          <input  id="CHECKBOX" type="CHECKBOX" name="checkbox" value="<%=nodeCode%>"/> 
          </Span></div></td> 
      <td nowrap> <div align="center"><Span ID=JobIDJobCode><%=job.getTxtRefCode()%></Span> </div></td> 
      <td nowrap> <Span ID=JobIDname> <A href="/jsp/type/job/yjobpreview.jsp?node=<%=nodeCode%>" target="_blank"><%=job.getName()%></A> </Span> </td> 
      <td nowrap> <Span ID=JobIDOrgId> <A href="/servlet/Node?node=<%=job.getSltOrgId()%>"><%=Node.find(job.getSltOrgId()).getSubject(1)%></A> </Span> </td> 
      <td nowrap> <div align="center"><Span ID=JobIDissuetime><%=node.getTimeToString()%></Span> </div></td> 
      <td nowrap> <div align="center"><Span ID=JobIDvalidity><%=job.getValidityDateToString()%></Span> </div></td> 
      <td nowrap> <div align="center"><Span ID=JobIDcount><%=tea.entity.member.Apply.countByJob(nodeCode)%> 
          <%//=tea.entity.member.Apply.countByNode(nodeCode)%> 
          </Span> </div></td> 
      <td nowrap> <div align="center"><Span ID=JobIDResume> <A href="/jsp/type/resume/yjobapplymanage.jsp?applyAmount=<%=nodeCode%>">查看</A> </Span> </div></td> 
      <%--    <td nowrap>
        <div align="center"><Span ID=JobIDResume>
            <form action="/servlet/SetVisible" method="POST">
                <input type="hidden" name="Node" value="<%=nodeCode%>"/>
                    <input type="hidden" name="nexturl" value="/jsp/type/job/cnoocjobendissue.jsp"/>
            <A HREF="#" onclick="submit()">发布</A>
            </form>
        </Span>
        </div></td>--%> 
      <td nowrap> <div align="center"><Span ID=JobIDAlterCopy> <A href="/jsp/type/job/EditJob.jsp?node=<%=nodeCode%>&nexturl=/jsp/type/job/yjobjobmanage.jsp?node=<%=nodeCode%>">修改</A> </Span> </div></td> 
      <%--    <td nowrap>
        <div align="center"><Span ID=JobIDDelete>
            <A onClick="if(confirm('确认删除')){window.open('/servlet/DeleteNode?node=<%=nodeCode%>&nexturl=<%=request.getRequestURI()+"?"+request.getQueryString()%>', '_self')};" HREF="#">删除</A>
        </Span>
        </div></td>--%> 
    </tr> 
    <% }%> 
  </table> 
  </div> 
  <LI ID="PageNum"> 
    <%
int sum=count/pagesize;
if(count%pagesize!=0)
sum=sum+1;
if(count>pagesize)
{

    if(pos>0)
    out.print("<A HREF="+request.getRequestURI()+"?node="+teasession._nNode+"&pos="+pos+"&"+request.getQueryString()+" >上一页</A> ");

    for(int len=1;len<=sum;len++)
    {
        if((pos+1)==len)
        out.println("<span>"+len+"</span> ");
        else
        out.print("<A HREF="+request.getRequestURI()+"?node="+teasession._nNode+"&pos="+len+"&"+request.getQueryString()+">"+len+"</A> ");
    }
    if((pos+2)<=sum)
    out.print("<A HREF="+request.getRequestURI()+"?node="+teasession._nNode+"&pos="+(pos+2)+"&"+request.getQueryString()+">下一页</A> ");
}
%> 
  </LI> 
  <div style="TEXT-ALIGN: center;padding-top:10px"> 
    <INPUT TYPE="hidden" name="nexturl" VALUE="<%=request.getRequestURI()+"?"+request.getQueryString()%>" /> 
    <INPUT TYPE="BUTTON" name="query" VALUE="查询" ID="CBNewJob" onclick="location='JobSearch.jsp?node=<%=teasession._nNode%>'" CLASS="in"/> 
    <INPUT TYPE="submit" name="issue" VALUE="发布" ID="CBNewJob" CLASS="in"/> 
    <INPUT TYPE="submit"  name="delete" VALUE="删除" ID="CBNewJob" CLASS="in" onClick="if(!confirm('确认删除')){return false;}"/> 
    <INPUT TYPE="BUTTON" VALUE="创建职位" ID="CBNewJob" CLASS="in" onClick="window.open('/jsp/type/job/EditJob.jsp?NewNode=ON&Type=50&TypeAlias=0&node=<%=tea.entity.site.Community.find(teasession._nNode).getJobNode()%>&nexturl=/jsp/type/job/yjobendissue.jsp', '_self');"/> 
    <INPUT TYPE="BUTTON" VALUE="发布职位" ID="CBNewJob" CLASS="in" onClick="window.open('/jsp/type/job/yjobjobmanage.jsp', '_self');"/> 
  </div> 
</form> 
<script>
function fselectall(obj)
{      for(var counter=0;counter<operate.elements.length;counter++)
      {
          if(operate.elements[counter].type=="checkbox")
          {
              operate.elements[counter].checked=obj.checked;
          }
      }
}
</script> 
<div id="head6"><img height="6" src="about:blank"></div> 
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div> 
</body>
</html>

