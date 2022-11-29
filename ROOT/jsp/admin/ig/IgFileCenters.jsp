<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="java.util.*"%>
<%@page import="java.net.*"%>
<%@page import="java.io.*"%>
<%@page import="tea.entity.netdisk.*"%>
<%@page import="tea.entity.admin.*"%><%@page import="tea.entity.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.ui.TeaSession"%><%
request.setCharacterEncoding("UTF-8");



Http h=new Http(request);

int filecenter=h.getInt("filecenter");


//FileCenter obj=FileCenter.find(filecenter);
//Enumeration e=FileCenter.find(teasession._strCommunity," AND father="+filecenter,null,false);
//while(e.hasMoreElements())
//{
//  int id=((Integer)e.nextElement()).intValue();
//  FileCenter nd=FileCenter.find(id);
//}


StringBuffer sb=new StringBuffer();
Enumeration e2=FileCenterAttach.findByFileCenter(filecenter);
while(e2.hasMoreElements())
{
  int fcaid=((Integer)e2.nextElement()).intValue();
  FileCenterAttach fca=FileCenterAttach.find(fcaid);
  out.print("<li><img src=/tea/image/netdisk/"+fca.getEx()+".gif align=absmiddle style=margin-right:5px;width:16px; onerror=src='/tea/image/netdisk/default.gif';onerror=null;><a href='/servlet/EditFileCenter?act=download&filecenter="+filecenter+"&filecenterattach="+fcaid+"'>"+fca.getName()+"</a>　"+(fca.getFileSize()/1024)+" KB");
}

%>
