<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.cfw.*"%><%@page import="tea.entity.subscribe.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.html.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.site.*"%><%@page import="tea.resource.*"%><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%@page import="java.net.URLEncoder"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);

if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
Resource r=new Resource();
r.add("/tea/ui/node/general/EditNode");


String nexturl = request.getRequestURL() + request.getContextPath();




StringBuffer sql = new StringBuffer();
StringBuffer param = new StringBuffer();
param.append("?id=").append(request.getParameter("id"));
param.append("&community=").append(teasession._strCommunity);



int pos = 0, pageSize = 10, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
count = MemberRegister.count(teasession._strCommunity,sql.toString());

sql.append(" order by times desc ");

%>
<html>
<head>
<title>书画艺术沙龙会员登记列表</title>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

</head>
<body >
<script>

function f_edit(igd)
{
	form1.mrid.value=igd;
	form1.action ="/jsp/type/cfw/MemberRegister.jsp";
	form1.submit();
}

function f_del(igd)
{
	form1.mrid.value=igd;
    form1.act.value="del";
	form1.action ="/jsp/type/cfw/MemberRegisterServlet.jsp";
	form1.submit();
}
</script>

<h1>书画艺术沙龙会员登记列表</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form action="?" name="form1" method="POST" >

<input type="hidden" name="community" value="<%=teasession._strCommunity %>"/>
<input type="hidden" name="nexturl" value="<%=nexturl %>"/>
<input type="hidden" name="act">
<input type="hidden" name="mrid"/>





<h2>书画艺术沙龙会员登记列表</h2>



  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id=tableonetr>

	      <td nowrap>姓名</td>
	      <td nowrap>性别</td>
	       <td nowrap>职业</td>
	       <td nowrap>所属机构</td>
	       <td nowrap>移动电话</td>
	       <td nowrap>登记时间</td>
	       <td nowrap>操作</td>
    </tr>
    <%

  // out.println(sql.toString());
	Enumeration e = MemberRegister.find(teasession._strCommunity,sql.toString(),pos,pageSize);
    if(!e.hasMoreElements())
    {
        out.print("<tr><td colspan=10 align=center>书画艺术沙龙会员登记</td></tr>");
    }
      for(int i = 1;e.hasMoreElements();i++)
      {

			int mrid = ((Integer)e.nextElement()).intValue();
			MemberRegister mrobj = MemberRegister.find(mrid);



    %>
    <tr onmouseover=bgColor='#BCD1E9'; onmouseout=bgColor=''; >

    <td><%=mrobj.getNames()%></td>

        <td><%if(mrobj.getGender()==1)
			{
				out.print("男");
			}else{
				out.print("女");
			}%></td>
         <td><%=mrobj.getOccupation()%></td>
        <td><%=mrobj.getConporation() %></td>

        <td><%=mrobj.getMobile() %></td>
        <td><%=mrobj.getTimesToString() %></td>
        <td><input type="button" value="修改" onclick="f_edit('<%=mrid %>');">&nbsp;
            <input type="button" value="删除" onclick="f_del('<%=mrid %>');">&nbsp;
        <input type="button" value="导出word" onclick="window.open('/jsp/type/cfw/MemberRegisterDoc.jsp?mrid=<%=mrid %>','_self')"></td>
    </tr>
    <%} %>
     <%if (count > pageSize) {  %>
      <tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,nexturl+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
      <%}  %>
  </table>
</form>
</body>
</html>
