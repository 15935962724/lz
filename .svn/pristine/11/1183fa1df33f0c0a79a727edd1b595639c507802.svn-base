<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.entity.node.*"%>
<%
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
String community="cnoocjob";//Node.find(teasession._nNode).getCommunity();
%>
<SELECT NAME="orgid"  onchange="fadd(foEdit.orgid.options[foEdit.orgid.selectedIndex].value)">
<OPTION VALUE="0">--请选择招聘机构--</OPTION>
<%java.util.Enumeration enumeration=tea.entity.node.Node.findByType(21,community);int nodeCode;
tea.db.DbAdapter dbadapter=new tea.db.DbAdapter();
int len;
   StringBuffer sb=new StringBuffer();
   sb.append("<script>function fadd(value){ var ccc=foEdit.applyAmount.length; for(var len=0;len<ccc;len++)foEdit.applyAmount.remove(len);");
while(enumeration.hasMoreElements())
{
   nodeCode =((Integer)enumeration.nextElement()).intValue();
   dbadapter.executeQuery("SELECT Job.node FROM Node,Job WHERE Node.node=Job.node AND orgid ="+nodeCode);
      sb.append("if(value=="+nodeCode+"){\r\n");
while(dbadapter.next())
{
    len=dbadapter.getInt(1);
    Job job=Job.find(len,1);
sb.append("foEdit.applyAmount.options.add(new Option('"+job.getName()+"','"+len+"'));\r\n");
}
sb.append("} else ");
%>
<OPTION VALUE="<%=nodeCode%>"><%=tea.entity.node.Node.find(nodeCode).getSubject(teasession._nLanguage)%></OPTION>
<%}
sb=sb.delete(sb.length()-5,sb.length());
sb.append("}</script>");
%>
</SELECT>
<select name="applyAmount" STYLE="WIDTH: 200px">
</select><%=sb.toString()%>

<% dbadapter.close();%>

