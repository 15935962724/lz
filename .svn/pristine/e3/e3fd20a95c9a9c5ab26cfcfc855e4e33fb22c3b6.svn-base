<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@ page  import="tea.entity.admin.im.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource();

StringBuffer param=new StringBuffer();
param.append("?community=").append(teasession._strCommunity);

StringBuffer sql=new StringBuffer();

String q=request.getParameter("q");
if(q!=null&&(q=q.trim()).length()>0)
{
  sql.append(" AND content LIKE "+DbAdapter.cite("%"+q+"%"));
  param.append("&q=").append(java.net.URLEncoder.encode(q,"UTF-8"));
}

int pos=0;
String tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}
param.append("&pos=");

String _strId=request.getParameter("id");

int count=ImHistory.count(sql.toString());

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/criterion/js.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>

<h1>历史记录</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<h2>查询</h2>
<FORM name=form1 action="?">
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<input type=hidden name="id" value="<%=_strId%>"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td>内容<input name="q" value="<%if(q!=null)out.print(q);%>"></td>
       <td><input type="submit" value="查询"/></td>
     </tr>
</table>


<h2>列表(<%=count%>)</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td nowrap width="1">&nbsp;</td>
    <TD>从</TD>
    <TD>到</TD>
    <TD>内容</TD>
    <TD>时间</TD>
  </tr>
<%
java.util.Enumeration e=ImHistory.find(sql.toString(),pos,25);
for(int index=1;e.hasMoreElements();index++)
{
  int ih=((Integer)e.nextElement()).intValue();
  ImHistory obj=ImHistory.find(ih);
  String c=obj.getContent();
  c=c.replaceAll(q,"<font color=red>"+q+"</font>");
  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td width="1"><%=index%></td>
    <td nowrap><%=obj.getFMember()%></td>
    <td nowrap><%=obj.getTMember()%></td>
    <td nowrap><%=c.replaceAll("\\r\\n","<br>")%></td>
    <td nowrap><%=obj.getTimeToString()%></td>
  </tr>
<%
}
%>
<tr><td colspan="6" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage, param.toString(), pos, count)%></td></tr>
</table>

</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
