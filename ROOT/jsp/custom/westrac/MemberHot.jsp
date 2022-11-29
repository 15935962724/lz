<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page import="java.util.*" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.bbs.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.entity.*" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><%


Http h=new Http(request);

Iterator it=ProfileBBS.find(" AND community="+DbAdapter.cite(h.community)+" AND member!='<ANONYMITY>' ORDER BY post+reply DESC",0,10).iterator();
for(int i=1;it.hasNext();i++)
{
  String m=(String)it.next();
  ProfileBBS mb=ProfileBBS.find(h.community,m);
  out.print("<li class='min' onmouseover='mt.hot(this)' id='hot"+i+"'><table border=0 cellspacing=0 cellpadding=0><tr><td class=td01>"+(i<10?"0":"")+i+"</td><td class=td02>"+m+"</td></tr></table></li>");
  out.print("<li class='max' style='display:none' id='hotter"+i+"'><table border=0 cellspacing=0 cellpadding=0><tr><td class=td01>"+(i<10?"0":"")+i+"</td><td class=td02><a href='/html/folder/3-1.htm?member="+Http.enc(m)+"'><img style=float:left  src='"+mb.getPortrait(h.language)+"' width=30 height=30>发贴:"+mb.post+"<br/>回复:"+mb.reply+"</a></td></tr></table></li>");
}
%>
<script>
var hot;
mt.hot=function(a)
{
  if(hot)
  {
    hot.style.display='';
    hot.nextSibling.style.display='none';
  }
  (hot=a).style.display='none';
  a.nextSibling.style.display='';
}
mt.hot($('hot1'));
</script>
