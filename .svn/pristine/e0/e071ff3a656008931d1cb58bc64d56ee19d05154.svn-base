<%@page import="tea.entity.Entity"%>
<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.io.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.node.MeetingNotice"%>
<% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource("/tea/resource/unitlist");



int node=Integer.parseInt(teasession.getParameter("node"));

String nexturl=request.getRequestURI()+"?node="+node;

int pos=0;
String tmp=request.getParameter("pos");
if(tmp!=null)pos=Integer.parseInt(tmp);

StringBuffer par=new StringBuffer();
StringBuffer sql = new StringBuffer();
par.append("?node=").append(node);
sql.append(" AND node="+node);
String title = request.getParameter("title");
if(title!=null&&title.length()>0){
  par.append("&title=").append(title);
  sql.append(" AND title like '%"+title+"%'");
}
par.append("&pos=");

int sum=MeetingNotice.count(sql.toString());
%><html>
<head>
<title>会议通知</title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<script src="/tea/mt.js" type="text/javascript"></script>
<script>var pmt=parent.mt;</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
function f_edit(id)
{
  form2.action="/jsp/type/meeting/WestracEditMeetingNotice.jsp";
  form2.method="get";
  form2.target="";
  form2.id.value=id;
  //form2.nexturl.value=location;
  form2.submit();
}
function f_delete(id)
{
  if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>'))
  {
    form2.id.value=id;
    form2.act.value='del';
    //form2.nexturl.value=location;
    form2.submit();
  }
}

mt.refresh=function(url){
	window.location.href=url;
};
</SCRIPT>
</head>
<BODY id="bodynone">
<div id="wai">
<!-- <h1>会议通知</h1> -->
<div id="head6"><img height="6" alt=""></div>

<form name="form1" action="?" method="POST">
<input type=hidden name="node" value="<%=node%>">
<h2>查询</h2>
<table cellSpacing="0" cellPadding="0" width="100%" border="0" id="tablecenter">
<tr>
  <td colspan="2" align="left">标题<input id="title" name="title" value="<%if(title!=null)out.print(title);%>"/>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>


<form name="form2" method="post" action="/servlet/EditMeetingNotices" target="_ajax" enctype=multipart/form-data>
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<input type=hidden name="node" value="<%=node%>">
<input type=hidden name="id">
<input type=hidden name="act"/>
<input type=hidden name="nexturl" value="<%=nexturl%>"/>
<h2>列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="2"><%=sum%></font>&nbsp;条通知&nbsp;)&nbsp;&nbsp;
<input type="button" value="添加通知" onclick="f_edit(0)">
</h2>
<table cellSpacing="0" cellPadding="0" width="100%" border="0" id="tablecenter">
  <tr id="tableonetr">
    <td><%=r.getString(teasession._nLanguage, "标题")%></td>
    <td><%=r.getString(teasession._nLanguage, "Time")%></td>
    <td><%=r.getString(teasession._nLanguage, "operation")%></td>
  </tr>
<%
if(sum>0)
{
  int last=0;
  ArrayList mnList = MeetingNotice.find(sql.toString()+" ORDER BY time desc",pos,15);
  for(int i=0;i<mnList.size();i++)
  {
	  MeetingNotice obj=(MeetingNotice)mnList.get(i);
    int id=obj.getId();
    out.write("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
    out.write("<td>"+obj.getTitle()+"</td>");
    out.write("<td>"+(obj.getTime()!=null?Entity.sdf2.format(obj.getTime()):"")+"</td>");
    out.write("<td nowrap>");
    	out.write(" <a href='###' onClick='f_edit("+id+")' >编辑&nbsp;</a>");
    	out.write(" <a href='###' onClick='f_delete("+id+")' >删除</a>");
    	out.write("</td>");
  }
  /* out.print("<tr><td></td>");
  out.print("<td><input type='checkbox' name='checkall2' id='checkall2' onclick='CheckAll2()' title='全选' style='cursor:pointer'>&nbsp;全选/反选&nbsp;&nbsp;");
  out.print("<input type='button' value='邀请选中会员' onClick='f_inviteall();'>&nbsp;");
  out.print("<input type='button' value='邀请所有会员' onClick='f_inviteall2();'>&nbsp;");
  out.print("</td>");
  out.print("<td colspan='3' align='right'>"+new tea.htmlx.FPNL(teasession._nLanguage,par.toString(),pos,sum,15)+"</td>");
  out.print("</tr>"); */
    
  
  if(sum>15)out.print("<tr><td colspan='5' align='right'>"+new tea.htmlx.FPNL(teasession._nLanguage,par.toString(),pos,sum,15)+"</td></tr>");
}else
{
  out.print("<tr><td colspan='5' align='center'>暂无会议通知");
}

%>
</table>
</br>
<center>
  <input type="button" name="reset" value="关闭"  onclick="parent.mt.close();">

</center>
</form>
<br>
<div id="head6"><img height="6" alt=""></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</div>
</body>
</html>
