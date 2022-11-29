<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page import="java.util.*" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.bbs.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.entity.*" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><%


Http h=new Http(request);

StringBuilder sb=new StringBuilder();

Enumeration e=Profile.find(" AND member NOT IN('webmaster','admin','admin1','admin2','admin3','admin4','admin5') AND time>'2011-11-01' ORDER BY integral DESC",0,8);
for(int i=1;e.hasMoreElements();i++)
{
  String m=(String)e.nextElement();
  ProfileBBS mb=ProfileBBS.find(h.community,m);
  Profile p=Profile.find(m);

  sb.append("<li id='hotter"+i+"'><table border=0 cellspacing=0 cellpadding=0><tr><td class=td01>"+(i<10?"0":"")+i+"</td><td class=td02><a href='/html/folder/3-1.htm?member="+Http.enc(m)+"'><img style=float:left src='"+mb.getPortrait(h.language)+"' width=30 height=30>用户名："+MT.f(m,7)+"<br/>工　分："+(int)p.getIntegral()+"<br/>发贴数："+(mb.post+mb.reply)+"</a></td></tr></table></li>");
}
%>
document.write("<%=sb.toString()%>");
