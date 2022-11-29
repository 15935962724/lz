<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@ page  import="tea.entity.admin.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.ui.TeaSession" %><%

request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String tmp;

String community=teasession._strCommunity;

Resource r=new Resource("/tea/resource/Workreport");

StringBuffer param=new StringBuffer("&community="+community);
StringBuffer sql=new StringBuffer();
//sql.append(" AND member=").append(DbAdapter.cite(teasession._rv._strV));

String menu_id=(request.getParameter("id"));
if(menu_id!=null&&menu_id.length()>0)
{
  param.append("&id=").append(menu_id);
}

int workproject=0;
String _strWorkproject=request.getParameter("workproject");
if(_strWorkproject!=null&&_strWorkproject.length()>0)
{
  workproject=Integer.parseInt(_strWorkproject);
  sql.append(" AND workproject=").append(workproject);
  param.append("&workproject=").append(workproject);
}

String worklinkman=request.getParameter("worklinkman");
if(worklinkman!=null&&worklinkman.length()>0)
{
  sql.append(" AND worklinkman=").append(DbAdapter.cite(worklinkman));
  param.append("&worklinkman=").append(worklinkman);
}

int worktype=0;
String _strWorktype=request.getParameter("worktype");
if(_strWorktype!=null&&_strWorktype.length()>0)
{
  worktype=Integer.parseInt(_strWorktype);
  sql.append(" AND worktype=").append(worktype);
  param.append("&worktype=").append(worktype);
}

DbAdapter db=new DbAdapter();
String time_s=request.getParameter("time_s");
String time_e=request.getParameter("time_e");
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

sql.append("and  problemreport =1 ");

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
out.println("<!-- "+sql.toString()+" -->");
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script type="">
function fload()
{
  var tr_today=document.all('tr_today');
  if(tr_today==null)
  {
    document.getElementById('tr_today_select').style.display='none';
  }else
  {
    if(!tr_today.length)
    {
      tr_today.parentElement.moveRow(tr_today.rowIndex,1);
    }else
    {
      for(var i=0;i<tr_today.length;i++)
      {
        var obj=tr_today[i];
        obj.parentElement.moveRow(obj.rowIndex,1);
      }
    }
  }
}
function submitCheck()
{
    if(form2.worklog.checked)
        return true;
	for(var i=0;i<form2.worklog.length;i++)
	{
		if(form2.worklog[i].checked)
			return true;
	}
	alert('无效选择');
	return false;
}
</script>
</head>
<body onLoad="fload();">
<!--工作记录管理-->
<h1><%=r.getString(teasession._nLanguage,"1168593689875")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<h2><%=r.getString(teasession._nLanguage,"1168574879546")%><!--查询--></h2>
   <form name=form1 METHOD=get action="?" >
   <input type=hidden name="community" value="<%=community%>"/>
   <input type=hidden name="order" value="<%=order%>"/>
   <input type=hidden name="desc" value="<%=desc%>"/>
   <input type=hidden name="id" value="<%=request.getParameter("id")%>"/>

   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td><%=r.getString(teasession._nLanguage,"1168584443703")%>
         <select name="workproject" onChange="fchange(this.value);">
           <option value="">-------------</option>
           <%
           StringBuffer sb=new StringBuffer();
           java.util.Enumeration fme = Flowitem.find(teasession._strCommunity,"");
           while(fme.hasMoreElements())
           {
           		int fid =((Integer)fme.nextElement()).intValue();
           		Flowitem fobj = Flowitem.find(fid);
           		out.print("<option value="+fid);

          		if(fid==workproject)
	           		out.print(" selected");
           		out.print(">"+fobj.getName(teasession._nLanguage));


           		 sb.append("case ").append(fid).append(": ");

             java.util.Enumeration e2=Worklinkman.find(teasession._strCommunity," AND workproject="+fobj.getWorkproject(),0,Integer.MAX_VALUE);
             while(e2.hasMoreElements())
             {
               String member_e=((String)e2.nextElement());
               //Worklinkman worklinkman_obj=Worklinkman.find(teasession._strCommunity,member_e);
               sb.append("obj.options[obj.options.length]=new Option(\""+member_e+"\",\""+member_e+"\");");
             }
             sb.append("break;\r\n");
           }


           %>
           </select>
       </td><!-- 联系人 -->
         <td><%=r.getString(teasession._nLanguage,"1168584403266")%><select name="worklinkman"><option value="">-------------</option></select>
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
           <%
           if(worklinkman!=null)
              out.print("form1.worklinkman.value=\""+worklinkman+"\";");
           %>
           </script>
           </td>
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
           </td></tr><tr>
           <td><%=r.getString(teasession._nLanguage,"Time")%><input name="time_s" size="7" onFocus="if(this.value=='yyyy-mm-dd')this.value='';" onBlur="if(this.value=='')this.value='yyyy-mm-dd';" value="<%if(time_s!=null)out.print(time_s);%>"><A href="###"><img onClick="showCalendar('form1.time_s');" src="/tea/image/public/Calendar2.gif" align="top"/></a> --
           <input name="time_e" size="7" onFocus="if(this.value=='yyyy-mm-dd')this.value='';" onBlur="if(this.value=='')this.value='yyyy-mm-dd';" value="<%if(time_e!=null)out.print(time_e);%>"><A href="###"><img onClick="showCalendar('form1.time_e');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
             <td><%=r.getString(teasession._nLanguage,"Text")%><input name="content" value="<%if(content!=null)out.print(content);%>"></td>
               <td><input type="submit" value="GO"/></td></tr>
   </table>
</form>
<br>



<form name=form2 METHOD=get action="/jsp/admin/workreport/SendWorklog.jsp" >
<input type=hidden name="community" value="<%=community%>"/>
<input type=hidden name="nexturl" value="<%=nexturl%>"/>
<input type=hidden name="action" value="exportworklogs"/>


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
       <td nowrap>
         <%
         if("workproject".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >"+r.getString(teasession._nLanguage,"1168584443703")+" "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=workproject&"+param.toString()+" >"+r.getString(teasession._nLanguage,"1168584443703")+"</a>");
         }
         %></td>
         <td nowrap><%
         if("worklinkman".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >"+r.getString(teasession._nLanguage,"1168584403266")+" "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=worklinkman&"+param.toString()+" >"+r.getString(teasession._nLanguage,"1168584403266")+"</a>");
         }
         %></td>
         <td nowrap><%
         if("worktype".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >"+r.getString(teasession._nLanguage,"1168592903313")+" "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=worktype&"+param.toString()+" >"+r.getString(teasession._nLanguage,"1168592903313")+"</a>");
         }
         %></td>
         <td nowrap>
         <%
         if("revertquestion".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >"+r.getString(teasession._nLanguage,"问题回复")+" "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=revertquestion&"+param.toString()+" >"+r.getString(teasession._nLanguage,"问题回复")+"</a>");
         }
         %>
         </td>
          <td nowrap><%
         if("publicity".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >"+r.getString(teasession._nLanguage,"1168595223953")+" "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=publicity&"+param.toString()+" >"+r.getString(teasession._nLanguage,"1168595223953")+"</a>");
         }
         %></td>
         <td></td>
       </tr>
       <tr id="tr_today_select"><td colspan="5"><input type="checkbox" onClick="if(form2.worklog){ if(form2.worklog.id=='cb_today')form2.worklog.checked=this.checked; for(var i=form2.worklog.length;i>0;i--)if(form2.worklog[i-1].id=='cb_today')form2.worklog[i-1].checked=this.checked; }" /><%=r.getString(teasession._nLanguage,"1168828939928")%></td></tr>
       <tr><td colspan="8" align="center">
       <!--=发送邮件-->
<input type="submit" value="<%=r.getString(teasession._nLanguage,"1168829505147")%>" onClick="if(window.Event){form2.action='/jsp/admin/workreport/SendWorklog.jsp';}else{form2.attributes[83].value='/jsp/admin/workreport/SendWorklog.jsp'; } return submitCheck();" >

<!--导出-->
<input type="submit" value="<%=r.getString(teasession._nLanguage,"1168831858710")%>" onClick="if(window.Event){form2.action='/servlet/EditWorkreport';}else{form2.attributes[83].value='/servlet/EditWorkreport'; } return submitCheck();" >

<input type="button" value="<%=r.getString(teasession._nLanguage,"Add")%>" onClick="window.open('/jsp/admin/workreport/EditWorklog.jsp?community=<%=community%>&worklog=0&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self');">

       </td></tr>
     <%
     StringBuffer html=new StringBuffer();
     String date_cu=Worklog.sdf.format(new java.util.Date());
     java.util.Enumeration enumer=Worklog.find(community,sql.toString(),pos,30);
     for(int index=1;enumer.hasMoreElements();index++)
     {

       int worklog=((Integer)enumer.nextElement()).intValue();
       Worklog obj=Worklog.find(worklog);
       workproject=obj.getWorkproject();
       html.append("<tr onMouseOver=\"javascript:this.bgColor='#BCD1E9';\" onMouseOut=\"javascript:this.bgColor='';\" ");
       if(obj.getTimeToString().equals(date_cu))
       {
         html.append(" id=tr_today >");
         html.append("<td width=\"1\"><input name=\"worklog\" type=\"checkbox\" value=\""+worklog+"\" id=cb_today /></td>");
       }else
       {
         html.append(">");
         html.append("<td width=\"1\"><input name=\"worklog\" type=\"checkbox\" value=\""+worklog+"\" /></td>");
       }

       html.append("<td nowrap>&nbsp;"+obj.getTimeToString()+"</td>");

       html.append("<td>&nbsp;");
       String log_content=obj.getContent(teasession._nLanguage).replaceAll("</","&lt;/");
       if(log_content.length()>25)
       html.append("<textarea style=display:none id=content_"+worklog+" >"+log_content.replaceAll("\r\n","<br/>").replaceAll(" ","&nbsp;")+"</textarea>"+log_content);//&#39;
       else
       html.append(log_content);
       html.append("</td>");

       html.append("<td>&nbsp;");

       if(obj.getWorkproject()>0)//客户于项目
       //html.append(Workproject.find(obj.getWorkproject()).getName(teasession._nLanguage));
       html.append(Flowitem.find(obj.getWorkproject()).getName(teasession._nLanguage));
       html.append("</td>");

       html.append("<td>&nbsp;");
       if(obj.getWorklinkman()!=null)
       html.append(obj.getWorklinkman());
       html.append("</td>");

       html.append("<td>&nbsp;");
       //       if(obj.getWorktype()>0)
       //       html.append(Worktype.find(obj.getWorktype()).getName(teasession._nLanguage));
       if(workproject>0)//客户与项目
       {
         //html.append(Workproject.find(obj.getWorkproject()).getName(teasession._nLanguage));
         Flowitem fi=Flowitem.find(workproject);
         if(fi.isExists())
         {
           html.append(fi.getName(teasession._nLanguage));
         }
       }
       html.append("</td>");

       //问题回复
       html.append("<td>&nbsp;");
       String revertquestion=obj.getRevertQuestion();
       if(revertquestion!=null)
       {
         revertquestion=revertquestion.replaceAll("</","&lt;/");
         if(revertquestion.length()>25)
         {
           html.append("<textarea style=display:none id=content_"+worklog+" >"+revertquestion.replaceAll("\r\n","<br/>").replaceAll(" ","&nbsp;")+"</textarea>"+revertquestion);//&#39;
         }else
         {
           String members = "";
           if(obj.getRevertmember()!=null && obj.getRevertmember().length()>0)
           {
             Profile objpro = Profile.find(obj.getRevertmember());

             members="/"+objpro.getName(teasession._nLanguage);
           }
           html.append(revertquestion+members);
         }
       }
       html.append("</td>");



       html.append("<td>&nbsp;").append(obj.isPublicity()?"√":"X").append("</td>");
       html.append("<td><input type=button value="+r.getString(teasession._nLanguage,"CBEdit")+" onClick=\"window.open('/jsp/admin/workreport/EditWorklog.jsp?community="+community+"&worklog="+worklog+"&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8")+"','_self');\">");
       html.append("<input type=button value="+r.getString(teasession._nLanguage,"CBDelete")+" onClick=\"if(confirm('"+r.getString(teasession._nLanguage,"ConfirmDelete")+"')){window.open('/servlet/EditWorkreport?community="+community+"&worklog="+worklog+"&action=deleteworklog&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8")+"','_self'); this.disabled=true;}\"></td></tr>");

     }
     out.print(html.toString());
%>
<tr><td colspan="2"><input type="checkbox" onClick="if(form2.worklog){ if(form2.worklog.id!='cb_today') form2.worklog.checked=this.checked;for(var i=form2.worklog.length;i>0;i--)if(form2.worklog[i-1].id!='cb_today')form2.worklog[i-1].checked=this.checked; }" /><%=r.getString(teasession._nLanguage,"1168828939928")%></td>
  <td colspan="5" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,30)%></td></tr>
</table>

</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>


