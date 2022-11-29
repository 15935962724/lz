<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%>
<%@page import="tea.entity.member.*"%><%

Http h=new Http(request,response);
TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}


int menuid=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer();

sql.append(" AND community="+DbAdapter.cite(h.community));
par.append("?community="+h.community+"&id="+menuid);

int type=h.getInt("type",-1);
if(type!=-1)
{
  sql.append(" AND type="+type);
  par.append("&type="+type);
}

int operator=h.getInt("operator");
if(operator>0)
{
  sql.append(" AND operator="+operator);
  par.append("&operator="+operator);
}

Date stime=h.getDate("stime");
if(stime!=null)
{
  sql.append(" AND time>"+Database.cite(stime));
  par.append("&stime="+MT.f(stime));
}
Date etime=h.getDate("etime");
if(etime!=null)
{
  sql.append(" AND time<"+Database.cite(etime));
  par.append("&etime="+MT.f(etime));
}

String mobile=h.get("mobile","");
if(mobile.length()>0)
{
  sql.append(" AND mobile LIKE "+DbAdapter.cite("%"+mobile+"%"));
  par.append("&mobile="+h.enc(mobile));
}

String content=h.get("content","");
if(content.length()>0)
{
  sql.append(" AND content LIKE "+DbAdapter.cite("%"+content+"%"));
  par.append("&content="+h.enc(content));
}


int pos=h.getInt("pos");
int sum=SMSMessage.count(sql.toString());
par.append("&pos=");

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>短信管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td>手机号:</td><td><input name="mobile" value="<%=mobile%>"/></td>
  <td>内容:</td><td><input name="content" value="<%=content%>"/></td>
  <td>接口:</td>
  <td>
    <select name="operator">
      <option value="0">----</option>
      <option value="2">移动代理服务器</option>
      <option value="3">触发短信</option>
    </select>
  </td>
  <%--<td>类型:</td><td><select name="type"><option value="-1">----</option><%=h.options(SMSMessage.SMS_TYPE,type)%></select>--%>
  <td>时间：</td><td><input name="stime" value="<%=MT.f(stime)%>" class="date" readonly onclick="mt.date(this)"/>至<input name="etime" value="<%=MT.f(etime)%>" class="date" readonly onclick="mt.date(this)"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/servlet/EditSMSMessage" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="smsmessage"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>用户</td>
  <td>手机号</td>
  <td>内容</td>
  <td>时间</td>
  <%--<td>操作</td>--%>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  sql.append(" ORDER BY smsmessage DESC");
  Iterator it=SMSMessage.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    SMSMessage t=(SMSMessage)it.next();
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><%=i%></td>
      <%
          List<Profile> arrayList = Profile.find1("AND mobile=" + Database.cite(t.mobile), 0, Integer.MAX_VALUE);
          String memberstr = "";
          if(arrayList.size()!=0) {
            for (int j = 0; j < arrayList.size(); j++) {
              Profile profile = arrayList.get(j);
              if (!profile.getMember().contains("删除")) {
                memberstr = profile.getMember();
              }


            }
          }

      %>
   <%-- <%if("webmaster".equals(t.member)){%>--%>
    <td><%=MT.f(memberstr)%></td>
    <%--<%}else {%>--%>
    <%--<td><%=MT.f(t.member)%></td>--%>
    <%--<%}%>--%>
    <td><%=MT.f(t.mobile)%></td>
    <td><%=MT.f(t.content)%></td>
    <td><%=MT.f(t.time,1)%></td>
    <%--<td><input type="button" value="删除" onclick="f_act('del',<%=t.smsmessage%>)"/></td>--%>
  </tr>
  <%
  }
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
<br/>
<input type="button" value="发送" onclick="f_act('edit','0')"/>
</form>

<script>
form1.operator.value="<%=operator%>";
form2.nexturl.value=location.pathname+location.search;
function f_act(a,id,b)
{
  form2.act.value=a;
  form2.smsmessage.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='edit')
  {
    form2.action='/jsp/sms/SMSMessageAdd.jsp';form2.target=form2.method='';form2.submit();
  }
}
</script>
</body>
</html>
