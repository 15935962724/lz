<%@page contentType="text/html;charset=UTF-8"  %>
<%@include file="/jsp/Header.jsp"%>

<%

int pagesize=15;
Purview purview=Purview.find(teasession._rv.toString());
String community=Node.find(teasession._nNode).getCommunity();//
//Purview purview=Purview.find(teasession._rv.toString());
StringBuffer sb=new StringBuffer();

String purviewNode=purview.getNode();

if(!License.getInstance().getWebMaster().equals(teasession._rv.toString())&&!teasession._rv.toString().equalsIgnoreCase("cnooc"))
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
java.util.Vector vector2=new java.util.Vector();
DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT Node.node FROM Node,Job  WHERE  Node.hidden=0 AND Node.node=Job.node and type=50 AND community="+dbadapter.cite(community)+sb.toString()+" ORDER BY sequence");
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

<table width="98%" border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;" align="center">
  <tr align="center" bgcolor="#FFFBF0">
    <td nowrap>职位编号</td>
    <td nowrap>职位名称</td>
    <td nowrap>所属机构</td>
    <td nowrap>备选简历</td>
    <td nowrap>有价值简历</td>
    <td nowrap>不合格简历</td>
    <td nowrap>简历数量</td>
    <td nowrap>应聘简历</td>
  </tr>
<%

java.util.Enumeration enumeration=vector2.elements();
for(int len=0;(len<(pos*pagesize))&&enumeration.hasMoreElements();enumeration.nextElement(),len++);
int resumecount[]=new int[3];
for(int len=0;len<pagesize&&enumeration.hasMoreElements();len++)
{
nodeCode =((Integer)enumeration.nextElement()).intValue();
Job job=Job.find(nodeCode,1);
Node node=    Node.find(nodeCode);
for(int sublen=0;sublen<resumecount.length;sublen++)
resumecount[sublen]=ResumeSort.count(teasession._rv.toString(),sublen+1,nodeCode);
%>
<tr>
    <td nowrap>
        <div align="center"><Span ID=JobIDJobCode><%=job.getTxtRefCode()%></Span>
        </div></td>
    <td nowrap>
        <Span ID=JobIDname>
            <A href="/jsp/type/job/cnoocjobpreview.jsp?node=<%=nodeCode%>" target="_blank">　<%=job.getName()%></A>        </Span>    </td>
    <td nowrap>
        <Span ID=JobIDOrgId>
            <A href="/servlet/Node?node=<%=job.getSltOrgId()%>"><%=Node.find(job.getSltOrgId()).getSubject(1)%></A>
        </Span>
    </td>
    <td nowrap>
        <div align="center"><Span ID=JobIDissuetime><a href="/jsp/type/resume/cnoocjobapplymanage.jsp?node=15542&ResumeSorttype=1&ResumeSortjob=<%=nodeCode%>"><%=resumecount[0]%></a></Span>
        </div></td>
    <td nowrap>
        <div align="center"><Span ID=JobIDvalidity><a href="/jsp/type/resume/cnoocjobapplymanage.jsp?node=15542&ResumeSorttype=2&ResumeSortjob=<%=nodeCode%>"><%=resumecount[1]%></a></Span>
        </div></td>
            <td nowrap>
        <div align="center"><Span ID=JobIDvalidity><a href="/jsp/type/resume/cnoocjobapplymanage.jsp?node=15542&ResumeSorttype=3&ResumeSortjob=<%=nodeCode%>"><%=resumecount[2]%></a></Span>
        </div></td>
    <td nowrap>
        <div align="center"><Span ID=JobIDcount><%=tea.entity.member.Apply.countByJob(nodeCode)%></Span>
        </div></td>
    <td nowrap>
        <div align="center"><Span ID=JobIDResume>
            <A href="/jsp/type/resume/cnoocjobapplymanage.jsp?node=15542&applyAmount=<%=nodeCode%>">查看</A>
        </Span>
        </div></td>
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
    out.print("<A HREF="+request.getRequestURI()+"?node="+teasession._nNode+"&pos="+pos+" >上一页</A> ");

    for(int len=1;len<=sum;len++)
    {
        if((pos+1)==len)
        out.println("<span>"+len+"</span> ");
        else
        out.print("<A HREF="+request.getRequestURI()+"?node="+teasession._nNode+"&pos="+len+">"+len+"</A> ");
    }
    if((pos+2)<=sum)
    out.print("<A HREF="+request.getRequestURI()+"?node="+teasession._nNode+"&pos="+(pos+2)+">下一页</A> ");
}
%>
</LI>
</div></div></div>

