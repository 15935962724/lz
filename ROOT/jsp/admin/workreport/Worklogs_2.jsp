<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter" %><%@page import="tea.entity.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.resource.Resource"  %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}



Resource r=new Resource("/tea/resource/Workreport");

StringBuffer param=new StringBuffer("&community="+teasession._strCommunity);
StringBuffer sql=new StringBuffer();

sql.append(" AND ( member=").append(DbAdapter.cite(teasession._rv._strV));
/////按项目
//AdminUsrRole aur=AdminUsrRole.find(teasession._strCommunity,teasession._rv._strV);
//String str=aur.getClasses();
//if(str.length()>2)
//{
//  str=str.substring(1,str.length()-1).replace('/',',');
//  sql.append(" OR member IN (SELECT member FROM AdminUsrRole WHERE community=").append(DbAdapter.cite(teasession._strCommunity)).append(" AND workproject IN (select workproject from worklinkman where member ="+DbAdapter.cite(teasession._rv._strV)+") )");
//}
//sql.append(")");


////////按部门和项目
AdminUsrRole aur=AdminUsrRole.find(teasession._strCommunity,teasession._rv._strV);
String str=aur.getClasses();
if(str.length()>2)
{
  str=str.substring(1,str.length()-1).replace('/',',');
  //sql.append(" OR member IN (SELECT member FROM AdminUsrRole WHERE community=").append(DbAdapter.cite(teasession._strCommunity)).append(" AND unit IN (").append(str).append(") )").append(" or workproject IN (select workproject from worklinkman where member ="+DbAdapter.cite(teasession._rv._strV)+" )");
  sql.append(" OR member IN (select p.member from AdminUsrRole aur inner JOIN  Profile p ON aur.member=p.profile and  aur.community=").append(DbAdapter.cite(teasession._strCommunity)).append(" AND aur.unit IN (").append(str).append(") )").append(" or workproject IN (select workproject from worklinkman where member ="+DbAdapter.cite(teasession._rv._strV)+" )");
}
sql.append(")");




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


String member=request.getParameter("member");
if(member!=null&&member.length()>0)
{
  sql.append(" AND member LIKE ").append(DbAdapter.cite("%"+member+"%"));
  param.append("&member=").append(java.net.URLEncoder.encode(member,"UTF-8"));
}


int worktype=0;
String _strWorktype=request.getParameter("worktype");
if(_strWorktype!=null&&_strWorktype.length()>0)
{
  worktype=Integer.parseInt(_strWorktype);
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
    sql.append(" AND time >=").append(DbAdapter.cite(time));
    param.append("&time_s=").append(java.net.URLEncoder.encode(time_s,"UTF-8"));
  }catch(java.text.ParseException pe)
  {}
}

if(time_e!=null&&(time_e=time_e.trim()).length()>0)
{
  try
  {
    java.util.Date time=Worklog.sdf.parse(time_e);
    sql.append(" AND time <").append(DbAdapter.cite(time));
    param.append("&time_e=").append(java.net.URLEncoder.encode(time_e,"UTF-8"));
  }catch(java.text.ParseException pe)
  {}
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

int count=Worklog.count(teasession._strCommunity,sql.toString());

param.append("&pos=").append(pos);

String nexturl=request.getRequestURI()+"?"+request.getQueryString();




int valuenum = 0;
if(teasession.getParameter("valuenum")!=null && teasession.getParameter("valuenum").length()>0)
{
  valuenum = Integer.parseInt(teasession.getParameter("valuenum"));
  param.append("&valuenum=").append(valuenum);
}
if(valuenum==0)
{
  count=count=Worklog.count(teasession._strCommunity,sql.toString());
}
else if(valuenum==1)
{
  count=Worklog.countmode(teasession._strCommunity,sql.toString()," distinct workproject");
}
else if(valuenum==2)
{
  count=2;
}
else if(valuenum==3)
{
  count=Worklog.countmode(teasession._strCommunity,sql.toString()," distinct member");
  param.append("&valuenum=").append(valuenum);
}
else if(valuenum==4)
{
  //sql.append(" t.assignerid like '%/'+ p.member+'/%'");
  count=Worklog.countmode(teasession._strCommunity,sql.toString()," distinct worktype");
  param.append("&valuenum=").append(valuenum);
}

//out.print(sql.toString());
%><html>
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
    <input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
    <input type=hidden name="id" value="<%=request.getParameter("id")%>"/>

    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <td><%=r.getString(teasession._nLanguage,"1168584443703")%>
          <select name="workproject">
            <option value="">---------</option>
        <optgroup label="经常填写的项目">
        <%
        StringBuffer sb = new StringBuffer();
        String memberx = teasession._rv.toString();//登录的用户ID
           java.util.Enumeration flmejc = Flowitem.findzuijin(teasession._strCommunity, " and type = 0 ",teasession._rv.toString());
       // java.util.Enumeration flmejc = Flowitem.find(teasession._strCommunity, "and Flowitem in (select top 10 workproject from  Worklog  where member ="+DbAdapter.cite(memberx)+" group by workproject order by count(workproject) desc)");
        while (flmejc.hasMoreElements())
        {
          int flid = ((Integer) flmejc.nextElement()).intValue();
          Flowitem flobj = Flowitem.find(flid);
          if(flobj.getManager().indexOf(memberx)!=-1 || flobj.getMember().indexOf(memberx)!=-1)
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
        java.util.Enumeration flmejx = Flowitem.find(teasession._strCommunity, "  and type = 0  and itemgenre=2 order by flowitem desc");
        while (flmejx.hasMoreElements())
        {
          int flid = ((Integer) flmejx.nextElement()).intValue();
          Flowitem flobj = Flowitem.find(flid);
          if(flobj.getManager().indexOf(memberx)!=-1 || flobj.getMember().indexOf(memberx)!=-1)
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
        java.util.Enumeration flmeqt = Flowitem.find(teasession._strCommunity, "  and type = 0  and itemgenre=1 order by flowitem desc");
        while (flmeqt.hasMoreElements())
        {
          int flid = ((Integer) flmeqt.nextElement()).intValue();
          Flowitem flobj = Flowitem.find(flid);
          if(flobj.getManager().indexOf(memberx)!=-1 || flobj.getMember().indexOf(memberx)!=-1)
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
        java.util.Enumeration flmewh = Flowitem.find(teasession._strCommunity, " and type = 0  and itemgenre=3 order by flowitem desc");
        while (flmewh.hasMoreElements())
        {
          int flid = ((Integer) flmewh.nextElement()).intValue();
          Flowitem flobj = Flowitem.find(flid);
          if(flobj.getManager().indexOf(memberx)!=-1 || flobj.getMember().indexOf(memberx)!=-1)
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


        java.util.Enumeration flme = Flowitem.find(teasession._strCommunity, " and type = 0  and itemgenre=4  order by flowitem desc");
        while (flme.hasMoreElements())
        {
          int flid = ((Integer) flme.nextElement()).intValue();
          Flowitem flobj = Flowitem.find(flid);
          if(flobj.getManager().indexOf(memberx)!=-1 || flobj.getMember().indexOf(memberx)!=-1)
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
            <!--option value=""></option>
            <%
//            java.util.Enumeration e=Flowitem.find(teasession._strCommunity,"",0,Integer.MAX_VALUE);
//            while(e.hasMoreElements())
//            {
//              int id=((Integer)e.nextElement()).intValue();
//              Flowitem obj=Flowitem.find(id);
//              out.print("<option value="+id);
//              if(id==workproject)
//              out.print(" SELECTED ");
//              out.print(" >"+obj.getName(teasession._nLanguage));
//            }
            %>
            </select-->
        </td>
        <td><%=r.getString(teasession._nLanguage,"MemberId")%>
          <input type="text" name="member" value="<%if(member!=null)out.print(member);%>" >
          <%--  <select name="member"><option value="">-------------</option></select> --%>
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
          <td><%=r.getString(teasession._nLanguage,"Time")%><input name="time_s" size="7" onFocus="if(this.value=='yyyy-MM-dd')this.value='';" onBlur="if(this.value=='')this.value='yyyy-MM-dd';" value="<%if(time_s!=null)out.print(time_s);%>"><A href="###"><img onClick="showCalendar('form1.time_s');" src="/tea/image/public/Calendar2.gif" align="top"/></a> --
            <input name="time_e" size="7" onFocus="if(this.value=='yyyy-MM-dd')this.value='';" onBlur="if(this.value=='')this.value='yyyy-MM-dd';" value="<%if(time_e!=null)out.print(time_e);%>"><A href="###"><img onClick="showCalendar('form1.time_e');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
              <td><%=r.getString(teasession._nLanguage,"Text")%><input name="content" value="<%if(content!=null)out.print(content);%>"></td>
                <td><input type="submit" value="GO"/></td></tr>
    </table>
</form>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>查看：　　<a href="/jsp/admin/workreport/Worklogs_2.jsp?valuenum=1">按项目</a></td><td><a href="/jsp/admin/workreport/Worklogs_2.jsp?valuenum=2">按创建时间</a></td><td><a href="/jsp/admin/workreport/Worklogs_2.jsp?valuenum=3">按人员</a></td><td><a href="/jsp/admin/workreport/Worklogs_2.jsp?valuenum=4">按类型</a></td>
  </tr>
</table>
<br>
<%
if(valuenum==0)
{
%>
  <form name=form2 METHOD=post action="/servlet/EditWorkreport" onSubmit="">
    <input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
    <input type=hidden name="action" value="exportworklogs"/>
    <input type="hidden" name="sql" value="<%=sql.toString()%>" />

    <script>document.write("<input type=hidden name=nexturl value="+document.location+">");</script>

      <h2><%=r.getString(teasession._nLanguage,"1168575045718")+"( "+count+" )"%><!--列表--></h2>
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr id="tableonetr">
          <td nowrap width="1"></td>
          <td nowrap><%=r.getString(teasession._nLanguage,"Username")%></td>
          <td nowrap><%=r.getString(teasession._nLanguage,"Text")%></td>
          <td nowrap><%=r.getString(teasession._nLanguage,"附件")%></td>
          <td nowrap><%=r.getString(teasession._nLanguage,"问题回馈")%></td>
        </tr>
        <%
        sql.append(" ORDER BY time DESC");
        java.util.Enumeration enumer=Worklog.find(teasession._strCommunity,sql.toString(),pos,25);
        for(int index=1;enumer.hasMoreElements();index++)
        {
          int worklog=((Integer)enumer.nextElement()).intValue();

          Worklog obj=Worklog.find(worklog);//提取 会员的 姓名
          Profile ob = Profile.find(obj.getMember());//obj.getMember(),obj.getCommunity()
          Flowitem fi=Flowitem.find(obj.getWorkproject());

          %>
          <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
            <td width="1"><input name="worklog" type="checkbox" value="<%=worklog%>" /></td>
              <td nowrap>&nbsp;<%=ob.getName(teasession._nLanguage)%>&nbsp;<%=MT.f(obj.getTime(),1)%>
                <br />
                &nbsp;<%
                if(obj.getWorkproject()>0)
                {
                  String flowName = fi.getName(teasession._nLanguage) ;
                  if(flowName!=null)
                  out.print(flowName);
                }
                %>&nbsp;&nbsp;<%=obj.isPublicity()?"对外":"不对外"%>&nbsp;&nbsp;<%=obj.getWearHours()+"小时"+obj.getWearMinutes()+"分钟"%>
                </td>
                <td>&nbsp;
                <%
                String log_content=obj.getContent(teasession._nLanguage).replaceAll("</","&lt;/");
                if(log_content.length()>25){
                  out.print(log_content.replaceAll("\r\n","<br/>").replaceAll(" ","&nbsp;"));//&#39;
                } else{
                  out.print(log_content);
                } //内容显示
                out.print("<td nowrap>");
                String accessories = obj.getAccessories();
                if(accessories!=null&&accessories.length()!=0)
                {
                  String url = obj.getPath();
                  String picType = null;
                  String picImg = "<img src=/tea/image/other/download.gif>";
                  if(accessories.lastIndexOf(".")==-1)
                  {
                    out.print("");
                  }
                  else
                  {
                    picType = accessories.substring(accessories.lastIndexOf("."));
                    if(picType.equals(".jpg")||picType.equals(".gif")||picType.equals(".bmp")||picType.equals(".JPG")||picType.equals(".GIF")||picType.equals(".BMP")){
                      picImg="<img height=20 width=20 src="+url+">";
                    }
                  }
                  out.print("<hr><a href= /jsp/include/DownFile.jsp?uri="+ url +"&name="+java.net.URLEncoder.encode(accessories,"UTF-8")+">"+accessories+"&nbsp"+picImg+"</a></td>");
                }
                if(obj.getRevertmember()!=null && obj.getRevertmember().length()>0)
                {
                  Profile pro1 = Profile.find(obj.getRevertmember());
                  out.print("<br/>回馈人："+pro1.getName(teasession._nLanguage));
                }
                else
                {
                  out.print("");
                }
                out.print("<td>");
                if(fi.isExists()&&fi.getManager().indexOf("/"+teasession._rv._strV+"/")!=-1)
                {
                  out.println("<input type='button' value="+r.getString(teasession._nLanguage,"打分")+" onClick=\"window.showModalDialog('/jsp/admin/workreport/SetWorklogScore.jsp?community="+teasession._strCommunity+"&worklog="+worklog+"',self,'status:0;help:0;resizable:1;dialogWidth:280px;dialogHeight:205px;');\">");
                }
                out.println("<input type='button' value="+r.getString(teasession._nLanguage,"回馈")+" onClick=\"window.open('/jsp/admin/workreport/Worklogs_7revert.jsp?community="+teasession._strCommunity+"&nexturl="+nexturl+"&worklog="+worklog+"','_blank');\"></td></tr>");
                %>
                </td>
          </tr>
          <%

        }
        %>
        <tr><td colspan="2"><input type="checkbox" onClick="if(form2.worklog){ form2.worklog.checked=this.checked;for(var i=form2.worklog.length;i>0;i--)form2.worklog[i-1].checked=this.checked; }" /><%=r.getString(teasession._nLanguage,"1168828939928")%></td>
          <td colspan="5" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,25)%></td></tr>
      </table>
      <!--=发送邮件
      <input type="button" value="<%=r.getString(teasession._nLanguage,"1168829505147")%>" onClick="window.open('/jsp/admin/workreport/EditWorklog.jsp?community=<%=teasession._strCommunity%>&worklog=0&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self');">
      -->
      <!--导出-->
      <input type="submit" value="<%=r.getString(teasession._nLanguage,"1168831858710")%>" >
      <!--
      <input type="submit" value="<%=r.getString(teasession._nLanguage,"导出全部")%>" >
      -->

</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>




<%
}else if (valuenum==1)///按项目
{
  %>
  <form name=form2 METHOD=post action="/servlet/EditWorkreport" onSubmit="">
    <input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
    <input type=hidden name="action" value="exportworklogs_2"/>
    <script>document.write("<input type=hidden name=nexturl value="+document.location+">");</script>

      <h2><%=r.getString(teasession._nLanguage,"1168575045718")+"( "+count+" )"%><!--列表--></h2>
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr id="tableonetr"> <td nowrap width="1"></td>
          <td nowrap><%=r.getString(teasession._nLanguage,"Username")%></td>
          <td nowrap><%=r.getString(teasession._nLanguage,"Text")%></td>
      </tr>
      <%
      java.util.Enumeration enumer1=Worklog.findByCommunitymode(teasession._strCommunity,sql.toString()+" group by workproject",0,10,"workproject",0);
      while(enumer1.hasMoreElements())
      {
        int worklogs=((Integer)enumer1.nextElement()).intValue();
        Flowitem flows1 = Flowitem.find(worklogs);
        //Worklog obj=Worklog.find(worklogs);//提取 会员的 姓名
        %>
        <tr><td></td><td><h2><%=flows1.getName(teasession._nLanguage)%><a href="/jsp/admin/workreport/Worklogs_2.jsp?workproject=<%=worklogs%>">更多</a></h2></td></tr>
        <%
        java.util.Enumeration enumer=Worklog.findByCommunitymode(teasession._strCommunity," and workproject="+worklogs+sql.toString(),pos,15,"worklog",0);
        while(enumer.hasMoreElements())
        {
          int worklog=((Integer)enumer.nextElement()).intValue();

          Worklog obj=Worklog.find(worklog);//提取 会员的 姓名
          Profile ob = Profile.find(obj.getMember());//obj.getMember(),obj.getCommunity()

          %>
          <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
            <td width="1"><input name="worklog" type="checkbox" value="<%=worklog%>" /></td>
              <td nowrap>&nbsp;<%=(ob.getLastName(teasession._nLanguage)+ob.getFirstName(teasession._nLanguage))%>&nbsp;<%=obj.getTimeToString()%>
                <br />
                &nbsp;<%
                if(obj.getWorkproject()>0){
                  String flowName = Flowitem.find(obj.getWorkproject()).getName(teasession._nLanguage) ;
                  if(flowName!=null)
                  out.print(flowName);
                }
                %>&nbsp;&nbsp;<%=obj.isPublicity()?"对外":"不对外"%>&nbsp;&nbsp;<%=obj.getWearHours()+"小时"+obj.getWearMinutes()+"分钟"%>
                </td>
                <td>&nbsp;
                <%
                String log_content=obj.getContent(teasession._nLanguage).replaceAll("</","&lt;/");
                if(log_content.length()>25){
                  out.print(log_content.replaceAll("\r\n","<br/>").replaceAll(" ","&nbsp;"));//&#39;
                } else{
                  out.print(log_content);
                } //内容显示
                String accessories = obj.getAccessories();
                if(accessories!=null&&accessories.length()!=0)
                {
                  String url = obj.getPath();
                  String picType = accessories.substring(accessories.lastIndexOf("."));
                  String picImg = "<img src=/tea/image/other/download.gif>";
                  if(picType.equals(".jpg")||picType.equals(".gif")||picType.equals(".bmp")||picType.equals(".JPG")||picType.equals(".GIF")||picType.equals(".BMP")){
                    picImg="<img height=20 width=20 src="+url+">";
                  }
                  out.print("<hr><a href= /jsp/include/DownFile.jsp?uri="+ url +"&name="+java.net.URLEncoder.encode(accessories,"UTF-8")+">"+accessories+"&nbsp"+picImg+"</a></td>");
                }
                %>
                </td>
          </tr>
          <%

        }
      }
      %>
      <tr><td colspan="2"><input type="checkbox" onClick="if(form2.worklog){ form2.worklog.checked=this.checked;for(var i=form2.worklog.length;i>0;i--)form2.worklog[i-1].checked=this.checked; }" /><%=r.getString(teasession._nLanguage,"1168828939928")%></td>
        <td colspan="5" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,10)%></td></tr>
      </table>
      <!--=发送邮件
      <input type="button" value="<%=r.getString(teasession._nLanguage,"1168829505147")%>" onClick="window.open('/jsp/admin/workreport/EditWorklog.jsp?community=<%=teasession._strCommunity%>&worklog=0&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self');">
      -->
      <!--导出-->
      <input type="submit" value="<%=r.getString(teasession._nLanguage,"1168831858710")%>" >

</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>






<%
}else if(valuenum ==2)//按创建时间
{
  %>
  <form name=form2 METHOD=post action="/servlet/EditWorkreport" onSubmit="">
    <input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
    <input type=hidden name="action" value="exportworklogs_2"/>
    <script>document.write("<input type=hidden name=nexturl value="+document.location+">");</script>

      <h2><%=r.getString(teasession._nLanguage,"1168575045718")+"( "+count+" )"%><!--列表--></h2>
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr id="tableonetr">
          <td nowrap width="1"></td>
          <td nowrap><%=r.getString(teasession._nLanguage,"Username")%></td>
          <td nowrap><%=r.getString(teasession._nLanguage,"Text")%></td>
        </tr>
        <%
        for(int i =0;i<2;i++)
        {
          %>
          <tr><td></td><td><h2><%if(i==0){out.print("今天");}else{out.print("昨天");}%><a href="/jsp/admin/workreport/Worklogs_2.jsp">更多</a></h2></td></tr>
          <%
          java.util.Enumeration enumer=Worklog.findByCommunitytoday(teasession._strCommunity,sql.toString(),pos,25,"worklog",i);
          for(int index=1;enumer.hasMoreElements();index++)
          {
            int worklog=((Integer)enumer.nextElement()).intValue();

            Worklog obj=Worklog.find(worklog);//提取 会员的 姓名
            Profile ob = Profile.find(obj.getMember());//obj.getMember(),obj.getCommunity()

            %>
            <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
              <td width="1"><input name="worklog" type="checkbox" value="<%=worklog%>" /></td>
                <td nowrap>&nbsp;<%=(ob.getLastName(teasession._nLanguage)+ob.getFirstName(teasession._nLanguage))%>&nbsp;<%=obj.getTimeToString()%>
                  <br />
                  &nbsp;<%
                  if(obj.getWorkproject()>0){
                    String flowName = Flowitem.find(obj.getWorkproject()).getName(teasession._nLanguage) ;
                    if(flowName!=null)
                    out.print(flowName);
                  }
                  %>&nbsp;&nbsp;<%=obj.isPublicity()?"对外":"不对外"%>&nbsp;&nbsp;<%=obj.getWearHours()+"小时"+obj.getWearMinutes()+"分钟"%>
                  </td>
                  <td>&nbsp;
                  <%
                  String log_content=obj.getContent(teasession._nLanguage).replaceAll("</","&lt;/");
                  if(log_content.length()>25){
                    out.print(log_content.replaceAll("\r\n","<br/>").replaceAll(" ","&nbsp;"));//&#39;
                  } else{
                    out.print(log_content);
                  } //内容显示
                  String accessories = obj.getAccessories();
                  if(accessories!=null&&accessories.length()!=0)
                  {
                    String url = obj.getPath();
                    String picType = accessories.substring(accessories.lastIndexOf("."));
                    String picImg = "<img src=/tea/image/other/download.gif>";
                    if(picType.equals(".jpg")||picType.equals(".gif")||picType.equals(".bmp")||picType.equals(".JPG")||picType.equals(".GIF")||picType.equals(".BMP")){
                      picImg="<img height=20 width=20 src="+url+">";
                    }
                    out.print("<hr><a href= /jsp/include/DownFile.jsp?uri="+ url +"&name="+java.net.URLEncoder.encode(accessories,"UTF-8")+">"+accessories+"&nbsp"+picImg+"</a></td>");
                  }
                  %>
                  </td>
            </tr>
            <%
            }
          }
          %>
          <tr><td colspan="2"><input type="checkbox" onClick="if(form2.worklog){ form2.worklog.checked=this.checked;for(var i=form2.worklog.length;i>0;i--)form2.worklog[i-1].checked=this.checked; }" /><%=r.getString(teasession._nLanguage,"1168828939928")%></td>
            <td colspan="5" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,25)%></td></tr>
      </table>
      <!--=发送邮件
      <input type="button" value="<%=r.getString(teasession._nLanguage,"1168829505147")%>" onClick="window.open('/jsp/admin/workreport/EditWorklog.jsp?community=<%=teasession._strCommunity%>&worklog=0&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self');">
      -->
      <!--导出-->
      <input type="submit" value="<%=r.getString(teasession._nLanguage,"1168831858710")%>" >

</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
<%
}else if(valuenum==3)//按人
{
  %>

  <form name=form2 METHOD=post action="/servlet/EditWorkreport" onSubmit="">
    <input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
    <input type=hidden name="action" value="exportworklogs_2"/>
    <script>document.write("<input type=hidden name=nexturl value="+document.location+">");</script>

      <h2><%=r.getString(teasession._nLanguage,"1168575045718")+"( "+count+" )"%><!--列表--></h2>
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr id="tableonetr">
          <td nowrap width="1"></td>
          <td nowrap><%=r.getString(teasession._nLanguage,"Username")%></td>
          <td nowrap><%=r.getString(teasession._nLanguage,"Text")%></td>
        </tr>
        <%

        java.util.Enumeration enumer3=Worklog.findByCommunitymode(teasession._strCommunity,sql.toString()+" group by member",0,20,"member",1);
       // out.print("@一："+sql.toString()+" group by member");
        while(enumer3.hasMoreElements())
        {
          String members =((String)enumer3.nextElement()).toString();
          //Flowitem flows1 = Flowitem.find(worklogs);
          Profile probj=Profile.find(members);

          //Worklog obj=Worklog.find(worklogs);//提取 会员的 姓名
          %>
          <tr><td></td><td><h2><%=probj.getName(teasession._nLanguage)%><a href="/jsp/admin/workreport/Worklogs_2.jsp?member=<%=members%>">更多</a></h2></td></tr>
          <%
          java.util.Enumeration enumer=Worklog.findByCommunitymode(teasession._strCommunity," and member="+DbAdapter.cite(members)+sql.toString(),pos,15,"worklog",0);
         // out.print("@二："+" and member="+DbAdapter.cite(members)+sql.toString());
          for(int index=1;enumer.hasMoreElements();index++)
          {
            int worklog=((Integer)enumer.nextElement()).intValue();

            Worklog obj=Worklog.find(worklog);//提取 会员的 姓名
            Profile ob = Profile.find(obj.getMember());//obj.getMember(),obj.getCommunity()

            %>
            <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
              <td width="1"><input name="worklog" type="checkbox" value="<%=worklog%>" /></td>
                <td nowrap>&nbsp;<%=(ob.getLastName(teasession._nLanguage)+ob.getFirstName(teasession._nLanguage))%>&nbsp;<%=obj.getTimeToString()%>
                  <br />
                  &nbsp;<%
                  if(obj.getWorkproject()>0){
                    String flowName = Flowitem.find(obj.getWorkproject()).getName(teasession._nLanguage) ;
                    if(flowName!=null)
                    out.print(flowName);
                  }
                  %>&nbsp;&nbsp;<%=obj.isPublicity()?"对外":"不对外"%>&nbsp;&nbsp;<%=obj.getWearHours()+"小时"+obj.getWearMinutes()+"分钟"%>
                  </td>
                  <td>&nbsp;
                  <%
                  String log_content=obj.getContent(teasession._nLanguage).replaceAll("</","&lt;/");
                  if(log_content.length()>25){
                    out.print(log_content.replaceAll("\r\n","<br/>").replaceAll(" ","&nbsp;"));//&#39;
                  } else{
                    out.print(log_content);
                  } //内容显示
                  String accessories = obj.getAccessories();
                  if(accessories!=null&&accessories.length()!=0)
                  {
                    String url = obj.getPath();
                    String picType = accessories.substring(accessories.lastIndexOf("."));
                    String picImg = "<img src=/tea/image/other/download.gif>";
                    if(picType.equals(".jpg")||picType.equals(".gif")||picType.equals(".bmp")||picType.equals(".JPG")||picType.equals(".GIF")||picType.equals(".BMP")){
                      picImg="<img height=20 width=20 src="+url+">";
                    }
                    out.print("<hr><a href= /jsp/include/DownFile.jsp?uri="+ url +"&name="+java.net.URLEncoder.encode(accessories,"UTF-8")+">"+accessories+"&nbsp"+picImg+"</a></td>");
                  }
                  %>
                  </td>
            </tr>
            <%
            }
          }
          %>
          <tr><td colspan="2"><input type="checkbox" onClick="if(form2.worklog){ form2.worklog.checked=this.checked;for(var i=form2.worklog.length;i>0;i--)form2.worklog[i-1].checked=this.checked; }" /><%=r.getString(teasession._nLanguage,"1168828939928")%></td>
            <td colspan="5" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,10)%></td></tr>
      </table>
      <!--=发送邮件
      <input type="button" value="<%=r.getString(teasession._nLanguage,"1168829505147")%>" onClick="window.open('/jsp/admin/workreport/EditWorklog.jsp?community=<%=teasession._strCommunity%>&worklog=0&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self');">
      -->
      <!--导出-->
      <input type="submit" value="<%=r.getString(teasession._nLanguage,"1168831858710")%>" >

</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
<%
}else if(valuenum==4)//按类型
{
  %>
  <form name=form2 METHOD=post action="/servlet/EditWorkreport" onSubmit="">
    <input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
    <input type=hidden name="action" value="exportworklogs_2"/>
    <script>document.write("<input type=hidden name=nexturl value="+document.location+">");</script>

      <h2><%=r.getString(teasession._nLanguage,"1168575045718")+"( "+count+" )"%><!--列表--></h2>
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr id="tableonetr">
          <td nowrap width="1"></td>
          <td nowrap><%=r.getString(teasession._nLanguage,"Username")%></td>
          <td nowrap><%=r.getString(teasession._nLanguage,"Text")%></td>
        </tr>
        <%
        java.util.Enumeration enumer4=Worklog.findByCommunitymode(teasession._strCommunity,sql.toString()+" group by worktype",0,25,"worktype",0);
        while(enumer4.hasMoreElements())
        {
          int worktypes=((Integer)enumer4.nextElement()).intValue();
          Worktype worktypeobj = Worktype.find(worktypes);
          //        System.out.print(worktypes+"@");
          //        System.out.print(sql.toString());
          // Flowitem flows1 = Flowitem.find(worklogs);
          //Worklog obj=Worklog.find(worklogs);//提取 会员的 姓名
          %>
          <tr><td></td><td><h2><%if(worktypeobj.getName(teasession._nLanguage)!=null && worktypeobj.getName(teasession._nLanguage).length()>0)
          {
            out.print(worktypeobj.getName(teasession._nLanguage));
          }
          else
          {
            out.print("未定义类型");
          }
          %><a href="/jsp/admin/workreport/Worklogs_2.jsp?worktype=<%=worktypes%>">更多</a></h2></td></tr>
          <%
          java.util.Enumeration enumer=Worklog.findByCommunitymode(teasession._strCommunity," and worktype="+worktypes+sql.toString(),pos,25,"worklog",0);

          for(int index=1;enumer.hasMoreElements();index++)
          {
            int worklog=((Integer)enumer.nextElement()).intValue();

            Worklog obj=Worklog.find(worklog);//提取 会员的 姓名
            Profile ob = Profile.find(obj.getMember());//obj.getMember(),obj.getCommunity()

            %>
            <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
              <td width="1"><input name="worklog" type="checkbox" value="<%=worklog%>" /></td>
                <td nowrap>&nbsp;<%=(ob.getLastName(teasession._nLanguage)+ob.getFirstName(teasession._nLanguage))%>&nbsp;<%=obj.getTimeToString()%>
                  <br />
                  &nbsp;<%
                  if(obj.getWorkproject()>0){
                    String flowName = Flowitem.find(obj.getWorkproject()).getName(teasession._nLanguage) ;
                    if(flowName!=null)
                    out.print(flowName);
                  }
                  %>&nbsp;&nbsp;<%=obj.isPublicity()?"对外":"不对外"%>&nbsp;&nbsp;<%=obj.getWearHours()+"小时"+obj.getWearMinutes()+"分钟"%>
                  </td>
                  <td>&nbsp;
                  <%
                  String log_content=obj.getContent(teasession._nLanguage).replaceAll("</","&lt;/");
                  if(log_content.length()>25){
                    out.print(log_content.replaceAll("\r\n","<br/>").replaceAll(" ","&nbsp;"));//&#39;
                  } else{
                    out.print(log_content);
                  } //内容显示
                  String accessories = obj.getAccessories();
                  if(accessories!=null&&accessories.length()!=0)
                  {
                    String url = obj.getPath();
                    String picType = accessories.substring(accessories.lastIndexOf("."));
                    String picImg = "<img src=/tea/image/other/download.gif>";
                    if(picType.equals(".jpg")||picType.equals(".gif")||picType.equals(".bmp")||picType.equals(".JPG")||picType.equals(".GIF")||picType.equals(".BMP")){
                      picImg="<img height=20 width=20 src="+url+">";
                    }
                    out.print("<hr><a href= /jsp/include/DownFile.jsp?uri="+ url +"&name="+java.net.URLEncoder.encode(accessories,"UTF-8")+">"+accessories+"&nbsp"+picImg+"</a></td>");
                  }
                  %>
                  </td>
            </tr>
            <%
            }
          }
          %>
          <tr><td colspan="2"><input type="checkbox" onClick="if(form2.worklog){ form2.worklog.checked=this.checked;for(var i=form2.worklog.length;i>0;i--)form2.worklog[i-1].checked=this.checked; }" /><%=r.getString(teasession._nLanguage,"1168828939928")%></td>
            <td colspan="5" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,25)%></td></tr>
      </table>
      <!--=发送邮件
      <input type="button" value="<%=r.getString(teasession._nLanguage,"1168829505147")%>" onClick="window.open('/jsp/admin/workreport/EditWorklog.jsp?community=<%=teasession._strCommunity%>&worklog=0&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self');">
      -->
      <!--导出-->
      <input type="submit" value="<%=r.getString(teasession._nLanguage,"1168831858710")%>" >
</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
<%
}
%>




