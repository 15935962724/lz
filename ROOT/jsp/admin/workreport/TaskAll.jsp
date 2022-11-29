<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource"  %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.admin.sales.*" %>
<%@page import="java.util.*" %>
<%@page import="java.net.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.admin.sales.*" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String _strId=request.getParameter("id");

String nextUrl = request.getRequestURI() + "?"+request.getQueryString();

String community=teasession._strCommunity;

Resource r=new Resource("/tea/resource/Workreport");

StringBuffer param=new StringBuffer();
param.append("?community=").append(community);

StringBuffer sql=new StringBuffer();


int flowitem=0;
String _strFlowitem=request.getParameter("flowitem");
if(_strFlowitem!=null&&_strFlowitem.length()>0)
{
  flowitem=Integer.parseInt(_strFlowitem);
  sql.append(" AND flowitem=").append(flowitem);
  param.append("&flowitem=").append(flowitem);
}





int fettle=-1;
String _strFettle=request.getParameter("fettle");
if(_strFettle!=null&&_strFettle.length()>0)
{
  fettle=Integer.parseInt(_strFettle);
  if(fettle>0)
  {
    sql.append(" AND fettle=").append(fettle);
    param.append("&fettle=").append(fettle);
  }
}
else
{
  sql.append(" and fettle!=").append(2);

}
int worktype=0;
String _strWorktype=request.getParameter("worktype");
if(_strWorktype!=null&&_strWorktype.length()>0)
{
  worktype=Integer.parseInt(_strWorktype);
  sql.append(" AND worktype=").append(worktype);
  param.append("&worktype=").append(worktype);
}


String q = request.getParameter("q");
if(q!=null&&(q=q.trim()).length()>0)
{
  sql.append(" AND motif LIKE ").append(DbAdapter.cite("%"+q+"%"));
  param.append("&q=").append(URLEncoder.encode(q,"UTF-8"));
}

String content=request.getParameter("content");
if(content!=null&&(content=content.trim()).length()>0)
{
  sql.append(" AND content LIKE ").append(DbAdapter.cite("%"+content+"%"));
  param.append("&content=").append(java.net.URLEncoder.encode(content,"UTF-8"));
}

String member=request.getParameter("member");
if(member!=null&&(member=member.trim()).length()>0)
{
  sql.append(" AND member LIKE ").append(DbAdapter.cite("%"+member+"%"));
  param.append("&member=").append(java.net.URLEncoder.encode(member,"UTF-8"));
}

String assignerid=request.getParameter("assignerid");
if(assignerid!=null&&(assignerid=assignerid.trim()).length()>0)
{
  sql.append(" AND assignerid LIKE ").append(DbAdapter.cite("%"+assignerid+"%"));
  param.append("&assignerid=").append(java.net.URLEncoder.encode(assignerid,"UTF-8"));
}
///////////////////////////////////////

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
      sql.append(" AND times >=").append(db.cite(time));
      param.append("&time_s=").append(java.net.URLEncoder.encode(time_s,"UTF-8"));
    }catch(java.text.ParseException pe)
    {}
  }

  if(time_e!=null&&(time_e=time_e.trim()).length()>0)
  {
    try
    {
      java.util.Date time=Worklog.sdf.parse(time_e);
      sql.append(" AND times <").append(db.cite(time));
      param.append("&time_e=").append(java.net.URLEncoder.encode(time_e,"UTF-8"));
    }catch(java.text.ParseException pe)
    {}
  }
}finally
{
  db.close();
}



int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}



//int flowitemid =0;
String _strFlowitemid = request.getParameter("flowitemidff");
if(_strFlowitemid!=null && _strFlowitemid.length()>0)
{
  sql.append(" and flowitem in (select flowitem from FlowitemLayer where name like "+DbAdapter.cite("%"+_strFlowitemid+"%")+")");
  param.append("&flowitemidff=").append(java.net.URLEncoder.encode(_strFlowitemid,"UTF-8"));
}

int count=0;
Task.count(community,sql.toString());

int valuenum = 0;
if(teasession.getParameter("valuenum")!=null && teasession.getParameter("valuenum").length()>0)
{
  valuenum = Integer.parseInt(teasession.getParameter("valuenum"));
  param.append("&valuenum=").append(valuenum);
}
if(valuenum==0)
{
  count=Task.count(community,sql.toString());
}
else if(valuenum==1)
{
  count=Task.count(community,sql.toString(),"distinct flowitem");
}
else if(valuenum==2)
{
  count=2;
}
else if(valuenum==3)
{

  //sql.append(" t.assignerid like '%/'+ p.member+'/%'");
  count=Task.count(community,sql.toString()," distinct member ");
  param.append("&valuenum=").append(valuenum);
}
else if(valuenum==4)
{
  //sql.append(" t.assignerid like '%/'+ p.member+'/%'");
  count=Task.countmember(community," and t.assignerid like '%/'+ p.member+'/%'  and fettle!=2"," distinct p.member "," Profile p,Task t ");
  param.append("&valuenum=").append(valuenum);
}
/////////////////////////////////////







//out.print(sql.toString());
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


            function ResponseOnload(cc)
            {
              window.open('/jsp/admin/workreport/task_info_2.jsp?nexturl='+cc,'VWproject2');
            }

            </script>
            </head>
            <body>

            <h1>任务汇总</h1>
            <h2><%=r.getString(teasession._nLanguage,"1168574879546")%><!--查询--></h2>
            <form name=form1 action="?" method="POST" >
              <input type=hidden name="community" value="<%=community%>"/>
              <input type=hidden name="nexturl" value="<%=nextUrl%>"/>
              <input type="hidden" name="id" value="<%=_strId%>">

              <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
                <tr>
                  <td>主题:<input name="q" value="<%if(q!=null)out.print(q);%>" ></td>
                    <td>项目<input name="flowitemidff" value=""></td>
                    </tr><tr>  <td nowrap>创建时间开始:<input name="time_s"  readonly="readonly" /><a href=### onClick="showCalendar('form1.time_s');"><img  alt="" src="/tea/image/public/Calendar2.gif"   ></a></td>

                        <td nowrap>创建时间结束:<input name="time_e"   readonly="readonly"/><a href=### onClick="showCalendar('form1.time_e');"><img  alt="" src="/tea/image/public/Calendar2.gif"   ></a></td>

                </tr><tr><td>任务分配人：<input name="q" value="" ></td>

                  <td>状态:<select name="fettle">
                  <%
                  for(int i=0;i<Task.FETTLE.length;i++)
                  {
                    out.print("<OPTION VALUE="+i);
                    if(fettle==i)
                    out.print(" selected ");
                    out.print(">"+Task.FETTLE[i]);
                  }
                  %>
                  </select>
                  　　  <input name="submit" type="submit" value="查询"/></td>

                </tr>
              </table>
</form>

<h2><%=r.getString(teasession._nLanguage,"1168575045718")+"( "+count+" )"%><!--列表--></h2>
<style>
#tasklist {margin:0px;padding:0px}
#tasklist li{list-style-position: outside;
	list-style-type: decimal;margin-left:33px;margin-top:5px}
	</style>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>查看：　　<a href="/jsp/admin/workreport/TaskAll.jsp?valuenum=1">按项目</a></td><td><a href="/jsp/admin/workreport/TaskAll.jsp?valuenum=2">按创建时间</a></td><td><a href="/jsp/admin/workreport/TaskAll.jsp?valuenum=4">按接纳人</a></td><td><a href="/jsp/admin/workreport/TaskAll.jsp?valuenum=3">按分配人</a></td>
  </tr>
</table>
<%
if(valuenum ==0)//
{
  %>

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter"><tr><td>
<ul id="tasklist">
    <%
    sql.append("  order by flowitem,times");
    Enumeration tame2 = Task.findByCommunity(teasession._strCommunity,sql.toString(),pos,30);
    while(tame2.hasMoreElements())
    {
      int taid2 = ((Integer)tame2.nextElement()).intValue();

      Task taobj2 = Task.find(taid2);
      Flowitem flows = Flowitem.find(taobj2.getFlowitem());
      Profile probj=Profile.find(taobj2.getMember());


      %>
      <li><a href="/jsp/admin/workreport/task_info_2.jsp?taid=<%=taid2 %>&nexturl=<%=nextUrl%>"><%=taobj2.getMotif()%></a><br>［所属项目：<%= flows.getName(teasession._nLanguage)%>
        状态：<%=Task.FETTLE[taobj2.getFettle()] %>
        创建时间：<%=taobj2.getTimesToString()%>
        创建人：<%=probj.getName(teasession._nLanguage)%>
	接纳人：<%
        String str=taobj2.getAssignerid();
        String []s=str.split("/");
        for(int i=0;i<s.length;i++)
        {
          Profile probj2=Profile.find(s[i]);
          out.print(probj2.getName(teasession._nLanguage)+" ");
        }
        %><%
        Enumeration tame3 = TaskConsign.findByCommunity(teasession._strCommunity," AND task="+taid2);
        while(tame3.hasMoreElements())
        {
          String assigner=(String)tame3.nextElement();
          TaskConsign taskcon = TaskConsign.find(taid2,assigner);
          String cs[] = taskcon.getConsign().split("/");
          for(int i=0;i<cs.length;i++)
          {
            Profile probj3=Profile.find(cs[i]);
            out.print(probj3.getName(teasession._nLanguage)+" ");
          }
        }
        %>］</li>
      <%
      }
      %></ul></td></tr>
      <tr>
        <td align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString(),pos,count,40)%></td></tr>
  </table>
  <br>
  <div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
            </body>
</html>



<%
}
else if (valuenum==1)//项目
{
  %>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter"><tr><td>
     <%
    Enumeration tame5_1 = Task.findByCommunitybh2(teasession._strCommunity,sql.toString(),"distinct flowitem",2,pos,10);
    while(tame5_1.hasMoreElements())
    {
      int  flowitems = ((Integer)tame5_1.nextElement()).intValue();
      Flowitem flows1 = Flowitem.find(flowitems);
      %>
    </ul> <h2><%=flows1.getName(teasession._nLanguage)%> 　<a href="/jsp/admin/workreport/TaskAll.jsp?flowitem=<%=flowitems%>">更多</a></h2><ul id="tasklist">

      <%
      Enumeration tame2 = Task.findByCommunity(teasession._strCommunity," and fettle!=2 and flowitem="+flowitems,0,15);
      while(tame2.hasMoreElements())
      {
        int taid2 = ((Integer)tame2.nextElement()).intValue();

        Task taobj2 = Task.find(taid2);
        Flowitem flows = Flowitem.find(taobj2.getFlowitem());
        Profile probj=Profile.find(taobj2.getMember());
        %>
     <li>   <a href="/jsp/admin/workreport/task_info_2.jsp?taid=<%=taid2 %>&nexturl=<%=nextUrl%>"><%=taobj2.getMotif()%></a><br>［状态：<%=Task.FETTLE[taobj2.getFettle()] %>		创建时间：<%=taobj2.getTimes().toString()%>		创建人：<%=probj.getName(teasession._nLanguage)%>
		接纳人：<%
        String str=taobj2.getAssignerid();
        String []s=str.split("/");
        for(int i=0;i<s.length;i++)
        {
          Profile probj2=Profile.find(s[i]);
          out.print(probj2.getName(teasession._nLanguage)+" ");
        }
        %><%
        Enumeration tame3 = TaskConsign.findByCommunity(teasession._strCommunity," AND task="+taid2);
        while(tame3.hasMoreElements())
        {
          String assigner=(String)tame3.nextElement();
          TaskConsign taskcon = TaskConsign.find(taid2,assigner);
          String cs[] = taskcon.getConsign().split("/");
          for(int i=0;i<cs.length;i++)
          {
            Profile probj3=Profile.find(cs[i]);
            out.print(probj3.getName(teasession._nLanguage)+" ");
          }
        }
        %>］</li>
          <%
          }
        }
        param.append("&pos=");

        %>
       </td></tr> <tr><td align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString(),pos,count,10)%></td></tr>
  </table>
  <br>
  <div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
<%
}
else if (valuenum==2)//创建时间
{
  %>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td>
    <%
    for(int h =0 ;h<2;h++)
    {
      %>
      </ul><h2><%if(h==0){out.print("今天");}else{out.print("昨天");}%><a href="/jsp/admin/workreport/TaskAll.jsp"></a></h2><ul id="tasklist">
      <%
      Enumeration tame2 = Task.findByCommunitytime(teasession._strCommunity,sql.toString(),pos,40,h);
      while(tame2.hasMoreElements())
      {
        int taid2 = ((Integer)tame2.nextElement()).intValue();
        Task taobj2 = Task.find(taid2);
        Flowitem flows = Flowitem.find(taobj2.getFlowitem());
        Profile probj=Profile.find(taobj2.getMember());
        %>
          <li>   <a href="/jsp/admin/workreport/task_info_2.jsp?taid=<%=taid2 %>&nexturl=<%=nextUrl%>"><%=taobj2.getMotif()%></a><br>［所属项目：<%= flows.getName(teasession._nLanguage)%>　状态：<%=Task.FETTLE[taobj2.getFettle()] %>	创建人：<%=probj.getName(teasession._nLanguage)%>
		接纳人：<%
        String str=taobj2.getAssignerid();
        String []s=str.split("/");
        for(int i=0;i<s.length;i++)
        {
          Profile probj2=Profile.find(s[i]);
          out.print(probj2.getName(teasession._nLanguage)+" ");
        }
        %><%
        Enumeration tame3 = TaskConsign.findByCommunity(teasession._strCommunity," AND task="+taid2);
        while(tame3.hasMoreElements())
        {
          String assigner=(String)tame3.nextElement();
          TaskConsign taskcon = TaskConsign.find(taid2,assigner);
          String cs[] = taskcon.getConsign().split("/");
          for(int i=0;i<cs.length;i++)
          {
            Profile probj3=Profile.find(cs[i]);
            out.print(probj3.getName(teasession._nLanguage)+" ");
          }
        }
        %>］</li>
        <%
        }
      }

      %>
     </td></tr> <tr>
        <td align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString(),pos,2,20)%></td></tr>
  </table>
  <br>
  <div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
<%
}
else if (valuenum==3)//任务分配人
{
  %>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td>
    <%
    Enumeration tame5_3 = Task.findByCommunitybh2(teasession._strCommunity,sql.toString(),"distinct member",1,pos,10);
    while(tame5_3.hasMoreElements())
    {
      String members = tame5_3.nextElement().toString();
      Profile probj5_3=Profile.find(members);
      %>
      </ul><h2><%=probj5_3.getName(teasession._nLanguage)%>　　<a href="/jsp/admin/workreport/Worklogs_12.jsp?member=<%=members%>">更多</a></h2><ul id="tasklist">
      <%
      Enumeration tame2 = Task.findByCommunity(teasession._strCommunity," and fettle!=2 and member ="+DbAdapter.cite(members),0,20);
      while(tame2.hasMoreElements())
      {
        int taid2 = ((Integer)tame2.nextElement()).intValue();

        Task taobj2 = Task.find(taid2);
        Flowitem flows = Flowitem.find(taobj2.getFlowitem());
        Profile probj=Profile.find(taobj2.getMember());
        %>
       <li>   <a href="/jsp/admin/workreport/task_info_2.jsp?taid=<%=taid2 %>&nexturl=<%=nextUrl%>"><%=taobj2.getMotif()%></a><br>［所属项目：<%= flows.getName(teasession._nLanguage)%>　状态：<%=Task.FETTLE[taobj2.getFettle()] %>		创建时间：<%=taobj2.getTimes().toString()%>
		接纳人：<%
        String str=taobj2.getAssignerid();
        String []s=str.split("/");
        for(int i=0;i<s.length;i++)
        {
          Profile probj2=Profile.find(s[i]);
          out.print(probj2.getName(teasession._nLanguage)+" ");
        }
        %><%
        Enumeration tame3 = TaskConsign.findByCommunity(teasession._strCommunity," AND task="+taid2);
        while(tame3.hasMoreElements())
        {
          String assigner=(String)tame3.nextElement();
          TaskConsign taskcon = TaskConsign.find(taid2,assigner);
          String cs[] = taskcon.getConsign().split("/");
          for(int i=0;i<cs.length;i++)
          {
            Profile probj3=Profile.find(cs[i]);
            out.print(probj3.getName(teasession._nLanguage)+" ");
          }
        }
        %>］</li>
        <%
        }

      }
      param.append("&pos=");
      %>
     </td></tr> <tr>
        <td align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString(),pos,count,10)%></td></tr>
  </table>
  <br>
  <div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
<%
}
else if (valuenum==4)//任务接受人
{
  %>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td>
    <%
    Enumeration tame5_4 =Task.findByCommunitybh3(teasession._strCommunity,sql.toString(),"",1,pos,10);
    while(tame5_4.hasMoreElements())
    {
      String assignerids =  tame5_4.nextElement().toString();
      Profile probj5_4=Profile.find(assignerids);
      %>
      </ul><h2><%=probj5_4.getName(teasession._nLanguage)%>　　<a href="/jsp/admin/workreport/Worklogs_12.jsp?assignerid=<%=assignerids%>">更多</a></h2><ul id="tasklist">
      <%
     // if()
      Enumeration tame2 = Task.findByCommunity(teasession._strCommunity,"  and fettle!=2 and assignerid like "+DbAdapter.cite("%/"+assignerids+"/%"),0,20);
      while(tame2.hasMoreElements())
      {
        int taid2 = ((Integer)tame2.nextElement()).intValue();
        Task taobj2 = Task.find(taid2);
        Flowitem flows = Flowitem.find(taobj2.getFlowitem());
        Profile probj=Profile.find(taobj2.getMember());
        %>
      <li>   <a href="/jsp/admin/workreport/task_info_2.jsp?taid=<%=taid2 %>&nexturl=<%=nextUrl%>"><%=taobj2.getMotif()%></a><br>［所属项目：<%= flows.getName(teasession._nLanguage)%>　状态：<%=Task.FETTLE[taobj2.getFettle()] %>		创建时间：<%=taobj2.getTimes().toString()%>		创建人：<%=probj.getName(teasession._nLanguage)%>
		<%
        Enumeration tame3 = TaskConsign.findByCommunity(teasession._strCommunity," AND task="+taid2);
        while(tame3.hasMoreElements())
        {
          String assigner=(String)tame3.nextElement();
          TaskConsign taskcon = TaskConsign.find(taid2,assigner);
          String cs[] = taskcon.getConsign().split("/");
          for(int i=0;i<cs.length;i++)
          {
            Profile probj3=Profile.find(cs[i]);
            out.print(probj3.getName(teasession._nLanguage)+" ");
          }
        }
        %>］</li>
          <%
          }
        }
        param.append("&pos=");
        %>
        </td></tr><tr>
          <td align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString(),pos,count,10)%></td></tr>
  </table>
  <br>
  <div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
<%
}
%>



