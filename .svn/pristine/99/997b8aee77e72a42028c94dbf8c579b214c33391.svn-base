<%@page contentType="text/html;charset=UTF-8"
%><%@page import="tea.db.DbAdapter" %><%@page import="tea.entity.member.*"
%><%@page import="tea.entity.site.*" %><%@page import="tea.entity.*"
%><%@page import="tea.htmlx.*" %><%@page import="tea.resource.*"
%><%@page import="tea.entity.node.*" %><%@page import="tea.entity.admin.*"
%><%@page import="tea.ui.TeaSession" %><%@page import="java.util.*"%><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Http h=new Http(request,response);


tea.entity.node.AccessMember am = null;
if (teasession._rv != null)
{

  am = tea.entity.node.AccessMember.find(teasession._nNode, teasession._rv._strV);

}


tea.entity.node.Node node = tea.entity.node.Node.find(teasession._nNode);
String nr = tea.ui.node.general.NodeServlet.getButton(node,h, am,request);

String community = teasession._strCommunity;

Resource r=new Resource("/tea/htmlx/HtmlX");
r.add("/tea/ui/member/community/Subscribers");
r.add("/tea/ui/member/community/Communities");

String s1 = request.getParameter("pos");
int pos = s1 == null ? 0 : Integer.parseInt(s1);

StringBuffer sql=new StringBuffer(" AND (select profile from profile where member = s.vmember) NOT IN(SELECT member FROM AdminUsrRole WHERE role!='/' AND community="+DbAdapter.cite(community)+")");
StringBuffer param=new StringBuffer();

String member=request.getParameter("member");
if(member!=null&&(member=member.trim()).length()>0)
{
  sql.append(" AND s.vmember LIKE "+DbAdapter.cite("%"+member.replaceAll(" ","%")+"%"));
  param.append("&member="+java.net.URLEncoder.encode(member, "UTF-8"));
}

String states=request.getParameter("states");

DbAdapter db=new DbAdapter();
try
{
  if(states!=null&&states.length()>0)
  {
    if("1".equals(states))
    {
      sql.append(" AND s.term>="+db.cite(new java.util.Date()));
    }else
    {
      sql.append(" AND ( s.term IS NULL OR s.term<"+db.cite(new java.util.Date())+")");
    }
    param.append("&states="+states);
  }
}finally
{
  db.close();
}


int count=Subscriber.count(community,sql.toString());

sql.append(" ORDER BY time DESC");
%>
<html>
<head>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
function fcheck()
{
  if(form2.members)
  {
    if(form2.members.checked)
    return true;
    for (var index=0;index<form2.members.length;index++)
    {
      if(form2.members[index].checked)
      return true;
    }
  }
  alert('无效选择');
  return false;
}

function fal(val)
{
  form2.members.checked=(form2.members.value==val);
  for (var index=0;index<form2.members.length;index++)
  {
    form2.members[index].checked=(form2.members[index].value==val);
  }
}
</script>
</head>
<body>
<%=nr%>
<h1><%=r.getString(teasession._nLanguage, "CBSubscribers")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<%-- <div id="PathDiv"><%=String.valueOf(ts.hrefGlance(teasession._rv))%> ><A href="/servlet/Communities"><%=r.getString(teasession._nLanguage, "Communities")%></A> ><A href="/servlet/OrganizingCommunities"><%=r.getString(teasession._nLanguage, "OrganizingCommunities")%></A> ><%=s%>:<%=r.getString(teasession._nLanguage, "Subscribers")%> </div>
--%>

  <h2><%=r.getString(teasession._nLanguage, "查询")%></h2>
  <FORM name=form1 METHOD=get action="<%=request.getRequestURI()%>">
  <input type="hidden" name="community" value="<%=community%>">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
  <td><%=r.getString(teasession._nLanguage, "MemberId")%>:<input type=text name="member" value="<%if(member!=null)out.print(member);%>" ></td>
  <td><%=r.getString(teasession._nLanguage, "States")%>:<select name="states" >
    <option value="">--------------</option>
    <option value="0" <%if("0".equals(states))out.print(" selected ");%>><%=r.getString(teasession._nLanguage,"NoAuditing")%></option>
    <option value="1" <%if("1".equals(states))out.print(" selected ");%>><%=r.getString(teasession._nLanguage,"Auditing")%></option>
</select>
  </td>
    <td><input type=submit value="<%=r.getString(teasession._nLanguage, "查询")%>" ></td>
  </tr>
  </table>
  </FORM>
<br/>

  <h2><%=r.getString(teasession._nLanguage, "列表")+" ( "+count+" )"%></h2>
  <FORM name=form2 METHOD=post action="/servlet/Subscribers">
    <input type="hidden" name="community" value="<%=community%>">
    <input type="hidden" name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>">

    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr id=tableonetr>
        <td width="1"> </td>
        <td><%=r.getString(teasession._nLanguage, "MemberId")%> </td>
          <td><%=r.getString(teasession._nLanguage, "Email")%> </td>
        <td><%=r.getString(teasession._nLanguage, "手机")%></td>
        <td><%=r.getString(teasession._nLanguage, "有效期")%></td>
        <td><%=r.getString(teasession._nLanguage, "States")%></td>
        <td id="smstd"></td>
      </tr>
<%
Enumeration e=Subscriber.find(community,sql.toString(),pos,25);
while(e.hasMoreElements())
{
  RV rv = (RV)e.nextElement();
  String s2=rv._strV;
  Profile p=Profile.find(s2);
  Subscriber s = Subscriber.find(teasession._strCommunity, rv);
  java.util.Date term=s.getTerm();
%>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
  <td width="1"><input type="CHECKBOX"  name="members" value="<%=s2%>" <%if("webmaster".equals(s2))out.print(" disabled ");%> ></td>
  <td><a target="_blank" href="/jsp/access/Glance.jsp?Member=<%=s2%>" ><%=s2%></A></td>
  <td><%if(p.getEmail()!=null)out.print("<A href=mailto:"+p.getEmail()+" >"+p.getEmail()+"</a>");%></td>
  <td><%=p.getMobile()%></td>
  <td><%
  if(term!=null&&term.getTime()>System.currentTimeMillis())
  {
    out.print(p.sdf.format(s.getTerm()));
    out.print("<td>"+r.getString(teasession._nLanguage,"Auditing"));
  }else
  {
    if(term==null)
    {
      java.util.Calendar c=java.util.Calendar.getInstance();
      c.set(c.YEAR,c.get(c.YEAR)+1);
      term=c.getTime();
    }
    out.print(new tea.htmlx.TimeSelection(s2+"_term", term));
    out.print("<td><input name=auditing onclick=\"fal('"+s2+"'); return true;\" type=submit value="+r.getString(teasession._nLanguage,"Auditing")+">");
  }
  %></td>
  <td id="smstd">
    <input type="submit" value="密码重置" name="clearpassword"  onclick="return confirm('<%=r.getString(teasession._nLanguage, "密码重置后为:111111.")%>')&&fal('<%=s2%>');"  >
    <input type='button' onClick="window.location='/jsp/sms/EditSMSMoney.jsp?node=<%=teasession._nNode%>&member=<%=s2%>';" name=Subscribers VALUE="<%=r.getString(teasession._nLanguage, "SMS")%>"></td>
</tr>
<%
 }
%>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td colspan="2"><input type="CHECKBOX" onClick="selectAll(form2.members ,this.checked)"/><%=r.getString(teasession._nLanguage, "SelectAll")%></td>
    <td colspan="20" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage, request.getRequestURI()+"?community="+community+"&node=" + teasession._nNode+param.toString() + "&pos=", pos, count )%> </td>
    </tr>
  </table>


    <input type="submit" name="auditing" value="<%=r.getString(teasession._nLanguage, "Auditing")%>" onClick="return fcheck();"/>
    <input type="submit" name="delete"  CLASS="CB"  value="<%=r.getString(teasession._nLanguage, "CBDelete")%>" onClick="return fcheck()&&confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>');"/>
    <input type="submit" name="export"  value="<%=r.getString(teasession._nLanguage, "导出选中项")%>" onClick="return fcheck();"/>
    <input type="submit" name="exportall"  value="<%=r.getString(teasession._nLanguage, "导出所有")%>" onClick=""/>
  </FORM>

<br>
<div id="head6"><img height="6" alt=""></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</body>
</html>

