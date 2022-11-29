<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.member.*"%><%@page import="net.mietian.convert.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.tobacco.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.tobacco.*"%><%

Http h=new Http(request,response);
if(h.member < 1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int menuid=h.getInt("id");
par.append("?id="+menuid);


int type=h.getInt("type");
if(type>0)
{
  sql.append(" AND type="+type);
  par.append("&type="+type);
}

//提醒
int remind=Smoke.count(sql.toString()+" AND state=1");
String act=h.get("act");
if("remind".equals(act))
{
  out.print(remind);
  return;
}

int matter=h.getInt("matter");
if(matter>0)
{
  sql.append(" AND matter="+matter);
  par.append("&matter="+matter);
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

String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND name LIKE "+DbAdapter.cite("%"+name+"%"));
  par.append("&name="+h.enc(name));
}

String idcard=h.get("idcard","");
if(idcard.length()>0)
{
  sql.append(" AND idcard LIKE "+DbAdapter.cite("%"+idcard+"%"));
  par.append("&idcard="+h.enc(idcard));
}

String address=h.get("address","");
if(address.length()>0)
{
  sql.append(" AND address LIKE "+DbAdapter.cite("%"+address+"%"));
  par.append("&address="+h.enc(address));
}

String mobile=h.get("mobile","");
if(mobile.length()>0)
{
  sql.append(" AND mobile LIKE "+DbAdapter.cite("%"+mobile.replaceAll("[- ]","")+"%"));
  par.append("&mobile="+h.enc(mobile));
}


String  content=h.get("content","");
if(content.length()>0)
{
  sql.append(" AND content LIKE "+DbAdapter.cite("%"+content+"%"));
  par.append("&content="+h.enc(content));
}

int order=h.getInt("order");
par.append("&order="+order);

boolean desc=!"false".equals(h.get("desc"));
par.append("&desc="+desc);


int tab=h.getInt("tab",1);
par.append("&tab="+tab);


int pos=h.getInt("pos");
par.append("&pos=");

String acts=h.get("acts","");

%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<style>
.C<%=type%>{display:none}
.T<%=tab%>{display:none}
#O<%=order%>{background:url(/tea/mt/order<%=desc?0:1%>.gif) no-repeat right;padding-right:8px}
.len{background:#000000;color:#FFFFFF;width:80px;margin-top:-3px;}
</style>
</head>
<body>
<h1><%=Smoke.SMOKE_TYPE[type]%>管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<input type="hidden" name="tab" value="<%=tab%>"/>
<input type="hidden" name="order" value="<%=order%>"/>
<input type="hidden" name="desc" value="<%=desc%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td class="th">姓名:</td><td><input name="name" value="<%=name%>"/></td>
  <td class="th">身份证号:</td><td><input name="idcard" value="<%=idcard%>"/></td>
  <td class="th">手机号:</td><td><input name="mobile" value="<%=mobile%>"/></td>
</tr>
<tr>
  <td class="th">类型:</td><td><select name="matter"><%=h.options(Smoke.MATTER_TYPE[type],matter)%></td>
  <td class="th">内容:</td><td><input name="content" value="<%=content%>"/></td>
  <td class="th">时间:</td><td><input name="time0" value="<%=MT.f(time0)%>" onclick="mt.date(this)" class="date"/>-<input name="time1" value="<%=MT.f(time1)%>" onclick="mt.date(this)" class="date"/>　<input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表</h2>
<form name="form2" action="/Smokes.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="smoke"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="state"/>
<input type="hidden" name="type" value="<%=type%>"/>
<%
out.print("<div class='switch'>");
for(int i=1;i<Smoke.STATE_TYPE.length;i++)
{
  out.print("<a href='javascript:mt.tab("+i+")' class='"+(i==tab?"current":"")+"'>"+Smoke.STATE_TYPE[i]+"("+Smoke.count(sql.toString()+" AND state="+i)+")</a>");
}
out.print("</div>");
%>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td width="15"><input type="checkbox" onclick="mt.select(form2.smokes,checked)"/></td>
  <td><a href="javascript:mt.order('O0')" id="O0">编号</a></td>
  <td><a href="javascript:mt.order('O1')" id="O1">姓名</a></td>
  <td class="C1">缩略图</td>
  <td><a href="javascript:mt.order('O2')" id="O2">手机号</a></td>
  <td><a href="javascript:mt.order('O3')" id="O3">类型</a></td>
  <td><a href="javascript:mt.order('O4')" id="O4">内容</a></td>
  <td><a href="javascript:mt.order('O5')" id="O5">时间</a></td>
  <td class="T1"><a href="javascript:mt.order('O6')" id="O6">处理人</a>/<a href="javascript:mt.order('O7')" id="O7">时间</a></td>
  <td>操作</td>
</tr>
<%
sql.append(" AND state="+tab);
int sum=Smoke.count(sql.toString());
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  String[] ORDER_TYPE={"code","name","mobile","matter","content","time","smember","stime"};
  sql.append(" ORDER BY "+ORDER_TYPE[order]+(desc?" DESC":" ASC")+",smoke"+(desc?" DESC":" ASC"));
  Iterator it=Smoke.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    Smoke t=(Smoke)it.next();
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><input type="checkbox" name="smokes" value="<%=t.smoke%>"/></td>
    <td><a href=javascript:mt.act('view',<%=t.smoke%>)><%=MT.f(t.code,"--")%></a></td>
    <td nowrap><%=MT.f(t.name)%></td>
    <td class="C1"><%
    if(t.attch>0)
    {
      Attch a=Attch.find(t.attch);
      if(a.path4!=null)
      {
        out.print("<img src='"+a.path4+"' width='80' />");
        if(t.type==3)out.println("<div class='len'>"+Video.f(a.numbers)+"</div>");
      }
    }
    %></td>
    <td nowrap><%=t.getMobile()%></td>
    <td nowrap><%=Smoke.MATTER_TYPE[t.type][t.matter]%></td>
    <td><%=MT.f(t.content)%></td>
    <td><%=MT.f(t.time,1)%></td>
    <td class="T1"><%=t.smember<1?"":Profile.find(t.smember).getMember()%> / <%=MT.f(t.stime,1)%></td>
    <td nowrap><%
    out.println("<a href=javascript:mt.act('edit',"+t.smoke+")>编辑</a>");
    out.println("<a href=javascript:mt.act('del',"+t.smoke+")>删除</a>");
    %></td>
  </tr>
  <%
  }
  if(sum>20)out.print("<tr><td colspan='10' align='right'>共"+sum+"条！"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
<br/>
<input type="button" value="删除" name="multi" onclick="mt.act('del','0')"/>
<input type="button" value="审核" name="multi" onclick="mt.act('state','0')"/>
<input type="button" value="导出" onclick="mt.act('exp','0')"/>
<%
if(type>1)out.print("<input type='button' value='导出"+Smoke.SMOKE_TYPE[type]+"' onclick=mt.act('exp2','0') />");
%>
<input type="button" value="添加" onclick="mt.act('edit','0')"/>
<input type="hidden" name="key" value="<%=MT.enc(sql.toString())%>"/>
</form>

<script>
edn.remind(<%=remind%>);
mt.disabled(form2.smokes);
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,b)
{
  form2.act.value=a;
  form2.smoke.value=id;
  //if(a=='exp')
  {
    form2.key.disabled=a.indexOf('exp')!=0;
  }
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='state')
  {
    mt.show("状态：<input name='_state' id='_state2' type='radio' value='2' checked /><label for='_state2'>通过</label>　<input name='_state' id='_state3' type='radio' value='3' /><label for='_state3'>拒绝</label>",2,"form2.state.value=$$('_state2').checked?2:3;form2.submit()");
  }else
  {
    if(a=='view')
      form2.action='/jsp/tobacco/SmokeView.jsp';
    else if(a=='edit')
      form2.action='/jsp/tobacco/SmokeEdit.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
};
</script>
</body>
</html>
