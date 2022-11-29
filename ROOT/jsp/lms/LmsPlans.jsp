<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.admin.*"%><%@page import="tea.entity.lms.*"%><%!
String f(LmsPlan t,int i)throws Exception
{
  StringBuilder htm=new StringBuilder();
  htm.append("<tr onMouseOver=bgColor='#FFFFCA' onMouseOut=bgColor='' id="+MT.enc(t.lmsplan)+">");
  htm.append("<td>"+i);
  htm.append("<td>"+(t.father<1?MT.f(t.name):"　　<script>mt.city('"+MT.f(t.city)+"')</script>"));
  htm.append("<td>"+MT.f(t.starttime,1));
  htm.append("<td>"+MT.f(t.endtime,1));
  htm.append("<td>"+MT.f(t.pstarttime,1));
  htm.append("<td>"+MT.f(t.pendtime,1));
  htm.append("<td>"+(t.member<1?"":Profile.find(t.member).getMember()));
  htm.append("<td>"+MT.f(t.time,1));
  htm.append("<td>"+(t.emember<1?"":Profile.find(t.emember).getMember()));
  htm.append("<td>"+MT.f(t.etime,1));
  htm.append("<td>"+LmsPlan.STATUS_TYPE[t.status]);
  htm.append("<td>");
  htm.append(" <a href=### onclick=mt.act(this,'view')>查看</a>");
  if(t.father<1)
  {
    htm.append(" <a href=### onclick=mt.act(this,'edit',"+t.lmsplan+") class='oper' title='如果某省的报名时间特殊，需单独对该省进行报考时间设置。'>添加</a>");
  }
  if(t.status==1||t.status==3)
  {
    htm.append(" <a href=### onclick=mt.act(this,'edit') class='oper'>编辑</a>");
    htm.append(" <a href=### onclick=mt.act(this,'del') class='oper'>删除</a>");
    htm.append(" <a href=### onclick=mt.act(this,'state') class='audit'>审核</a>");
  }else if(t.father<1)
  {
    htm.append(" <a href=### onclick=mt.act(this,'course') class='oper'>课程"+MT.f(LmsPlanCourse.count(" AND lmsplan="+t.lmsplan),'(')+"</a>");
  }
  return htm.toString();
}
%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int menuid=h.getInt("id");
par.append("?id="+menuid);

String act=h.get("act");
if("action".equals(act))
{
  out.print("oper,audit,");
  return;
}

String acts=h.get("acts","");
int remind=acts.contains("audit,")?LmsPlan.count(sql.toString()+" AND lp.status=1"):0;
if("remind".equals(act))
{
  out.print(remind);
  return;
}

int status=h.getInt("status");
if(status>0)
{
  sql.append(" AND lp.status="+status);
  par.append("&status="+status);
}

String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND lp.name LIKE "+DbAdapter.cite("%"+name+"%"));
  par.append("&name="+h.enc(name));
}

int city=h.getInt("city");
if(city>0)
{
  sql.append(" AND lp.city="+city);
  par.append("&city="+city);
}

Date time0=h.getDate("time0");
if(time0!=null)
{
  sql.append(" AND lp.time>"+DbAdapter.cite(time0));
  par.append("&time0="+MT.f(time0));
}
Date time1=h.getDate("time1");
if(time1!=null)
{
  sql.append(" AND lp.time<"+DbAdapter.cite(time1));
  par.append("&time1="+MT.f(time1));
}

int order=h.getInt("order",8);
par.append("&order="+order);

boolean desc="true".equals(h.get("desc"));
par.append("&desc="+desc);


int pos=h.getInt("pos");
par.append("&pos=");

int sum=LmsPlan.count(" AND lp.father=0"+sql.toString());

%><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/city.js" type="text/javascript"></script>
<style>
#O<%=order%>{background:url(/tea/mt/order<%=desc?0:1%>.gif) no-repeat right;padding-right:8px}
.null<%=(acts.contains("oper,")?"":",.oper")+(acts.contains("audit,")?"":",.audit")%>{display:none}
</style>
</head>
<body>
<h1><%=menuid<1?"考试计划":AdminFunction.find(menuid).getName(h.language)%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<input type="hidden" name="order" value="<%=order%>"/>
<input type="hidden" name="desc" value="<%=desc%>"/>
<table id="tablecenter" cellspacing="0" class="alignLeft">
<tr>
  <th>标题名称:</th><td><input name="name" value="<%=name%>"/></td>
  <th>省份:</th><td><script>mt.city("city",null,null,"<%=city%>")</script></td>
  <th>状态:</th><td><select name="status"><%=h.options(LmsPlan.STATUS_TYPE,status)%></select></td>
</tr>
<tr>
  <th>创建时间:</th><td colspan="4"><input name="time0" value="<%=MT.f(time0)%>" onclick="mt.date(this)" class="date"/> - <input name="time1" value="<%=MT.f(time1)%>" onclick="mt.date(this)" class="date"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h3>
<input type="button" value="添加" onclick="mt.act(null,'edit')" class="oper"/>
<input type="button" value="导出" onclick="mt.show(null,0);form3.submit();"/>
</h3>
<h2>列表</h2>
<form name="form2" action="/LmsPlans.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="lmsplan"/>
<input type="hidden" name="father"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="status"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td><a href="javascript:mt.order('O1')" id="O1">标题名称</a></td>
  <td><a href="javascript:mt.order('O3')" id="O3">机考报考开始时间</a></td>
  <td><a href="javascript:mt.order('O4')" id="O4">机考报考结束时间</a></td>
  <td><a href="javascript:mt.order('O5')" id="O5">实践环节报考开始时间</a></td>
  <td><a href="javascript:mt.order('O6')" id="O6">实践环节报考结束时间</a></td>
  <td><a href="javascript:mt.order('O7')" id="O7">创建人</a></td>
  <td><a href="javascript:mt.order('O8')" id="O8">创建时间</a></td>
  <td><a href="javascript:mt.order('O9')" id="O9">审核人</a></td>
  <td><a href="javascript:mt.order('O10')" id="O10">审核时间</a></td>
  <td><a href="javascript:mt.order('O11')" id="O11">状态</a></td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='12' align='center'>暂无记录!</td></tr>");
}else
{
  String[] ORDER_TYPE={"lp.lmsplan","lp.name","lp.city","lp.starttime","lp.endtime","lp.pstarttime","lp.pendtime","lp.member","lp.time","lp.emember","lp.etime","lp.status"};
  sql.append(" ORDER BY "+ORDER_TYPE[order]+(desc?" DESC":" ASC")+",lp.lmsplan");
  Iterator it=LmsPlan.find(" AND lp.father=0"+sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    LmsPlan t=(LmsPlan)it.next();
    out.print(f(t,i));

    out.print("<tbody style='background-color:#F6F6F6'>");
    ArrayList al=LmsPlan.find(" AND lp.father="+t.lmsplan+sql.toString(),0,200);
    for(int j=0;j<al.size();j++)
    {
      t=(LmsPlan)al.get(j);
      out.print(f(t,j+1));
    }
    out.print("</tbody>");
  }
  if(sum>20)out.print("<tr><td colspan='10' align='right'>共"+sum+"条！"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}
%>
</table>
</form>

<form name="form3" action="/LmsExports.do?name=考试计划.xlsx" method="post" target="_ajax">
<input type="hidden" name="act" value="sql"/>
<input type="hidden" name="key" value="<%=MT.enc("SELECT lp.name 名称,c.address 省份,lp.starttime 机考报考开始时间,lp.endtime 机考报考结束时间,lp.pstarttime 实践环节报考开始时间,lp.pendtime 实践环节报考结束时间,lp.time 创建时间,lp.etime 审核时间,"+Lms.when(LmsPlan.STATUS_TYPE,"lp.status")+" 状态 FROM LmsPlan lp LEFT JOIN Card c ON lp.city=c.card WHERE 1=1"+sql.toString())%>"/>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(t,a,b)
{
  form2.act.value=a;
  form2.lmsplan.value=t?mt.ftr(t).id:"";
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='state')
  {
    mt.show("审核：<input name='status' type='radio' id='_status2' checked value='2' /><label for='_status2'>通过</label>　<input name='status' type='radio' id='_status3' value='3' /><label for='_status3'>拒绝</label>",2,"form2.status.value=$$('_status3').checked?3:2;form2.submit()");
  }else
  {
    if(a=='view')
      form2.action='/jsp/lms/LmsPlanView.jsp';
    else if(a=='edit')
    {
      if(b)
      {
        form2.father.value=b;
        form2.lmsplan.value="";
      }
      form2.action='/jsp/lms/LmsPlanEdit.jsp';
    }else if(a=='course')
      form2.action='/jsp/lms/LmsPlanCourseEdit.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
};
edn.remind(<%=remind%>);
</script>
</body>
</html>
