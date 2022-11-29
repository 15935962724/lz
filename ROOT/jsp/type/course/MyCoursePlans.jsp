<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);

int menuid=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer();

sql.append(" AND member="+h.member+" AND deleted=0");
par.append("?");

String subject=h.get("subject","");
if(subject.length()>0)
{
  sql.append(" AND node IN(SELECT node FROM NodeLayer WHERE subject LIKE "+DbAdapter.cite("%"+subject+"%")+")");
  par.append("&subject="+Http.enc(subject));
}


int ispay=h.getInt("ispay");
if(ispay>0)
{
  sql.append(" AND ispay LIKE "+DbAdapter.cite("%"+ispay+"%"));
  par.append("&ispay="+ispay);
}

int sum=CoursePlan.count(sql.toString());

sql.append(" ORDER BY courseplan DESC");
int pos=h.getInt("pos");
par.append("&pos=");

%><div class="cplans">
<div class="pxjltop">培训记录</div>
<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table class="pxjlcx" id="tablecenter" cellspacing="0" >
<tr>
  <td>培训名称:<input name="subject" value="<%=subject%>"/></td>
  <td>付款状态:<select name="ispay"><%=h.options(CoursePlan.ISPAY_TYPE,ispay)%></select></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/Courses.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="courseplan"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>培训名称</td>
  <td>培训时间</td>
  <td>报名时间</td>
  <td>金额</td>
  <td>支付方式</td>
  <td>支付状态</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=CoursePlan.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    CoursePlan t=(CoursePlan)it.next();
    Node n=Node.find(t.node);
    Course c=Course.find(t.node,h.language);
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><%=i%></td>
    <td><%=n.getAnchor(h.language)%></td>
    <td><%=MT.f(n.getStartTime())%></td>
    <td><%=MT.f(t.time)%></td>
    <td><%=MT.f(t.ispay==2?t.price:c.price)%></td>
    <td><%=CoursePlan.PAYMENT_TYPE[t.payment]%></td>
    <td><%=CoursePlan.ISPAY_TYPE[t.ispay]%></td>
    <td><a href="javascript:mt.act('del',<%=t.courseplan%>)">取消报名</a></td>
  </tr>
  <%
  }
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
</form></div>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,b)
{
  form2.act.value='plan'+a;
  form2.courseplan.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='edit')
  {
    form2.action='/CoursePlanEdit.jsp';form2.target='_self';form2.method='get';form2.submit();
  }
};
</script>
