<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*" %>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.admin.*"%>
<%@ page import="tea.resource.Resource" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.member.*" %>
 

<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");


TeaSession teasession=new TeaSession(request);
String community=teasession._strCommunity;
java.util.Date date = new java.util.Date();


if(teasession._rv==null)
{
	out.println("您还没有登录，没有权限查看，请登录");
	return;
}
  String nexturl =  request.getRequestURI()+"?"+request.getQueryString();

StringBuffer sql=new StringBuffer();
StringBuffer param=new StringBuffer();
param.append("id=").append(request.getParameter("id"));
	



int question = 0;
if(teasession.getParameter("question")!=null && teasession.getParameter("question").length()>0){
	question = Integer.parseInt(teasession.getParameter("question"));
	sql.append("  and poll  = " ).append(question);
	param.append("&question=").append(question);
}
 

int pos=0,size = 20;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
param.append("&pos=").append(pos);
 
int count = PollChoice.count(sql.toString());


 



%>
<html>
<HEAD>
  <link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <link href="/tea/CssJs/Home.css" rel="stylesheet" type="text/css">
  <script src="/tea/tea.js" type="text/javascript"></script>
</HEAD>
<style>
#
</style>
<script>
function f_excel()
{
	if(confirm("您确定要导出数据吗?"))
	    {
			form1.action='/servlet/EditVolunteerExcel';
			form1.act.value='PollProblemStatistics';
			form1.submit();
		}
}
</script>
<body>
<script type="text/javascript">

</script>
<h1>投票问题统计</h1>
<form name="form1" action="?" method="POST" >
<input type="hidden" name="id" value="<%=request.getParameter("id") %>">
<input type="hidden" name="node" value="<%=teasession._nNode %>">
<input type="hidden" name="act" >

<input type="hidden" name="files" value="投票问题信息表"/> 
<input type="hidden" name="sql" value="<%=MT.enc(sql.toString())%>">
<table border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter"> 
  <tr>
  <td align="right" nowrap>  投票问题：</td>
    <td>
    	<select name="question">
    		<option value="">-投票问题-</option>
    	
    	
    	<%
    	java.util.Enumeration e =Poll.findByNode("",teasession._nNode,teasession._nLanguage,0,20);
    	for(int i=0;e.hasMoreElements();i++)
    	{
    		
    		 int poll_id = ((Integer) e.nextElement()).intValue();
    	     Poll poll_obj = Poll.find(poll_id);
    	 
    	     String q=tea.html.HtmlElement.htmlToText(poll_obj.getQuestion());
    	    out.print("<option value="+poll_id);
    	    if(question==poll_id)
    	    {
    	    	out.print(" selected ");
    	    }
    	    out.print(">"+q);
    	    out.print("</option>");
    	}
    	%>
    	</select>
    </td>


     <td colspan="10" align="center"><input type="submit" value="查询" /></td></tr>

</table>

<span id="show2"></span>
<span id ="show">
<h2>列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="2"><%=count%></font>&nbsp;条记录&nbsp;)&nbsp;&nbsp;
<input type="button" value="导出信息EXCEL" onclick="f_excel();">&nbsp;&nbsp;

</h2>



  <table border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">

 <tr id="tableonetr">
  <td nowrap>投票问题</td>
   <td nowrap>投票选项</td>
   <td nowrap>票数</td>
    <TD NOWRAP>所占比例</TD> 
</tr>

<%
Enumeration e2 = PollChoice.find(sql.toString(),pos,size);

while(e2.hasMoreElements())
{ 
	
	int pcid = ((Integer)e2.nextElement()).intValue();
	
	PollChoice pcobj = PollChoice.find(pcid);
	Poll plobj = Poll.find(pcobj.getPoll());
	int co = PollResult.count(" and poll ="+pcobj.getPoll()+" and answer = "+pcid);
	
	String su = PollChoice.getResults_ZJG(pcobj.getPoll(),pcid,1,teasession._nLanguage);
	
	 
	
%> 

 
 <tr onMouseOver=bgColor="#BCD1E9" onMouseOut=bgColor=""  >
 	<td><%=plobj.getQuestion() %></td>
 	<Td><%=pcobj.getTitle() %></Td>
<td><%=co %></td>
<td><%=su %></td>
  <%} %>
  
  <% 
  	if(count>size){
  %>
  <tr><td colspan="20"  align="center" style="padding-right:5px;"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,size)%></td></tr>

<%} %>

 

   </table>
</form>
</body>
</html>
