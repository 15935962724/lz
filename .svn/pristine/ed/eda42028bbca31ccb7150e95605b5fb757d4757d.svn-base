<%@page contentType="text/html;charset=UTF-8" %>
<%@ include file="/jsp/Header.jsp" %><%
String community=node.getCommunity();

%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></head>
<body>
<h1><%=r.getString(teasession._nLanguage, "ScoreQuery")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<span style="float:left;color:#FF0000;font-weight:bold;"><img SRC="/tea/image/score/0001.jpg">　查看会友成绩</span>
<span style="float:right;color:#FF0000;font-weight:bold;">你好：
<%

tea.entity.member.Profile profile_obj=tea.entity.member.Profile.find(teasession._rv.toString());
out.println(profile_obj.getLastName(teasession._nLanguage));
out.println(profile_obj.getFirstName(teasession._nLanguage));
%></span>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter" bgcolor="#CCCCCC">
<tr id=oneline>
  <td>&nbsp;您的会友:
  <tr>
  <%
   tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);

   java.util.Enumeration enumerType=tea.entity.node.Node.findByType(64,tea.entity.node.Node.find(  teasession._nNode).getCommunity());
  while(enumerType.hasMoreElements())
  {
    int nodecode=((Integer)    enumerType.nextElement()).intValue();
    if(tea.entity.node.AccessMember.find(nodecode,teasession._rv._strV).isExists())
    {
      String confrere_member=tea.entity.node.Node.find(nodecode).getCreator().toString();
tea.entity.member.Profile profile_obj2=      tea.entity.member.Profile.find(confrere_member);//.getFirstName(teasession._nLanguage)

%>
  <td bgcolor="#FFFFFF">
&nbsp;<img SRC="/images/0008.jpg" width="9" height="12" border="0">&nbsp;<A href="<%=request.getRequestURI()%>?member=<%=confrere_member%>&<%=request.getQueryString()%>"><%=profile_obj2.getFirstName(teasession._nLanguage)%>  <%=profile_obj2.getLastName(teasession._nLanguage)%></a>
&nbsp; </td>
  <%
}
}
String member=request.getParameter("member");
%>
</table>
&nbsp;点击上面的用户名，可以查看会员的成绩！<br>
<br><br>
<form action="" method="get">
  &nbsp;会员ID:
    <input type="text" name="member">
    <input type="submit" class=in name="Submit" value="提交">
&nbsp;输入会友ID可查看会员成绩    <%if(member!=null)
{tea.entity.member.Profile profile_member=tea.entity.member.Profile.find(member);
out.print("<span style='float:right;color:#FF0000;font-weight:bold;'>以下为:"+getNull(profile_member.getFirstName(1))+" "+getNull(profile_member.getLastName(1))+"的成绩</span>");
}%>
</form><table border="0" cellpadding="0" cellspacing="0" id="tablecenter" bgcolor="#CCCCCC">
  <tr id=oneline>
    <td align="center" scope="col">打球日期</td>
    <td scope="col">&nbsp;球场</td>
    <td align="center" scope="col">发球台</td>
    <td align="center" scope="col">成绩</td>
    <td align="center" scope="col">是否比赛</td>
    <td align="center" scope="col">详细</td>
  </tr>
  <%

  if(member!=null)
  {
    member=member.trim();
  enumerType=tea.entity.node.Node.findByType(64,tea.entity.node.Node.find(teasession._nNode).getCommunity());
  while(enumerType.hasMoreElements())
  {
    int nodecode=((Integer)    enumerType.nextElement()).intValue();
tea.entity.node.Node node=    tea.entity.node.Node.find(nodecode);
    if(member.equals(node.getCreator()._strR))
    {
if(tea.entity.node.AccessMember.find(nodecode,node.getCreator()._strV).isExists()||(node.getOptions1()&1)!=0)
{

 Iterator it = tea.entity.node.Score.find(" AND node=" +nodecode + " ORDER BY times DESC",0,1).iterator();
    
       
int score;
while(it.hasNext())
{
 Score obj = (Score) it.next();
 score = obj.score;


%>
<tr bgcolor="#FFFFFF">
  <td align="center"><%=obj.getTimes("yyyy-MM-dd")%></td>
  <td>&nbsp;
    <%
    if(obj.getNode()!=0)
    out.print(new tea.html.Anchor("/servlet/Node?node="+obj.getNode(),obj.getName()));
    else
    out.print(obj.getName());
    %></td><td align="center"><img src=/images/0<%=obj.getTee()+1%>.jpg></td>
    <td align="center"><%=obj.getSums()%></td>
    <td align="center"><%=(obj.isCompete()?"是":"否")%></td>
    	<td align="center"><a href="/jsp/type/score/ScoreBrowse.jsp?score=<%=score%>" target="_blank"><img SRC="/images/0002.jpg" alt="详细" width="17" height="14" border="0"></a>	  </td>
</tr>
<%}
}   }
  }
}%>
</table>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage, request)%></div>
</body>
</html>

