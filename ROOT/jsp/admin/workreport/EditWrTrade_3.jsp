<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.entity.node.*" %><%@ page  import="tea.resource.Resource"  %><%@ page import="java.math.*" %><%@ page  import="tea.entity.admin.*" %><%@ page  import="java.util.*" %><%@ page  import="tea.entity.*" %><%@ page  import="tea.entity.member.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession._strCommunity;

Resource r=new Resource("/tea/resource/Workreport");

String member=request.getParameter("member");

int worklog=0;
if(request.getParameter("worklog")!=null)
{
  worklog=Integer.parseInt(request.getParameter("worklog"));
}
int workproject=0,worktype=0,goods=0;
boolean publicity=false;
String content=null,time=null,worklinkman=null;
if(worklog>0)
{
  Worklog obj=Worklog.find(worklog);
  workproject=obj.getWorkproject();
  worklinkman=obj.getWorklinkman();
  worktype=obj.getWorktype();
  publicity=obj.isPublicity();
  time=obj.getTimeToString();
  content=obj.getContent(teasession._nLanguage);
}else
{
  time=Worklog.sdf.format(new java.util.Date());
}

String nexturl=request.getParameter("nexturl");
if(nexturl==null)
nexturl="/jsp/admin/workreport/EditWrTrade_2.jsp?community="+community+"&node="+teasession._nNode+"&member="+java.net.URLEncoder.encode(member,"UTF-8");

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
<body onLoad="form1.squantity.focus();">
<!--新建/编辑销售记录-->
<h1><%=r.getString(teasession._nLanguage,"1169451073098")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

   <form name="form1" METHOD="post" action="/servlet/EditWorkreport" onSubmit="return submitText(this.goods,'<%=r.getString(teasession._nLanguage,"Goods")%>')&&submitInteger(this.squantity,'<%=r.getString(teasession._nLanguage,"Quantity")%>');">
     <input type=hidden name="community" value="<%=community%>"/>
     <input type=hidden name="member" value="<%=member%>"/>
     <input type=hidden name="worklog" value="<%=worklog%>"/>
     <input type=hidden name="nexturl" value="<%=nexturl%>"/>
     <input type=hidden name="action" value="editwrtrade"/>


   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

           <tr><td><%=r.getString(teasession._nLanguage,"Goods")%></td>
             <td>
               <select name="goods">
                 <option value="">-------------</option>
                 <%
                 java.util.Enumeration e3=Node.findByType(34,teasession._strCommunity);
                 while(e3.hasMoreElements())
                 {
                   int id=((Integer)e3.nextElement()).intValue();
                   Node obj=Node.find(id);
                   out.print("<option value="+id);
                   if(id==goods)
                   out.print(" SELECTED ");
                   out.print(" >"+obj.getSubject(teasession._nLanguage));
                 }
           %>
               </select>
               <input name="button" type="button" onClick="window.open('/jsp/admin/workreport/WrGoods_2.jsp?community=<%=teasession._strCommunity%>&fieldname=form1.goods','','height=500,width=500,left=200,top=100,scrollbars=yes,toolbar=no,status=no,menubar=no,location=no,resizable=yes');" value="..."/>
             </td>
</tr>

	<tr><td><%=r.getString(teasession._nLanguage,"Time")%></td>
     <td><input name="time" onFocus="if(this.value=='yyyy-MM-dd')this.value='';" onBlur="if(this.value=='')this.value='yyyy-MM-dd';" value="<%if(time!=null)out.print(time);else{out.print("yyyy-MM-dd");}%>"><A href="#"><img onClick="showCalendar('form1.time');" src="/tea/image/public/Calendar2.gif" align="top"/></a></td></tr>

     <tr><td><%=r.getString(teasession._nLanguage,"Quantity")%></td>
       <td><input type="text" name="squantity" value="0"></td></tr>
   </table>

   <input type="submit" value="<%=r.getString(teasession._nLanguage,"Submit")%>"  onclick="">
   <input type="button" value="<%=r.getString(teasession._nLanguage,"CBBack")%>" onClick="history.back();" >
</form>


<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>



