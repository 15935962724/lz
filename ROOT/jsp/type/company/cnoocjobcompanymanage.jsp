<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
Purview purview=Purview.find(teasession._rv.toString(),teasession._strCommunity);
if(!purview.isCompany()&&!License.getInstance().getWebMaster().equals(teasession._rv.toString())&&!teasession._rv.toString().equalsIgnoreCase("cnooc"))
{
    ts.outText(response,1, "你没有权限,访问本页.");
    return;
}
%>
<%@include file="/jsp/type/job/cnoocjobheader.jsp" %>
<div id="jigouwai" style="width:98%;">
        <div id="jigounei" style="width:100%;">
          <div style="width:100%;">
            <h1 align="left" style="margin-bottom:0px;">机构管理</h1>

<table width="98%" border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;" align="center">
  <tr align="center" bgcolor="#FFFBF0">
    <td nowrap>公司名称</td>
    <td nowrap>联系人</td>
    <td nowrap>邮箱</td>
    <td nowrap>传真</td>
    <td nowrap>电话</td>
    <td nowrap>网址</td>
    <td nowrap>招聘职位</td>
    <td nowrap>编辑</td>
    <td nowrap>删除</td>
  </tr>
<%
int pagesize=20;
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
String community=Node.find(teasession._nNode).getCommunity();
String strPurview=purview.getNode();
StringBuffer sb=new StringBuffer();
if(!License.getInstance().getWebMaster().equals(teasession._rv.toString())&&!teasession._rv.toString().equalsIgnoreCase("cnooc"))
{
    java.util.StringTokenizer tokenizer=new StringTokenizer(strPurview,"/");
    if(tokenizer.hasMoreTokens())
        sb.append(" and (Node.node="+tokenizer.nextToken());
        while(tokenizer.hasMoreTokens())
        {
            sb.append(" OR Node.node="+tokenizer.nextToken());
        }
    sb.append(")");
}
java.util.Vector vector=new java.util.Vector();
DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT node FROM Node  WHERE type=21 AND community="+dbadapter.cite(community)+sb.toString()+" ORDER BY sequence");
            for (; dbadapter.next(); vector.addElement(new Integer(dbadapter.getInt(1))));
        } catch (Exception exception)
        {
           exception.printStackTrace();
        } finally
        {
            dbadapter.close();
        }

int count=vector.size();
java.util.Enumeration enumeration=vector.elements();
int nodeCode;
int pos=request.getParameter("pos")==null?0:Integer.parseInt(request.getParameter("pos"))-1;
for(int len=0;len<pos*pagesize&&enumeration.hasMoreElements();len++)
{enumeration.nextElement();
}
for(int len=0;len<pagesize&&enumeration.hasMoreElements();len++)
{
nodeCode =((Integer)enumeration.nextElement()).intValue();
Company classified=Company.find(nodeCode);
%>
<tr>
    <td nowrap><Span ID=CompanyIDName><A href="/servlet/Node?node=<%=nodeCode%>" target="_blank">&nbsp;<%=Node.find(nodeCode).getSubject(1)%></A></Span></td>
    <td nowrap>&nbsp;<Span ID=CompanyIDContact><%=getNull(classified.getContact(teasession._nLanguage))%></Span></td>
    <td nowrap><Span ID=CompanyIDEmailAddress><A href="mailto:<%=getNull(classified.getEmail(teasession._nLanguage))%>"><%=getNull(classified.getEmail(teasession._nLanguage))%></a></Span></td>
    <td nowrap><Span ID=CompanyIDFax>&nbsp;<%=getNull(classified.getFax(teasession._nLanguage))%></Span></td>
    <td nowrap><Span ID=CompanyIDTelephone>&nbsp;<%=getNull(classified.getTelephone(teasession._nLanguage))%></Span></td>
    <td nowrap><Span ID=CompanyIDWebPage><A href=<%=getNull(classified.getWebPage(teasession._nLanguage))%>><%=getNull(classified.getWebPage(teasession._nLanguage))%></A></Span></td>
    <td nowrap align=center><Span ID=CompanyIDCorpJobButton>
        <INPUT TYPE=BUTTON VALUE=招聘职位 onClick="window.open('/jsp/type/job/cnoocjobjobmanage.jsp?node=15542&orgid=<%=nodeCode%>','_self')"/>
    </Span></td>
    <td nowrap align=center><input type="button" onclick="window.open('/jsp/type/company/cnoocjobEditCompany.jsp?node=<%=nodeCode%>&nexturl=<%=request.getRequestURI()+"?"+request.getQueryString()%>','_self')" name="Submit" style="border:1px solid #ffffff;" class="in" value="编辑">
</td>
            <td nowrap align=center><Span ID=CompanyIDDeleteButton>
                <INPUT TYPE="BUTTON" VALUE=删除 onClick="if(confirm('确认删除')){window.open('/servlet/DeleteNode?node=<%=nodeCode%>&nexturl=<%=request.getRequestURI()+"?"+request.getQueryString()%>', '_self');}"/>
            </Span></td>
        </tr>
<%}%>
</table>
</div><LI ID="PageNum">
<%
int sum=count/pagesize;
if(count%pagesize!=0)
sum=sum+1;
if(sum>0)
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
<div style="TEXT-ALIGN: center;padding-top:5px">
<INPUT TYPE="BUTTON" VALUE="创建公司" ID="CBNewCompany" CLASS="in" onClick="window.open('/jsp/type/company/cnoocjobEditCompany.jsp?NewNode=ON&Type=21&TypeAlias=0&node=15443&nexturl=<%=request.getRequestURI()+"?"+request.getQueryString()%>', '_self');"/></div></div></div>
<div align="center"><%@include file="/jsp/type/job/cnoocjobfooter.jsp" %></div>

