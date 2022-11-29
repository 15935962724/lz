<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@ page  import="tea.entity.admin.*" %><%@ page  import="tea.entity.member.*" %><%@ page import="tea.ui.TeaSession" %><%
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
sql.append(" community="+DbAdapter.cite(community));

String menu_id=request.getParameter("id");
param.append("&id=").append(menu_id);

//
sql.append(" AND workproject IN(0");
Enumeration e=Flowitem.find(teasession._strCommunity," AND manager LIKE "+DbAdapter.cite("%/"+teasession._rv._strV+"/%"));
while(e.hasMoreElements())
{
  int fiid=((Integer)e.nextElement()).intValue();
  sql.append(",").append(fiid);
}
sql.append(")");


int workproject=0;
String tmp=request.getParameter("workproject");
if(tmp!=null&&tmp.length()>0)
{
  workproject=Integer.parseInt(tmp);
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
tmp=request.getParameter("worktype");
if(tmp!=null&&tmp.length()>0)
{
  worktype=Integer.parseInt(tmp);
  sql.append(" AND worktype=").append(worktype);
  param.append("&worktype=").append(worktype);
}

String time_s=request.getParameter("time_s");
String time_e=request.getParameter("time_e");
if(time_s!=null&&(time_s=time_s.trim()).length()>0)
{
  try
  {
    java.util.Date time=Worklog.sdf.parse(time_s);
    sql.append(" AND time>=").append(DbAdapter.cite(time));
    param.append("&time_s=").append(java.net.URLEncoder.encode(time_s,"UTF-8"));
  }catch(Exception pe)
  {}
}
if(time_e!=null&&(time_e=time_e.trim()).length()>0)
{
  try
  {
    java.util.Date time=Worklog.sdf.parse(time_e);
    sql.append(" AND time<").append(DbAdapter.cite(time));
    param.append("&time_e=").append(java.net.URLEncoder.encode(time_e,"UTF-8"));
  }catch(Exception pe)
  {}
}


String content=request.getParameter("content");
if(content!=null&&(content=content.trim()).length()>0)
{
  sql.append(" AND content LIKE ").append(DbAdapter.cite("%"+content+"%"));
  param.append("&content=").append(java.net.URLEncoder.encode(content,"UTF-8"));
}

int pos=0;
tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}

param.append("&pos=").append(pos);

String nexturl=request.getRequestURI()+"?"+request.getQueryString();



%>
<!--只显示你管理的项目中的平均分-->
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script type="">
function f_go(url)
{
  form1.action=url;
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
<body>
<!--工作记录管理-->
<h1><%=r.getString(teasession._nLanguage,"1168593689875")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<h2><%=r.getString(teasession._nLanguage,"1168574879546")%><!--查询--></h2>
   <form name="form1" METHOD=get action="?" >
   <input type=hidden name="community" value="<%=community%>"/>
   <input type=hidden name="id" value="<%=request.getParameter("id")%>"/>
   <input type=hidden name="nexturl" value="<%=nexturl%>"/>
   <input type=hidden name="act" value="exportworklogs"/>

   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td><%=r.getString(teasession._nLanguage,"1168584443703")%>
         <select name="workproject" onChange="fchange(this.value);">
        <option value="">---------</option>
        <optgroup label="最近填写的项目">
        <%
        StringBuffer sb = new StringBuffer();
        String member = teasession._rv.toString();//登录的用户ID
          java.util.Enumeration flmejc = Flowitem.findzuijin(teasession._strCommunity, "",teasession._rv.toString());
        //java.util.Enumeration flmejc = Flowitem.find(teasession._strCommunity, "and Flowitem in (select top 10 workproject from  Worklog  where member ="+DbAdapter.cite(member)+" group by workproject order by count(workproject) desc)");
        while (flmejc.hasMoreElements())
        {
          int flid = ((Integer) flmejc.nextElement()).intValue();
          Flowitem flobj = Flowitem.find(flid);
          if(flobj.getManager().indexOf(member)!=-1 || flobj.getMember().indexOf(member)!=-1)
          {
            out.print("<option value=" + flid);

            if (flid == workproject)
            out.print(" selected ");
            out.print(" >" + flobj.getName(teasession._nLanguage));
          }
          sb.append("case ").append(flid).append(": ");

          java.util.Enumeration e2=Worklinkman.find(teasession._strCommunity," AND workproject="+flobj.getWorkproject(),0,Integer.MAX_VALUE);
          while(e2.hasMoreElements())
          {
            String member_e=((String)e2.nextElement());
            //Worklinkman worklinkman_obj=Worklinkman.find(teasession._strCommunity,member_e);
            sb.append("obj.options[obj.options.length]=new Option(\""+member_e+"\",\""+member_e+"\");");
          }
          sb.append("break;\r\n");
        }
        %>

        </optgroup>
          <optgroup label="进行中的项目">
      <%
        java.util.Enumeration flmejx = Flowitem.find(teasession._strCommunity, " and itemgenre=2 order by flowitem desc");
        while (flmejx.hasMoreElements())
        {
          int flid = ((Integer) flmejx.nextElement()).intValue();
          Flowitem flobj = Flowitem.find(flid);
          if(flobj.getManager().indexOf(member)!=-1 || flobj.getMember().indexOf(member)!=-1)
          {
	          out.print("<option value=" + flid);

	                  if (flid == workproject)
	            out.print(" selected ");
	          out.print(" >" + flobj.getName(teasession._nLanguage));

	 	  }
          sb.append("case ").append(flid).append(": ");

             java.util.Enumeration e2=Worklinkman.find(teasession._strCommunity," AND workproject="+flobj.getWorkproject(),0,Integer.MAX_VALUE);
             while(e2.hasMoreElements())
             {
               String member_e=((String)e2.nextElement());
               //Worklinkman worklinkman_obj=Worklinkman.find(teasession._strCommunity,member_e);
               sb.append("obj.options[obj.options.length]=new Option(\""+member_e+"\",\""+member_e+"\");");
             }
             sb.append("break;\r\n");
        }
      %>
          </optgroup>
              <optgroup label="洽谈中的项目">
      <%
        java.util.Enumeration flmeqt = Flowitem.find(teasession._strCommunity, " and itemgenre=1 order by flowitem desc");
        while (flmeqt.hasMoreElements())
        {
          int flid = ((Integer) flmeqt.nextElement()).intValue();
          Flowitem flobj = Flowitem.find(flid);
          if(flobj.getManager().indexOf(member)!=-1 || flobj.getMember().indexOf(member)!=-1)
          {
	          out.print("<option value=" + flid);

	                  if (flid == workproject)
	            out.print(" selected ");
	          out.print(" >" + flobj.getName(teasession._nLanguage));

	 	  }
          sb.append("case ").append(flid).append(": ");

             java.util.Enumeration e2=Worklinkman.find(teasession._strCommunity," AND workproject="+flobj.getWorkproject(),0,Integer.MAX_VALUE);
             while(e2.hasMoreElements())
             {
               String member_e=((String)e2.nextElement());
               //Worklinkman worklinkman_obj=Worklinkman.find(teasession._strCommunity,member_e);
               sb.append("obj.options[obj.options.length]=new Option(\""+member_e+"\",\""+member_e+"\");");
             }
             sb.append("break;\r\n");
        }
      %>
          </optgroup>
          <optgroup label="维护中的项目">
      <%
        java.util.Enumeration flmewh = Flowitem.find(teasession._strCommunity, " and itemgenre=3 order by flowitem desc");
        while (flmewh.hasMoreElements())
        {
          int flid = ((Integer) flmewh.nextElement()).intValue();
          Flowitem flobj = Flowitem.find(flid);
          if(flobj.getManager().indexOf(member)!=-1 || flobj.getMember().indexOf(member)!=-1)
          {
	          out.print("<option value=" + flid);

	                 if (flid == workproject)
	            out.print(" selected ");
	          out.print(" >" + flobj.getName(teasession._nLanguage));

	 	  }
          sb.append("case ").append(flid).append(": ");

             java.util.Enumeration e2=Worklinkman.find(teasession._strCommunity," AND workproject="+flobj.getWorkproject(),0,Integer.MAX_VALUE);
             while(e2.hasMoreElements())
             {
               String member_e=((String)e2.nextElement());
               //Worklinkman worklinkman_obj=Worklinkman.find(teasession._strCommunity,member_e);
               sb.append("obj.options[obj.options.length]=new Option(\""+member_e+"\",\""+member_e+"\");");
             }
             sb.append("break;\r\n");
        }
      %>
          </optgroup>
        <optgroup label="完成的项目">
      <%


        java.util.Enumeration flme = Flowitem.find(teasession._strCommunity, " and itemgenre=4  order by flowitem desc");
        while (flme.hasMoreElements())
        {
          int flid = ((Integer) flme.nextElement()).intValue();
          Flowitem flobj = Flowitem.find(flid);
          if(flobj.getManager().indexOf(member)!=-1 || flobj.getMember().indexOf(member)!=-1)
          {
	          out.print("<option value=" + flid);

	      if (flid == workproject)
	            out.print(" selected ");
	          out.print(" >" + flobj.getName(teasession._nLanguage));

	 	  }
          sb.append("case ").append(flid).append(": ");

             java.util.Enumeration e2=Worklinkman.find(teasession._strCommunity," AND workproject="+flobj.getWorkproject(),0,Integer.MAX_VALUE);
             while(e2.hasMoreElements())
             {
               String member_e=((String)e2.nextElement());
               //Worklinkman worklinkman_obj=Worklinkman.find(teasession._strCommunity,member_e);
               sb.append("obj.options[obj.options.length]=new Option(\""+member_e+"\",\""+member_e+"\");");
             }
             sb.append("break;\r\n");
        }
      %>
          </optgroup>
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
           </td></tr>
           <tr>
             <td><%=r.getString(teasession._nLanguage,"Time")%><input name="time_s" size="10" onFocus="if(this.value=='yyyy-mm-dd')this.value='';" onBlur="if(this.value=='')this.value='yyyy-mm-dd';" value="<%if(time_s!=null)out.print(time_s);%>"><A href="###"><img onClick="showCalendar('form1.time_s');" src="/tea/image/public/Calendar2.gif" align="top"/></a> --
               <input name="time_e" size="10" onFocus="if(this.value=='yyyy-mm-dd')this.value='';" onBlur="if(this.value=='')this.value='yyyy-mm-dd';" value="<%if(time_e!=null)out.print(time_e);%>"><A href="###"><img onClick="showCalendar('form1.time_e');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
                 <td><%=r.getString(teasession._nLanguage,"Text")%><input name="content" value="<%if(content!=null)out.print(content);%>"></td>
                   <td><input type="submit" value="GO" onclick="f_go('?')"/></td></tr>
   </table>
<br>

<%
DbAdapter db=new DbAdapter();
try
{
  int count=db.getInt("SELECT COUNT(DISTINCT member) FROM Worklog WHERE"+sql.toString());
  out.print("<h2>"+r.getString(teasession._nLanguage,"1168575045718")+"( "+count+" )</h2>");
  out.print("<table border='0' cellpadding='0' cellspacing='0' id='tablecenter'>");
  out.print("<tr id='tableonetr'><td>员工<td>部门<td>平均分");

  db.executeQuery("SELECT member,AVG(score) FROM Worklog WHERE"+sql.toString()+" GROUP BY member",pos,20);
  for(int i=0;db.next();i++)
  {
      String wlm=db.getString(1);
      int avg=db.getInt(2);
      int unit=AdminUsrRole.find(teasession._strCommunity,wlm).getUnit();
      out.print("<tr><td><a href='/jsp/admin/workreport/ViewWorklogScore.jsp?member="+java.net.URLEncoder.encode(wlm,"UTF-8")+"'>"+Profile.find(wlm).getName(teasession._nLanguage)+"</a></td>");
      out.print("<td>");
      AdminUnit au=AdminUnit.find(unit);
      if(au.isExists())
      {
        out.print(au.getName());
      }
      out.print("<td>"+(avg>0?String.valueOf(avg):"--"));
  }
  if(count>20)
  {
    out.print("<tr><td colspan='5' align='center'>"+new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,20)+"</td></tr>");
  }
  out.print("</table>");
}finally
{
  db.close();
}
%>
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
