<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*" %><%@page import="tea.entity.member.*" %>
<%@ page import="tea.db.DbAdapter"%><%@page import="tea.resource.Resource" %>
<%@ page import="tea.entity.cio.*" %><%@ page import="tea.ui.TeaSession" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String menuid=request.getParameter("id");

String q=request.getParameter("q");

StringBuilder sql=new StringBuilder();
sql.append(" AND time IS NOT NULL");
if(q!=null)
{
  sql.append(" AND name LIKE ").append(DbAdapter.cite("%"+q+"%"));
}


String tmp = request.getParameter("central");
if(tmp!=null&&tmp.length()>0&&!tmp.equals("2"))
{
  sql.append(" AND central="+tmp);
}

Resource r=new Resource();

int j=CioCompany.count(teasession._strCommunity,sql.toString());

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>

<h1>已报名的企业<%=j%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>

<form name="form1" action="?" >
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>

<div id="mihu">企业集团名称　<input type="text" name="q" value="<%if(q!=null)out.print(q);%>">

  　　企业类型　<select name="central">
  <option value="2" selected="selected">-----</option>
  <option value="1" <%if("1".equals(tmp))out.print(" selected ");%>>央企</option>
  <option value="0" <%if("0".equals(tmp))out.print(" selected ");%>>地方</option>

  </select>
  　<a href="###" onclick="form1.submit()">模糊查找</a></div>
</form>

<form name="form2" action="/servlet/EditCioCompany" >
<script type="">document.write("<input type='hidden' name='nexturl' value='"+location+"' />");</script>
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="act" value="receipt"/>

<table border='0' cellpadding='0' cellspacing='0' id='tablecenterleft'>
<tr id='tableonetr'>
  <td id='xuhao'>&nbsp;</td>
  <td id='xuhao'>序号</td>
  <td id='gongsi'>企业（集团）名称</td>
  <td id='qiyeleixing'>企业类型</td>
  <td id='qiyexuhao'>报名表提交时间</td>
  <td>状态</td>
  <td id='denglumm'>操作</td>
</tr>
<%
Enumeration e=CioCompany.find(teasession._strCommunity,sql.toString(),0,Integer.MAX_VALUE);
for(int i=1;e.hasMoreElements();i++)
{
  CioCompany cc=(CioCompany)e.nextElement();
  int ccid=cc.getCioCompany();
  String name=cc.getName();
  boolean receipt=cc.isReceipt();
  String ctype=cc.isCentral()?"央企":"地方";
  if(q!=null&&q.length()>0)
  {
    name=name.replaceAll(q,"<font color='red'>"+q+"</font>");
  }
  out.print("<tr onmouseover=bgColor='#BCD1E9' onmouseout=bgColor=''>");
  out.print("<td id='xuhao'>");
  if(!receipt)
  {
    out.print("<input type='checkbox' name='ciocompanys' value='"+ccid+"' />");
  }
  out.print("<td id='xuhao'>"+i);
  out.print("<td id='gongsi'>"+name);
  out.print("<td id='qiyeleixing'>"+ctype);
  out.print("<td id='qiyexuhao'>"+cc.getTimeToString());
  out.print("<td>"+(receipt?"已回执":"未回执"));
  out.print("<td id='denglumm'><a href='/jsp/cio/ViewCioCompany.jsp?ciocompany="+ccid+"' target='_blank'>查看报名表</a> ");
  out.print("<a href='/jsp/cio/EditCioCompany.jsp?ciocompany="+ccid+"' target='_blank'>修改报名表</a>");
}
%>
</table>
<div id="tablebottom_button02">
<input type="button"  value="全选列表中企业" onClick="selectAll(form2.ciocompanys,true);"/>
<input type="submit"  value="给选中的企业发参会回执" />
</div>
</form>
<div  id="tablebottom_02">
说明：<br/>
点击公司名称可查看该企业报名表。<br/>
确认信息填写规范后给企业发确认回执.
</div>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
