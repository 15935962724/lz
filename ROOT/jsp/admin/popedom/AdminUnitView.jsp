<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.io.*" %>
<%@page import="java.net.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.ui.TeaSession" %>
<% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource();

String field=teasession.getParameter("field");
String name=teasession.getParameter("name");
String title=teasession.getParameter("title");
String degree=teasession.getParameter("degree");
int polity=0;
String tmp=teasession.getParameter("polity");
if(tmp!=null)
{
  polity=Integer.parseInt(tmp);
}
String etimestart=teasession.getParameter("etimestart");
String etimeend=teasession.getParameter("etimeend");

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function f_change(obj)
{
  var op=obj.options;
  for(var i=0;i<op.length;i++)
  {
    var j=document.all(op[i].value);
    if(op[i].value!=obj.value)
    {
      j.style.display="none";
      j.disabled=true;
    }else
    {
      var d=form1.degree;
      if(obj.value=="degree"&&d.value=="")
      {
        d.value="本科";
      }
      var p=form1.polity;
      if(obj.value=="polity"&&p.value=="0")
      {
        p.value="1";
      }
      j.style.display="";
      j.disabled=false;
    }
  }
}
function f_load()
{
  <%
  if(field!=null)
  {
    out.print("form1.field.value='"+field+"';");
  }
  if(degree!=null)
  {
    out.print("form1.degree.value='"+degree+"';");
  }
  %>
  f_change(form1.field);
}
</script>
</head>
<BODY onLoad="f_load()">
<h1><%=r.getString(teasession._nLanguage, "浏览部门记录")%></h1>
<div id="head6"><img height="6" alt=""></div>

<h2><%=r.getString(teasession._nLanguage, "查询")%></h2>
<form name="form1" action="?">
<table cellSpacing="0" cellPadding="0"  border="0" id="tablecenter">
<tr>
  <td nowrap width="300px">
    <select name="field" onChange="f_change(this)">
    <option value="name">姓名</option>
    <option value="title">职称</option>
    <option value="degree">学历</option>
    <option value="polity">政治面貌</option>
    </select>
    <input type="text" name="name" value="<%if(name!=null)out.print(name);%>">
    <input type="text" name="title" style="display:none" value="<%if(title!=null)out.print(title);%>">
    <select name="degree" style="display:none">
      <option value="">--------------
      <option value="博士">博士
      <option value="硕士">硕士
      <option value="本科">本科
      <option value="大专">大专
      <option value="高中">高中
    </select>
  <select name="polity" style="display:none">
  <%
  for(int i=0;i<Profile.POLITY_TYPE.length;i++)
  {
    out.print("<option value="+i);
    if(i==polity)
    {
      out.print(" SELECTED ");
    }
    out.print(">"+r.getString(teasession._nLanguage,Profile.POLITY_TYPE[i]));
  }
  %>
  </select>
  </td>
  <td nowrap>入职时间
    <input type="text" name="etimestart" value="<%if(etimestart!=null)out.print(etimestart);%>" size="12" readonly><img src="/tea/image/public/Calendar2.gif" onClick="showCalendar('form1.etimestart');"> - <input type="text" name="etimeend" value="<%if(etimeend!=null)out.print(etimeend);%>" size="12" readonly><img src="/tea/image/public/Calendar2.gif" onClick="showCalendar('form1.etimeend');"></td>
  <td><input type="submit" value="检索"/></td>
</tr>
</table>
</form>

<%
if(field!=null)
{
  StringBuffer sql=new StringBuffer();
  StringBuffer par=new StringBuffer();
  par.append("?community=").append(teasession._strCommunity);
  par.append("&field=").append(field);
  sql.append(" AND role!='/' AND options NOT LIKE '%/1/%'");

  sql.append(" AND member IN ( SELECT p.member FROM Profile p INNER JOIN ProfileLayer pl ON p.member=pl.member WHERE 1=1");
  if(name!=null&&name.length()>0)
  {
    sql.append(" AND pl.lastname+pl.firstname LIKE ").append(DbAdapter.cite("%"+name+"%"));
    par.append("&name=").append(URLEncoder.encode(name,"UTF-8"));
  }

  if(title!=null&&title.length()>0)
  {
    sql.append(" AND pl.title LIKE ").append(DbAdapter.cite("%"+title+"%"));
    par.append("&title=").append(URLEncoder.encode(title,"UTF-8"));
  }

  if(degree!=null&&degree.length()>0)
  {
    sql.append(" AND pl.degree LIKE ").append(DbAdapter.cite("%"+degree+"%"));
    par.append("&degree=").append(URLEncoder.encode(degree,"UTF-8"));
  }

  if(polity!=0)
  {
    sql.append(" AND p.polity=").append(polity);
    par.append("&polity=").append(polity);
  }

  if(etimestart!=null&&etimestart.length()>0)
  {
    sql.append(" AND p.etime>=").append(DbAdapter.cite(etimestart));
    par.append("&etimestart=").append(etimestart);
  }
  if(etimeend!=null&&etimeend.length()>0)
  {
    sql.append(" AND p.etime<").append(DbAdapter.cite(etimeend));
    par.append("&etimeend=").append(etimeend);
  }
  sql.append(" )");

  int pos=0,size=10;
  tmp=request.getParameter("pos");
  if(tmp!=null)
  {
    pos=Integer.parseInt(tmp);
  }
  par.append("&pos=");
  int count=AdminUsrRole.count(teasession._strCommunity,sql.toString());
%>
<!--==================搜索=========================-->
<h2><%=r.getString(teasession._nLanguage, "列表")+" ( "+count+" )"%></h2>
<table border="1" cellPadding="0" cellSpacing="0" id="tablecenter" style="border-collapse: collapse">
<%
if(count>0)
{
  Enumeration e = AdminUsrRole.find(teasession._strCommunity,sql.toString(), pos, size);
  while(e.hasMoreElements())
  {
    String member = (String) e.nextElement();
    AdminUsrRole aur = AdminUsrRole.find(teasession._strCommunity, member);

    Profile p = Profile.find(member);
    String photo=p.getPhotopath2(teasession._nLanguage);

    String href="/jsp/user/ProfileView.jsp?community="+teasession._strCommunity+"&member="+java.net.URLEncoder.encode(member,"UTF-8");
    %>
    <tr>
      <td width="15%" rowspan="3" align="center" valign="top" style="padding:2px;margin:0px"><%
      if(photo!=null&&photo.length()>0)
      {
        out.print("<a href="+href+"><img width=80 src="+photo+" ></a>");
      }
      %></td>
      <td colspan="2" align="center"><a href="<%=href%>"><b><%=p.getName(teasession._nLanguage)%></b></a></td>
      <td align="center"><%=p.getJob(teasession._nLanguage)%></td>
    </tr>
    <tr>
      <td width="25%" align="center">&nbsp;<%=p.getTelephone(teasession._nLanguage)%>　</td>
      <td width="25%" align="center">&nbsp;<%=p.getMobile()%>　</td>
      <td width="35%" align="center">&nbsp;<%=p.getEmail()%>　</td>
    </tr>
    <tr>
      <td colspan="3" align="left">&nbsp;<%=p.getFunctions(teasession._nLanguage)%></td>
    </tr>
    <tr>
      <td colspan="4" style="height:15px; border:0; background-color:#FFFFFF">&nbsp;</td>
    </tr>
    <%
    }
    out.print("<tr><td colspan=20 align=right>"+new tea.htmlx.FPNL(teasession._nLanguage,par.toString(),pos,count,size)+"</td></tr>");
  }else
  {
    out.print("<tr><td colspan=20>"+r.getString(teasession._nLanguage, "暂无记录")+"</td></tr>");
  }
%>
</table>

<%
}else
{
  int adminunit=Integer.parseInt(teasession.getParameter("adminunit"));
  AdminUnit au=AdminUnit.find(adminunit);
%>
<!--==================部门=========================-->
<h2><%=r.getString(teasession._nLanguage, "部门信息")%></h2>
<table cellSpacing="0" cellPadding="0"  border="0" id="tablecenter">
  <tr>
    <td width="80" align="right"><%=r.getString(teasession._nLanguage, "部门名称")%></td>
    <td>&nbsp;<%=au.getName()%></td>
  </tr>
  <tr>
    <td width="80" align="right"><%=r.getString(teasession._nLanguage, "英文名称")%></td>
    <td>&nbsp;<%=au.getEName()%></td>
  </tr>
  <tr>
    <td width="80" align="right"><%=r.getString(teasession._nLanguage, "负 责 人")%></td>
    <td>&nbsp;<%=au.getLinkmanname()%></td>
  </tr>
  <tr>
    <td width="80" align="right"><%=r.getString(teasession._nLanguage, "办公电话")%></td>
    <td>&nbsp;<%=au.getTel()%></td>
  </tr>
  <tr>
    <td width="80" align="right"><%=r.getString(teasession._nLanguage, "传　　真")%></td>
    <td>&nbsp;<%=au.getFax()%></td>
  </tr>
  <tr>
    <td width="80" align="right"><%=r.getString(teasession._nLanguage, "地　　址")%></td>
    <td>&nbsp;<%=au.getAddress()%></td>
  </tr>
</TABLE>


<h2><%=r.getString(teasession._nLanguage, "部门成员")%></h2>
<table  border="1" cellPadding="0" cellSpacing="0" id="tablecenter" style="border-collapse: collapse">
<%
Enumeration e = AdminUnitSeq.findByCommunity(teasession._strCommunity, adminunit, true);//AdminUsrRole.find(teasession._strCommunity, " AND role!='/' AND ( unit=" + adminunit + " OR classes LIKE '%/" + adminunit + "/%' ) AND options NOT LIKE '%/1/%'", 0, Integer.MAX_VALUE);
while (e.hasMoreElements())
{
  String member = (String) e.nextElement();
  AdminUsrRole aur = AdminUsrRole.find(teasession._strCommunity, member);

  Profile p = Profile.find(member);
  String photo=p.getPhotopath2(teasession._nLanguage);

  String href="/jsp/user/ProfileView.jsp?community="+teasession._strCommunity+"&member="+java.net.URLEncoder.encode(member,"UTF-8");
%>
  <tr>
    <td width="15%" rowspan="3" align="center" valign="top" style="padding:2px;margin:0px"><%
    if(photo!=null&&photo.length()>0)
    {
      out.print("<a href="+href+"><img width=80 src="+photo+" ></a>");
    }
    %></td>
    <td colspan="2" align="center"><a href="<%=href%>"><b><%=p.getName(teasession._nLanguage)%></b></a></td>
    <td align="center"><%=p.getJob(teasession._nLanguage)%></td>
  </tr>
  <tr>
    <td width="25%" align="center">&nbsp;<%=p.getTelephone(teasession._nLanguage)%>　</td>
    <td width="25%" align="center">&nbsp;<%=p.getMobile()%>　</td>
    <td width="35%" align="center">&nbsp;<%=p.getEmail()%>　</td>
  </tr>
  <tr>
    <td colspan="3" align="left">&nbsp;<%=p.getFunctions(teasession._nLanguage)%></td>
  </tr>
  <tr>
    <td colspan="4" style="height:15px; border:0; background-color:#FFFFFF">&nbsp;</td>
  </tr>
<%
}
%>
</TABLE>
<%}%>


<br>
<div id="head6"><img height="6" alt=""></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</BODY>
</html>
