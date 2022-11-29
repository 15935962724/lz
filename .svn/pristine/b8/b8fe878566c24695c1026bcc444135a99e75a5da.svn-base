<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.weixin.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  out.print("<script>top.location='/servlet/StartLogin?bg=1&node="+h.node+"'</script>");
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int menuid=h.getInt("id");
par.append("?community="+h.community+"&id="+menuid);
sql.append(" AND community="+DbAdapter.cite(h.community));

int type = h.getInt("type");
sql.append(" AND type="+type);
par.append("&type="+type);

String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND name LIKE "+DbAdapter.cite("%"+name+"%"));
  par.append("&name="+h.enc(name));
}

String keyword=h.get("keyword","");
if(keyword.length()>0)
{
  sql.append(" AND keyword LIKE "+DbAdapter.cite("%"+keyword+"%"));
  par.append("&keyword="+h.enc(keyword));
}

int status = h.getInt("status");
if(status>0){
	Date nowDate = new Date();
	String staSql = "";
	if(status==1){
		staSql = " AND starttime > "+DbAdapter.cite(nowDate);
	}else if(status==2){
		staSql = " AND stoptime < "+DbAdapter.cite(nowDate);
	}else{
		staSql = " AND starttime < "+DbAdapter.cite(nowDate)+" AND stoptime > "+DbAdapter.cite(nowDate);
	}
	sql.append(staSql);
	par.append("&status="+status);
}

int sum=WxActivity.count(sql.toString());

int pos=h.getInt("pos");
par.append("&pos=");

String acts=h.get("acts","");

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>我的<%=WxActivity.TYPEARR[type]%>活动</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menuid%>"/>
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="type" value="<%=type%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td class="th">名称：</td><td><input name="name" value="<%=name%>"/></td>
  <td class="th">关键字：</td><td><input name="keyword" value="<%=keyword%>"/></td>
  <td class="th">活动状态：</td>
  <td>
  		<select name="status">
  			<option value="0" <%=status==0?"selected":"" %> >--请选择--</option>
  			<option value="1" <%=status==1?"selected":"" %> >未开始</option>
  			<option value="2" <%=status==2?"selected":"" %> >已结束</option>
  			<option value="3" <%=status==3?"selected":"" %> >进行中</option>
  		</select>
  		
  </td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表</h2>
<form name="form2" action="/WxActivitys.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="type" value="<%=type%>"/>
<input type="hidden" name="wxActivity"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>

<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td width="20" align="center"><input type="checkbox" onClick="mt.select(form2.wxActivitys,checked)" title="选中/取消选中"></td>
  <td>名称</td>
  <td>关键字</td>
  <td>活动时间</td>
  <td>活动状态</td>
  <td>操作</td>
</tr>
<%
sql.append(" ORDER BY time desc");
ArrayList ali=WxActivity.find(sql.toString(),pos,15);
if(ali.size()<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  for(int i=0;i<ali.size();i++)
  {
    WxActivity t=(WxActivity)ali.get(i);
    out.print("<tr><td align='center'><input type='checkbox' name='wxActivitys' value='"+t.getId()+"' /></td>");
    out.print("<td>");
    if(t.isHidden())out.print("<s>");
    out.print(MT.red(t.getName(),name)+"</td>");
    out.print("<td>"+MT.f(t.getKeyword())+"</td>");
    out.print("<td>"+MT.f(t.getStarttime(),1)+" 至 "+MT.f(t.getStoptime(),1)+"</td>");
    long nowTimes = new Date().getTime();
    out.println("<td>");
    if(nowTimes<t.getStarttime().getTime()){
    	out.print("未开始");
    }else if(nowTimes>t.getStoptime().getTime()){
    	out.print("已结束");
    }else{
    	out.print("进行中");
    }
    out.println("</td>");
    out.println("<td><a href=javascript:mt.act('edit',"+t.getId()+")>编辑</a>");
    out.println("<a href=javascript:mt.act('del',"+t.getId()+")>删除</a>");
    out.println("<a href=javascript:mt.act('actyMems',"+t.getId()+")>数据监测</a></td>");

  }
  if(sum>15)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language,par.toString(),pos,sum,15));
}
%>
</table>
<input type="button" name="multi" value="批量删除" onClick="mt.act('del','0')"/>
<input type="button" value="添加" onClick="mt.act('edit','0')"/>
</form>

<script>
mt.disabled(form2.wxActivitys);
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,b)
{
  form2.act.value=a;
  form2.wxActivity.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else
  {
    if(a=='edit')
      form2.action='/jsp/weixin/WxActivityEdit.jsp';
    else if(a=='actyMems')
    	form2.action='/jsp/weixin/WxActivityMems.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
};

</script>
</body>
</html>
