<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource"  %>
<%@page import="tea.entity.member.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String member=teasession._rv._strV;

Resource r=new Resource();
r.add("/tea/ui/member/contact/EditCGroup").add("/tea/ui/member/message/MessageFolders").add("/tea/ui/member/message/Messages").add("/tea/ui/member/email/EmailBoxs").add("/tea/ui/member/contact/CGroups");

StringBuffer param=new StringBuffer("&community="+teasession._strCommunity);
StringBuffer sql=new StringBuffer();


String name=request.getParameter("name");
if(name!=null&&(name=name.trim()).length()>0)
{
  sql.append(" AND member LIKE "+DbAdapter.cite("%"+name.replaceAll(" ","%")+"%"));
  param.append("&name="+java.net.URLEncoder.encode(name,"UTF-8"));
}

String type=(request.getParameter("type"));
if(type!=null&&type.length()>0)
{
  sql.append(" AND type="+type);
  param.append("&type="+java.net.URLEncoder.encode(type,"UTF-8"));
}

int cgroup=0;
String tmp=request.getParameter("cgroup");
if(tmp!=null&&tmp.length()>0)
{
  cgroup=Integer.parseInt(tmp);
  sql.append(" AND cgroup="+cgroup);
  param.append("&cgroup="+cgroup);
}

String _strId=request.getParameter("id");

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function f_act(act,cgroup,member,seq)
{
  if(act=="delcontact")
  {
    if(!confirm('确认删除'))
    {
      return;
    }
    form1.action='/servlet/EditContact';
  }else if(act=="move")
  {
    form1.sequence.value=seq;
  }else if(act=="newcontact")
  {
    window.open("about:blank","dialog","width=400px,height=300px");
    form1.action="/jsp/message/NewContacts.jsp";
    form1.target="dialog";

  }
  form1.cgroup.value=cgroup;
  form1.member.value=member;
  form1.act.value=act;
  form1.submit();

  form1.action="?";
  form1.target="";
}
</script>
</head>
<body>

<h1>我的组别</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<h2>查询</h2>
<FORM name="form1" action="?">
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<script>document.write("<input type=hidden name=nexturl value="+document.location+">");</script>
<input type=hidden name="id" value="<%=_strId%>"/>
<input type=hidden name="act" >
<input type=hidden name="member" >
<input type=hidden name="sequence">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>名称<input name="name" value="<%if(name!=null)out.print(name);%>"></td>
    <td>分组
      <select name="cgroup">
      <option value="">-------------</option>
      <%
      Enumeration e=CGroup.find(teasession._rv._strV,"",0,Integer.MAX_VALUE);
      while(e.hasMoreElements())
      {
        int id=((Integer)e.nextElement()).intValue();
        CGroup obj=CGroup.find(id);
        out.print("<option value="+id);
        if(id==cgroup)
        {
          out.print(" selected ");
        }
        out.print(">"+obj.getName(teasession._nLanguage));
      }
      %>
      </select>
    </td>
    <td><input type="submit" value="查询"></td>
  </tr>
</table>


<h2>列表</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td width="1">&nbsp;</td>
    <td>名称</td>
<!--    <td>排序</td>-->
    <td>&nbsp;</td>
  </tr>
<%
Enumeration e2=Contact.find(cgroup,sql.toString(),0,Integer.MAX_VALUE);
for(int i=1;e2.hasMoreElements();i++)
{
  Contact obj=(Contact)e2.nextElement();
  cgroup=obj.getCGroup();
  member=obj.getMember();
%>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
  <td width="1"><%=i%></td>
  <td><%=member%></td>
  <!--
  <td><%
  if(i>1)
  {
    out.print("<a href=javascript:f_act('move','"+member+"',true); ><img src=/tea/image/public/arrow_up.gif></a>");
  }
  if(e.hasMoreElements())
  {
    out.print("<a href=javascript:f_act('move','"+member+"',false); ><img src=/tea/image/public/arrow_down.gif></a>");
  }
  %></td>-->
  <td>
    <input type=button value="<%=r.getString(teasession._nLanguage,"CBDelete")%>"  onClick="f_act('delcontact',<%=cgroup%>,'<%=member%>');">
  </td>
</tr>
<%
}
%>
</table>
<input type="button" value="<%=r.getString(teasession._nLanguage,"CBNew")%>" onClick="<%--f_act('newcontact',<%=cgroup%>);--%>window.open('/jsp/message/NewContacts.jsp?community=<%=teasession._strCommunity%>','_blank','width=400px,height=300px');">
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
