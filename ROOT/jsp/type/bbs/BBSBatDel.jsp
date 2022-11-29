<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.*" %>
<%@include file="/jsp/Header.jsp"%>

<%
r.add("/tea/resource/BBS");

Http h=new Http(request);

if("POST".equals(request.getMethod()))
{
  tea.db.DbAdapter db=new tea.db.DbAdapter();
  int delnode=0,j=0;
  try
  {
    delnode=Integer.parseInt(request.getParameter("delnode"));
    String sql;
    if(delnode!=0)
    {
      sql=" AND father="+delnode;
    }else
    sql="";

    int tl=h.getInt("TimeLimited");
    Calendar c=Calendar.getInstance();
    c.add(c.DAY_OF_YEAR,-tl);
    Date time=c.getTime();
    if(request.getParameter("alldel")!=null)
    {
      j=db.executeUpdate("DELETE FROM Node WHERE type=57 AND community="+db.cite(node.getCommunity())+" AND time<"+db.cite(time)+sql);
    }else
    if(request.getParameter("alldelTopic")!=null)
    {
      j=db.executeUpdate("DELETE FROM Node WHERE type=57 AND time<"+db.cite(time)+" AND node NOT IN (SELECT node FROM BBSReply) AND community="+db.cite(node.getCommunity())+sql);
    }else
    if(request.getParameter("userdel")!=null)
    {
      j=db.executeUpdate("DELETE FROM Node WHERE rcreator="+db.cite(request.getParameter("username"))+" AND type=57 AND community="+db.cite(node.getCommunity())+sql);
    }
  }finally
  {
    db.close();
  }
  out.println(new tea.html.Script("alert('"+r.getString(teasession._nLanguage,"DeleteSucceed")+"\\n\\n共删除了 "+j+" 条贴子!');history.back();"));
  return ;
}

tea.html.DropDown select=new tea.html.DropDown("delnode");
select.addOption(0,"所有版面");
java.util.Enumeration enumer=tea.entity.node.Node.findByType(1,teasession._strCommunity);
tea.entity.admin.AdminUsrRole aur_obj=tea.entity.admin.AdminUsrRole.find(teasession._rv._strR,teasession._strCommunity);
Communitybbs com_obj=Communitybbs.find(teasession._strCommunity);
boolean _bCommunityMember=  teasession._rv._strR.equals(com_obj.getSuperhost());
while(enumer.hasMoreElements())
{
  int id=((Integer)enumer.nextElement()).intValue();
  tea.entity.node.Category cat=  tea.entity.node.Category.find(id);
  if(cat.getCategory()==57&&(aur_obj.getBbsHost().indexOf("/"+id+"/")!=-1||_bCommunityMember))
  select.addOption(id,tea.entity.node.Node.find(id).getSubject(teasession._nLanguage));
}

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<script>
function f_c()
{
  return confirm("确定要删除吗？");
}
</script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Delete")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<table cellspacing="0" cellpadding="0" bordr="0" id="tablecenter">
<form action="<%=request.getRequestURI()%>" method="post" onsubmit="return f_c();">
  <input type="hidden" name="node" value="<%=teasession._nNode%>"/>
  <tr>
    <td valign=middle colspan=2  align=left><h2><%=r.getString(teasession._nLanguage,"DeleteDateBBS")%></h2></td>
  </tr>
  <tr>
    <td valign=middle><%=r.getString(teasession._nLanguage,"DeleteDayBBS(Number)")%></td>
    <td ><input name="TimeLimited" value=100 size=30 mask="int">
      &nbsp;
      <input type=submit name="alldel" value="<%=r.getString(teasession._nLanguage,"Submit")%>"></td>
  </tr>
  <tr>
    <td valign=middle ><%=r.getString(teasession._nLanguage,"BBSSpace")%></td>
    <td ><%=select%> </td>
  </tr>
</form>
<form action="<%=request.getRequestURI()%>" method="post" onsubmit="return f_c();">
  <input type="hidden" name="node" value="<%=teasession._nNode%>"/>
  <tr >
    <td valign=middle colspan=2  align=left><h2><%=r.getString(teasession._nLanguage,"DeleteDateNoneReply")%></h2></td>
  </tr>
  <tr>
    <td valign=middle   ><%=r.getString(teasession._nLanguage,"DeleteDayBBS(Number)")%></td>
    <td ><input name="TimeLimited" value=100 size=30 mask="int">
      &nbsp;
      <input type=submit name="alldelTopic" value="<%=r.getString(teasession._nLanguage,"Submit")%>"></td>
  </tr>
  <tr>
    <td valign=middle   ><%=r.getString(teasession._nLanguage,"BBSSpace")%></td>
    <td ><%=select%> </td>
  </tr>
</form>
<form action="<%=request.getRequestURI()%>" method="post" onsubmit="return submitText(this.username,'“会员ID”不能为空!')&&f_c();">
  <input type="hidden" name="node" value="<%=teasession._nNode%>"/>
  <tr >
    <td valign=middle colspan=2  align=left><h2><%=r.getString(teasession._nLanguage,"DeleteUserAllBBS")%></h2></td>
  </tr>
  <tr>
    <td valign=middle   ><%=r.getString(teasession._nLanguage,"MemberId")%></td>
    <td ><input type=text name="username" size=30>
      &nbsp;
      <input type=submit name="userdel" value="<%=r.getString(teasession._nLanguage,"Submit")%>"></td>
  </tr>
  <tr>
    <td valign=middle   ><%=r.getString(teasession._nLanguage,"BBSSpace")%></td>
    <td ><%=select%> </td>
  </tr>
</form>


<!--form action="<%=request.getRequestURI()%>" method="post">
  <input type="hidden" name="node" value="<%=teasession._nNode%>"/>
            <tr>
            <td  valign=middle>删除指定日期内没有登录的用户</td>
            <td  valign=middle>
<select name=TimeLimited size=1>
<option value=1>删除一天前的
<option value=2>删除两天前的
<option value=7>删除一星期前的
<option value=15>删除半个月前的
<option value=30>删除一个月前的
<option value=60>删除两个月前的
<option value=180>删除半年前的
</select>
</select><input type=submit name="delUser" value="提 交"></td></tr></form-->

</table>
<div id="head6"><img height="6" src="about:blank"></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</body>
</html>

