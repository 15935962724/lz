<%@page contentType="text/html;charset=UTF-8"  %><%@page import="java.util.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.db.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.ui.*" %><%@page import="tea.resource.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.node.*" %><%request.setCharacterEncoding("UTF-8"); %>
<%!

public java.util.Enumeration getOrg(TeaSession teasession) throws java.sql.SQLException
{
  Communityjob communityjob=Communityjob.find(teasession._strCommunity);
  StringBuffer sb=new StringBuffer();
  if(!License.getInstance().getWebMaster().equals(teasession._rv.toString())&&!teasession._rv.toString().equalsIgnoreCase(communityjob.getJobmember()))
  {
    AdminUsrRole aur_obj=AdminUsrRole.find(teasession._strCommunity,teasession._rv._strV);

    java.util.StringTokenizer tokenizer=new StringTokenizer(aur_obj.getCompany(),"/");
    if(tokenizer.hasMoreTokens())
    sb.append(" AND (n.node="+tokenizer.nextToken());
    while(tokenizer.hasMoreTokens())
    {
      sb.append(" OR n.node="+tokenizer.nextToken());
    }
    sb.append(")");
  }
  java.util.Vector vector=new java.util.Vector();
  DbAdapter dbadapter= new DbAdapter();
  try
  {
    dbadapter.executeQuery("SELECT DISTINCT n.node,c.sequence,n.sequence FROM Node n INNER JOIN Company c ON n.node=c.node WHERE n.node=c.node AND n.type=21 AND n.community="+dbadapter.cite(teasession._strCommunity)+sb.toString()+" ORDER BY c.sequence, n.sequence");
    while (dbadapter.next())
    {
      vector.addElement(Integer.valueOf(dbadapter.getInt(1)));
    }
  } catch (Exception exception)
  {
    exception.printStackTrace();
  }finally
  {
    dbadapter.close();
  }
  return vector.elements();
}

%>
<%
//TeaSession teasession=new TeaSession(request);
//String info=request.getParameter("info");
//int count=Integer.parseInt(request.getParameter("count"));

%>
<h1 ><%=info+"("+count+")"%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<h2>查询</h2>
<form name="form1" method="post" action="/jsp/type/resume/yjobapplymanage.jsp">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td >
<SELECT NAME="orgid"  onchange="fadd(this.value)">
<OPTION VALUE="">--请选择招聘机构--</OPTION>
<%
java.util.Enumeration amh_enumeration=getOrg(teasession);
StringBuffer amh_script=new StringBuffer();
while(amh_enumeration.hasMoreElements())
{
  int node_id =((Integer)amh_enumeration.nextElement()).intValue();
  Node node_obj=Node.find(node_id);
  amh_script.append("case "+node_id+":\r\n");
  DbAdapter amh_dbadapter=new DbAdapter();
  try
  {
    amh_dbadapter.executeQuery("SELECT n.node FROM Node n INNER JOIN Job j ON n.node=j.node WHERE j.orgid="+node_id);
    while(amh_dbadapter.next())
    {
      int node_id_2=amh_dbadapter.getInt(1);
      Node obj_2=Node.find(node_id_2);
      String subject_2=obj_2.getSubject(teasession._nLanguage).replaceAll("\"","&quot;");
      amh_script.append("form1.applyAmount.options.add(new Option(\""+subject_2+"\",'"+node_id_2+"'));");
    }
  }finally
  {
    amh_dbadapter.close();
  }
  amh_script.append("break;\r\n");
  out.print("<option value="+node_id+" >"+node_obj.getSubject(teasession._nLanguage));
}
out.print("</SELECT>");
out.print("<select name=applyAmount STYLE=\"WIDTH: 200px\"><option value=\"\">----请选择职位----</option></select>");

if(resumesorttype!=null)
out.println("<input type=hidden name=resumesorttype value="+resumesorttype+" />");


%>
<script>
function fadd(value)
{
  var ccc=form1.applyAmount.length;
  for(;1<=ccc;ccc--)
  form1.applyAmount.remove(ccc);

  switch(parseInt(value))
  {
    <%=amh_script.toString()%>
  }
}
</script>



<input name=keyword />
<input name="submit" type="submit" class="in" value="查询"/>
<input name="button" type="button" class="in" value="高级查询/简历筛选" onclick="window.open('/jsp/type/resume/JobApplySearch.jsp<%if(resumesorttype!=null)out.print("?resumesorttype="+resumesorttype);%>','_self')"/>

</td></tr></table>

</form>

