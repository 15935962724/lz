<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.node.type.mpoll.*" %><%@page import="tea.entity.*" %><%@page import="java.util.*" %><%@page import="tea.db.DbAdapter"%><% request.setCharacterEncoding("UTF-8");

Http h=new Http(request);
Poll p=Poll.find(h.getInt("poll"));

String title=h.get("title");
ArrayList al=Vote.find(" AND v.poll="+p.poll+" AND v.total>="+p.score+" AND v.winning=0 AND v.random>rand() ORDER BY v.random",0,h.getInt("size"));

StringBuilder htm=new StringBuilder();
out.print("<form name='form2' action='/MVotes.do' method='post' target='_ajax'>");
out.print("<input type='hidden' name='act' value='expquestion' />");
out.print("<input type='hidden' name='poll' value='"+p.poll+"' />");
out.print("<input type='hidden' name='title' value='"+title+"' />");
out.print("<input type='hidden' name='question' value='|13104408|13104395|13105109|13104399|13104405|13104394|13104409|13105054|' />");
out.print("<div class='lottery_title'>"+title+"</div><div class='lottery_list'><ul>");
out.print("<li><span class='seq'>序号</span><span class='name'>姓名</span><span class='sex'>性别</span><span class='area'>地区</span><span class='style'>证件类型</span><span class='number'>证件号</span><span class='pro'>职业</span></li>");
StringBuilder ids=new StringBuilder("|");
for(int i=0;i<al.size();i++)
{
  Vote v=(Vote)al.get(i);
  HashMap hm=Answer.findByVote(v.vote);

  ids.append(v.vote).append("|");
  out.print("<li><span class='seq'>"+(i+1)+"</span>");

  Answer a=(Answer)hm.get(new Integer(13104408));
  out.print("<li><span class='name'>"+a.getContent()+"</span>");

  a=(Answer)hm.get(new Integer(13104395));
  out.print("<span class='sex'>"+a.getContent()+"</span>");

  a=(Answer)hm.get(new Integer(13105109));
  out.print("<span class='area'>"+a.getContent()+"</span>");

  a=(Answer)hm.get(new Integer(13104399));
  out.print("<span class='style'>"+a.getContent()+"</span>");

  a=(Answer)hm.get(new Integer(13104405));
  out.print("<span class='number'>"+a.getContent()+"</span>");

  a=(Answer)hm.get(new Integer(13104394));
  out.print("<span class='pro'>"+a.getContent()+"</span></li>");

  //a=(Answer)hm.get(new Integer(13104409));
  //out.print("<span class='add'>"+a.getContent()+"</span>");

  //a=(Answer)hm.get(new Integer(13105054));
  //out.println("<span class='code'>"+a.getContent()+"</span>");
}
out.print("<input name='votes' type='hidden' value='"+ids.toString()+"' /></form></ul></div>");
%>

<!--
document.write("<%//=htm.toString().replaceAll("\\\\","\\\\\\\\").replaceAll("\"","\\\\\"")%>");
-->
