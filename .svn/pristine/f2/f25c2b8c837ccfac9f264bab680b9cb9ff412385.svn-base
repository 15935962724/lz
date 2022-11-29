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
sql.append(" AND member=").append(DbAdapter.cite(teasession._rv._strV));

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

int teltype=-1;
String _strWorktype=request.getParameter("teltype");
if(_strWorktype!=null&&_strWorktype.length()>0)
{
  teltype=Integer.parseInt(_strWorktype);
  sql.append(" AND teltype=").append(teltype);
  param.append("&teltype=").append(teltype);
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
	    java.util.Date time=Worktel.sdf.parse(time_s);
	    sql.append(" AND ctime >=").append(db.cite(time));
	    param.append("&time_s=").append(java.net.URLEncoder.encode(time_s,"UTF-8"));
	  }catch(java.text.ParseException pe)
	  {}
	}
	if(time_e!=null&&(time_e=time_e.trim()).length()>0)
	{
	  try
	  {
	    java.util.Date time=Worktel.sdf.parse(time_e);
	    sql.append(" AND ctime <").append(db.cite(time));
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

int count=Worktel.count(community,sql.toString());

param.append("&pos=").append(pos);

String order=request.getParameter("order");
if(order==null)
order="ctime";
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
<script type="">
function fload()
{/*
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
  }*/
}
</script>
</head>
<body onLoad="fload();">
<!--1170212391937=电话记录管理-->
<h1><%=r.getString(teasession._nLanguage,"1170212391937")%></h1>
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
       <td><%=r.getString(teasession._nLanguage,"1168584443703")%>
         <select name="workproject" onChange="fchange(this.value);">
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
               String member_e=((String)e2.nextElement());
               //Worklinkman worklinkman_obj=Worklinkman.find(teasession._strCommunity,member_e);
               sb.append("obj.options[obj.options.length]=new Option(\""+member_e+"\",\""+member_e+"\");");
             }
             sb.append("break;\r\n");
           }
           %>
           </select>
       </td>
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
             <select name="teltype">
               <option value="">-------------</option>
           <%
             out.print("<option value=1");
             if(1==teltype)
             out.print(" SELECTED ");
             out.print(" > "+r.getString(teasession._nLanguage,"1170212958984"));

             out.print("<option value=0");
             if(0==teltype)
             out.print(" SELECTED ");
             out.print(" > "+r.getString(teasession._nLanguage,"1170212966468"));
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



<form name=form2 METHOD=get action="/jsp/admin/workreport/SendWorktel.jsp" onSubmit="">
<input type=hidden name="community" value="<%=community%>"/>
<input type=hidden name="nexturl" value="<%=nexturl%>"/>
<input type=hidden name="action" value="exportworktels"/>


<h2><%=r.getString(teasession._nLanguage,"1168575045718")+"( "+count+" )"%><!--列表--></h2>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
     <td nowrap width="1">　</td>
     <td nowrap><!--时间-->
         <%
         if("ctime".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >"+r.getString(teasession._nLanguage,"Time")+" "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=ctime&"+param.toString()+" >"+r.getString(teasession._nLanguage,"Time")+"</a>");
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
         if("teltype".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >"+r.getString(teasession._nLanguage,"1168592903313")+" "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=teltype&"+param.toString()+" >"+r.getString(teasession._nLanguage,"1168592903313")+"</a>");
         }
         %></td>
         <td nowrap><%
         if("imember".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >"+r.getString(teasession._nLanguage,"1170213683406")+" "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=imember&"+param.toString()+" >"+r.getString(teasession._nLanguage,"1170213683406")+"</a>");
         }
         %></td>
         <!--1170217759890=是否修改过/修改时间-->
         <td nowrap><%=r.getString(teasession._nLanguage,"1170217759890")%></td>
         <td>　</td>
       </tr>


     <%
     StringBuffer html=new StringBuffer();
     String date_cu=Worktel.sdf.format(new java.util.Date());
     java.util.Enumeration enumer=Worktel.find(community,sql.toString(),pos,30);
     for(int index=1;enumer.hasMoreElements();index++)
     {
       int worktel=((Integer)enumer.nextElement()).intValue();
       Worktel obj=Worktel.find(worktel);

       html.append("<tr onMouseOver=\"javascript:this.bgColor='#BCD1E9';\" onMouseOut=\"javascript:this.bgColor='';\" ");
       if(obj.getCtimeToString().equals(date_cu))
       {
         html.append(" id=tr_today >");
         html.append("<td width=\"1\"><input name=\"worktel\" type=\"checkbox\" value=\""+worktel+"\" id=cb_today /></td>");
       }else
       {
         html.append(">");
         html.append("<td width=\"1\"><input name=\"worktel\" type=\"checkbox\" value=\""+worktel+"\" /></td>");
       }

       html.append("<td noWrap>&nbsp;"+obj.getCtimeToString()+"</td>");

       html.append("<td>&nbsp;");
       String log_content=obj.getContent(teasession._nLanguage).replaceAll("</","&lt;/");
       if(log_content.length()>25)
       html.append("<textarea style=display:none id=content_"+worktel+" >"+log_content.replaceAll("\r\n","<br/>").replaceAll(" ","&nbsp;")+"</textarea><a href=\"javascript:var obj=window.open('','','height=250,width=500,left=400,top=300,scrollbars=yes,toolbar=no,status=no,menubar=no,location=no,resizable=yes');obj.document.write(document.getElementById('content_"+worktel+"').value);\" >"+log_content.substring(0,25)+"...</a>");//&#39;
       else
       html.append(log_content);
       html.append("</td>");

       html.append("<td>&nbsp;");
       if(obj.getWorkproject()>0)
       html.append(Workproject.find(obj.getWorkproject()).getName(teasession._nLanguage));
       html.append("</td>");

       html.append("<td>&nbsp;");
       if(obj.getWorklinkman()!=null)
       html.append(obj.getWorklinkman());
       html.append("</td>");

       html.append("<td>&nbsp;").append(r.getString(teasession._nLanguage,obj.isTeltype()?"1170212958984":"1170212966468")).append("</td>");//来电/去电

       html.append("<td>&nbsp;").append(obj.getImember()).append("</td>");



       html.append("<td>&nbsp;");
       if (obj.getCtime().getTime() != obj.getUtime().getTime())
       {
         html.append(obj.getUtimeToString()); //是否修改过/修改时间
       }

       html.append("<td><input type=button value="+r.getString(teasession._nLanguage,"CBEdit")+" onClick=\"window.open('/jsp/admin/workreport/EditWorktel.jsp?community="+community+"&worktel="+worktel+"&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8")+"','_self');\">");
       html.append("<input type=button value="+r.getString(teasession._nLanguage,"CBDelete")+" onClick=\"if(confirm('"+r.getString(teasession._nLanguage,"ConfirmDelete")+"')){window.open('/servlet/EditWorkreport?community="+community+"&worktel="+worktel+"&action=deleteworktel&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8")+"','_self'); this.disabled=true;}\"></td></tr>");

     }
     out.print(html.toString());
%>
<tr><td colspan="5"><input type="checkbox" onClick="if(form2.worktel){ if(form2.worktel.id!='cb_today') form2.worktel.checked=this.checked;for(var i=form2.worktel.length;i>0;i--)if(form2.worktel[i-1].id!='cb_today')form2.worktel[i-1].checked=this.checked; }" /><%=r.getString(teasession._nLanguage,"1168828939928")%></td><td colspan="5" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,30)%></td></tr>


  <tr><td colspan="8" align="center">
    <!--=发送邮件-->
    <input type="submit" value="<%=r.getString(teasession._nLanguage,"1168829505147")%>" onClick="if(window.Event){form2.action='/jsp/admin/workreport/SendWorktel.jsp';}else{form2.attributes[83].value='/jsp/admin/workreport/SendWorktel.jsp'; }" >

    <!--导出-->
    <input type="submit" value="<%=r.getString(teasession._nLanguage,"1168831858710")%>" onClick="if(window.Event){form2.action='/servlet/EditWorkreport';}else{form2.attributes[83].value='/servlet/EditWorkreport'; }" >

    <input type="button" value="<%=r.getString(teasession._nLanguage,"Add")%>" onClick="window.open('/jsp/admin/workreport/EditWorktel.jsp?community=<%=community%>&worktel=0&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self');">

</td></tr>
</table>



</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>


