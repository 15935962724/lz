<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.entity.*"%><%

Http h=new Http(request,response);
TeaSession ts=new TeaSession(request);
if(ts._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node+"&nexturl="+Http.enc(request.getRequestURI()+"?"+request.getQueryString()));
  return;
}



int folder=h.getInt("folder");

int menu=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer();
par.append("?community="+h.community);

String tname=h.get("tname","");
if(tname.length()>0)
{
  sql.append(" AND( member IN (SELECT profile FROM Profile WHERE member LIKE "+Database.cite("%"+tname+"%")+") OR tname0 LIKE "+Database.cite("%"+tname+"%")+" OR tname1 LIKE "+Database.cite("%"+tname+"%")+")");
  par.append("&tname="+h.enc(tname));
}

String subject=h.get("subject","");
if(subject.length()>0)
{
  sql.append(" AND subject LIKE "+Database.cite("%"+subject+"%"));
  par.append("&subject="+h.enc(subject));
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

int pos=h.getInt("pos");
par.append("&pos=");

String nexturl=h.enc(request.getRequestURI()+"?"+request.getQueryString());

Profile p=Profile.find(h.member);

String sqlx=Message.sql(folder,p.getProfile())+sql.toString();
int sum=Message.count(sqlx);


%><html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
<style>
.F0,.F1,.F2,.F3{display:none};
.F<%=folder%>{display:inline};
</style>
</head>
<body>
<h1><%=Message.FOLDER_TYPE[folder]%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>
<input type="hidden" name="folder" value="<%=folder%>"/>
<table id="tablecenter">
<tr>
  <td>主题:<input name="subject" value="<%=subject%>" size="15"/></td>
  <td>收/发件人:<input name="tname" value="<%=tname%>" size="15"/></td>
  <td>时间:<input name="stime" value="<%=MT.f(stime)%>" onclick="mt.date(this)" class="date"/>-<input name="etime" value="<%=MT.f(etime)%>" onclick="mt.date(this)" class="date"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>


<h2>列表</h2>
<form name="form2" action="/Messages.do" target="_ajax">
<input type="hidden" name="folder" value="<%=folder%>"/>
<input type="hidden" name="act"/>
<input type="hidden" name="move"/>
<input type="hidden" name="nexturl"/>

<table id="tablecenter">
<tr id=tableonetr><td><a href='###' onclick='mt.select(form2.message,1)'>全选</a>/<a href='###' onclick='mt.select(form2.message,2)'>反选</a></td>
  <td>主题</td>
  <td class="F0 F3">发件人</td>
  <td class="F1 F2">收件人</td>
  <td>发送时间</td>
  <td></td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=Message.find(sqlx+" ORDER BY message DESC",pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    Message t=(Message)it.next();

    out.print("<tr onMouseOver=bgColor='#FFFFE1' onMouseOut=bgColor=''>");
    out.print("<td align=center><input type='checkbox' name='message' value='"+t.message+"' /></td>");
    out.print("<td>");
    if(!t.isReader(p.getProfile()))out.print("<b>");
    out.print("<a href='/jsp/message/MessageView.jsp?message="+t.message+"&nexturl="+nexturl+"'>"+MT.f(t.subject)+"</a></b></td>");
    out.print("<td class='F0 F3'>"+Profile.find(t.member).getMember()+"</td>");
    out.print("<td class='F1 F2'>"+t.tname[h.language]+"</td>");
    out.print("<td>"+MT.f(t.time,1)+"</td>");
    out.print("<td><a href='javascript:mt.reader("+t.message+")'>回执</a></td>");
    out.print("</tr>");
  }
  %>
  <tr class="trbutton"><td colspan="5"><div class="left">
<%
if(folder<3)out.print("<input name='multi' type='button' value='删除' onclick=\"mt.act('del',"+folder+")\"/>");
%>
<input name="multi" type="button" value="彻底删除" onClick="mt.act('del2',<%=folder%>)"/>
<input name="multi" type="button" value="清空" onClick="mt.select(form2.message,0)"/>
<select name="multi" onChange="mt.act('move',value)"><option value="">移动到<%=h.options(Message.FOLDER_TYPE,-1)%></select></div>
<%
  if(sum>20)out.print("<div class='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20)+"</div>");
}
%>

<%--
<input type="button" value="移动到" onclick="var st=$('move').style;st.display='';st.left=mt.left(this);st.top=mt.top(this)+this.offsetHeight;"/>
<span style="border:1px solid #9CB8CC;position:absolute;cursor:default;display:none" id="move">
<div onMouseOver="style.backgroundColor='#BCD1E9'" onMouseOut="style.backgroundColor=''">111</div>
<div onMouseOver="style.backgroundColor='#BCD1E9'" onMouseOut="style.backgroundColor=''">222</div>
</span>
--%>
  </td>
</tr>
</table>
</form>
<input type="button" value="写消息" onClick="window.open('/jsp/message/MessageEdit.jsp?nexturl=<%=nexturl%>','_self')"/>

<script>
form2.nexturl.value=location.pathname+location.search;

mt.disabled(form2.message);
mt.act=function(a,m)
{
  if(mt.value(form2.message)==null)
  {
    mt.show("至少要选择一个!");
    return;
  }
  form2.act.value=a;
  if(m)form2.move.value=m;
  switch(a)
  {
    case "del":
    mt.show("确认删除所选?",2,"form2.submit()");
    break;
    case "del2":
    mt.show("确认彻底删除所选?",2,"form2.submit()");
    break;
    default:
    form2.submit();
  }
}
mt.reader=function(m)
{
  mt.show('/jsp/message/MessageReader.jsp?message='+m,1,'察看阅读情况',500,300);
}
</script>

</body>
</html>
