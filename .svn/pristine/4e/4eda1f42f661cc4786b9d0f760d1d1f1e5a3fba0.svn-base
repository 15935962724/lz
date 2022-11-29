<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.*" %><%@page import="tea.resource.*"%><%@page import="java.util.*" %><%@page import="tea.entity.*" %><%@page import="tea.entity.node.*" %><%



Http h=new Http(request,response);

Node n=Node.find(h.node);

String tmp=h.get("lang");
if(tmp!=null)h.language=Integer.parseInt(tmp);

Resource r = new Resource();

//2011-04-07 用 于 cec oa

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查看结票结果</title>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<script>
//导出
function f_excel()
{
  if(confirm("您确定要导出数据吗?"))
  {
	  
    form1.action='/PollVotes.do'; 
    form1.act.value='exp';
    form1.submit();
  }
}
</script>
<body topmargin="0" leftmargin="0" marginheight="0" marginwidth="0" scroll="yes">
<%
/*
Vector v=n.getLanguages();
if(v.size()==1)
  h.language=((Integer)v.get(0)).intValue();
else for(int i=0;i<v.size();i++)
{
  int j=((Integer)v.get(i)).intValue();
  out.print("<a href='?node="+h.node+"&lang="+j+"'>"+r.getString(h.language,Common.LANGUAGE[j])+"</a>　");
}

*/
%>
<div id="language"><%=new tea.htmlx.Languages(h.language,request)%></div>
<form action="?" method="get" name="form1">
<input type="hidden" name="node" value="<%=h.node %>">
<input type="hidden" name="community" value="<%=h.community%>">
<input type="hidden" name="act" >
<input type="hidden" name="files" value="调查结果导出"/>
<table class="PollResultView">
<%

Enumeration e=Poll.findByNode(h.node,h.language,0,200);
for(int i=1;e.hasMoreElements();i++)
{
  int pid=((Integer)e.nextElement()).intValue();
  Poll p=Poll.find(pid);
  int ptype=p.getType();
  out.print("<tr><th colspan='3'>"+p.getQuestion()+"</th></tr>");
  if(ptype==2||ptype==3)
  {
    out.print("<tr><td colspan=3 class='PollResultArea'>");
    Iterator it=PollVoteList.find(" AND poll=" + pid + " ORDER BY pollvote",0,2000).iterator();
    while(it.hasNext())
    {
      PollVoteList pvl=(PollVoteList)it.next();
      out.print(MT.f(PollVote.find(pvl.pollvote).member,"游客") + "：" + MT.f(pvl.answer,"无")+"<br/>");
    }
    out.print("</td>");
  }else
  {
    int sum=DbAdapter.execute("SELECT SUM(sorting) FROM PollChoice WHERE poll=" + pid);
    Enumeration ec=PollChoice.findByPoll(pid,0,200);
    while(ec.hasMoreElements())
    {
      int id=((Integer)ec.nextElement()).intValue();
      PollChoice pc=PollChoice.find(id);
      int hits=pc.getSorting(),perc=hits*100/Math.max(sum,1);
      out.print("<!--"+id+"-->");
      %>
      <tr><td align="right" width="270"><%=pc.getTitle()%></td><td width="130"><img src="<%=MT.f(p.getPicture(),"/tea/image/other/bar2.gif")%>" style="width:<%=perc%>px;height:15px"/></td><td width="80"><%=hits+"　"+perc+"%"%></td>
        <%
    }
  }
}
%>
<tr><th colspan="3"><input type="button" value="导出" onclick="f_excel();"></th></tr>
</table>
</form>
</body>
</html>
