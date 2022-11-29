<%@page contentType="text/html;charset=UTF-8"  %>
<%@include file="/jsp/Header.jsp"%>

<%
Purview purview=Purview.find(teasession._rv.toString());
if(!purview.isJob()&&!License.getInstance().getWebMaster().equals(teasession._rv.toString())&&!teasession._rv.toString().equalsIgnoreCase("cnooc"))
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
if(orgid!=null)
{
    sb2.append(" and Job.orgid="+orgid);
}

java.util.Vector vector=new java.util.Vector();java.util.Vector vector2=new java.util.Vector();
DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT Node.node FROM Node,Job  WHERE Node.hidden=1 AND Node.node=Job.node and type=50 AND community="+dbadapter.cite(community)+sb.toString()+" ORDER BY sequence");
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
<%@include file="/jsp/type/job/cnoocjobheader.jsp" %>
<div id="jigouwai" style="width:98%;">
        <div id="jigounei" style="width:100%;">
          <div style="width:100%;">
            <h1 align="left" style="margin-bottom:0px;">职位管理</h1>
			<br><table width="98%" border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;border-bottom:0px" align="center">
  <tr  bgcolor="#FFFBF0">
    <td align="left"><span >&nbsp;您所管辖的机构下末发布的职位 <%=vector.size()%> 个。  请选择机构
<SELECT NAME="orgid" STYLE="WIDTH: 292px;" onchange="window.open('/jsp/type/job/cnoocjobjobmanage.jsp?node=15542&orgid='+orgid.options[orgid.selectedIndex].value,'_self')">
<OPTION VALUE="">--请选择招聘机构--</OPTION>
<%
java.util.Enumeration enumerationOrgid=vector.elements();

while(enumerationOrgid.hasMoreElements())
{
    nodeCode=    Job.find( ((Integer)enumerationOrgid.nextElement()).intValue(),1).getSltOrgId()
   ;

%>
<OPTION VALUE="<%=nodeCode%>"><%=Node.find(nodeCode).getSubject(1)%></OPTION>
<%}%>
</SELECT></span></td></tr></table>
<form action="cnoocjoboperate.jsp" name="operate">
<table width="98%" border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;" align="center">
  <tr align="center" bgcolor="#FFFBF0">
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
<tr>
     <td nowrap>
        <div align="center"><Span ID=JobIDJobCode><input  id="CHECKBOX" type="CHECKBOX" name="checkbox" value="<%=nodeCode%>"/></Span></div>
    </td>
    <td nowrap>
        <div align="center"><Span ID=JobIDJobCode><%=job.getTxtRefCode()%></Span>
        </div></td>
    <td nowrap>
        <Span ID=JobIDname>
            <A href="/jsp/type/job/cnoocjobpreview.jsp?node=<%=nodeCode%>" target="_blank"><%=job.getName()%></A>
        </Span>
    </td>
    <td nowrap>
        <Span ID=JobIDOrgId>
            <A href="/servlet/Node?node=<%=job.getSltOrgId()%>">　<%=Node.find(job.getSltOrgId()).getSubject(1)%></A>
        </Span>
    </td>
    <td nowrap>
        <div align="center"><Span ID=JobIDissuetime><%=node.getTime("yyyy-MM-dd")%></Span>
        </div></td>
    <td nowrap>
        <div align="center"><Span ID=JobIDvalidity><%=job.getValidityDateToString()%></Span>
        </div></td>
    <td nowrap>
        <div align="center"><Span ID=JobIDcount><%=tea.entity.member.Apply.countByJob(nodeCode)%><%//=tea.entity.member.Apply.countByNode(nodeCode)%></Span>
        </div></td>
        <td nowrap>
        <div align="center"><Span ID=JobIDResume>
            <A href="/jsp/type/resume/cnoocjobapplymanage.jsp?node=15542&applyAmount=<%=nodeCode%>">查看</A>
        </Span>
        </div></td>
<%--    <td nowrap>
        <div align="center"><Span ID=JobIDResume>
            <form action="/servlet/SetVisible" method="POST">
                <input type="hidden" name="Node" value="<%=nodeCode%>"/>
                    <input type="hidden" name="nexturl" value="/jsp/type/job/cnoocjobendissue.jsp"/>
            <A HREF="#" onclick="submit()">发布</A>
            </form>
        </Span>
        </div></td>--%>
    <td nowrap>
        <div align="center"><Span ID=JobIDAlterCopy>
            <A href="/jsp/type/job/cnoocjobEditJob.jsp?node=<%=nodeCode%>&nexturl=/jsp/type/job/cnoocjobjobmanage.jsp?node=<%=nodeCode%>">修改</A>
        </Span>
        </div></td>
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

<div style="TEXT-ALIGN: center;padding-top:10px">
   <INPUT TYPE="hidden" name="nexturl" VALUE="<%=request.getRequestURI()+"?"+request.getQueryString()%>" />
   <INPUT TYPE="submit" name="issue" VALUE="发布" ID="CBNewJob" CLASS="in"/>
   <INPUT TYPE="submit"  name="delete" VALUE="删除" ID="CBNewJob" CLASS="in" onClick="if(!confirm('确认删除')){return false;}"/>
  <INPUT TYPE="BUTTON" VALUE="创建职位" ID="CBNewJob" CLASS="in" onClick="window.open('/jsp/type/job/cnoocjobEditJob.jsp?NewNode=ON&Type=50&TypeAlias=0&node=15470&nexturl=/jsp/type/job/cnoocjobendissue.jsp', '_self');"/>
  <INPUT TYPE="BUTTON" VALUE="发布职位" ID="CBNewJob" CLASS="in" onClick="window.open('/jsp/type/job/cnoocjobjobmanage.jsp?node=15542', '_self');"/>
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
</div></div></div>
<%@include file="/jsp/type/job/cnoocjobfooter.jsp" %>

