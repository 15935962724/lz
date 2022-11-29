<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}


StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int menuid=h.getInt("id");
sql.append(" AND deleted=0 AND state=2");
par.append("?community="+h.community+"&id="+menuid);

int course=h.getInt("course");
if(course>0)
{
  sql.append(" AND node="+course);
  par.append("&course="+course);
}


//
String username=h.get("username","");
int sex=h.getInt("sex",-1);
String name=h.get("name","");
sql.append(" AND member IN(SELECT profile FROM Profile p WHERE 1=1");
{
  if(username.length()>0)
  {
    sql.append(" AND member LIKE "+DbAdapter.cite("%"+username+"%"));
    par.append("&username="+Http.enc(username));
  }
  if(sex!=-1)
  {
    sql.append(" AND sex="+sex);
    par.append("&sex="+sex);
  }
  if(name.length()>0)
  {
    sql.append(" AND EXISTS(SELECT member FROM ProfileLayer pl WHERE p.member=pl.member");
    sql.append(" AND pl.firstname LIKE "+DbAdapter.cite("%"+name+"%"));
    par.append("&name="+Http.enc(name));
    sql.append(")");
  }
}
sql.append(")");

String subject=h.get("subject","");
if(subject.length()>0)
{
  sql.append(" AND node IN(SELECT node FROM NodeLayer WHERE subject LIKE "+DbAdapter.cite("%"+subject+"%")+")");
  par.append("&subject="+h.enc(subject));
}

Date time0=h.getDate("time0");
if(time0!=null)
{
  sql.append(" AND time>"+DbAdapter.cite(time0));
  par.append("&time0="+MT.f(time0));
}
Date time1=h.getDate("time1");
if(time1!=null)
{
  sql.append(" AND time<"+DbAdapter.cite(time1));
  par.append("&time1="+MT.f(time1));
}
String paymember=h.get("paymember","");
if(paymember.length()>0)
{
  sql.append(" AND paymember IN(SELECT profile FROM Profile WHERE member LIKE "+DbAdapter.cite("%"+paymember+"%")+")");
  par.append("&paymember="+h.enc(paymember));
}
int ispay=h.getInt("ispay");

int sum=CoursePlan.count(sql.toString());


int pos=h.getInt("pos");
par.append("&pos=");

%><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>支付确认——报名管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<input type="hidden" name="ispay" value="<%=ispay%>"/>
<input type="hidden" name="course" value="<%=course%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td class="th">用户名：</td><td><input name="username" value="<%=username%>"/></td>
  <td class="th">姓名：</td><td><input name="name" value="<%=name%>"/></td>
  <td class="th">姓别：</td><td><select name="sex"><option value="-1">---不限---</option><option value="1">男</option><option value="0">女</option></select></td>
</tr>
<tr>
  <td class="th">课程名称：</td><td><input name="subject" value="<%=subject%>"/></td>
  <td class="th">收款人：</td><td><input name="paymember" value="<%=paymember%>"/></td>
  <td class="th">报名时间：</td><td><input name="time0" value="<%=MT.f(time0)%>" onclick="mt.date(this)" class="date"/>-<input name="time1" value="<%=MT.f(time1)%>" onclick="mt.date(this)" class="date"/>　　<input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/Courses.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="courseplan"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="ispay"/>
<input type="hidden" name="paynote"/>
<div class="switch">
<%
for(int i=0;i<CoursePlan.ISPAY_TYPE.length;i++)
{
  out.print("<a href='javascript:mt.tab("+i+")' id='a_tab"+i+"'>"+(i==0?"全部":CoursePlan.ISPAY_TYPE[i])+"（"+CoursePlan.count(sql.toString()+(i==0?"":" AND ispay="+i))+"）</a>");
}
%>
</div>
<script>$("a_tab<%=ispay%>").className="current";</script>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td></td>
  <td>课程名称</td>
  <td>用户名</td>
  <td>姓名</td>
  <td>单位</td>
  <td>职务</td>
  <td>性别</td>
  <td>手机号</td>
  <td>支付方式</td>
  <td>付款状态</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='20' align='center'>暂无记录!</td></tr>");
}else
{
  if(ispay>0)sql.append(" AND ispay="+ispay);
  Iterator it=CoursePlan.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    CoursePlan t=(CoursePlan)it.next();
    Node n=Node.find(t.node);
    Profile m=Profile.find(t.member);
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><input type="checkbox" name="courseplans" value="<%=t.courseplan%>" /></td>
    <td><%=n.getAnchor(h.language)%></td>
    <td><%=m.getMember()%></td>
    <td><%=m.getName(h.language)%></td>
    <td><%=m.getOrganization(h.language)%></td>
    <td><%=m.getJob(h.language)%></td>
    <td><%=m.isSex()?"男":"女"%></td>
    <td><%=m.getMobile()%></td>
    <td><%=CoursePlan.PAYMENT_TYPE[t.payment]%></td>
    <td><%=CoursePlan.ISPAY_TYPE[t.ispay]%></td>
    <td>
      <a href="javascript:mt.act('ispay',<%=t.courseplan%>)">到场确认</a>
      <a href="javascript:mt.act('view',<%=t.courseplan%>)">详细</a>
      <a href="javascript:mt.act('del',<%=t.courseplan%>)">删除</a>
    </td>
  </tr>
  <%
  }
  %>
  <tr>
    <td colspan='3'><input type='checkbox' onclick='mt.select(form2.courseplans,checked)' id="sel" /><label for="sel">全选/反选</label>
    <input type="button" name="multi" value="批量确认" onclick="mt.act('ispay','0')"/>
    <input type="button" name="multi" value="批量删除" onclick="mt.act('del','0')"/>
    <input type="button" value="导出" onclick="form3.submit()"/>
    <td colspan='10' align='right'><%=new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20)%>
  </tr>
  <%
}%>
</table>
</form>

<form name="form3" action="/Exports.do/参加人员.xls" method="post" target="_ajax">
<input type="hidden" name="act" value="courseplan"/>
<input type="hidden" name="key" value="<%=MT.enc(sql.toString())%>"/>
</form>

<script>
mt.disabled(form2.courseplans);
form1.sex.value=<%=sex%>;
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,b)
{
  form2.act.value='plan'+a;
  form2.courseplan.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='ispay')
  {
    mt.show("支付：<input type='radio' name='ispay' value='2' id='_ispay2' checked /><label for='_ispay2'>已付款</label>　<input type='radio' name='ispay' value='1' id='_ispay1' /><label for='_ispay1'>待付款</label><br/>备注：<textarea id='paynote' cols='22' rows='3'></textarea>",2,"form2.ispay.value=$$('_ispay2').checked?2:1;form2.paynote.value=$$('paynote').value;form2.submit()");
  }else
  {
    if(a=='view')
    {
      form2.action='/jsp/type/course/CoursePlanView.jsp';
    }
    form2.target=form2.method='';
    form2.submit();
  }
};
mt.tab=function(i)
{
  form1.ispay.value=i;
  form1.submit();
};
</script>
</body>
</html>
