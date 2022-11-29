<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@ page  import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession._strCommunity;

Resource r=new Resource("/tea/resource/Workreport");

StringBuffer param=new StringBuffer("&community="+community);
StringBuffer sql=new StringBuffer();
sql.append(" AND publicity=1 AND worklinkman=").append(DbAdapter.cite(teasession._rv._strV));



int workproject=0;
String _strWorkproject=request.getParameter("workproject");
if(_strWorkproject!=null&&_strWorkproject.length()>0)
{
  workproject=Integer.parseInt(_strWorkproject);
  param.append("&workproject=").append(workproject);
}

int worklinkman=0;
String _strWorklinkman=request.getParameter("worklinkman");
if(_strWorklinkman!=null&&_strWorklinkman.length()>0)
{
  worklinkman=Integer.parseInt(_strWorklinkman);
  param.append("&worklinkman=").append(worklinkman);
}

int worktype=0;
String _strWorktype=request.getParameter("worktype");
if(_strWorktype!=null&&_strWorktype.length()>0)
{
  worktype=Integer.parseInt(_strWorktype);
  param.append("&worktype=").append(worktype);
}

String time_s=request.getParameter("time_s");
String time_e=request.getParameter("time_e");

DbAdapter db=new DbAdapter();
try
{
	if(time_s!=null&&(time_s=time_s.trim()).length()>0)
	{
	  try
	  {
	    java.util.Date time=Worklog.sdf.parse(time_s);
	    sql.append(" AND time >=").append(db.cite(time));
	    param.append("&time_s=").append(java.net.URLEncoder.encode(time_s,"UTF-8"));
	  }catch(java.text.ParseException pe)
	  {}
	}
	if(time_e!=null&&(time_e=time_e.trim()).length()>0)
	{
	  try
	  {
	    java.util.Date time=Worklog.sdf.parse(time_e);
	    sql.append(" AND time <").append(db.cite(time));
	    param.append("&time_e=").append(java.net.URLEncoder.encode(time_e,"UTF-8"));
	  }catch(java.text.ParseException pe)
	  {}
	}
}finally
{
	db.close();
}

String content=request.getParameter("content");
if(content!=null&&(content=content.trim()).length()>0)
{
  sql.append(" AND content LIKE ").append(DbAdapter.cite("%"+content+"%"));
  param.append("&content=").append(java.net.URLEncoder.encode(content,"UTF-8"));
}


int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}

int count=Worklog.count(community,sql.toString());

param.append("&pos=").append(pos);

String order=request.getParameter("order");
if(order==null)
order="time";
param.append("&order=").append(order);

String desc=request.getParameter("desc");
if(desc==null)
desc="desc";
param.append("&desc=").append(desc);

sql.append(" ORDER BY ").append(order).append(" ").append(desc);

String nexturl=request.getRequestURI()+"?"+request.getQueryString();


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
<!--工作记录管理-->
<h1><%=r.getString(teasession._nLanguage,"1168593689875")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<h2><%=r.getString(teasession._nLanguage,"1168574879546")%><!--查询--></h2>
   <form name=form1 METHOD=get action="?" onSubmit="">
   <input type=hidden name="community" value="<%=community%>"/>
   <input type=hidden name="order" value="<%=order%>"/>
   <input type=hidden name="desc" value="<%=desc%>"/>
   <input type=hidden name="id" value="<%=request.getParameter("id")%>"/>

   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
     <%--
       <td><%=r.getString(teasession._nLanguage,"1168584443703")%>
         <select name="workproject" onchange="fchange(this.value);">
           <option value="">-------------</option>
           <%
           StringBuffer sb=new StringBuffer();
           java.util.Enumeration e=Workproject.find(teasession._strCommunity,"",0,Integer.MAX_VALUE);
           while(e.hasMoreElements())
           {
             int id=((Integer)e.nextElement()).intValue();
             Workproject obj=Workproject.find(id);
             out.print("<option value="+id);
             if(id==workproject)
             out.print(" SELECTED ");
             out.print(" >"+obj.getName(teasession._nLanguage));

             sb.append("case ").append(id).append(": ");
             java.util.Enumeration e2=Worklinkman.find(teasession._strCommunity," AND workproject="+id,0,Integer.MAX_VALUE);
             while(e2.hasMoreElements())
             {
               String worklinkman_id=((String)e2.nextElement());
              // Worklinkman worklinkman_obj=Worklinkman.find(worklinkman_id);
               sb.append("obj.options[obj.options.length]=new Option(\""+worklinkman_id+"\",\""+worklinkman_id+"\");");
             }
             sb.append("break;\r\n");
           }
           %>
           </select>
       </td>
         <td><%=r.getString(teasession._nLanguage,"1168584403266")%><select name="worklinkman"><option value="0">-------------</option></select>
           <script type="">
           function fchange(value)
           {
             var obj=form1.worklinkman;
             while(obj.options.length>1)
             {
               obj.options[1]=null;
             }
             switch(parseInt(value))
             {
               <%=sb.toString()%>
             }
           }
           fchange(form1.workproject.value);
           form1.worklinkman.value=<%=worklinkman%>;
           </script>
           </td>
           --%></tr><tr>
           <td><%=r.getString(teasession._nLanguage,"1168592903313")%>
             <select name="worktype">
               <option value="">-------------</option>
           <%
           java.util.Enumeration e3=Worktype.find(teasession._strCommunity,"",0,Integer.MAX_VALUE);
           while(e3.hasMoreElements())
           {
             int id=((Integer)e3.nextElement()).intValue();
             Worktype obj=Worktype.find(id);
             out.print("<option value="+id);
             if(id==worktype)
             out.print(" SELECTED ");
             out.print(" >"+obj.getName(teasession._nLanguage));
           }
           %>
           </select>
           </td>
           <td><%=r.getString(teasession._nLanguage,"Time")%><input name="time_s" size="7" onFocus="if(this.value=='yyyy-MM-dd')this.value='';" onBlur="if(this.value=='')this.value='yyyy-MM-dd';" value="<%if(time_s!=null)out.print(time_s);%>"><A href="###"><img onClick="showCalendar('form1.time_s');" src="/tea/image/public/Calendar2.gif" align="top"/></a> --
           <input name="time_e" size="7" onFocus="if(this.value=='yyyy-MM-dd')this.value='';" onBlur="if(this.value=='')this.value='yyyy-MM-dd';" value="<%if(time_e!=null)out.print(time_e);%>"><A href="###"><img onClick="showCalendar('form1.time_e');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
             <td><%=r.getString(teasession._nLanguage,"Text")%><input name="content" value="<%if(content!=null)out.print(content);%>"></td>
               <td><input type="submit" value="GO"/></td></tr>
   </table>
</form>

<br>
<form name=form2 METHOD=post action="/servlet/EditWorkreport" onSubmit="">
<input type=hidden name="community" value="<%=community%>"/>
<input type=hidden name="action" value="exportworklogs"/>
<input type=hidden name="nexturl">

<h2><%=r.getString(teasession._nLanguage,"1168575045718")+"( "+count+" )"%><!--列表--></h2>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
     <td nowrap width="1"></td>
     <td nowrap><!--时间-->
         <%
         if("time".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >"+r.getString(teasession._nLanguage,"Time")+" "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=time&"+param.toString()+" >"+r.getString(teasession._nLanguage,"Time")+"</a>");
         }
         %></td>
       <td nowrap>
         <%
         if("content".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >"+r.getString(teasession._nLanguage,"Text")+" "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=content&"+param.toString()+" >"+r.getString(teasession._nLanguage,"Text")+"</a>");
         }
         %></td>
         <td>&nbsp;</td>
       </tr>
     <%

     java.util.Enumeration enumer=Worklog.find(community,sql.toString(),pos,10);
     for(int index=1;enumer.hasMoreElements();index++)
     {
       int worklog=((Integer)enumer.nextElement()).intValue();
       Worklog obj=Worklog.find(worklog);

  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td width="1"><input name="worklog" type="checkbox" value="<%=worklog%>" /></td>
    <td>&nbsp;<%=obj.getTimeToString()%></td>
    <td>&nbsp;
    <%
    String log_content=obj.getContent(teasession._nLanguage).replaceAll("</","&lt;/");
    if(log_content.length()>25)
    out.print(log_content.replaceAll("\r\n","<br/>").replaceAll(" ","&nbsp;"));//&#39;
   // out.print("<textarea style=display:none id=content_"+worklog+" >"+log_content.replaceAll("\r\n","<br/>").replaceAll(" ","&nbsp;")+"</textarea><a href=\"javascript:var obj=window.open('','','height=250,width=500,left=400,top=300,scrollbars=yes,toolbar=no,status=no,menubar=no,location=no,resizable=yes');obj.document.write(document.getElementById('content_"+worklog+"').value);\" >"+log_content.substring(0,25)+"...</a>"); //&#39;
    else
    out.print(log_content);
    %>
    </td>
 </tr>
  <%
}
     %>
<tr>
  <td colspan="4"><input type="checkbox" onClick="if(form2.worklog){form2.worklog.checked=this.checked;for(var i=form2.worklog.length;i>0;i--)form2.worklog[i-1].checked=this.checked;}" /><%=r.getString(teasession._nLanguage,"1168828939928")%></td><td colspan="5" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,10)%></td>
</tr>
</table>
<!--=发送邮件
<input type="button" value="<%=r.getString(teasession._nLanguage,"1168829505147")%>" onClick="window.open('/jsp/admin/workreport/EditWorklog.jsp?community=<%=community%>&worklog=0&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self');">
-->
<!--导出-->
<input type="submit" value="<%=r.getString(teasession._nLanguage,"1168831858710")%>" >

</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>


