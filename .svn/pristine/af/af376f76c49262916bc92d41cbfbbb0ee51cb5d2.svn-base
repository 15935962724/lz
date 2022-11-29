<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String community=request.getParameter("community");
String NOTIFY_TYPE = request.getParameter("NOTIFY_TYPE");


%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>
<%
  if(NOTIFY_TYPE.equals("1")){
 %>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
     <td nowrap>发布人</td>
         <td nowrap>标题</td>
         <td nowrap>附件文件</td>
         <td nowrap>发布时间</td>
       </tr>
       <%
java.util.Enumeration enumer = Bulletin.findByCommunity(teasession._strCommunity," and type=1 and (naught =2 or naught2=2) ");

if(!enumer.hasMoreElements())
{
	out.print("<tr><td><font color=red><b>暂无全体公告</b></font></td></tr>");
}else
       		while(enumer.hasMoreElements())
       		{
       			int id = ((Integer)enumer.nextElement()).intValue();
       			Bulletin obj = Bulletin.find(id);
       			String bu[] = obj.getBulletin().split(",");
        %>
       <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
		    <td nowrap><a href="/jsp/admin/flow/BulletinContent.jsp?community=<%=community %>"  target="_blank"><%=obj.getMember() %></a></td>
		     <td nowrap><a href="/jsp/admin/flow/BulletinContent.jsp?community=<%=community %>&id=<%=id %>"  target="_blank"><%
               if(obj.getNotread()==0){
            out.print("<B>");
            out.print(obj.getCaption());
            out.print("</B>");
          }else
          {
            out.print(obj.getCaption());
          }

             %></a></td>
		    <td nowrap>
				<%

		    	String a[] =obj.getAcceefile().split("#");
		    	String b[] = obj.getAcceefilename().split("#");
		   		 for(int i=1;i<a.length;i++)
		  		{
		  			if(a[i]!=null ){
						out.print("<a href =\"/jsp/include/DownFile.jsp?uri="+java.net.URLEncoder.encode(b[i],"UTF-8")+"&name="+java.net.URLEncoder.encode(a[i],"UTF-8")+"\">"+a[i]+"</a><br>");
					}
		  		}
   			 %>
			　</td>
		     <td nowrap><%=obj.getIssuetime() %></td>
    </tr>
    <%
    	}//while循环

     %>
</table>
<%
	}
	if(NOTIFY_TYPE.equals("2")){
 %>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
     <td nowrap>发布人</td>
         <td nowrap>标题</td>
         <td nowrap>附件文件</td>
         <td nowrap>发布时间</td>
       </tr>
<%


AdminUsrRole adobj = AdminUsrRole.find(teasession._strCommunity,teasession._rv.toString());

StringBuffer sql=new StringBuffer(" and type=1 and naught =1 and  naught2=1 and (");
String aa[] = adobj.getRole().split("/");//当然用户的角色
for(int i=0;i<aa.length;i++)
{
	sql.append("   partid like '%/"+aa[i]+"/%' or ");
}
sql.append("  bulletinid like '%/"+adobj.getUnit()+"/%')");

java.util.Enumeration enumer = Bulletin.findByCommunity(teasession._strCommunity,sql.toString());
if(!enumer.hasMoreElements())
{
	out.print("<tr><td><font color=red><b>暂无部门公告</b></font></td></tr>");
}else
       		while(enumer.hasMoreElements())
       		{
       			int id = ((Integer)enumer.nextElement()).intValue();
       			Bulletin obj = Bulletin.find(id);
       			String bu[] = obj.getBulletin().split(",");
        %>
       <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
		    <td nowrap><a href="/jsp/admin/flow/BulletinContent.jsp?community=<%=community %>"  target="_blank"><%=obj.getMember() %></a></td>
		     <td nowrap><a href="/jsp/admin/flow/BulletinContent.jsp?community=<%=community %>&id=<%=id %>"  target="_blank"><%
               if(obj.getNotread()==0){
            out.print("<B>");
            out.print(obj.getCaption());
            out.print("</B>");
          }else
          {
            out.print(obj.getCaption());
          }
             %></a></td>
		    <td nowrap>
				<%

		    	String a[] =obj.getAcceefile().split("#");
		    	String b[] = obj.getAcceefilename().split("#");
		   		 for(int i=1;i<a.length;i++)
		  		{
		  			if(a[i]!=null ){
						out.print("<a href =\"/jsp/include/DownFile.jsp?uri="+java.net.URLEncoder.encode(b[i],"UTF-8")+"&name="+java.net.URLEncoder.encode(a[i],"UTF-8")+"\">"+a[i]+"</a><br>");
					}
		  		}
   			 %>
			　</td>
		     <td nowrap><%=obj.getIssuetime() %></td>
    </tr>
    <%
    	}//while循环

     %>
</table>
<%
	}
 %>
</body>
</HTML>



