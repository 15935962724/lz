<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int menuid=h.getInt("id");
par.append("?id="+menuid);
sql.append(" AND father="+h.node);

String subject=h.get("subject","");
if(subject.length()>0)
{
  sql.append(" AND node IN(SELECT node FROM NodeLayer WHERE 1=1");
  sql.append(" AND subject LIKE "+DbAdapter.cite("%"+subject+"%"));
  par.append("&subject="+h.enc(subject));
  sql.append(")");
}

int hidden=h.getInt("hidden",-1);
if(hidden!=-1)
{
  sql.append(" AND hidden="+hidden);
  par.append("&hidden="+hidden);
}

Date time0=h.getDate("time0");
if(time0!=null)
{
  sql.append(" AND starttime>"+DbAdapter.cite(time0));
  par.append("&time0="+MT.f(time0));
}
Date time1=h.getDate("time1");
if(time1!=null)
{
  sql.append(" AND starttime<"+DbAdapter.cite(time1));
  par.append("&time1="+MT.f(time1));
}

int pos=h.getInt("pos");
par.append("&pos=");

int sum=Node.count(sql.toString());

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>课程管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td class="th">名称：</td><td><input name="subject" value="<%=MT.f(subject)%>"/></td>
  <td class="th">培训时间：</td><td><input name="time0" value="<%=MT.f(time0)%>" onclick="mt.date(this)" class="date"/>-<input name="time1" value="<%=MT.f(time1)%>" onclick="mt.date(this)" class="date"/></td>
  <td class="th">发布状态：</td><td><select name="hidden"><option value="-1">--<option value="0">已发布<option value="1">未发布</select></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/Courses.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="node"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>名称</td>
  <td>培训时间</td>
  <td>培训地址</td>
  <td>培训费用</td>
  <td>联系电话</td>
  <td>报名截止时间</td>
  <td>报名人数</td>
  <td>显示状态</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Enumeration e=Node.find(sql.toString(),pos,20);
  for(int i=1+pos;e.hasMoreElements();i++)
  {
    int node=((Integer)e.nextElement()).intValue();
    Node n=Node.find(node);
    Course t=Course.find(node,h.language);
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><%=i%></td>
    <td><%=n.getAnchor(h.language)%></td>
    <td><%=MT.f(n.getStartTime())%></td>
    <td><%=MT.f(t.address)%></td>
    <td><%=MT.f(t.price)%></td>
    <td><%=MT.f(t.tel)%></td>
    <td><%=MT.f(t.regstop)%></td>
    <td><%%></td>
    <td><%=n.isHidden()?"未发布":"已发布"%></td>
    <td>
    <%
    out.print("<a href='###' onMouseOver='mt.more(this)'>操作</a><div style='display:none'>");
    out.println("<a href=javascript:mt.act('hidden',"+node+")>"+(n.isHidden()?"发布":"取消发布")+"</a>");
    out.println("<a href=javascript:mt.act('edit',"+node+")>编辑</a>");
    out.println("<a href=javascript:mt.act('invite',"+node+")>邀请</a>");
    out.println("<a href=javascript:mt.act('audit',"+node+")>报名审核</a>");
    out.println("<a href=javascript:mt.act('ispay',"+node+")>参加人员</a>");
    out.println("<a href=javascript:mt.act('attch',"+node+")>上传课件</a>");
    out.println("<a href=javascript:mt.act('del',"+node+")>删除</a>");
    out.print("</div>");
    %>
    </td>
  </tr>
  <%
  }
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
<br/>
<input type="button" value="添加" onclick="mt.act('edit','<%=h.node%>')"/>
</form>

<script>
form1.hidden.value="<%=hidden%>";
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,b)
{
  form2.act.value=a;
  form2.node.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else
  {
    if(a=='hidden')
    {
    }else
    {
      if(a=='edit')
      {
        form2.action='/jsp/type/course/EditCourse.jsp';
      }else if(a=='attch')
      {
        form2.action='/jsp/type/course/CourseAttch.jsp';
      }else if(a=='invite')
      {
        form2.action='/jsp/custom/edu/EduMemberInvites.jsp';
      }else
      {
        form2.node.name='course';
        if(a=='audit')
        {
          form2.action='/jsp/type/course/CoursePlans.jsp';
        }else if(a=='ispay')
        {
          form2.action='/jsp/type/course/CoursePlanPays.jsp';
        }
      }
      form2.target=form2.method='';
    }
    form2.submit();
  }
};
</script>
</body>
</html>
