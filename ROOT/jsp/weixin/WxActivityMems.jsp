<%@page import="tea.entity.member.Profile"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.weixin.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  out.print("<script>top.location='/servlet/StartLogin?bg=1&node="+h.node+"'</script>");
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int type = h.getInt("type");
par.append("?type="+type);

int wxActivity = h.getInt("wxActivity");
sql.append(" AND activityId="+wxActivity);
par.append("&wxActivity="+wxActivity);

String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND pf.member LIKE "+DbAdapter.cite("%"+name+"%"));
  par.append("&name="+h.enc(name));
}

String tel=h.get("tel","");
if(tel.length()>0)
{
  sql.append(" AND wam.tel LIKE "+DbAdapter.cite("%"+tel+"%"));
  par.append("&tel="+h.enc(tel));
}

Integer status=h.get("status","").length()>0?h.getInt("status"):null;
if(status!=null)
{
  sql.append(" AND wam.status = "+status);
  par.append("&status="+status);
}

Date startdate = h.getDate("startdate");
if(startdate!=null){
	sql.append(" AND wam.time > "+DbAdapter.cite(startdate));
	par.append("&startdate="+MT.f(startdate));
}

Date enddate = h.getDate("enddate");
if(enddate!=null){
	sql.append(" AND wam.time < "+DbAdapter.cite(enddate));
	par.append("&enddate="+MT.f(enddate));
}

int sum=WxActivityMem.count(sql.toString());

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
<input type="hidden" name="type" value="<%=type%>"/>
<input type="hidden" name="wxActivity" value="<%=wxActivity%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td class="th">用户名：</td><td><input name="name" value="<%=name%>"/></td>
  <td class="th">手机号：</td><td><input name="tel" value="<%=tel%>"/></td>
  <td class="th">状态：</td>
  <td>
  		<select name="status">
  			<option value="">--请选择--</option>
  			<%
  			for(int i=0;i<WxActivityMem.STATUSARR.length;i++){
  				out.print("<option value='"+i+"' "+(status!=null&&status==i?"selected":"")+" >"+WxActivityMem.STATUSARR[i]+"</option>");
  			}
  			%>
  		</select>
  </td>
  <td class="th">开始时间：</td><td><input name="startdate" onclick="mt.date(this)" value="<%=MT.f(startdate)%>"/></td>
  <td class="th">结束时间：</td><td><input name="enddate" onclick="mt.date(this)" value="<%=MT.f(enddate)%>"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表</h2>
<form name="form2" action="/WxActivityMems.do" method="post" target="_ajax">
<input type="hidden" name="type" value="<%=type%>"/>
<input type="hidden" name="wxActivityMem"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>

<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td width="20" align="center"></td>
  <td>用户名</td>
  <td>手机号</td>
  <td>获得奖项</td>
  <td>参与时间</td>
  <td>操作</td>
</tr>
<%
sql.append(" ORDER BY wam.time desc");
ArrayList ali=WxActivityMem.find(sql.toString(),pos,15);
if(ali.size()<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  for(int i=0;i<ali.size();i++)
  {
	  WxActivityMem t=(WxActivityMem)ali.get(i);
	  Profile pf = Profile.find(t.getMember());
	  out.print("<tr><td align='center'>"+(i+1)+"</td>");
	  out.print("<td>"+MT.f(pf.getMember())+"</td>");
	  out.print("<td>"+MT.f(t.getTel())+"</td>");
	  out.print("<td>"+(t.getActivityPrizeId()>0?MT.f(WxActivityPrize.find(t.getActivityPrizeId()).getName()):"谢谢参与")+"</td>");
	  out.print("<td>"+MT.f(t.getTime(),1)+"</td>");
	  out.println("<td>");
	  if(t.getStatus()==0){
	  	out.println("未中奖");
	  }else if(t.getStatus()==1){
	  	out.println("<a href=\"javascript:mt.act('awardPrize',"+t.getId()+")\">未领奖</a>");
	  }else if(t.getStatus()==2){
	  	out.println("已领奖");
	  }
	  out.println("</td>");

  }
  if(sum>15)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language,par.toString(),pos,sum,15));
}
%>
</table>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,b)
{
  form2.act.value=a;
  form2.wxActivityMem.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='awardPrize'){
	  mt.show('你确定要领取奖品吗？',2,'form2.submit()');
  }else
  {
    if(a=='edit')
      form2.action='/jsp/weixin/WxActivityEdit.jsp';
    else if(a=='actyMems')
    	form2.action='/jsp/weixin/WxActivityEdit.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
};

</script>
</body>
</html>
