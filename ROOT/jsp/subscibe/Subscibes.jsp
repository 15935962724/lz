<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="tea.entity.site.*" %><%@page import="tea.db.*"%><%@ page import="tea.entity.member.*" %><%@ page import="tea.resource.*" %><%@ page import="tea.ui.*" %><%@ page import="tea.entity.node.*" %><%request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


CommunityOption co=CommunityOption.find(teasession._strCommunity);
int subday=co.getInt("subday");
String subnode=co.get("subnode");

StringBuffer sql = new StringBuffer();
StringBuffer param = new StringBuffer("?community=" + teasession._strCommunity);

param.append("&id=").append(request.getParameter("id"));

param.append("&node=").append(teasession._nNode);

String email_name = teasession.getParameter("email_name");
if(email_name!=null && email_name.length()>0)
{
	sql.append(" and email like ").append(DbAdapter.cite("%"+email_name+"%"));
	param.append("&email_name=").append(email_name);
}

String subscribe = teasession.getParameter("subscribe");
if(subscribe!=null && (!"0".equals(subscribe)))
{
  sql.append(" and node like ").append(DbAdapter.cite("%/"+subscribe+"/%"));
  param.append("&subscribe=").append(subscribe);
}else{
	subscribe="0";
}


int pos=0,pageSize=10,count=0;
String tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}

 count = Subscibe.countByCommunity(teasession._strCommunity,sql.toString());

Resource r=new Resource();

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="">
function f_add()
{
  form1.method="get";
  form1.action="/jsp/subscibe/EditSubscibe.jsp";
  form1.submit();
}
</script>
</head>
<body>

<h1>订阅管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<h2>订阅查询</h2>
<form action="?" method="post" name="form2">
<script type="">document.write("<input type='hidden' name='nexturl' value='"+document.location.href+"' />");</script>
<input type="hidden" name="node" value="<%=teasession._nNode%>"/>
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>
	<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
		<tr>
			<td>E-mail:</td>
			<td><input type="text" name="email_name" value="<%if(email_name!=null)out.print(email_name); %>"/></td>
			<td>订阅项:</td>
      <td>
      <select  name="subscribe" >
      <option value="0">请选择</option>
      <%
    	DbAdapter db=new DbAdapter();
      try{
      db.executeQuery("SELECT DISTINCT n.node FROM Node n , Category c WHERE n.node=c.node AND n.community="+db.cite(teasession._strCommunity)+" AND n.type=1 AND c.category=39");
      int sid=Integer.parseInt(subscribe);
      while(db.next()){
    	  int nodeId=db.getInt(1);
    	  if(subnode.indexOf("/"+nodeId+"/")>=0){
    		  if(sid!=nodeId){
    		  	out.print("<option value='"+nodeId+"'>"+Node.find(nodeId).getSubject(teasession._nLanguage)+"</option>");
    		  }else{
    			  out.print("<option value='"+nodeId+"' selected >"+Node.find(nodeId).getSubject(teasession._nLanguage)+"</option>");  
    		  }
    	  }
      }
      }finally{
    	  db.close();
      }
      %>
      
      </select></td>
     </tr>
     <tr>
        <td colspan="4" align="center"><input type="submit" value="查询"/></td>
    </tr>
	</table>
</form>


<h2>订阅列表</h2>
<form  name="form1" method="post" action="/servlet/Subscibes" >
<script type="">document.write("<input type='hidden' name='nexturl' value='"+document.location.href+"' />");</script>
<input type="hidden" name="node" value="<%=teasession._nNode%>"/>
<input type="hidden" name="act" value="email"/>
<input type="hidden" name="email" value=""/>



<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
	<td colspan="3">
	<input type="button" value="添加订阅" onClick="f_add();" />
	<input type="submit" value="删除订阅" onClick="return(confirm('确认删除'));"/></td>
</tr>
<tr id="tableonetr">
<td><input type="checkbox" onClick="selectAll(form1.email,checked);"></td>
<td>E-Mail</td>
<td>订阅项</td>
<td>时间</td>
</tr>
<%
Enumeration enumer=Subscibe.findByCommunity(teasession._strCommunity,sql.toString(),pos,pageSize);
if(!enumer.hasMoreElements())
{
    out.print("<tr><td colspan=10 align=center>暂无订阅用户</td></tr>");
}

while(enumer.hasMoreElements())
{
  String email=(String)enumer.nextElement();
  Subscibe obj=Subscibe.find(teasession._strCommunity,email);
  String strnode=obj.getNode();
%>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
  <td width="1"><input id="CHECKBOX" type="CHECKBOX" name="email" value="<%=email%>"/></td>
  <td><a href="mailto:<%=email%>" ><%=email%></a></td>
  <td><%
  if(strnode!=null)
  {
    String strnodes[]=strnode.split("/");
    for(int index=1;index<strnodes.length;index++)
    {
      out.println("<a target=_blank HREF=/servlet/Node?node="+strnodes[index]+" >"+Node.find(Integer.parseInt(strnodes[index])).getSubject(teasession._nLanguage)+"</a>");
    }
  }
  %></td>
<td><%=obj.getTimesToString()%></td>
</tr>
<%
}
%>
  <%if (count > pageSize) {  %>
  <tr></tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td></tr>
  <%}  %></table></form>

<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
