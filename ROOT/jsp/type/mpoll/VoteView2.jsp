<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.node.type.mpoll.*" %><%@page import="java.util.*" %><%@page import="tea.entity.*" %><%@page import="tea.db.*" %>
<%@page import="tea.entity.member.*" %><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?nexturl="+Http.enc(request.getRequestURI()+"?"+request.getQueryString()));
  return;
}

Poll p=Poll.find(h.getInt("poll"));



%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查看结票结果</title>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<script>
//导出
function f_excel()
{
  if(confirm("您确定要导出数据吗?"))
  {
    form1.action='/MVotes.do';
    form1.act.value='exp';
    form1.submit();
  }
}
</script>
<body topmargin="0" leftmargin="0" marginheight="0" marginwidth="0" scroll="yes">

<form action="?" method="get" name="form1">
<input type="hidden" name="poll" value="<%=p.poll%>">
<input type="hidden" name="act" >
<table class="PollResultView">
<%
Iterator it=Question.find(" AND poll="+p.poll+ " AND type!=10",0,200).iterator();
while(it.hasNext())
{
  Question q=(Question)it.next();
  out.print("<tr><th colspan='3'>"+q.name[1]+"</th></tr>");
  if(q.type<3)
  {
    int sum=DbAdapter.execute("SELECT SUM(hits) FROM "+Poll.PR+"Choice WHERE question="+q.question);
    Iterator ic=Choice.find(" AND question="+q.question,0,200).iterator();
    while(ic.hasNext())
    {
      Choice c=(Choice)ic.next();
      int perc=c.hits*100/Math.max(sum,1);
      out.print("<tr><td align='right' width='270'>"+c.name[1]+"</td><td width='130'><img src='/tea/image/poll/vote.gif' style='width:"+perc+"px;height:15px'/></td><td width='80'>"+c.hits+'　'+perc+'%'+"</td>");
    }
  }else
  {
    out.print("<tr><td colspan=3 class='PollResultArea'>");
    Iterator ia=Answer.find(" AND question="+q.question+" ORDER BY vote",0,2000).iterator();
    while(ia.hasNext())
    {
      Answer a=(Answer)ia.next();
      Vote v=Vote.find(a.vote);
      out.print((v.member<1?"游客":Profile.find(v.member).getMember())+"："+MT.f(a.content,"无")+"<br/>");
    }
    out.print("</td>");
  }
}
%>
<tr><th colspan="3"><input type="button" value="导出" onclick="f_excel();"></th></tr>
</table>
</form>
</body>
</html>
