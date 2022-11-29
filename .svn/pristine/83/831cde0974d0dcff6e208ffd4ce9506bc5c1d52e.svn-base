<%@page contentType="text/html;charset=utf-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
String from=request.getParameter("from");
String to=request.getParameter("to");
String creator=request.getParameter("creator");
String keywords=request.getParameter("keywords");

StringBuffer sql=new StringBuffer();
if(from!=null&&from.length()>0)
{
  sql.append(" AND time>="+DbAdapter.cite(from));
}
if(to!=null&&to.length()>0)
{
  sql.append(" AND time<"+DbAdapter.cite(to));
}
if(creator!=null&&creator.length()>0)
{
  sql.append(" AND rcreator like "+DbAdapter.cite("%"+creator+"%"));
}
if(keywords!=null&&keywords.length()>0)
{
  sql.append(" AND id IN ( SELECT bbsreply FROM BBSReplyLayer WHERE content LIKE "+DbAdapter.cite("%"+keywords+"%")+")");
}
//查阅状态
int search = -1;
if(teasession.getParameter("search")!=null && teasession.getParameter("search").length()>0)
{
	search = Integer.parseInt(teasession.getParameter("search"));
}
if(search>=0)
{
	 sql.append(" and search ="+search);
//	 param.append("&search=").append(search);
}

BBS bbs=BBS.find(teasession._nNode,teasession._nLanguage);
int best=bbs.getBest();

%><html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "跟贴管理")+" ( "+node.getSubject(teasession._nLanguage)+" )"%></h1>
<div id="head6"><img height="6" alt=""></div>
<br>
<h2><%=r.getString(teasession._nLanguage, "查询")%></h2>
<form name="form1" action="?" >
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="node" value="<%=teasession._nNode%>"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td>时间:<input type="text" name="from" value="<%if(from!=null)out.print(from);%>" readonly size="9"><input onclick="showCalendar('form1.from')" type="button" value="...">
   <input readonly name="to"  value="<%if(to!=null)out.print(to);%>" type="text" size="9"><input  onclick="showCalendar('form1.to')" type="button" value="...">
   </td>
  <td>发表人:<input name="creator"  value="<%if(creator!=null)out.print(creator);%>" type="text" size="10"></td>
  
</tr>
<tr>
<td>查阅状态：
<select name="search">
<option value="-1">-查阅状态-</option>
<option value="0" <%if(search==0)out.print(" selected "); %>>-未查阅-</option>
<option value="1" <%if(search==1)out.print(" selected "); %>>-已查阅-</option>
 
</select></td>
  <td>关键字:<input name="keywords"  value="<%if(keywords!=null)out.print(keywords);%>" type="text">
  <td><input type="submit" value="GO">
</tr>
</table>
</form>
<br>
<form name="form2" action="/servlet/EditBBSReply" method="post">
<h2><%=r.getString(teasession._nLanguage, "列表")%>

<input type="submit" name="search" value="<%=r.getString(teasession._nLanguage, "查阅")%>" />
<input type="submit" name="best" value="<%=r.getString(teasession._nLanguage, "最佳答案")%>" />
<input type="submit" name="del" value="<%=r.getString(teasession._nLanguage, "CBDelete")%>" onClick="return (confirm('<%=r.getString(teasession._nLanguage, "ConfirmDeleteSelected")%>'))"/>
<input type="submit" name="grant" value="<%=r.getString(teasession._nLanguage, "CBGrant")%>" />
<input type="submit" name="hide" value="<%=r.getString(teasession._nLanguage, "Hide")%>" />
</h2>

<input type="hidden" name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>">
<input type="hidden" name="node" value="<%=teasession._nNode%>">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td width=1><input type="CHECKBOX" onclick="selectAll(form2.replay,this.checked);"/></td>
    <td>主题</td>
    <td>发贴人</td>
    <td>查阅状态</td>
     <td>查阅用户</td>
    <td>创建日期</td>  
     <td>操作</td>
  </tr>
<%
DbAdapter db=new DbAdapter();
try
{
  db.executeQuery("SELECT id FROM BBSReply WHERE node="+teasession._nNode+sql.toString());
  while(db.next())
  {
    int brid=db.getInt(1);
    BBSReply obj=BBSReply.find(brid);
    String value=obj.getContent(teasession._nLanguage);
    if(value.length()>20)
    {
      value=value.substring(0,20)+"...";
    }
%>
<tr onmouseover="javascript:this.bgColor='#BCD1E9'" onmouseout="javascript:this.bgColor=''" >
  <td><input type="CHECKBOX"  name="replay" value="<%=brid%>"/></td>
    <%
    out.print("<td><A target=_blank href=/servlet/BBS?node="+teasession._nNode+"#"+brid+">");
    if(obj.isHidden())
    {
      out.print("<STRIKE>"+value+"</STRIKE>");
    }else
    {
      out.print(value);
    }
    if(best==brid)
    {
      out.print("[最佳答案]");
    }
    out.print("</A></td>");
    out.print("<td>"+obj.getMember());
    out.print("<td>");
    if(obj.getSearch()==0){out.print("<font color=red>未查阅</font>");}else{out.print("已查阅");}
    out.print("</td>");
    out.print("<td>");
    if(obj.getSearch()==1&& obj.getSearchmember()!=null)out.print(obj.getSearchmember());
    out.print("</td>");
    out.print("<td>"+obj.getTimeToString()+"</td>");
    out.print("<td><a href=/jsp/type/bbs/EditBBSReply.jsp?node="+obj.getNode()+"&bbsreply="+brid+"&nexturl=/jsp/type/bbs/BBSReplyManage.jsp?community="+teasession._strCommunity+"&node="+obj.getNode()+">查阅</a></td>");
    out.print("</tr>");
  }
}finally
{
  db.close();
}
%>
</table>
<!--最佳答案-->

</form>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>
