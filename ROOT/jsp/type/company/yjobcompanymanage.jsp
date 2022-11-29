<%@page contentType="text/html;charset=utf-8"  %><%@page import="java.util.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.db.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.ui.*" %><%@page import="tea.resource.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.node.*" %><%request.setCharacterEncoding("utf-8");

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

Communityjob communityjob=Communityjob.find(community);


//Purview purview=Purview.find(teasession._rv.toString(),community);


/*
if(!purview.isCompany()&&!License.getInstance().getWebMaster().equals(teasession._rv.toString())&&!teasession._rv.toString().equalsIgnoreCase(communityjob.getJobmember()))
{
    response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("你没有权�?访问本页.","UTF-8"));
    return;
}
*/





StringBuffer sb=new StringBuffer();
if(!License.getInstance().getWebMaster().equals(teasession._rv.toString())&&!teasession._rv.toString().equalsIgnoreCase(communityjob.getJobmember()))
{
  AdminUsrRole aur_obj=AdminUsrRole.find(community,teasession._rv._strV);
  java.util.StringTokenizer tokenizer=new StringTokenizer(aur_obj.getCompany(),"/");
  sb.append(" AND ((n.rcreator="+DbAdapter.cite(teasession._rv._strR) +" AND n.vcreator="+DbAdapter.cite(teasession._rv._strV)+")");
  //  if(tokenizer.hasMoreTokens())
  //  sb.append(" and (Node.node="+tokenizer.nextToken());
  while(tokenizer.hasMoreTokens())
  {
    sb.append(" OR n.node="+tokenizer.nextToken());
  }
  sb.append(")");
}
int pagesize=25;
int pos=0;
String _strPos=request.getParameter("pos");
if(_strPos!=null)
{
  pos=Integer.parseInt(_strPos);
}
int count=0;

java.util.Vector vector=new java.util.Vector();
DbAdapter dbadapter = new DbAdapter();

try
{
  count=dbadapter.getInt("SELECT COUNT( n.node ) FROM Node n INNER JOIN Company c ON n.node=c.node WHERE n.type=21 AND n.community="+dbadapter.cite(community)+sb.toString());
  dbadapter.executeQuery("SELECT  distinct n.node, c.sequence,n.sequence FROM Node n INNER JOIN Company c ON n.node=c.node WHERE n.type=21 AND n.community="+dbadapter.cite(community)+sb.toString()+" ORDER BY c.sequence,n.sequence");
  for (int l = 0; l < pos + pagesize && dbadapter.next(); l++)
  {
    if (l >= pos)
    {
      vector.addElement(Integer.valueOf(dbadapter.getInt(1)));
    }
  }
}finally
{
  dbadapter.close();
}
java.util.Enumeration enumeration=vector.elements();

tea.resource.Resource r=new tea.resource.Resource("/tea/resource/Job");

String info=request.getParameter("info");
if(info==null)
{
  info=r.getString(teasession._nLanguage,"1167441040171");
}

String nexturl=java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(), "UTF-8");
%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="/tea/tea.js" type="text/javascript"></script>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>
<h1 ><%=info+"("+count+")"%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<form action="?" method="get" name="form1" >
<input type="hidden" name="community" value="<%=community%>"/>
<input type="hidden" name="node" value=""/>
<input type="hidden" name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr ID=tableonetr>
    <td height="18" nowrap><%=r.getString(teasession._nLanguage,"1167441109218")%></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1167441134359")%></td>
    <td nowrap>E-Mail</td>
<%--<td nowrap><%=r.getString(teasession._nLanguage,"1167441166281")%></td>--%>
    <td nowrap><%=r.getString(teasession._nLanguage,"1167441181656")%></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1167441198859")%></td>
    <td nowrap>　 </td>
  </tr>
<%
int nodeCode;
while(enumeration.hasMoreElements())
{
nodeCode =((Integer)enumeration.nextElement()).intValue();
Company obj=Company.find(nodeCode);
String contact=obj.getContact(teasession._nLanguage);
String email=obj.getEmail(teasession._nLanguage);
String fax=obj.getFax(teasession._nLanguage);
String telephone=obj.getTelephone(teasession._nLanguage);
String webpage=obj.getWebPage(teasession._nLanguage);
Node node_obj=Node.find(nodeCode);

%>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
    <td nowrap><A href="/servlet/Company?node=<%=nodeCode%>&language=<%=teasession._nLanguage%>" target="_blank"><%=node_obj.getSubject(teasession._nLanguage)%></A></td>
    <td nowrap>&nbsp;<%if(contact!=null)out.print(contact);%></td>
    <td nowrap>&nbsp;<A href="mailto:<%=email%>"><%if(email!=null)out.print(email);%></a></td>
<%--    <td nowrap>&nbsp;<%if(fax!=null)out.print(fax);%></td>--%>
    <td nowrap>&nbsp;<%if(telephone!=null)out.print(telephone);%></td>
    <td nowrap>&nbsp;<A href="<%=webpage%>" target="_blank"><%if(webpage!=null)out.print(webpage);%></A></td>
    <td nowrap>
    <!--/jsp/type/job/yjobjobmanage.jsp?orgid=<%=nodeCode%>&community=<%=community%>-->
      <INPUT TYPE=BUTTON  VALUE="<%=r.getString(teasession._nLanguage,"1167441243500")%>" onClick="window.open('/jsp/type/job/JobManage.jsp?company=<%=nodeCode%>&community=<%=community%>','_self')"/>
        <input type="submit" onClick="form1.action='/jsp/type/company/yjobEditCompany.jsp';form1.node.value=<%=nodeCode%>;" value="<%=r.getString(teasession._nLanguage,"CBEdit")%>">
        <input type="submit"  onClick="if(confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>')){form1.action='/servlet/DeleteNode';form1.node.value=<%=nodeCode%>;}else return false;" value="<%=r.getString(teasession._nLanguage,"CBDelete")%>">
    </td>
    </tr>
<%}%>
</table>

<%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+"?community="+community+"&pos=",pos,count) %>

<INPUT TYPE="BUTTON" VALUE="<%=r.getString(teasession._nLanguage,"CBNewCompany")%>" onClick="window.open('/jsp/type/company/yjobEditCompany.jsp?NewNode=ON&Type=21&TypeAlias=0&node=<%=communityjob.getCompany()%>&nexturl=<%=nexturl%>', '_self');"/>
</form>

<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

